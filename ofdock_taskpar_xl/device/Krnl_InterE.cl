// --------------------------------------------------------------------------
// InterE calculates the intermolecular energy of a ligand given by 
// ligand xyz-positions, and a receptor represented as a grid. 
// The grid point values must be stored at the location which starts at GlobFgrids. 
// If an atom is remains outside the grid, 
// a very high value will be added to the current energy as a penalty. 
// Originally from: processligand.c
// --------------------------------------------------------------------------
/*
__kernel __attribute__ ((max_global_work_dim(0)))
*/
__kernel __attribute__ ((reqd_work_group_size(1,1,1)))
void Krnl_InterE(
             __global const float* restrict GlobFgrids,

#if defined (FIXED_POINT_INTERE)
 	     __constant fixedpt64* restrict KerConstStatic_atom_charges_const,
#else
 	     __constant float*     restrict KerConstStatic_atom_charges_const,
#endif

 	     __constant char*      restrict KerConstStatic_atom_types_const,

			    unsigned char                    DockConst_g1,
  			    unsigned int                     DockConst_g2,
			    unsigned int                     DockConst_g3,
   			    unsigned char                    DockConst_num_of_atoms,
#if defined (FIXED_POINT_INTERE)
			    unsigned char                    DockConst_gridsize_x_minus1,
			    unsigned char                    DockConst_gridsize_y_minus1,
			    unsigned char                    DockConst_gridsize_z_minus1,
#else
			    float                   	     DockConst_gridsize_x_minus1,
			    float                    	     DockConst_gridsize_y_minus1,
			    float                    	     DockConst_gridsize_z_minus1,
#endif
/*
#if defined(SEPARATE_FGRID_INTERE)
	     __constant float* restrict GlobFgrids2,
	     __constant float* restrict GlobFgrids3
#else
*/
			    unsigned int                     Host_mul_tmp2,
			    unsigned int                     Host_mul_tmp3
/*
#endif
*/
)
{
	char active = 0x01;

	__global const float* GlobFgrids2 = & GlobFgrids [Host_mul_tmp2];
	__global const float* GlobFgrids3 = & GlobFgrids [Host_mul_tmp3];

#pragma max_concurrency 32
while(active) {

	char mode;

/*
	float3 __attribute__ ((
			      memory,
			      numbanks(2),
			      bankwidth(16),
			      singlepump,
			      numreadports(1),
			      numwriteports(1)
			    )) loc_coords[MAX_NUM_OF_ATOMS];
*/
	float3 loc_coords[MAX_NUM_OF_ATOMS];

	//printf("BEFORE In INTER CHANNEL\n");
	// --------------------------------------------------------------
	// Wait for ligand atomic coordinates in channel
	// --------------------------------------------------------------

/*
	char2 actmode = read_channel_altera(chan_Conf2Intere_actmode);
*/
	char2 actmode;
	read_pipe_block(chan_Conf2Intere_actmode, &actmode);
/*
	mem_fence(CLK_CHANNEL_MEM_FENCE);
*/

	active = actmode.x;
	mode   = actmode.y;

	for (uchar pipe_cnt=0; pipe_cnt<DockConst_num_of_atoms; pipe_cnt+=2) {
/*
		float8 tmp = read_channel_altera(chan_Conf2Intere_xyz);
*/
		float8 tmp;
		read_pipe_block(chan_Conf2Intere_xyz, &tmp);

		float3 tmp1 = {tmp.s0, tmp.s1, tmp.s2};
		float3 tmp2 = {tmp.s4, tmp.s5, tmp.s6};
		loc_coords[pipe_cnt] = tmp1;
		loc_coords[pipe_cnt+1] = tmp2;
	}

	// --------------------------------------------------------------
	//printf("AFTER In INTER CHANNEL\n");

	#if defined (DEBUG_ACTIVE_KERNEL)
	if (active == 0x00) {printf("	%-20s: %s\n", "Krnl_InterE", "must be disabled");}
	#endif

	#if defined (FIXED_POINT_INTERE)
	fixedpt64 fixpt_interE = 0;
	#else
	float interE = 0.0f;
	#endif

	// For each ligand atom
	for (uchar atom1_id=0; atom1_id<DockConst_num_of_atoms; atom1_id++)
	{
		char atom1_typeid = KerConstStatic_atom_types_const [atom1_id];

		float3 loc_coords_atid1 = loc_coords[atom1_id];

		float x = loc_coords_atid1.x;
		float y = loc_coords_atid1.y;
		float z = loc_coords_atid1.z;

		#if defined (FIXED_POINT_INTERE)

		#else
		float q = KerConstStatic_atom_charges_const [atom1_id];
		#endif

		#if defined (FIXED_POINT_INTERE)
		fixedpt64 fixpt_x = fixedpt64_fromfloat(loc_coords_atid1.x); 
		fixedpt64 fixpt_y = fixedpt64_fromfloat(loc_coords_atid1.y); 
		fixedpt64 fixpt_z = fixedpt64_fromfloat(loc_coords_atid1.z); 
//		fixedpt64 fixpt_q = fixedpt64_fromfloat(atom_charges_localcache [atom1_id]);
		fixedpt64 fixpt_q = KerConstStatic_atom_charges_const [atom1_id];
		#endif

		#if defined (FIXED_POINT_INTERE)
		fixedpt64 fixpt_partialE1;
		fixedpt64 fixpt_partialE2;
		fixedpt64 fixpt_partialE3;
		#else
		float partialE1;
		float partialE2;
		float partialE3;
		#endif

		// If the atom is outside of the grid
		#if defined (FIXED_POINT_INTERE)
		if ((fixpt_x < 0) || (fixpt_x >= fixedpt64_fromint(DockConst_gridsize_x_minus1)) || 
		    (fixpt_y < 0) || (fixpt_y >= fixedpt64_fromint(DockConst_gridsize_y_minus1)) ||
		    (fixpt_z < 0) || (fixpt_z >= fixedpt64_fromint(DockConst_gridsize_z_minus1))) {
		#else
		if ((x < 0.0f) || (x >= DockConst_gridsize_x_minus1) || 
		    (y < 0.0f) || (y >= DockConst_gridsize_y_minus1) ||
		    (z < 0.0f) || (z >= DockConst_gridsize_z_minus1))	{
		#endif

			// Penalty is 2^24 for each atom outside the grid
			/*
			interE += 16777216.0f; 
			*/
			#if defined (FIXED_POINT_INTERE)
			fixpt_partialE1 = /*fixedpt64_fromfloat(16777216.0f)*/ 0x100000000000000;
			fixpt_partialE2 = 0;
			fixpt_partialE3 = 0;
			#else
			partialE1 = 16777216.0f; 
			partialE2 = 0.0f;
			partialE3 = 0.0f;
			#endif
		} 
		else 
		{
			int x_low  = convert_int(floor(x));
			int y_low  = convert_int(floor(y));
			int z_low  = convert_int(floor(z));
			int x_high = convert_int(ceil(x));	 
			int y_high = convert_int(ceil(y));
			int z_high = convert_int(ceil(z));

			#if defined (FIXED_POINT_INTERE)
			fixedpt64 fixpt_x_low  = fixedpt64_floor(fixpt_x); 
			fixedpt64 fixpt_y_low  = fixedpt64_floor(fixpt_y);
			fixedpt64 fixpt_z_low  = fixedpt64_floor(fixpt_z);
			fixedpt64 fixpt_x_high = fixedpt64_ceil(fixpt_x);	 
			fixedpt64 fixpt_y_high = fixedpt64_ceil(fixpt_y);
			fixedpt64 fixpt_z_high = fixedpt64_ceil(fixpt_z);
			#endif

			#if defined (FIXED_POINT_INTERE)
			fixedpt64 fixpt_dx = fixedpt64_sub(fixpt_x, fixpt_x_low); 
			fixedpt64 fixpt_dy = fixedpt64_sub(fixpt_y, fixpt_y_low); 
			fixedpt64 fixpt_dz = fixedpt64_sub(fixpt_z, fixpt_z_low);
			#else
			float dx = x - x_low; 
			float dy = y - y_low; 
			float dz = z - z_low;
			#endif

			// Calculates the weights for trilinear interpolation
			// based on the location of the point inside
			#if defined (FIXED_POINT_INTERE)
			fixedpt64 fixpt_weights [2][2][2];
			fixpt_weights [0][0][0] = fixedpt64_mul((FIXEDPT64_ONE-fixpt_dx), fixedpt64_mul((FIXEDPT64_ONE-fixpt_dy), (FIXEDPT64_ONE-fixpt_dz)));
			fixpt_weights [1][0][0] = fixedpt64_mul(fixpt_dx, fixedpt64_mul((FIXEDPT64_ONE-fixpt_dy), (FIXEDPT64_ONE-fixpt_dz)));
			fixpt_weights [0][1][0] = fixedpt64_mul((FIXEDPT64_ONE-fixpt_dx), fixedpt64_mul(fixpt_dy,(FIXEDPT64_ONE-fixpt_dz)));
			fixpt_weights [1][1][0] = fixedpt64_mul(fixpt_dx, fixedpt64_mul(fixpt_dy, (FIXEDPT64_ONE-fixpt_dz)));
			fixpt_weights [0][0][1] = fixedpt64_mul((FIXEDPT64_ONE-fixpt_dx), fixedpt64_mul((FIXEDPT64_ONE-fixpt_dy), fixpt_dz));
			fixpt_weights [1][0][1] = fixedpt64_mul(fixpt_dx, fixedpt64_mul((FIXEDPT64_ONE-fixpt_dy), fixpt_dz));
			fixpt_weights [0][1][1] = fixedpt64_mul((FIXEDPT64_ONE-fixpt_dx), fixedpt64_mul(fixpt_dy, fixpt_dz));
			fixpt_weights [1][1][1] = fixedpt64_mul(fixpt_dx, fixedpt64_mul(fixpt_dy, fixpt_dz));
			#else
			float weights [2][2][2];
			weights [0][0][0] = (1-dx)*(1-dy)*(1-dz);
			weights [1][0][0] = dx*(1-dy)*(1-dz);
			weights [0][1][0] = (1-dx)*dy*(1-dz);
			weights [1][1][0] = dx*dy*(1-dz);
			weights [0][0][1] = (1-dx)*(1-dy)*dz;
			weights [1][0][1] = dx*(1-dy)*dz;
			weights [0][1][1] = (1-dx)*dy*dz;
			weights [1][1][1] = dx*dy*dz;
			#endif

			#if defined (DEBUG_KRNL_INTERE)
			printf("\n\nPartial results for atom with id %i:\n", atom1_id);
			printf("x_low = %d, x_high = %d, x_frac = %f\n", x_low, x_high, dx);
			printf("y_low = %d, y_high = %d, y_frac = %f\n", y_low, y_high, dy);
			printf("z_low = %d, z_high = %d, z_frac = %f\n\n", z_low, z_high, dz);
			printf("coeff(0,0,0) = %f\n", weights [0][0][0]);
			printf("coeff(1,0,0) = %f\n", weights [1][0][0]);
			printf("coeff(0,1,0) = %f\n", weights [0][1][0]);
			printf("coeff(1,1,0) = %f\n", weights [1][1][0]);
			printf("coeff(0,0,1) = %f\n", weights [0][0][1]);
			printf("coeff(1,0,1) = %f\n", weights [1][0][1]);
			printf("coeff(0,1,1) = %f\n", weights [0][1][1]);
			printf("coeff(1,1,1) = %f\n", weights [1][1][1]);
			#endif

			// Added temporal variables
			uint cube_000, cube_100, cube_010, cube_110, cube_001, cube_101, cube_011, cube_111;

			uint ylow_times_g1  = y_low  * DockConst_g1;	
			uint yhigh_times_g1 = y_high * DockConst_g1;
        	        uint zlow_times_g2  = z_low  * DockConst_g2;	
			uint zhigh_times_g2 = z_high * DockConst_g2;

        	        cube_000 = x_low  + ylow_times_g1  + zlow_times_g2;
        	        cube_100 = x_high + ylow_times_g1  + zlow_times_g2;
        	        cube_010 = x_low  + yhigh_times_g1 + zlow_times_g2;
        	        cube_110 = x_high + yhigh_times_g1 + zlow_times_g2;
        	        cube_001 = x_low  + ylow_times_g1  + zhigh_times_g2;
        	        cube_101 = x_high + ylow_times_g1  + zhigh_times_g2;
        	        cube_011 = x_low  + yhigh_times_g1 + zhigh_times_g2;
        	        cube_111 = x_high + yhigh_times_g1 + zhigh_times_g2;

			uint mul_tmp = atom1_typeid * DockConst_g3;

			// Energy contribution of the current grid type
			#if defined (FIXED_POINT_INTERE)
			fixedpt64 fixpt_cube [2][2][2];
	                fixpt_cube [0][0][0] = fixedpt64_fromfloat(GlobFgrids[cube_000 + mul_tmp]);
        	        fixpt_cube [1][0][0] = fixedpt64_fromfloat(GlobFgrids[cube_100 + mul_tmp]);
        	        fixpt_cube [0][1][0] = fixedpt64_fromfloat(GlobFgrids[cube_010 + mul_tmp]);
        	        fixpt_cube [1][1][0] = fixedpt64_fromfloat(GlobFgrids[cube_110 + mul_tmp]);
        	        fixpt_cube [0][0][1] = fixedpt64_fromfloat(GlobFgrids[cube_001 + mul_tmp]);
        	        fixpt_cube [1][0][1] = fixedpt64_fromfloat(GlobFgrids[cube_101 + mul_tmp]);
        	        fixpt_cube [0][1][1] = fixedpt64_fromfloat(GlobFgrids[cube_011 + mul_tmp]);
        	        fixpt_cube [1][1][1] = fixedpt64_fromfloat(GlobFgrids[cube_111 + mul_tmp]);
			#else
			float cube [2][2][2];
	                cube [0][0][0] = GlobFgrids[cube_000 + mul_tmp];
        	        cube [1][0][0] = GlobFgrids[cube_100 + mul_tmp];
        	        cube [0][1][0] = GlobFgrids[cube_010 + mul_tmp];
        	        cube [1][1][0] = GlobFgrids[cube_110 + mul_tmp];
        	        cube [0][0][1] = GlobFgrids[cube_001 + mul_tmp];
        	        cube [1][0][1] = GlobFgrids[cube_101 + mul_tmp];
        	        cube [0][1][1] = GlobFgrids[cube_011 + mul_tmp];
        	        cube [1][1][1] = GlobFgrids[cube_111 + mul_tmp];
			#endif
		
			#if defined (DEBUG_KRNL_INTERE)
			printf("Interpolation of van der Waals map:\n");
			printf("cube(0,0,0) = %f\n", cube [0][0][0]);
			printf("cube(1,0,0) = %f\n", cube [1][0][0]);
			printf("cube(0,1,0) = %f\n", cube [0][1][0]);
			printf("cube(1,1,0) = %f\n", cube [1][1][0]);
			printf("cube(0,0,1) = %f\n", cube [0][0][1]);
			printf("cube(1,0,1) = %f\n", cube [1][0][1]);
			printf("cube(0,1,1) = %f\n", cube [0][1][1]);
			printf("cube(1,1,1) = %f\n", cube [1][1][1]);
			#endif

			#if defined (FIXED_POINT_INTERE)
			fixpt_partialE1 = fixedpt64_mul(fixpt_cube[0][0][0], fixpt_weights[0][0][0]) +
				    	  fixedpt64_mul(fixpt_cube[1][0][0], fixpt_weights[1][0][0]) +
				    	  fixedpt64_mul(fixpt_cube[0][1][0], fixpt_weights[0][1][0]) +
				    	  fixedpt64_mul(fixpt_cube[1][1][0], fixpt_weights[1][1][0]) + 
				    	  fixedpt64_mul(fixpt_cube[0][0][1], fixpt_weights[0][0][1]) +
				     	  fixedpt64_mul(fixpt_cube[1][0][1], fixpt_weights[1][0][1]) + 
				    	  fixedpt64_mul(fixpt_cube[0][1][1], fixpt_weights[0][1][1]) +
				    	  fixedpt64_mul(fixpt_cube[1][1][1], fixpt_weights[1][1][1]);
			#else
			/*partialE1 = TRILININTERPOL(cube, weights);*/
			partialE1 = cube[0][0][0] * weights[0][0][0] +
				    cube[1][0][0] * weights[1][0][0] +
				    cube[0][1][0] * weights[0][1][0] +
				    cube[1][1][0] * weights[1][1][0] + 
				    cube[0][0][1] * weights[0][0][1] +
				    cube[1][0][1] * weights[1][0][1] + 
				    cube[0][1][1] * weights[0][1][1] +
				    cube[1][1][1] * weights[1][1][1];
			#endif

			#if defined (DEBUG_KRNL_INTERE)
			printf("interpolated value = %f\n\n", TRILININTERPOL(cube, weights));
			#endif

			// Energy contribution of the electrostatic grid
			/*
			#if defined(SEPARATE_FGRID_INTERE)
			#else
			uint mul_tmp2 = Host_mul_tmp2;
			#endif
			*/

			#if defined (FIXED_POINT_INTERE)
			fixpt_cube [0][0][0] = fixedpt64_fromfloat(GlobFgrids[cube_000 + mul_tmp2]);
        	        fixpt_cube [1][0][0] = fixedpt64_fromfloat(GlobFgrids[cube_100 + mul_tmp2]);
        	        fixpt_cube [0][1][0] = fixedpt64_fromfloat(GlobFgrids[cube_010 + mul_tmp2]);
        	        fixpt_cube [1][1][0] = fixedpt64_fromfloat(GlobFgrids[cube_110 + mul_tmp2]);
        	        fixpt_cube [0][0][1] = fixedpt64_fromfloat(GlobFgrids[cube_001 + mul_tmp2]);
        	        fixpt_cube [1][0][1] = fixedpt64_fromfloat(GlobFgrids[cube_101 + mul_tmp2]);
        	        fixpt_cube [0][1][1] = fixedpt64_fromfloat(GlobFgrids[cube_011 + mul_tmp2]);
        	        fixpt_cube [1][1][1] = fixedpt64_fromfloat(GlobFgrids[cube_111 + mul_tmp2]);
			#else
			cube [0][0][0] = GlobFgrids2[cube_000] /*GlobFgrids [Host_mul_tmp2 + cube_000]*/;
                        cube [1][0][0] = GlobFgrids2[cube_100] /*GlobFgrids [Host_mul_tmp2 + cube_100]*/;
                        cube [0][1][0] = GlobFgrids2[cube_010] /*GlobFgrids [Host_mul_tmp2 + cube_010]*/;
                        cube [1][1][0] = GlobFgrids2[cube_110] /*GlobFgrids [Host_mul_tmp2 + cube_110]*/;
                        cube [0][0][1] = GlobFgrids2[cube_001] /*GlobFgrids [Host_mul_tmp2 + cube_001]*/;
                        cube [1][0][1] = GlobFgrids2[cube_101] /*GlobFgrids [Host_mul_tmp2 + cube_101]*/;
                        cube [0][1][1] = GlobFgrids2[cube_011] /*GlobFgrids [Host_mul_tmp2 + cube_011]*/;
                        cube [1][1][1] = GlobFgrids2[cube_111] /*GlobFgrids [Host_mul_tmp2 + cube_111]*/;
			#endif

			#if defined (DEBUG_KRNL_INTERE)
			printf("Interpolation of electrostatic map:\n");
			printf("cube(0,0,0) = %f\n", cube [0][0][0]);
			printf("cube(1,0,0) = %f\n", cube [1][0][0]);
			printf("cube(0,1,0) = %f\n", cube [0][1][0]);
			printf("cube(1,1,0) = %f\n", cube [1][1][0]);
			printf("cube(0,0,1) = %f\n", cube [0][0][1]);
			printf("cube(1,0,1) = %f\n", cube [1][0][1]);
			printf("cube(0,1,1) = %f\n", cube [0][1][1]);
			printf("cube(1,1,1) = %f\n", cube [1][1][1]);
			#endif

			#if defined (FIXED_POINT_INTERE)
			fixpt_partialE2 = fixedpt64_mul(fixpt_q, 
								(
						         fixedpt64_mul(fixpt_cube[0][0][0], fixpt_weights[0][0][0]) +
				    			 fixedpt64_mul(fixpt_cube[1][0][0], fixpt_weights[1][0][0]) +
				    	 		 fixedpt64_mul(fixpt_cube[0][1][0], fixpt_weights[0][1][0]) +
						    	 fixedpt64_mul(fixpt_cube[1][1][0], fixpt_weights[1][1][0]) + 
						    	 fixedpt64_mul(fixpt_cube[0][0][1], fixpt_weights[0][0][1]) +
						    	 fixedpt64_mul(fixpt_cube[1][0][1], fixpt_weights[1][0][1]) + 
						    	 fixedpt64_mul(fixpt_cube[0][1][1], fixpt_weights[0][1][1]) +
						    	 fixedpt64_mul(fixpt_cube[1][1][1], fixpt_weights[1][1][1])
								)
							);
			#else
			/*partialE2 = q * TRILININTERPOL(cube, weights);*/
			partialE2 = q * (cube[0][0][0] * weights[0][0][0] +
				    	 cube[1][0][0] * weights[1][0][0] +
				    	 cube[0][1][0] * weights[0][1][0] +
				    	 cube[1][1][0] * weights[1][1][0] + 
				    	 cube[0][0][1] * weights[0][0][1] +
				    	 cube[1][0][1] * weights[1][0][1] + 
				    	 cube[0][1][1] * weights[0][1][1] +
				    	 cube[1][1][1] * weights[1][1][1]);
			#endif
		
			#if defined (DEBUG_KRNL_INTERE)
			printf("interpolated value = %f, multiplied by q = %f\n\n", TRILININTERPOL(cube, weights), q*TRILININTERPOL(cube, weights));
			#endif

			// Energy contribution of the desolvation grid
			/*
			#if defined(SEPARATE_FGRID_INTERE)
			#else
			uint mul_tmp3 = Host_mul_tmp3;
			#endif
			*/

			#if defined (FIXED_POINT_INTERE)
			fixpt_cube [0][0][0] = fixedpt64_fromfloat(GlobFgrids[cube_000 + mul_tmp3]);
        	        fixpt_cube [1][0][0] = fixedpt64_fromfloat(GlobFgrids[cube_100 + mul_tmp3]);
        	        fixpt_cube [0][1][0] = fixedpt64_fromfloat(GlobFgrids[cube_010 + mul_tmp3]);
        	        fixpt_cube [1][1][0] = fixedpt64_fromfloat(GlobFgrids[cube_110 + mul_tmp3]);
        	        fixpt_cube [0][0][1] = fixedpt64_fromfloat(GlobFgrids[cube_001 + mul_tmp3]);
        	        fixpt_cube [1][0][1] = fixedpt64_fromfloat(GlobFgrids[cube_101 + mul_tmp3]);
        	        fixpt_cube [0][1][1] = fixedpt64_fromfloat(GlobFgrids[cube_011 + mul_tmp3]);
        	        fixpt_cube [1][1][1] = fixedpt64_fromfloat(GlobFgrids[cube_111 + mul_tmp3]);
			#else
			cube [0][0][0] = GlobFgrids3[cube_000] /*GlobFgrids [Host_mul_tmp3 + cube_000]*/;
                        cube [1][0][0] = GlobFgrids3[cube_100] /*GlobFgrids [Host_mul_tmp3 + cube_100]*/;
                        cube [0][1][0] = GlobFgrids3[cube_010] /*GlobFgrids [Host_mul_tmp3 + cube_010]*/;
                        cube [1][1][0] = GlobFgrids3[cube_110] /*GlobFgrids [Host_mul_tmp3 + cube_110]*/;
                        cube [0][0][1] = GlobFgrids3[cube_001] /*GlobFgrids [Host_mul_tmp3 + cube_001]*/;
                        cube [1][0][1] = GlobFgrids3[cube_101] /*GlobFgrids [Host_mul_tmp3 + cube_101]*/;
                        cube [0][1][1] = GlobFgrids3[cube_011] /*GlobFgrids [Host_mul_tmp3 + cube_011]*/;
                        cube [1][1][1] = GlobFgrids3[cube_111] /*GlobFgrids [Host_mul_tmp3 + cube_111]*/;
			#endif

			#if defined (DEBUG_KRNL_INTERE)
			printf("Interpolation of desolvation map:\n");
			printf("cube(0,0,0) = %f\n", cube [0][0][0]);
			printf("cube(1,0,0) = %f\n", cube [1][0][0]);
			printf("cube(0,1,0) = %f\n", cube [0][1][0]);
			printf("cube(1,1,0) = %f\n", cube [1][1][0]);
			printf("cube(0,0,1) = %f\n", cube [0][0][1]);
			printf("cube(1,0,1) = %f\n", cube [1][0][1]);
			printf("cube(0,1,1) = %f\n", cube [0][1][1]);
			printf("cube(1,1,1) = %f\n", cube [1][1][1]);
			#endif

			#if defined (FIXED_POINT_INTERE)
			fixpt_partialE3 = fixedpt64_mul(fixedpt64_abs(fixpt_q), 
								  	(
					       			fixedpt64_mul(fixpt_cube[0][0][0], fixpt_weights[0][0][0]) +
				    	       			fixedpt64_mul(fixpt_cube[1][0][0], fixpt_weights[1][0][0]) +
				    	       			fixedpt64_mul(fixpt_cube[0][1][0], fixpt_weights[0][1][0]) +
				    	       			fixedpt64_mul(fixpt_cube[1][1][0], fixpt_weights[1][1][0]) + 
				    	       			fixedpt64_mul(fixpt_cube[0][0][1], fixpt_weights[0][0][1]) +
				    	       			fixedpt64_mul(fixpt_cube[1][0][1], fixpt_weights[1][0][1]) + 
				    	       			fixedpt64_mul(fixpt_cube[0][1][1], fixpt_weights[0][1][1]) +
				    	       			fixedpt64_mul(fixpt_cube[1][1][1], fixpt_weights[1][1][1])
					      		          	)
						  	);
			#else
			/*partialE3 = fabs(q) * TRILININTERPOL(cube, weights);*/
			partialE3 = fabs(q) * (cube[0][0][0] * weights[0][0][0] +
				    	       cube[1][0][0] * weights[1][0][0] +
				    	       cube[0][1][0] * weights[0][1][0] +
				    	       cube[1][1][0] * weights[1][1][0] + 
				    	       cube[0][0][1] * weights[0][0][1] +
				    	       cube[1][0][1] * weights[1][0][1] + 
				    	       cube[0][1][1] * weights[0][1][1] +
				    	       cube[1][1][1] * weights[1][1][1]);
			#endif

			#if defined (DEBUG_KRNL_INTERE)
			printf("interpolated value = %f, multiplied by abs(q) = %f\n\n", TRILININTERPOL(cube, weights), fabs(q) * trilin_interpol(cube, weights));
			printf("Current value of intermolecular energy = %f\n\n\n", interE);
			#endif
		}

		#if defined (FIXED_POINT_INTERE)
		fixpt_interE += fixpt_partialE1 + fixpt_partialE2 + fixpt_partialE3;
		#else
		interE += partialE1 + partialE2 + partialE3;
		#endif
	} // End of atom1_id for-loop

	// --------------------------------------------------------------
	// Send intermolecular energy to chanel
	// --------------------------------------------------------------
	#if defined (FIXED_POINT_INTERE)
	float final_interE = fixedpt64_tofloat(fixpt_interE);
	#else
	float final_interE = interE;
	#endif

	switch (mode) {
/*
		case 'I':  write_channel_altera(chan_Intere2StoreIC_intere, final_interE);     break;
		case 'G':  write_channel_altera(chan_Intere2StoreGG_intere, final_interE);     break;
		case 0x01: write_channel_altera(chan_Intere2StoreLS_LS1_intere, final_interE); break;
		case 0x02: write_channel_altera(chan_Intere2StoreLS_LS2_intere, final_interE); break;
		case 0x03: write_channel_altera(chan_Intere2StoreLS_LS3_intere, final_interE); break;
		case 0x04: write_channel_altera(chan_Intere2StoreLS_LS4_intere, final_interE); break;
		case 0x05: write_channel_altera(chan_Intere2StoreLS_LS5_intere, final_interE); break;
		case 0x06: write_channel_altera(chan_Intere2StoreLS_LS6_intere, final_interE); break;
		case 0x07: write_channel_altera(chan_Intere2StoreLS_LS7_intere, final_interE); break;
		case 0x08: write_channel_altera(chan_Intere2StoreLS_LS8_intere, final_interE); break;
		case 0x09: write_channel_altera(chan_Intere2StoreLS_LS9_intere, final_interE); break;
*/
		case 'I':  write_pipe_block(chan_Intere2StoreIC_intere, &final_interE);     break;
		case 'G':  write_pipe_block(chan_Intere2StoreGG_intere, &final_interE);     break;
		case 0x01: write_pipe_block(chan_Intere2StoreLS_LS1_intere, &final_interE); break;
		case 0x02: write_pipe_block(chan_Intere2StoreLS_LS2_intere, &final_interE); break;
		case 0x03: write_pipe_block(chan_Intere2StoreLS_LS3_intere, &final_interE); break;
		case 0x04: write_pipe_block(chan_Intere2StoreLS_LS4_intere, &final_interE); break;
		case 0x05: write_pipe_block(chan_Intere2StoreLS_LS5_intere, &final_interE); break;
		case 0x06: write_pipe_block(chan_Intere2StoreLS_LS6_intere, &final_interE); break;
		case 0x07: write_pipe_block(chan_Intere2StoreLS_LS7_intere, &final_interE); break;
		case 0x08: write_pipe_block(chan_Intere2StoreLS_LS8_intere, &final_interE); break;
		case 0x09: write_pipe_block(chan_Intere2StoreLS_LS9_intere, &final_interE); break;
	}
	// --------------------------------------------------------------

	#if defined (DEBUG_KRNL_INTERE)
	printf("AFTER Out INTERE CHANNEL\n");
	#endif
 	
} // End of while(active)

	#if defined (DEBUG_ACTIVE_KERNEL)
	printf("	%-20s: %s\n", "Krnl_InterE", "disabled");
	#endif
}
// --------------------------------------------------------------------------
// --------------------------------------------------------------------------

