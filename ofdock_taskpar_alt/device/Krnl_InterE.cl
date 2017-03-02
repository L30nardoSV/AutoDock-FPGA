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
__kernel __attribute__ ((reqd_work_group_size(1,1,1)))
void Krnl_InterE(__global const float*           restrict GlobFgrids,
		 __global const Ligandconstant*  restrict LigConst,
		 __global const Gridconstant*    restrict GridConst)
{
#ifdef EMULATOR
	printf("Krnl InterE!!\n");
	printf("GridConst->size_x = %u\n", GridConst->size_x);	
	printf("GridConst->size_y = %u\n", GridConst->size_y);
	printf("GridConst->size_z = %u\n", GridConst->size_z);
	printf("GridConst->g1 = %u\n", GridConst->g1);
	printf("GridConst->g2 = %u\n", GridConst->g2);
	printf("GridConst->g3 = %u\n", GridConst->g3);
	printf("GridConst->spacing  = %f\n", GridConst->spacing);
	printf("GridConst->num_of_atypes = %u\n", GridConst->num_of_atypes);
#endif
	// --------------------------------------------------------------
	// Wait for ligand data
	// --------------------------------------------------------------
	__local float myligand_atom_idxyzq[MAX_NUM_OF_ATOMS*5];

	uint init_cnt;

	for(init_cnt=0; init_cnt<LigConst->num_of_atoms*5; init_cnt++)
	{
		myligand_atom_idxyzq[init_cnt] = read_channel_altera(chan_Conf2Intere_ligandatom_idxyzq);
	}
	// --------------------------------------------------------------

	int atom_cnt;
	uint atom_cnt_times_5;
	float x, y, z, dx, dy, dz, q;
	float cube [2][2][2];
	float weights [2][2][2];
	int x_low, x_high, y_low, y_high, z_low, z_high;

	int typeid;




	float interE = 0.0f;
	float interE_OUTGRID = 0.0f;
	float interE_INGRID  = 0.0f;

	// L30nardoSV	
	unsigned int mul_tmp;
        unsigned int ylow_times_g1, yhigh_times_g1;
        unsigned int zlow_times_g2, zhigh_times_g2;
        
	unsigned int cube_000, cube_100, cube_010, cube_110;
        unsigned int cube_001, cube_101, cube_011, cube_111;

	// for each atom
	// **********************************************
	// ADD VENDOR SPECIFIC PRAGMA	
	// **********************************************
	LOOP_INTERE_1:
	for (atom_cnt=LigConst->num_of_atoms-1; atom_cnt>=0; atom_cnt--)		
	{
		atom_cnt_times_5 = atom_cnt*5;
		typeid = convert_int(myligand_atom_idxyzq [atom_cnt_times_5]);
		x = myligand_atom_idxyzq [atom_cnt_times_5+1];
		y = myligand_atom_idxyzq [atom_cnt_times_5+2];
		z = myligand_atom_idxyzq [atom_cnt_times_5+3];
		q = myligand_atom_idxyzq [atom_cnt_times_5+4];

		// if the atom is outside of the grid
		if ((x < 0.0f) || (x >= GridConst->size_x-1) || 
		    (y < 0.0f) || (y >= GridConst->size_y-1) ||
		    (z < 0.0f) || (z >= GridConst->size_z-1))	
		{
			interE_OUTGRID += 16777216.0f; //penalty is 2^24 for each atom outside the grid
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

			#if defined (DEBUG_KERNEL_INTER_E)
			printf("\n\nPartial results for atom with id %i:\n", atom_cnt);
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
			ylow_times_g1  = y_low*GridConst->g1;	yhigh_times_g1 = y_high*GridConst->g1;
        	        zlow_times_g2  = z_low*GridConst->g2;	zhigh_times_g2 = z_high*GridConst->g2;
        	        cube_000 = x_low  + ylow_times_g1  + zlow_times_g2;
        	        cube_100 = x_high + ylow_times_g1  + zlow_times_g2;
        	        cube_010 = x_low  + yhigh_times_g1 + zlow_times_g2;
        	        cube_110 = x_high + yhigh_times_g1 + zlow_times_g2;
        	        cube_001 = x_low  + ylow_times_g1  + zhigh_times_g2;
        	        cube_101 = x_high + ylow_times_g1  + zhigh_times_g2;
        	        cube_011 = x_low  + yhigh_times_g1 + zhigh_times_g2;
        	        cube_111 = x_high + yhigh_times_g1 + zhigh_times_g2;
        	        mul_tmp = typeid*GridConst->g3;

			//energy contribution of the current grid type
			cube [0][0][0] = *(GlobFgrids);
/*
	                cube [0][0][0] = *(GlobFgrids + cube_000 + mul_tmp);
        	        cube [1][0][0] = *(GlobFgrids + cube_100 + mul_tmp);
        	        cube [0][1][0] = *(GlobFgrids + cube_010 + mul_tmp);
        	        cube [1][1][0] = *(GlobFgrids + cube_110 + mul_tmp);
        	        cube [0][0][1] = *(GlobFgrids + cube_001 + mul_tmp);
        	        cube [1][0][1] = *(GlobFgrids + cube_101 + mul_tmp);
        	        cube [0][1][1] = *(GlobFgrids + cube_011 + mul_tmp);
        	        cube [1][1][1] = *(GlobFgrids + cube_111 + mul_tmp);
*/
		
			#if defined (DEBUG_KERNEL_INTER_E)
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

			interE_INGRID += trilin_interpol(cube, weights);

			#if defined (DEBUG_KERNEL_INTER_E)
			printf("interpolated value = %f\n\n", trilin_interpol(cube, weights));
			#endif

			//energy contribution of the electrostatic grid
			typeid = GridConst->num_of_atypes;
			mul_tmp = typeid*GridConst->g3;
/*
        	        cube [0][0][0] = *(GlobFgrids + cube_000 + mul_tmp);
        	        cube [1][0][0] = *(GlobFgrids + cube_100 + mul_tmp);
        	        cube [0][1][0] = *(GlobFgrids + cube_010 + mul_tmp);
        	        cube [1][1][0] = *(GlobFgrids + cube_110 + mul_tmp);
        	        cube [0][0][1] = *(GlobFgrids + cube_001 + mul_tmp);
        	        cube [1][0][1] = *(GlobFgrids + cube_101 + mul_tmp);
        	        cube [0][1][1] = *(GlobFgrids + cube_011 + mul_tmp);
        	        cube [1][1][1] = *(GlobFgrids + cube_111 + mul_tmp);
*/

			#if defined (DEBUG_KERNEL_INTER_E)
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

			interE_INGRID += q * trilin_interpol(cube, weights);

			#if defined (DEBUG_KERNEL_INTER_E)
			printf("interpoated value = %f, multiplied by q = %f\n\n", trilin_interpol(cube, weights), q*trilin_interpol(cube, weights));
			#endif

			//energy contribution of the desolvation grid
			typeid = GridConst->num_of_atypes+1;
			mul_tmp = typeid*GridConst->g3;
/*
        	        cube [0][0][0] = *(GlobFgrids + cube_000 + mul_tmp);
        	        cube [1][0][0] = *(GlobFgrids + cube_100 + mul_tmp);
        	        cube [0][1][0] = *(GlobFgrids + cube_010 + mul_tmp);
        	        cube [1][1][0] = *(GlobFgrids + cube_110 + mul_tmp);
        	        cube [0][0][1] = *(GlobFgrids + cube_001 + mul_tmp);
        	        cube [1][0][1] = *(GlobFgrids + cube_101 + mul_tmp);
        	        cube [0][1][1] = *(GlobFgrids + cube_011 + mul_tmp);
        	        cube [1][1][1] = *(GlobFgrids + cube_111 + mul_tmp);
*/
			#if defined (DEBUG_KERNEL_INTER_E)
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

			interE_INGRID += fabs(q) * trilin_interpol(cube, weights);

			#if defined (DEBUG_KERNEL_KERNEL_INTER_E)
			printf("interploated value = %f, multiplied by abs(q) = %f\n\n", trilin_interpol(cube, weights), fabs(q) * trilin_interpol(cube, weights));
			printf("Current value of intermolecular energy = %f\n\n\n", interE_INGRID);
			#endif
		}
	} // End of LOOP_INTERE_1:	

	interE = interE_OUTGRID + interE_INGRID;
	
/*
	// --------------------------------------------------------------
	// Send intermolecular energy to GA
	// --------------------------------------------------------------
	write_channel_altera(chan_Intere2GA_intere, interE);
	// --------------------------------------------------------------
*/

}
// --------------------------------------------------------------------------
// --------------------------------------------------------------------------
