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

//#if defined (FIXED_POINT_INTERE)
// 	     __constant fixedpt64* restrict KerConstStatic_atom_charges_const,
//#else
 	     __constant float* restrict KerConstStatic_atom_charges_const,
//#endif

 	     __constant char*  restrict KerConstStatic_atom_types_const,


/*
	     __constant char*  restrict KerConstStatic_intraE_contributors_const,
*/
	     /*__constant*/ __global const  char3* restrict KerConstStatic_intraE_contributors_const,
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
			float                            DockConst_coeff_desolv,
   			unsigned int                     Host_square_num_of_atypes

)
{
/*
	bool active = true;
*/
	char active = 0x01;

	__local char  atom_types_localcache   [MAX_NUM_OF_ATOMS];
	__local float atom_charges_localcache [MAX_NUM_OF_ATOMS];
	__local float VWpars_AC_localcache    [MAX_NUM_OF_ATYPES*MAX_NUM_OF_ATYPES];
	__local float VWpars_BD_localcache    [MAX_NUM_OF_ATYPES*MAX_NUM_OF_ATYPES];
	__local float dspars_S_localcache     [MAX_NUM_OF_ATYPES];
	__local float dspars_V_localcache     [MAX_NUM_OF_ATYPES];


	for (uchar i=0; i<DockConst_num_of_atoms; i++) {
		atom_types_localcache   [i] = KerConstStatic_atom_types_const   [i];
//#if defined (FIXED_POINT_INTERE)
//		atom_charges_localcache [i] = fixedpt64_tofloat(KerConstStatic_atom_charges_const [i]);	
//#else
		atom_charges_localcache [i] = KerConstStatic_atom_charges_const [i];	
//#endif
	}


	for (uchar i=0; i<Host_square_num_of_atypes; i++) {
		if (i < DockConst_num_of_atypes) {
			dspars_S_localcache [i] = KerConstStatic_dspars_S_const [i];
			dspars_V_localcache [i] = KerConstStatic_dspars_V_const [i];
		}
		
		VWpars_AC_localcache [i] = KerConstStatic_VWpars_AC_const [i];
		VWpars_BD_localcache [i] = KerConstStatic_VWpars_BD_const [i];
		
	}

/*
	printf("%i\n", fixedpt_toint(681391));
	printf("%i\n", fixedpt_toint(-772243));

	printf("%li\n", fixedpt64_fromint(18));
	printf("%li\n", fixedpt64_fromint(-18));

	printf("%f\n", fixedpt64_tofloat(178145));
	printf("%f\n", fixedpt_tofloat(178145));
*/
/*
// passed correctly
printf("kernel intraE %i \n", DockConst_num_of_intraE_contributors);
*/

/*
	__local char  intraE_contributors_localcache   [3*MAX_INTRAE_CONTRIBUTORS];

	for (ushort i=0; i<3*MAX_INTRAE_CONTRIBUTORS; i++) {
		intraE_contributors_localcache [i] = KerConstStatic_intraE_contributors_const [i];	
	}
*/

	__local char3  intraE_contributors_localcache   [MAX_INTRAE_CONTRIBUTORS];

	for (ushort i=0; i<MAX_INTRAE_CONTRIBUTORS; i++) {
		intraE_contributors_localcache [i] = KerConstStatic_intraE_contributors_const [i];	
	}

#pragma max_concurrency 32
while(active) {
	char mode;

	float3 __attribute__ ((
			      memory,
			      numbanks(2),
			      bankwidth(16),
			      singlepump,
			      numreadports(2),
			      numwriteports(1)
			    )) loc_coords[MAX_NUM_OF_ATOMS];

	//printf("BEFORE In INTRA CHANNEL\n");
	// --------------------------------------------------------------
	// Wait for ligand atomic coordinates in channel
	// --------------------------------------------------------------

	char2 actmode = read_channel_altera(chan_Conf2Intrae_actmode);
	mem_fence(CLK_CHANNEL_MEM_FENCE);

	active = actmode.x;
	mode   = actmode.y;

/*
	for (uchar pipe_cnt=0; pipe_cnt<DockConst_num_of_atoms; pipe_cnt++) {
		loc_coords[pipe_cnt] = read_channel_altera(chan_Conf2Intrae_xyz);
	}
*/

	for (uchar pipe_cnt=0; pipe_cnt<DockConst_num_of_atoms; pipe_cnt+=2) {
		float8 tmp = read_channel_altera(chan_Conf2Intrae_xyz);
		float3 tmp1 = {tmp.s0, tmp.s1, tmp.s2};
		float3 tmp2 = {tmp.s4, tmp.s5, tmp.s6};
		loc_coords[pipe_cnt] = tmp1;
		loc_coords[pipe_cnt+1] = tmp2;
	}


	// --------------------------------------------------------------
	//printf("AFTER In INTRA CHANNEL\n");

	#if defined (DEBUG_ACTIVE_KERNEL)
	if (active == 0) {printf("	%-20s: %s\n", "Krnl_IntraE", "must be disabled");}
	#endif






	float intraE = 0.0f;



#if defined (FIXED_POINT_INTRAE)
	// create shift register to reduce II (initially II=32, unroll-factor=8) 
	// use fixedpt64 to reduce II=4 (after shift-register) downto II=1
	//float shift_intraE[33];
	fixedpt64 shift_intraE[33];

	#pragma unroll
	for (uchar i=0; i<33; i++) {
		//shift_intraE[i] = 0.0f;
		shift_intraE[i] = 0;
	}

#endif



	//for each intramolecular atom contributor pair

	//#pragma unroll 10
	for (ushort contributor_counter=0; contributor_counter<DockConst_num_of_intraE_contributors; contributor_counter++) {

		/*
		// passed correctly
		printf("kernel intraE %i: %i \n", contributor_counter, DockConst_num_of_intraE_contributors);
		*/

		char3 ref_intraE_contributors_const;
		ref_intraE_contributors_const = intraE_contributors_localcache[contributor_counter];

		char atom1_id = ref_intraE_contributors_const.x;
		char atom2_id = ref_intraE_contributors_const.y;

		float3 loc_coords_atid1 = loc_coords[atom1_id];
		float3 loc_coords_atid2 = loc_coords[atom2_id];
		float subx = loc_coords_atid1.x - loc_coords_atid2.x;
		float suby = loc_coords_atid1.y - loc_coords_atid2.y;
		float subz = loc_coords_atid1.z - loc_coords_atid2.z;

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
		float inverse_distance_pow_2  = native_divide(1.0f, distance_pow_2);
		float inverse_distance_pow_4  = inverse_distance_pow_2 * inverse_distance_pow_2;
		float inverse_distance_pow_6  = inverse_distance_pow_4 * inverse_distance_pow_2;
		float inverse_distance_pow_10 = inverse_distance_pow_6 * inverse_distance_pow_4;
		float inverse_distance_pow_12 = inverse_distance_pow_6 * inverse_distance_pow_6;
		
		float partialE1;
		float partialE2;
		float partialE3;
		float partialE4;

		//but only if the distance is less than distance cutoff value and 20.48A (because of the tables)
		//if ((distance_leo < 8.0f) && (distance_leo < 20.48f))
		if (distance_leo < 8.0f) 
		{
			char atom1_typeid = atom_types_localcache [atom1_id];
			char atom2_typeid = atom_types_localcache [atom2_id];

			//calculating van der Waals / hydrogen bond term
			
			partialE1 = VWpars_AC_localcache [atom1_typeid*DockConst_num_of_atypes+atom2_typeid]*inverse_distance_pow_12;
			/*
			partialE1 = native_divide(VWpars_AC_localcache [atom1_typeid*DockConst_num_of_atypes+atom2_typeid], distance_pow_12);
			*/

			float tmp_pE2 = VWpars_BD_localcache [atom1_typeid*DockConst_num_of_atypes+atom2_typeid];

			/*
			if (ref_intraE_contributors_const[2] == 1)	//H-bond
			*/
			if (ref_intraE_contributors_const.z == 1)	//H-bond
				partialE2 = tmp_pE2 * inverse_distance_pow_10;
				/*
				partialE2 = native_divide(tmp_pE2, distance_pow_10);
				*/
			else	//van der Waals
				partialE2 = tmp_pE2 * inverse_distance_pow_6;
				/*
				partialE2 = native_divide(tmp_pE2, distance_pow_6);
				*/
			//calculating electrostatic term
			/*
			partialE3 = DockConst_coeff_elec*atom_charges_localcache[atom1_id]*atom_charges_localcache[atom2_id]/(distance_leo*(-8.5525f + 86.9525f/(1.0f + 7.7839f*native_exp(-0.3154f*distance_leo))));
			*/
			partialE3 = native_divide(  (DockConst_coeff_elec*atom_charges_localcache[atom1_id]*atom_charges_localcache[atom2_id]) , (distance_leo*(-8.5525f + native_divide(86.9525f, (1.0f + 7.7839f*native_exp(-0.3154f*distance_leo)))))       );

			//calculating desolvation term
			partialE4 = (
				  (dspars_S_localcache[atom1_typeid] + DockConst_qasp*fabs(atom_charges_localcache[atom1_id])) * dspars_V_localcache[atom2_typeid] + 
				  (dspars_S_localcache[atom2_typeid] + DockConst_qasp*fabs(atom_charges_localcache[atom2_id])) * dspars_V_localcache[atom1_typeid]) * 
				 DockConst_coeff_desolv*native_exp(-0.0386f*distance_pow_2);

		} // End of if: if ((dist < dcutoff) && (dist < 20.48))	
	
#if defined (FIXED_POINT_INTRAE)
		//shift_intraE[32] = shift_intraE[0] + partialE1 + partialE2 + partialE3 + partialE4;
		shift_intraE[32] = shift_intraE[0] + fixedpt64_fromfloat(partialE1) + 
						     fixedpt64_fromfloat(partialE2) + 
						     fixedpt64_fromfloat(partialE3) + 
						     fixedpt64_fromfloat(partialE4);

		#pragma unroll
		for (uchar j=0; j<32; j++) {
			shift_intraE[j] = shift_intraE[j+1];
		}
#else
		intraE += partialE1 + partialE2 + partialE3 + partialE4;
#endif
	
	} // End of contributor_counter for-loop

#if defined (FIXED_POINT_INTRAE)
	fixedpt64 fixpt_intraE = 0;

	#pragma unroll
	for (uchar j=0; j<32; j++) {
		//intraE += shift_intraE[j];
		fixpt_intraE += shift_intraE[j];
	}
	intraE = fixedpt64_tofloat(fixpt_intraE);
#endif

	// --------------------------------------------------------------
	// Send intramolecular energy to channel
	// --------------------------------------------------------------
	switch (mode) {
		case /*0x01*/ 'I':	// IC
			write_channel_altera(chan_Intrae2StoreIC_intrae, intraE);
		break;

		case /*0x02*/ 'G':	// GG
			write_channel_altera(chan_Intrae2StoreGG_intrae, intraE);
		break;

		case /*0x03*/ 0x01:	// LS 1
			write_channel_altera(chan_Intrae2StoreLS_LS1_intrae, intraE);
		break;

		case 0x02:	// LS 2
			write_channel_altera(chan_Intrae2StoreLS_LS2_intrae, intraE);
		break;

		case 0x03:	// LS 3
			write_channel_altera(chan_Intrae2StoreLS_LS3_intrae, intraE);
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
