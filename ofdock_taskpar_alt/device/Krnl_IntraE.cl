// sqrt7 ////https://www.codeproject.com/Articles/69941/Best-Square-Root-Method-Algorithm-Function-Precisi
float sqrt_custom(const float x) 
{ 	//uint i = as_uint(x);	
	uint i = *(uint*) &x;    	
	i  += 127 << 23;	// adjust bias   	
	i >>= 1; 		// approximation of square root 	
	return as_float(i);	//return *(float*) &i; 
}  



// --------------------------------------------------------------------------
// Originally from: processligand.c
// --------------------------------------------------------------------------
__kernel __attribute__ ((max_global_work_dim(0)))
void Krnl_IntraE(
	     __global const kernelconstant_static*  restrict KerConstStatic,
	     __constant     Dockparameters*  restrict DockConst
)
{

	__local float loc_coords_x[MAX_NUM_OF_ATOMS];
	__local float loc_coords_y[MAX_NUM_OF_ATOMS];
	__local float loc_coords_z[MAX_NUM_OF_ATOMS];
/*
	float __attribute__((register)) loc_coords_x[MAX_NUM_OF_ATOMS];
	float __attribute__((register)) loc_coords_y[MAX_NUM_OF_ATOMS];
	float __attribute__((register)) loc_coords_z[MAX_NUM_OF_ATOMS];
*/
	char active = 1;
	char mode   = 0;
	ushort cnt  = 0; //uint cnt    = 0; 

	int contributor_counter;
	char atom1_id, atom2_id, atom1_typeid, atom2_typeid;
	float subx, suby, subz, distance_leo;

 	// Altera doesn't support power function 	
	// so this is implemented with multiplications 	
	// Full precision is used 	
	float distance_pow_2, distance_pow_4, distance_pow_6, distance_pow_10, distance_pow_12;
	float inverse_distance_pow_12, inverse_distance_pow_10, inverse_distance_pow_6;

	float intraE;

	float partialE1, partialE2, partialE3, partialE4;

	// To store global values KerConst->intraE_contributors_const
	char ref_intraE_contributors_const[3];

while(active) {
	//printf("BEFORE In INTRA CHANNEL\n");
	// --------------------------------------------------------------
	// Wait for ligand atomic coordinates in channel
	// --------------------------------------------------------------
	active = read_channel_altera(chan_Conf2Intrae_active);
	mem_fence(CLK_CHANNEL_MEM_FENCE);
	mode   = read_channel_altera(chan_Conf2Intrae_mode);
	mem_fence(CLK_CHANNEL_MEM_FENCE);
	cnt    = read_channel_altera(chan_Conf2Intrae_cnt);
	mem_fence(CLK_CHANNEL_MEM_FENCE);

	float3 position_xyz;

	for (uchar pipe_cnt=0; pipe_cnt<DockConst->num_of_atoms; pipe_cnt++) {
		/*
		loc_coords_x[pipe_cnt] = read_channel_altera(chan_Conf2Intrae_x);
		mem_fence(CLK_CHANNEL_MEM_FENCE | CLK_LOCAL_MEM_FENCE);
		loc_coords_y[pipe_cnt] = read_channel_altera(chan_Conf2Intrae_y);
		mem_fence(CLK_CHANNEL_MEM_FENCE | CLK_LOCAL_MEM_FENCE);
		loc_coords_z[pipe_cnt] = read_channel_altera(chan_Conf2Intrae_z);
		*/
		position_xyz = read_channel_altera(chan_Conf2Intrae_xyz);
		loc_coords_x[pipe_cnt] = position_xyz.x;
		loc_coords_y[pipe_cnt] = position_xyz.y;
		loc_coords_z[pipe_cnt] = position_xyz.z;
	}
	// --------------------------------------------------------------
	//printf("AFTER In INTRA CHANNEL\n");

	#if defined (DEBUG_ACTIVE_KERNEL)
	if (active == 0) {printf("	%-20s: %s\n", "Krnl_IntraE", "must be disabled");}
	#endif

	intraE = 0.0f;
	partialE1 = 0.0f;
	partialE2 = 0.0f;
	partialE3 = 0.0f;
	partialE4 = 0.0f;

	//for each intramolecular atom contributor pair
	for (ushort contributor_counter=0; contributor_counter<DockConst->num_of_intraE_contributors; contributor_counter++) {
		for (uchar i=0; i<3; i++) {
			ref_intraE_contributors_const[i] = KerConstStatic->intraE_contributors_const[3*contributor_counter+i];
		}
		atom1_id = ref_intraE_contributors_const[0];
		atom2_id = ref_intraE_contributors_const[1];

		subx = loc_coords_x[atom1_id] - loc_coords_x[atom2_id];
		suby = loc_coords_y[atom1_id] - loc_coords_y[atom2_id];
		subz = loc_coords_z[atom1_id] - loc_coords_z[atom2_id];

		//distance_leo = sqrt(subx*subx + suby*suby + subz*subz)*DockConst->grid_spacing;
		distance_leo = sqrt_custom(subx*subx + suby*suby + subz*subz)*DockConst->grid_spacing;

		if (distance_leo < 1.0f) {
			#if defined (DEBUG_KRNL_INTRAE)
			printf("\n\nToo low distance (%f) between atoms %u and %u\n", distance_leo, atom1_id, atom2_id);
			#endif
			//return HIGHEST_ENERGY;	//returning maximal value
			distance_leo = 1.0f;
		}

		#if defined (DEBUG_KRNL_INTRAE)
		printf("\n\nCalculating energy contribution of atoms %u and %u\n", atom1_id+1, atom2_id+1);
		printf("Distance: %f\n", distance_leo);
		#endif

		distance_pow_2  = distance_leo*distance_leo; 		
		distance_pow_4  = distance_pow_2*distance_pow_2; 		
		distance_pow_6  = distance_pow_2*distance_pow_4; 		
		distance_pow_10 = distance_pow_4*distance_pow_6; 		
		distance_pow_12 = distance_pow_6*distance_pow_6;
		inverse_distance_pow_12 = 1 / distance_pow_12;
		inverse_distance_pow_10 = inverse_distance_pow_12 * distance_pow_2;
		inverse_distance_pow_6  = inverse_distance_pow_10 * distance_pow_4;
		
		//but only if the distance is less than distance cutoff value and 20.48A (because of the tables)
		//if ((distance_leo < 8.0f) && (distance_leo < 20.48f))
		if (distance_leo < 8.0f) 
		{
			atom1_typeid = KerConstStatic->atom_types_const [atom1_id];
			atom2_typeid = KerConstStatic->atom_types_const [atom2_id];

			//calculating van der Waals / hydrogen bond term
			partialE1 = KerConstStatic->VWpars_AC_const[atom1_typeid*DockConst->num_of_atypes+atom2_typeid]*inverse_distance_pow_12;

			if (ref_intraE_contributors_const[2] == 1)	//H-bond
				partialE2 = KerConstStatic->VWpars_BD_const[atom1_typeid*DockConst->num_of_atypes+atom2_typeid]*inverse_distance_pow_10;

			else	//van der Waals
				partialE2 = KerConstStatic->VWpars_BD_const[atom1_typeid*DockConst->num_of_atypes+atom2_typeid]*inverse_distance_pow_6;

			//calculating electrostatic term
			partialE3 = DockConst->coeff_elec*KerConstStatic->atom_charges_const[atom1_id]*KerConstStatic->atom_charges_const[atom2_id]/(distance_leo*(-8.5525f + 86.9525f/(1.0f + 7.7839f*exp(-0.3154f*distance_leo))));

			//calculating desolvation term
			partialE4 = (
				  ( KerConstStatic->dspars_S_const[atom1_typeid] + DockConst->qasp*fabs(KerConstStatic->atom_charges_const[atom1_id]) ) * KerConstStatic->dspars_V_const[atom2_typeid] + 
				  ( KerConstStatic->dspars_S_const[atom2_typeid] + DockConst->qasp*fabs(KerConstStatic->atom_charges_const[atom2_id]) ) * KerConstStatic->dspars_V_const[atom1_typeid]) * 
				 DockConst->coeff_desolv*exp(-0.0386f*distance_pow_2);

		} // End of if: if ((dist < dcutoff) && (dist < 20.48))	

		intraE += partialE1 + partialE2 + partialE3 + partialE4;

	} // End of LOOP_INTRAE_1

	//////======================================================
	if ((active == 0) && (cnt == (DockConst->pop_size -1))) {
		active = 0;	
	}
	else {
		active = 1;
	}
	//////======================================================

	// --------------------------------------------------------------
	// Send intramolecular energy to channel
	// --------------------------------------------------------------
	write_channel_altera(chan_Intrae2Store_intrae, intraE);
	mem_fence(CLK_CHANNEL_MEM_FENCE);
	write_channel_altera(chan_Intrae2Store_active, active);
	mem_fence(CLK_CHANNEL_MEM_FENCE);
	write_channel_altera(chan_Intrae2Store_mode,   mode);
	mem_fence(CLK_CHANNEL_MEM_FENCE);
	write_channel_altera(chan_Intrae2Store_cnt,    cnt);
	// --------------------------------------------------------------

	} // End of while(1)

	#if defined (DEBUG_ACTIVE_KERNEL)
	printf("	%-20s: %s\n", "Krnl_IntraE", "disabled");
	#endif
}
// --------------------------------------------------------------------------
// --------------------------------------------------------------------------
