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
//__attribute__ ((reqd_work_group_size(1,1,1)))
void Krnl_InterE(
             __global const float*           restrict GlobFgrids,
	     //__global const kernelconstant*  restrict KerConst,
	     __global const kernelconstant_static*  restrict KerConstStatic,
	     //__global const Dockparameters*  restrict DockConst
	     __constant     Dockparameters*  restrict DockConst
		//      const unsigned char 		      DockConst_gridsize_x,
		//      const unsigned char 		      DockConst_gridsize_y,
		//      const unsigned char 		      DockConst_gridsize_z,
		//      const unsigned char 		      DockConst_g1,
		//      const unsigned int 		      DockConst_g2,
		//      const unsigned int 		      DockConst_g3,
		//      const unsigned char 		      DockConst_num_of_atoms,
		//      const unsigned char 		      DockConst_num_of_atypes	
)
{
/*
	__local float loc_coords_x[MAX_NUM_OF_ATOMS];
	__local float loc_coords_y[MAX_NUM_OF_ATOMS];
	__local float loc_coords_z[MAX_NUM_OF_ATOMS];
*/

	float __attribute__((register)) loc_coords_x[MAX_NUM_OF_ATOMS];
	float __attribute__((register)) loc_coords_y[MAX_NUM_OF_ATOMS];
	float __attribute__((register)) loc_coords_z[MAX_NUM_OF_ATOMS];


	char active = 1;
	char mode   = 0;
	uint cnt    = 0;   

	float interE;
	float partialE1, partialE2, partialE3;


	//char atom1_id, atom1_typeid;
	char atom1_typeid;

	__local char  ref_atom_types_const  [MAX_NUM_OF_ATOMS];
	__local float ref_atom_charges_const[MAX_NUM_OF_ATOMS];

	for (uchar i=0; i<MAX_NUM_OF_ATOMS; i++) {
		//ref_atom_types_const [i] = KerConst->atom_types_const[i];
		ref_atom_types_const [i] = KerConstStatic->atom_types_const[i];
		//ref_atom_charges_const [i] = KerConst->atom_charges_const[i];
		ref_atom_charges_const [i] = KerConstStatic->atom_charges_const[i];
	}
	
	float x, y, z, dx, dy, dz, q;
	float cube [2][2][2];
	float weights [2][2][2];
	int x_low, x_high, y_low, y_high, z_low, z_high;

	// L30nardoSV	
	unsigned int  mul_tmp;
	//unsigned char g1 = DockConst->gridsize_x; 	
	//unsigned int  g2 = DockConst->gridsize_x * DockConst->gridsize_y;         
	//unsigned int  g3 = DockConst->gridsize_x * DockConst->gridsize_y * DockConst->gridsize_z;
		//unsigned char g1 = DockConst_gridsize_x; 	
		//unsigned int  g2 = DockConst_gridsize_x * DockConst_gridsize_y;         
		//unsigned int  g3 = DockConst_gridsize_x * DockConst_gridsize_y * DockConst_gridsize_z;

	//unsigned char g1 = DockConst_g1; 	
	//unsigned int  g2 = DockConst_g2;         
	//unsigned int  g3 = DockConst_g3;

	unsigned char g1 = DockConst->g1; 	
	unsigned int  g2 = DockConst->g2;         
	unsigned int  g3 = DockConst->g3;

        unsigned int  ylow_times_g1, yhigh_times_g1;
        unsigned int  zlow_times_g2, zhigh_times_g2;
	unsigned int  cube_000, cube_100, cube_010, cube_110;
        unsigned int  cube_001, cube_101, cube_011, cube_111;

while(active) {
	//printf("BEFORE In INTER CHANNEL\n");
	// --------------------------------------------------------------
	// Wait for ligand atomic coordinates in channel
	// --------------------------------------------------------------
	active = read_channel_altera(chan_Conf2Intere_active);
	mem_fence(CLK_CHANNEL_MEM_FENCE);
	mode   = read_channel_altera(chan_Conf2Intere_mode);
	mem_fence(CLK_CHANNEL_MEM_FENCE);
	cnt    = read_channel_altera(chan_Conf2Intere_cnt);
	mem_fence(CLK_CHANNEL_MEM_FENCE);

	//for (uint pipe_cnt=0; pipe_cnt<DockConst->num_of_atoms; pipe_cnt++) {
	for (uchar pipe_cnt=0; pipe_cnt<DockConst->num_of_atoms; pipe_cnt++) {
	//for (uchar pipe_cnt=0; pipe_cnt<DockConst_num_of_atoms; pipe_cnt++) {
		loc_coords_x[pipe_cnt] = read_channel_altera(chan_Conf2Intere_x);
		//mem_fence(CLK_CHANNEL_MEM_FENCE | CLK_LOCAL_MEM_FENCE);
		mem_fence(CLK_CHANNEL_MEM_FENCE);
		loc_coords_y[pipe_cnt] = read_channel_altera(chan_Conf2Intere_y);
		//mem_fence(CLK_CHANNEL_MEM_FENCE | CLK_LOCAL_MEM_FENCE);
		mem_fence(CLK_CHANNEL_MEM_FENCE);
		loc_coords_z[pipe_cnt] = read_channel_altera(chan_Conf2Intere_z);

	}
	// --------------------------------------------------------------
	//printf("AFTER In INTER CHANNEL\n");

	#if defined (DEBUG_ACTIVE_KERNEL)
	if (active == 0) {printf("	%-20s: %s\n", "Krnl_InterE", "must be disabled");}
	#endif

	interE = 0.0f;
	partialE1 = 0.0f;
	partialE2 = 0.0f;
	partialE3 = 0.0f;

	// for each atom
	// **********************************************
	// ADD VENDOR SPECIFIC PRAGMA	
	// **********************************************
	LOOP_INTERE_1:
	//for (atom1_id=0; atom1_id<DockConst->num_of_atoms; atom1_id++)	
	for (uchar atom1_id=0; atom1_id<DockConst->num_of_atoms; atom1_id++)
	//for (uchar atom1_id=0; atom1_id<DockConst_num_of_atoms; atom1_id++)	
	{
		//atom1_typeid = KerConst->atom_types_const[atom1_id];
		atom1_typeid = ref_atom_types_const[atom1_id];
		x = loc_coords_x[atom1_id];
		y = loc_coords_y[atom1_id];
		z = loc_coords_z[atom1_id];
		//q = KerConst->atom_charges_const[atom1_id];
		q = ref_atom_charges_const[atom1_id];

		// if the atom is outside of the grid
		if ((x < 0.0f) || (x >= DockConst->gridsize_x-1) || 
		    (y < 0.0f) || (y >= DockConst->gridsize_y-1) ||
		    (z < 0.0f) || (z >= DockConst->gridsize_z-1))	{
		//if ((x < 0.0f) || (x >= DockConst_gridsize_x-1) || 
		//    (y < 0.0f) || (y >= DockConst_gridsize_y-1) ||
		//    (z < 0.0f) || (z >= DockConst_gridsize_z-1))	{
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
			x_low  = convert_int(floor(x));
			y_low  = convert_int(floor(y));
			z_low  = convert_int(floor(z));
			x_high = convert_int(ceil(x));	 
			y_high = convert_int(ceil(y));
			z_high = convert_int(ceil(z));
			dx = x - x_low; dy = y - y_low; dz = z - z_low;

			// Calculates the weights for trilinear interpolation
			// based on the location of the point inside
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

			// L30nardoSV
			ylow_times_g1  = y_low*g1;	yhigh_times_g1 = y_high*g1;
        	        zlow_times_g2  = z_low*g2;	zhigh_times_g2 = z_high*g2;
        	        cube_000 = x_low  + ylow_times_g1  + zlow_times_g2;
        	        cube_100 = x_high + ylow_times_g1  + zlow_times_g2;
        	        cube_010 = x_low  + yhigh_times_g1 + zlow_times_g2;
        	        cube_110 = x_high + yhigh_times_g1 + zlow_times_g2;
        	        cube_001 = x_low  + ylow_times_g1  + zhigh_times_g2;
        	        cube_101 = x_high + ylow_times_g1  + zhigh_times_g2;
        	        cube_011 = x_low  + yhigh_times_g1 + zhigh_times_g2;
        	        cube_111 = x_high + yhigh_times_g1 + zhigh_times_g2;
        	        mul_tmp = atom1_typeid*g3;

			//energy contribution of the current grid type
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

			/*
			interE += TRILININTERPOL(cube, weights);
			*/
			partialE1 = TRILININTERPOL(cube, weights);

			#if defined (DEBUG_KRNL_INTERE)
			printf("interpolated value = %f\n\n", TRILININTERPOL(cube, weights));
			#endif

			//energy contribution of the electrostatic grid
			atom1_typeid = DockConst->num_of_atypes;
			//atom1_typeid = DockConst_num_of_atypes;
			mul_tmp = atom1_typeid*g3;
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

			/*
			interE += q * TRILININTERPOL(cube, weights);
			*/
			partialE2 = q * TRILININTERPOL(cube, weights);
		
			#if defined (DEBUG_KRNL_INTERE)
			printf("interpoated value = %f, multiplied by q = %f\n\n", TRILININTERPOL(cube, weights), q*TRILININTERPOL(cube, weights));
			#endif

			//energy contribution of the desolvation grid
			atom1_typeid = DockConst->num_of_atypes+1;
			//atom1_typeid = DockConst_num_of_atypes+1;
			mul_tmp = atom1_typeid*g3;
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

			/*
			interE += fabs(q) * TRILININTERPOL(cube, weights);
			*/
			partialE3 = fabs(q) * TRILININTERPOL(cube, weights);

			#if defined (DEBUG_KRNL_INTERE)
			printf("interploated value = %f, multiplied by abs(q) = %f\n\n", TRILININTERPOL(cube, weights), fabs(q) * trilin_interpol(cube, weights));
			printf("Current value of intermolecular energy = %f\n\n\n", interE);
			#endif
		}


		interE += partialE1 + partialE2 + partialE3;
	} // End of LOOP_INTERE_1:	

	// --------------------------------------------------------------
	// Send intermolecular energy to chanel
	// --------------------------------------------------------------
	write_channel_altera(chan_Intere2Store_intere, interE);
	mem_fence(CLK_CHANNEL_MEM_FENCE);
	write_channel_altera(chan_Intere2Store_active, active);
	mem_fence(CLK_CHANNEL_MEM_FENCE);
	write_channel_altera(chan_Intere2Store_mode,   mode);
	mem_fence(CLK_CHANNEL_MEM_FENCE);
	write_channel_altera(chan_Intere2Store_cnt,    cnt);
	// --------------------------------------------------------------
 	
	} // End of while(1)

	#if defined (DEBUG_ACTIVE_KERNEL)
	printf("	%-20s: %s\n", "Krnl_InterE", "disabled");
	#endif
}
// --------------------------------------------------------------------------
// --------------------------------------------------------------------------
