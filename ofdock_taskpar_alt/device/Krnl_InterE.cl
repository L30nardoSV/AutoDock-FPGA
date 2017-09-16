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
void Krnl_InterE(
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
			    unsigned char                    DockConst_num_of_atypes
)
{
	// local vars are allowed only at kernel scope
	// however, they can be moved inside loops and still be local
	// see how to do that here!

	/*char active = 1;*/
	bool active = true;

/*
	__local char  ref_atom_types_const  [MAX_NUM_OF_ATOMS];
	__local float ref_atom_charges_const[MAX_NUM_OF_ATOMS];

	for (uchar i=0; i<DockConst_num_of_atoms; i++) {
		ref_atom_types_const [i]   = KerConstStatic_atom_types_const[i];
		ref_atom_charges_const [i] = KerConstStatic_atom_charges_const[i];
	}
*/
while(active) {
	char mode;

	//printf("BEFORE In INTER CHANNEL\n");
	// --------------------------------------------------------------
	// Wait for ligand atomic coordinates in channel
	// --------------------------------------------------------------
	active = read_channel_altera(chan_Conf2Intere_active);
	mem_fence(CLK_CHANNEL_MEM_FENCE);
	mode   = read_channel_altera(chan_Conf2Intere_mode);
	mem_fence(CLK_CHANNEL_MEM_FENCE);

	float __attribute__ ((
			      memory,
			      numbanks(2),
			      bankwidth(16),
			      singlepump,
			      numreadports(2),
			      numwriteports(1)
			    )) loc_coords[MAX_NUM_OF_ATOMS][3];

	float3 position_xyz;

	for (uchar pipe_cnt=0; pipe_cnt<DockConst_num_of_atoms; pipe_cnt++) {
		position_xyz = read_channel_altera(chan_Conf2Intere_xyz);
		loc_coords[pipe_cnt][0x0] = position_xyz.x;
		loc_coords[pipe_cnt][0x1] = position_xyz.y;
		loc_coords[pipe_cnt][0x2] = position_xyz.z;
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
		/*char atom1_typeid = ref_atom_types_const[atom1_id];*/
		char atom1_typeid = KerConstStatic_atom_types_const[atom1_id];
		float x = loc_coords[atom1_id][0x0];
		float y = loc_coords[atom1_id][0x1];
		float z = loc_coords[atom1_id][0x2];
		/*float q = ref_atom_charges_const[atom1_id];*/
		float q = KerConstStatic_atom_charges_const[atom1_id];

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

			// lvs added temporal variables
			uint cube_000, cube_100, cube_010, cube_110, cube_001, cube_101, cube_011, cube_111;
			uint mul_tmp;

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

			mul_tmp = atom1_typeid * DockConst_g3;

			//energy contribution of the current grid type
			float cube [2][2][2];
	                cube [0][0][0] = *(GlobFgrids + cube_000 + mul_tmp);
        	        cube [1][0][0] = *(GlobFgrids + cube_100 + mul_tmp);
        	        cube [0][1][0] = *(GlobFgrids + cube_010 + mul_tmp);
        	        cube [1][1][0] = *(GlobFgrids + cube_110 + mul_tmp);
        	        cube [0][0][1] = *(GlobFgrids + cube_001 + mul_tmp);
        	        cube [1][0][1] = *(GlobFgrids + cube_101 + mul_tmp);
        	        cube [0][1][1] = *(GlobFgrids + cube_011 + mul_tmp);
        	        cube [1][1][1] = *(GlobFgrids + cube_111 + mul_tmp);
		
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

			partialE1 = TRILININTERPOL(cube, weights);

			#if defined (DEBUG_KRNL_INTERE)
			printf("interpolated value = %f\n\n", TRILININTERPOL(cube, weights));
			#endif

			//energy contribution of the electrostatic grid
			atom1_typeid = DockConst_num_of_atypes;
			mul_tmp = atom1_typeid * DockConst_g3;

        	        cube [0][0][0] = *(GlobFgrids + cube_000 + mul_tmp);
        	        cube [1][0][0] = *(GlobFgrids + cube_100 + mul_tmp);
        	        cube [0][1][0] = *(GlobFgrids + cube_010 + mul_tmp);
        	        cube [1][1][0] = *(GlobFgrids + cube_110 + mul_tmp);
        	        cube [0][0][1] = *(GlobFgrids + cube_001 + mul_tmp);
        	        cube [1][0][1] = *(GlobFgrids + cube_101 + mul_tmp);
        	        cube [0][1][1] = *(GlobFgrids + cube_011 + mul_tmp);
        	        cube [1][1][1] = *(GlobFgrids + cube_111 + mul_tmp);

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

			partialE2 = q * TRILININTERPOL(cube, weights);
		
			#if defined (DEBUG_KRNL_INTERE)
			printf("interpolated value = %f, multiplied by q = %f\n\n", TRILININTERPOL(cube, weights), q*TRILININTERPOL(cube, weights));
			#endif

			//energy contribution of the desolvation grid
			atom1_typeid = DockConst_num_of_atypes+1;
			mul_tmp = atom1_typeid * DockConst_g3;

        	        cube [0][0][0] = *(GlobFgrids + cube_000 + mul_tmp);
        	        cube [1][0][0] = *(GlobFgrids + cube_100 + mul_tmp);
        	        cube [0][1][0] = *(GlobFgrids + cube_010 + mul_tmp);
        	        cube [1][1][0] = *(GlobFgrids + cube_110 + mul_tmp);
        	        cube [0][0][1] = *(GlobFgrids + cube_001 + mul_tmp);
        	        cube [1][0][1] = *(GlobFgrids + cube_101 + mul_tmp);
        	        cube [0][1][1] = *(GlobFgrids + cube_011 + mul_tmp);
        	        cube [1][1][1] = *(GlobFgrids + cube_111 + mul_tmp);

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

			partialE3 = fabs(q) * TRILININTERPOL(cube, weights);

			#if defined (DEBUG_KRNL_INTERE)
			printf("interpolated value = %f, multiplied by abs(q) = %f\n\n", TRILININTERPOL(cube, weights), fabs(q) * trilin_interpol(cube, weights));
			printf("Current value of intermolecular energy = %f\n\n\n", interE);
			#endif
		}

		interE += partialE1 + partialE2 + partialE3;
	} // End of atom1_id for-loop

	// --------------------------------------------------------------
	// Send intermolecular energy to chanel
	// --------------------------------------------------------------
	switch (mode) {
		case 0x01:	// IC
			write_channel_altera(chan_Intere2StoreIC_intere, interE);
		break;

		case 0x02:	// GG
			write_channel_altera(chan_Intere2StoreGG_intere, interE);
		break;

		case 0x03:	// LS
			write_channel_altera(chan_Intere2StoreLS_intere, interE);
		break;

		//case 5:	// Off
		//	write_channel_altera(chan_Intere2StoreOff_intere, interE);
		//break;
	}
	// --------------------------------------------------------------
 	
} // End of while(1)

	#if defined (DEBUG_ACTIVE_KERNEL)
	printf("	%-20s: %s\n", "Krnl_InterE", "disabled");
	#endif
}
// --------------------------------------------------------------------------
// --------------------------------------------------------------------------
