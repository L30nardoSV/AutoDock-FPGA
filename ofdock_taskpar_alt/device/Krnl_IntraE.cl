// NOT SURE IF THIS MUST BE KEPT WITH THE 
// SINGLE FOR-LOOP/DATA PARALLEL IMPLEMENTATION
/*
#include "auxiliary_intrae.cl"
*/

// --------------------------------------------------------------------------
// Originally from: processligand.c
// --------------------------------------------------------------------------
__kernel __attribute__ ((reqd_work_group_size(1,1,1)))
/*
void Krnl_IntraE(__global const float* 		 restrict GlobLigand_intraE_contributors,
		 __global const float* 		 restrict GlobLigand_VWpars_A,	 
		 __global const float* 		 restrict GlobLigand_VWpars_B,
		 __global const float* 		 restrict GlobLigand_VWpars_C,
		 __global const float* 		 restrict GlobLigand_VWpars_D,
	         __global const float* 		 restrict GlobLigand_volume,
		 __global const float* 		 restrict GlobLigand_solpar,
		 __global const float* 		 restrict Glob_r_6_table,
		 __global const float* 		 restrict Glob_r_10_table,
		 __global const float* 		 restrict Glob_r_12_table,
		 __global const float* 		 restrict Glob_r_epsr_table,
	         __global const float* 		 restrict Glob_desolv_table,
		 __global const float* 		 restrict Glob_q1q2,
		 __global const float* 		 restrict Glob_qasp_mul_absq,
		 __global const Ligandconstant*  restrict LigConst,
		 __global const Gridconstant*    restrict GridConst)
*/
void Krnl_IntraE(
             __global const float*           restrict GlobFgrids,
	     __global       float*           restrict GlobPopulationCurrent,
	     __global       float*           restrict GlobEnergyCurrent,
	     __global       float*           restrict GlobPopulationNext,
	     __global       float*           restrict GlobEnergyNext,
             __global const float*           restrict GlobPRNG,
	     __global const kernelconstant* restrict KerConst,
	     __global const Dockparameters* restrict DockConst)
{
	// --------------------------------------------------------------
	// Wait for ligand data
	// --------------------------------------------------------------
/*
	__local float myligand_atom_idxyzq[MAX_NUM_OF_ATOMS*5];

	uint init_cnt;

	for (init_cnt=0; init_cnt<LigConst->num_of_atoms*5; init_cnt++)
	{
		myligand_atom_idxyzq[init_cnt] = read_channel_altera(chan_Conf2Intrae_ligandatom_idxyzq);
	}
*/
	__local float loc_coords_x[MAX_NUM_OF_ATOMS];
	__local float loc_coords_y[MAX_NUM_OF_ATOMS];
	__local float loc_coords_z[MAX_NUM_OF_ATOMS];

	for (uint pipe_cnt=0; pipe_cnt<DockConst->num_of_atoms; pipe_cnt++) {
		loc_coords_x[pipe_cnt] = read_channel_altera(chan_Conf2Intrae_x);
		loc_coords_y[pipe_cnt] = read_channel_altera(chan_Conf2Intrae_y);
		loc_coords_z[pipe_cnt] = read_channel_altera(chan_Conf2Intrae_z);
	}
	// --------------------------------------------------------------


	//uint atom_id1, atom_id2;
	//uint type_id1, type_id2;

	char atom_id1, atom_id2;
	char type_id1, type_id2;


	float subx, suby, subz, distance_leo;

 	// Altera doesn't support power function 	
	// so this is implemented with multiplications 	
	// Full precision is used 	
	float distance_pow_2, distance_pow_4, distance_pow_6, distance_pow_10, distance_pow_12;

	//float dist;
	int distance_id;
	float vdW1, vdW2;
	float s1, s2, v1, v2;
	float vW = 0.0f, el = 0.0f, desolv = 0.0f;
	float intraE = 0.0f;

	#if defined (DEBUG_KERNEL_INTRA_E)
	printf("\n\n\nINTRAMOLECULAR ENERGY CALCULATION\n\n");
	#endif
	
	//for each intramolecular atom contributor pair
	uint contrib_cnt;


	// **********************************************
	// ADD VENDOR SPECIFIC PRAGMA
	// **********************************************
	LOOP_INTRAE_1:
	for (contrib_cnt=0; contrib_cnt<DockConst->num_of_intraE_contributors; contrib_cnt++)
	{
			
		atom_id1 = KerConst->intraE_contributors_const[3*contrib_cnt]; 
		atom_id2 = KerConst->intraE_contributors_const[3*contrib_cnt+1];

		//dist = GridConst->spacing * distance_custom(&myligand_atom_idxyzq [atom_id1*5+1], &myligand_atom_idxyzq [atom_id2*5+1]);
		subx = loc_coords_x[atom_id1] - loc_coords_x[atom_id2];
		suby = loc_coords_y[atom_id1] - loc_coords_y[atom_id2];
		subz = loc_coords_z[atom_id1] - loc_coords_z[atom_id2];
		distance_leo = sqrt(subx*subx + suby*suby + subz*subz)*DockConst->grid_spacing;

		if (distance_leo < 1.0f) {
			#if defined (DEBUG_KERNEL_INTRA_E)
			printf("\n\nToo low distance (%f) between atoms %u and %u\n", distance_leo, atom_id1, atom_id2);
			#endif
			//return HIGHEST_ENERGY;	//returning maximal value
			distance_leo = 1.0f;
		}

		#if defined (DEBUG_KERNEL_INTRA_E)
		printf("\n\nCalculating energy contribution of atoms %u and %u\n", atom_id1+1, atom_id2+1);
		printf("Distance: %f\n", distance_leo);
		#endif

		distance_pow_2  = distance_leo*distance_leo; 		
		distance_pow_4  = distance_pow_2*distance_pow_2; 		
		distance_pow_6  = distance_pow_2*distance_pow_4; 		
		distance_pow_10 = distance_pow_4*distance_pow_6; 		
		distance_pow_12 = distance_pow_6*distance_pow_6;
		

		//but only if the distance is less than distance cutoff value and 20.48A (because of the tables)
		if ((distance_leo < 8.0f) && (distance_leo < 20.48f)) 
		{
			type_id1 = KerConst->atom_types_const [atom_id1];
			type_id2 = KerConst->atom_types_const [atom_id2];


/*							
			// +0.5: rounding, -1: r_xx_table [0] corresponds to r=0.01
			distance_id = convert_int(floor((100.0f*dist) + 0.5f)) - 1; //distance_id = (int) floor((100.0f*dist) + 0.5f) - 1;	
			if (distance_id < 0) {distance_id = 0;}


			//H-bond
			//if (is_H_bond(atom1_typeid, atom2_typeid) != 0)
			if (GlobLigand_intraE_contributors[3*contrib_cnt+2] == 1)
			{
				vdW1 = GlobLigand_VWpars_C [type_id1*MAX_NUM_OF_ATYPES+type_id2]*Glob_r_12_table [distance_id];
				vdW2 = GlobLigand_VWpars_D [type_id1*MAX_NUM_OF_ATYPES+type_id2]*Glob_r_10_table [distance_id];
						
				#if defined (DEBUG_KERNEL_INTRA_E)
				printf("H-bond interaction = ");
				#endif
			}
			else	//normal van der Waals
			{
				vdW1 = GlobLigand_VWpars_A [type_id1*MAX_NUM_OF_ATYPES+type_id2]*Glob_r_12_table [distance_id];
				vdW2 = GlobLigand_VWpars_B [type_id1*MAX_NUM_OF_ATYPES+type_id2]*Glob_r_6_table  [distance_id];

				#if defined (DEBUG_KERNEL_INTRA_E)
				printf("van der Waals interaction = ");
				#endif
			}

			s1 = GlobLigand_solpar [type_id1] + Glob_qasp_mul_absq [atom_id1];
			s2 = GlobLigand_solpar [type_id2] + Glob_qasp_mul_absq [atom_id2];
			v1 = GlobLigand_volume [type_id1];
			v2 = GlobLigand_volume [type_id2];

			#if defined (DEBUG_KERNEL_INTRA_E)
			printf(" %f, electrostatic = %f, desolv = %f\n", (vdW1 - vdW2), 
									 Glob_q1q2[atom_id1*MAX_NUM_OF_ATOMS+atom_id2] * Glob_r_epsr_table [distance_id],
									 (s1*v2 + s2*v1) * Glob_desolv_table [distance_id]);
			#endif

			vW += vdW1 - vdW2;
			el += Glob_q1q2[atom_id1*MAX_NUM_OF_ATOMS+atom_id2] * Glob_r_epsr_table [distance_id];
			desolv += (s1*v2 + s2*v1) * Glob_desolv_table [distance_id];
			
*/
	
			//calculating van der Waals / hydrogen bond term
			intraE += KerConst->VWpars_AC_const[type_id1 * DockConst->num_of_atypes+type_id2]/distance_pow_12;

			if (KerConst->intraE_contributors_const[3*contrib_cnt+2] == 1)	//H-bond
				intraE-= KerConst->VWpars_BD_const[type_id1*DockConst->num_of_atypes+type_id2]/distance_pow_10;	
			else	//van der Waals
				intraE-= KerConst->VWpars_BD_const[type_id1*DockConst->num_of_atypes+type_id2]/distance_pow_6;

			//calculating electrostatic term
			intraE+= DockConst->coeff_elec*KerConst->atom_charges_const[atom_id1]*KerConst->atom_charges_const[atom_id2]/(distance_leo*(-8.5525f + 86.9525f/(1.0f + 7.7839f*exp(-0.3154f*distance_leo))));

			//calculating desolvation term
			intraE+= ((KerConst->dspars_S_const[type_id2] + DockConst->qasp*fabs(KerConst->atom_charges_const[atom_id1]))*KerConst->dspars_V_const[type_id2] + (KerConst->dspars_S_const[type_id2] + 							       DockConst->qasp*fabs(KerConst->atom_charges_const[atom_id2]))*KerConst->dspars_V_const[type_id1]) * DockConst->coeff_desolv*exp(-distance_leo*distance_leo/25.92f);
	
		} // End of if: if ((dist < dcutoff) && (dist < 20.48))	

	} // End of LOOP_INTRAE_1



// NOT SURE IF THIS MUST BE KEPT WITH THE 
// SINGLE FOR-LOOP/DATA PARALLEL IMPLEMENTATION
/*
	#if defined (DEBUG_KERNEL_INTRA_E)
	printf("\nFinal energies: van der Waals = %f, electrostatic = %f, desolvation = %f, total = %f\n\n", vW, el,desolv, vW + el + desolv);
	#endif

	#if defined (IGNORE_DESOLV)
	intraE = vW + el;
	#else
	intraE = vW + el + desolv;
	#endif
*/


	//// --------------------------------------------------------------
	//// Send intramolecular energy to GA
	//// --------------------------------------------------------------
	//write_channel_altera(chan_Intrae2GA_intrae, intraE);
	//// --------------------------------------------------------------


}
// --------------------------------------------------------------------------
// --------------------------------------------------------------------------
