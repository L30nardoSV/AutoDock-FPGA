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
 	     __constant float* restrict KerConstStatic_atom_charges_const,
 	     __constant char*  restrict KerConstStatic_atom_types_const,
	     __constant char*  restrict KerConstStatic_intraE_contributors_const,
	     __constant float* restrict KerConstStatic_VWpars_AC_const,
	     __constant float* restrict KerConstStatic_VWpars_BD_const,
	     __constant float* restrict KerConstStatic_dspars_S_const,
 	     __constant float* restrict KerConstStatic_dspars_V_const,

			    unsigned char                    DockConst_num_of_atoms,
		   	    unsigned int                     DockConst_num_of_intraE_contributors,
		  	    float                            DockConst_grid_spacing,
			    unsigned char                    DockConst_num_of_atypes,
			    float                            DockConst_coeff_elec,
			    float                            DockConst_qasp,
			    float                            DockConst_coeff_desolv
)
{
	// local vars are allowed only at kernel scope
	__local float loc_coords_x[MAX_NUM_OF_ATOMS];
	__local float loc_coords_y[MAX_NUM_OF_ATOMS];
	__local float loc_coords_z[MAX_NUM_OF_ATOMS];

	char active = 1;

while(active) {
	char mode;

	//printf("BEFORE In INTRA CHANNEL\n");
	// --------------------------------------------------------------
	// Wait for ligand atomic coordinates in channel
	// --------------------------------------------------------------
	active = read_channel_altera(chan_Conf2Intrae_active);
	mem_fence(CLK_CHANNEL_MEM_FENCE);
	mode   = read_channel_altera(chan_Conf2Intrae_mode);
	mem_fence(CLK_CHANNEL_MEM_FENCE);

	float3 position_xyz;

	for (uchar pipe_cnt=0; pipe_cnt<DockConst_num_of_atoms; pipe_cnt++) {
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

	float intraE = 0.0f;

	//for each intramolecular atom contributor pair
	for (ushort contributor_counter=0; contributor_counter<DockConst_num_of_intraE_contributors; contributor_counter++) {

		char ref_intraE_contributors_const[3];

		for (uchar i=0; i<3; i++) {
			ref_intraE_contributors_const[i] = KerConstStatic_intraE_contributors_const[3*contributor_counter+i];
		}

		char atom1_id = ref_intraE_contributors_const[0];
		char atom2_id = ref_intraE_contributors_const[1];

		float subx = loc_coords_x[atom1_id] - loc_coords_x[atom2_id];
		float suby = loc_coords_y[atom1_id] - loc_coords_y[atom2_id];
		float subz = loc_coords_z[atom1_id] - loc_coords_z[atom2_id];

		//distance_leo = sqrt(subx*subx + suby*suby + subz*subz)*DockConst_grid_spacing;
		float distance_leo = sqrt_custom(subx*subx + suby*suby + subz*subz)*DockConst_grid_spacing;

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

		float distance_pow_2  = distance_leo*distance_leo; 		
		float distance_pow_4  = distance_pow_2*distance_pow_2; 		
		float distance_pow_6  = distance_pow_2*distance_pow_4; 		
		float distance_pow_10 = distance_pow_4*distance_pow_6; 		
		float distance_pow_12 = distance_pow_6*distance_pow_6;

		float inverse_distance_pow_12 = 1 / distance_pow_12;
		float inverse_distance_pow_10 = inverse_distance_pow_12 * distance_pow_2;
		float inverse_distance_pow_6  = inverse_distance_pow_10 * distance_pow_4;
		
		float partialE1;
		float partialE2;
		float partialE3;
		float partialE4;

		//but only if the distance is less than distance cutoff value and 20.48A (because of the tables)
		//if ((distance_leo < 8.0f) && (distance_leo < 20.48f))
		if (distance_leo < 8.0f) 
		{
			char atom1_typeid = KerConstStatic_atom_types_const [atom1_id];
			char atom2_typeid = KerConstStatic_atom_types_const [atom2_id];

			//calculating van der Waals / hydrogen bond term
			partialE1 = KerConstStatic_VWpars_AC_const[atom1_typeid*DockConst_num_of_atypes+atom2_typeid]*inverse_distance_pow_12;

			float tmp_pE2 = KerConstStatic_VWpars_BD_const[atom1_typeid*DockConst_num_of_atypes+atom2_typeid];

			if (ref_intraE_contributors_const[2] == 1)	//H-bond
				partialE2 = tmp_pE2 * inverse_distance_pow_10;
			else	//van der Waals
				partialE2 = tmp_pE2 * inverse_distance_pow_6;

			//calculating electrostatic term
			partialE3 = DockConst_coeff_elec*KerConstStatic_atom_charges_const[atom1_id]*KerConstStatic_atom_charges_const[atom2_id]/(distance_leo*(-8.5525f + 86.9525f/(1.0f + 7.7839f*exp(-0.3154f*distance_leo))));

			//calculating desolvation term
			partialE4 = (
				  ( KerConstStatic_dspars_S_const[atom1_typeid] + DockConst_qasp*fabs(KerConstStatic_atom_charges_const[atom1_id]) ) * KerConstStatic_dspars_V_const[atom2_typeid] + 
				  ( KerConstStatic_dspars_S_const[atom2_typeid] + DockConst_qasp*fabs(KerConstStatic_atom_charges_const[atom2_id]) ) * KerConstStatic_dspars_V_const[atom1_typeid]) * 
				 DockConst_coeff_desolv*exp(-0.0386f*distance_pow_2);

		} // End of if: if ((dist < dcutoff) && (dist < 20.48))	

		intraE += partialE1 + partialE2 + partialE3 + partialE4;

	} // End of contributor_counter for-loop

	// --------------------------------------------------------------
	// Send intramolecular energy to channel
	// --------------------------------------------------------------
	switch (mode) {
		case 1:	// IC
			write_channel_altera(chan_Intrae2StoreIC_intrae, intraE);
		break;
		case 2:	// GG
			write_channel_altera(chan_Intrae2StoreGG_intrae, intraE);
		break;
		case 3:	// LS - positive descent
			write_channel_altera(chan_Intrae2StoreLS_pos_intrae, intraE);
		break;
		case 4:	// LS - negative descent
			write_channel_altera(chan_Intrae2StoreLS_neg_intrae, intraE);
		break;
		case 5:	// Off
			write_channel_altera(chan_Intrae2StoreOff_intrae, intraE);
		break;
	}
	// --------------------------------------------------------------

} // End of while(1)

	#if defined (DEBUG_ACTIVE_KERNEL)
	printf("	%-20s: %s\n", "Krnl_IntraE", "disabled");
	#endif
}
// --------------------------------------------------------------------------
// --------------------------------------------------------------------------
