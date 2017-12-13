// --------------------------------------------------------------------------
// The function calculates the intermolecular energy of a ligand given by 
// myligand parameter, and a receptor represented as a grid. 
// The grid point values must be stored at the location which starts at GlobFgrids, 
// the memory content can be generated with get_gridvalues function.
// The mygrid parameter must be the corresponding grid informtaion. 
// If an atom is outside the grid, the coordinates will be changed with 
// the value of outofgrid_tolerance, 
// if it remains outside, a very high value will be added to the current energy as a penalty. 
// Originally from: processligand.c
// --------------------------------------------------------------------------
__kernel __attribute__ ((max_global_work_dim(0)))
void Krnl_InterE2(
             __constant float* restrict GlobFgrids,
 	     __constant float* restrict KerConstStatic_atom_charges_const,
 	     __constant char*  restrict KerConstStatic_atom_types_const,

			    unsigned char                    DockConst_g1,
  			    unsigned int                     DockConst_g2,
			    unsigned int                     DockConst_g3,
   			    unsigned char                    DockConst_num_of_atoms,
			    unsigned char                    DockConst_gridsize_x_minus1,
			    unsigned char                    DockConst_gridsize_y_minus1,
			    unsigned char                    DockConst_gridsize_z_minus1,
			    unsigned int                     Host_mul_tmp2,
			    unsigned int                     Host_mul_tmp3
)
{
	// local vars are allowed only at kernel scope
	// however, they can be moved inside loops and still be local
	// see how to do that here!

	bool active = true;

	__local char  atom_types_localcache   [MAX_NUM_OF_ATOMS];
	__local float atom_charges_localcache [MAX_NUM_OF_ATOMS];

	for (uchar i=0; i<DockConst_num_of_atoms; i++) {
		atom_types_localcache [i]   = KerConstStatic_atom_types_const   [i];
		atom_charges_localcache [i] = KerConstStatic_atom_charges_const [i];
	}

while(active) {

	char mode;

	float3 __attribute__ ((
			      memory,
			      numbanks(2),
			      bankwidth(16),
			      singlepump,
			      numreadports(1),
			      numwriteports(1)
			    )) loc_coords[MAX_NUM_OF_ATOMS];

	//printf("BEFORE In INTER CHANNEL\n");
	// --------------------------------------------------------------
	// Wait for ligand atomic coordinates in channel
	// --------------------------------------------------------------
	/*
	active = read_channel_altera(chan_Conf2Intere_LS2_active);
	mem_fence(CLK_CHANNEL_MEM_FENCE);

	mode   = read_channel_altera(chan_Conf2Intere_LS2_mode);
	mem_fence(CLK_CHANNEL_MEM_FENCE);

	for (uchar pipe_cnt=0; pipe_cnt<DockConst_num_of_atoms; pipe_cnt++) {
		loc_coords[pipe_cnt] = read_channel_altera(chan_Conf2Intere_LS2_xyz);
	}
	*/

	active = read_channel_altera(chan_Conf2Intere_LS2_active);
	mem_fence(CLK_CHANNEL_MEM_FENCE);

	for (uchar pipe_cnt=0; pipe_cnt<DockConst_num_of_atoms; pipe_cnt++) {
		if (pipe_cnt == 0) {
			mode   = read_channel_altera(chan_Conf2Intere_LS2_mode);
			mem_fence(CLK_CHANNEL_MEM_FENCE);
		}
		loc_coords[pipe_cnt] = read_channel_altera(chan_Conf2Intere_LS2_xyz);
	}
	// --------------------------------------------------------------
	//printf("AFTER In INTER CHANNEL\n");

	#if defined (DEBUG_ACTIVE_KERNEL)
	if (active == 0) {printf("	%-20s: %s\n", "Krnl_InterE", "must be disabled");}
	#endif

	float interE = 0.0f;

	// for each atom
	for (uchar atom1_id=0; atom1_id<DockConst_num_of_atoms; atom1_id++)
	{
		char atom1_typeid = atom_types_localcache [atom1_id];

		float3 loc_coords_atid1 = loc_coords[atom1_id];
		float x = loc_coords_atid1.x;
		float y = loc_coords_atid1.y;
		float z = loc_coords_atid1.z;
		float q = atom_charges_localcache [atom1_id];	

		float partialE1;
		float partialE2;
		float partialE3;

		// if the atom is outside of the grid
		if ((x < 0.0f) || (x >= DockConst_gridsize_x_minus1) || 
		    (y < 0.0f) || (y >= DockConst_gridsize_y_minus1) ||
		    (z < 0.0f) || (z >= DockConst_gridsize_z_minus1))	{
			//penalty is 2^24 for each atom outside the grid
			/*
			interE += 16777216.0f; 
			*/
			partialE1 = 16777216.0f; 
			partialE2 = 0.0f;
			partialE3 = 0.0f;
		} 
		else 
		{
			int x_low  = convert_int(floor(x));
			int y_low  = convert_int(floor(y));
			int z_low  = convert_int(floor(z));
			int x_high = convert_int(ceil(x));	 
			int y_high = convert_int(ceil(y));
			int z_high = convert_int(ceil(z));
			float dx = x - x_low; 
			float dy = y - y_low; 
			float dz = z - z_low;

			// Calculates the weights for trilinear interpolation
			// based on the location of the point inside
			float weights [2][2][2];
			weights [0][0][0] = (1-dx)*(1-dy)*(1-dz);
			weights [1][0][0] = dx*(1-dy)*(1-dz);
			weights [0][1][0] = (1-dx)*dy*(1-dz);
			weights [1][1][0] = dx*dy*(1-dz);
			weights [0][0][1] = (1-dx)*(1-dy)*dz;
			weights [1][0][1] = dx*(1-dy)*dz;
			weights [0][1][1] = (1-dx)*dy*dz;
			weights [1][1][1] = dx*dy*dz;

			// lvs added temporal variables
			uint cube_000, cube_100, cube_010, cube_110, cube_001, cube_101, cube_011, cube_111;
/*
			uint mul_tmp;
*/

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

			//energy contribution of the current grid type
			float cube [2][2][2];
	                cube [0][0][0] = GlobFgrids[cube_000 + mul_tmp];
        	        cube [1][0][0] = GlobFgrids[cube_100 + mul_tmp];
        	        cube [0][1][0] = GlobFgrids[cube_010 + mul_tmp];
        	        cube [1][1][0] = GlobFgrids[cube_110 + mul_tmp];
        	        cube [0][0][1] = GlobFgrids[cube_001 + mul_tmp];
        	        cube [1][0][1] = GlobFgrids[cube_101 + mul_tmp];
        	        cube [0][1][1] = GlobFgrids[cube_011 + mul_tmp];
        	        cube [1][1][1] = GlobFgrids[cube_111 + mul_tmp];
		
			partialE1 = TRILININTERPOL(cube, weights);

			//energy contribution of the electrostatic grid
/*
			atom1_typeid = DockConst_num_of_atypes;
			mul_tmp = atom1_typeid * DockConst_g3;
*/
			uint mul_tmp2 = Host_mul_tmp2;

			cube [0][0][0] = GlobFgrids[cube_000 + mul_tmp2];
        	        cube [1][0][0] = GlobFgrids[cube_100 + mul_tmp2];
        	        cube [0][1][0] = GlobFgrids[cube_010 + mul_tmp2];
        	        cube [1][1][0] = GlobFgrids[cube_110 + mul_tmp2];
        	        cube [0][0][1] = GlobFgrids[cube_001 + mul_tmp2];
        	        cube [1][0][1] = GlobFgrids[cube_101 + mul_tmp2];
        	        cube [0][1][1] = GlobFgrids[cube_011 + mul_tmp2];
        	        cube [1][1][1] = GlobFgrids[cube_111 + mul_tmp2];

			partialE2 = q * TRILININTERPOL(cube, weights);
		
			//energy contribution of the desolvation grid
/*
			atom1_typeid = DockConst_num_of_atypes+1;
			mul_tmp = atom1_typeid * DockConst_g3;
*/
			uint mul_tmp3 = Host_mul_tmp3;

			cube [0][0][0] = GlobFgrids[cube_000 + mul_tmp3];
        	        cube [1][0][0] = GlobFgrids[cube_100 + mul_tmp3];
        	        cube [0][1][0] = GlobFgrids[cube_010 + mul_tmp3];
        	        cube [1][1][0] = GlobFgrids[cube_110 + mul_tmp3];
        	        cube [0][0][1] = GlobFgrids[cube_001 + mul_tmp3];
        	        cube [1][0][1] = GlobFgrids[cube_101 + mul_tmp3];
        	        cube [0][1][1] = GlobFgrids[cube_011 + mul_tmp3];
        	        cube [1][1][1] = GlobFgrids[cube_111 + mul_tmp3];

			partialE3 = fabs(q) * TRILININTERPOL(cube, weights);

		}

		interE += partialE1 + partialE2 + partialE3;
	} // End of atom1_id for-loop

	// --------------------------------------------------------------
	// Send intermolecular energy to chanel
	// --------------------------------------------------------------
	switch (mode) {
		case 0x02:	// LS 2
			write_channel_altera(chan_Intere2StoreLS_LS2_intere, interE);
		break;

		case 0x03:	// LS 3
			write_channel_altera(chan_Intere2StoreLS_LS3_intere, interE);
		break;
	}
	// --------------------------------------------------------------
 	
} // End of while(1)

	#if defined (DEBUG_ACTIVE_KERNEL)
	printf("	%-20s: %s\n", "Krnl_InterE", "disabled");
	#endif
}
// --------------------------------------------------------------------------
// --------------------------------------------------------------------------
