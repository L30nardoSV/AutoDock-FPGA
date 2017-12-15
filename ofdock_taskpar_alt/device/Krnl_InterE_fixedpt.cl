#include "../defines_fixedpt_64.h"

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
	/*
	printf("InterE %f %f\n", fixedpt64_tofloat(fixedpt64_fromfloat(-2.2f)), fixedpt64_tofloat(fixedpt64_fromfloat(-5.45f)));
	printf("InterE %f\n", fixedpt64_tofloat(fixedpt64_smul(fixedpt64_fromfloat(-2.2f), fixedpt64_fromfloat(-5.45f))));
	*/

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
	active = read_channel_altera(chan_Conf2Intere_active);
	mem_fence(CLK_CHANNEL_MEM_FENCE);

	mode   = read_channel_altera(chan_Conf2Intere_mode);
	mem_fence(CLK_CHANNEL_MEM_FENCE);

	for (uchar pipe_cnt=0; pipe_cnt<DockConst_num_of_atoms; pipe_cnt++) {
		loc_coords[pipe_cnt] = read_channel_altera(chan_Conf2Intere_xyz);
	}
	*/

	active = read_channel_altera(chan_Conf2Intere_active);
	mem_fence(CLK_CHANNEL_MEM_FENCE);

	for (uchar pipe_cnt=0; pipe_cnt<DockConst_num_of_atoms; pipe_cnt++) {
		if (pipe_cnt == 0) {
			mode   = read_channel_altera(chan_Conf2Intere_mode);
			mem_fence(CLK_CHANNEL_MEM_FENCE);
		}

		loc_coords[pipe_cnt] = read_channel_altera(chan_Conf2Intere_xyz);
	}

	// --------------------------------------------------------------
	//printf("AFTER In INTER CHANNEL\n");

	#if defined (DEBUG_ACTIVE_KERNEL)
	if (active == 0) {printf("	%-20s: %s\n", "Krnl_InterE", "must be disabled");}
	#endif

// FLOAT VERSION
/*
	float interE = 0.0f;
*/	
	fixedpt64 fixpt_interE = 0;

	// for each atom
	for (uchar atom1_id=0; atom1_id<DockConst_num_of_atoms; atom1_id++)
	{
		char atom1_typeid = atom_types_localcache [atom1_id];

		float3 loc_coords_atid1 = loc_coords[atom1_id];



		float x = loc_coords_atid1.x;
		float y = loc_coords_atid1.y;
		float z = loc_coords_atid1.z;
		float q = atom_charges_localcache [atom1_id];


		//float3 loc_coords_atid1 = loc_coords[atom1_id];
		fixedpt64 fixpt_x = fixedpt64_fromfloat(loc_coords_atid1.x); 
		fixedpt64 fixpt_y = fixedpt64_fromfloat(loc_coords_atid1.y); 
		fixedpt64 fixpt_z = fixedpt64_fromfloat(loc_coords_atid1.z); 
		fixedpt64 fixpt_q = fixedpt64_fromfloat(atom_charges_localcache [atom1_id]);
//printf("x: %-20f %-20f %-20f\n", x, fixedpt64_tofloat(fixpt_x), x - fixedpt64_tofloat(fixpt_x));
//printf("y: %-20f %-20f %-20f\n", y, fixedpt64_tofloat(fixpt_y), y - fixedpt64_tofloat(fixpt_y));
//printf("z: %-20f %-20f %-20f\n", z, fixedpt64_tofloat(fixpt_z), z - fixedpt64_tofloat(fixpt_z));
//printf("q: %-20f %-20f %-20f\n", q, fixedpt64_tofloat(fixpt_q), q - fixedpt64_tofloat(fixpt_q));

// FLOAT VERSION
/*
		float partialE1;
		float partialE2;
		float partialE3;
*/
		fixedpt64 fixpt_partialE1;
		fixedpt64 fixpt_partialE2;
		fixedpt64 fixpt_partialE3;
	
		// if the atom is outside of the grid
		/*
		if ((x < 0.0f) || (x >= DockConst_gridsize_x_minus1) || 
		    (y < 0.0f) || (y >= DockConst_gridsize_y_minus1) ||
		    (z < 0.0f) || (z >= DockConst_gridsize_z_minus1))	{
		*/

		if ((fixpt_x < 0) || (fixpt_x >= fixedpt64_fromint(DockConst_gridsize_x_minus1)) || 
		    (fixpt_y < 0) || (fixpt_y >= fixedpt64_fromint(DockConst_gridsize_y_minus1)) ||
		    (fixpt_z < 0) || (fixpt_z >= fixedpt64_fromint(DockConst_gridsize_z_minus1))) {

			//penalty is 2^24 for each atom outside the grid
			/*
			interE += 16777216.0f; 
			*/
			
// FLOAT VERSION
/*
			partialE1 = 16777216.0f; 
			partialE2 = 0.0f;
			partialE3 = 0.0f;
*/
			fixpt_partialE1 = fixedpt64_fromfloat(16777216.0f);
			fixpt_partialE2 = 0;
			fixpt_partialE3 = 0;
//printf("partialE1 %-20f %-20f %-20f\n", partialE1, fixedpt64_tofloat(fixpt_partialE1), partialE1 - fixedpt64_tofloat(fixpt_partialE1));
//printf("partialE2 %-20f %-20f %-20f\n", partialE2, fixedpt64_tofloat(fixpt_partialE2), partialE2 - fixedpt64_tofloat(fixpt_partialE2));
//printf("partialE3 %-20f %-20f %-20f\n", partialE3, fixedpt64_tofloat(fixpt_partialE3), partialE3 - fixedpt64_tofloat(fixpt_partialE3));
		} 
		else 
		{	
//printf("x: %-20f %-20f %-20f\n", x, fixedpt64_tofloat(fixpt_x), x - fixedpt64_tofloat(fixpt_x));
//printf("y: %-20f %-20f %-20f\n", y, fixedpt64_tofloat(fixpt_y), y - fixedpt64_tofloat(fixpt_y));
//printf("z: %-20f %-20f %-20f\n", z, fixedpt64_tofloat(fixpt_z), z - fixedpt64_tofloat(fixpt_z));
//printf("q: %-20f %-20f %-20f\n", q, fixedpt64_tofloat(fixpt_q), q - fixedpt64_tofloat(fixpt_q));

			int x_low  = convert_int(floor(x));
			int y_low  = convert_int(floor(y));
			int z_low  = convert_int(floor(z));
			int x_high = convert_int(ceil(x));	 
			int y_high = convert_int(ceil(y));
			int z_high = convert_int(ceil(z));
			
			fixedpt64 fixpt_x_low  = fixedpt64_floor(fixedpt64_fromfloat(x)); 
			fixedpt64 fixpt_y_low  = fixedpt64_floor(fixedpt64_fromfloat(y));
			fixedpt64 fixpt_z_low  = fixedpt64_floor(fixedpt64_fromfloat(z));
			fixedpt64 fixpt_x_high = fixedpt64_ceil(fixedpt64_fromfloat(x));	 
			fixedpt64 fixpt_y_high = fixedpt64_ceil(fixedpt64_fromfloat(y));
			fixedpt64 fixpt_z_high = fixedpt64_ceil(fixedpt64_fromfloat(z));
//printf("x_low: %-20i %-20f %-20f\n", x_low, fixedpt64_tofloat(fixpt_x_low), x_low - fixedpt64_tofloat(fixpt_x_low));
//printf("y_low: %-20i %-20f %-20f\n", y_low, fixedpt64_tofloat(fixpt_y_low), y_low - fixedpt64_tofloat(fixpt_y_low));
//printf("z_low: %-20i %-20f %-20f\n", z_low, fixedpt64_tofloat(fixpt_z_low), z_low - fixedpt64_tofloat(fixpt_z_low));
//printf("x_high: %-20i %-20f %-20f\n", x_high, fixedpt64_tofloat(fixpt_x_high), x_high - fixedpt64_tofloat(fixpt_x_high));
//printf("y_high: %-20i %-20f %-20f\n", y_high, fixedpt64_tofloat(fixpt_y_high), y_high - fixedpt64_tofloat(fixpt_y_high));
//printf("z_high: %-20i %-20f %-20f\n", z_high, fixedpt64_tofloat(fixpt_z_high), z_high - fixedpt64_tofloat(fixpt_z_high));

// FLOAT VERSION
/*
			float dx = x - x_low; 
			float dy = y - y_low; 
			float dz = z - z_low;
*/		
			fixedpt64 fixpt_dx = fixedpt64_ssub(fixpt_x, fixpt_x_low); 
			fixedpt64 fixpt_dy = fixedpt64_ssub(fixpt_y, fixpt_y_low); 
			fixedpt64 fixpt_dz = fixedpt64_ssub(fixpt_z, fixpt_z_low);
//printf("dx: %-20f %-20f %-20f\n", dx, fixedpt64_tofloat(fixpt_dx), dx - fixedpt64_tofloat(fixpt_dx));
//printf("dy: %-20f %-20f %-20f\n", dy, fixedpt64_tofloat(fixpt_dy), dy - fixedpt64_tofloat(fixpt_dy));
//printf("dz: %-20f %-20f %-20f\n", dz, fixedpt64_tofloat(fixpt_dz), dz - fixedpt64_tofloat(fixpt_dz));

			// Calculates the weights for trilinear interpolation
			// based on the location of the point inside
// FLOAT VERSION
/*
			float weights [2][2][2];
			weights [0][0][0] = (1-dx)*(1-dy)*(1-dz);
			weights [1][0][0] = dx*(1-dy)*(1-dz);
			weights [0][1][0] = (1-dx)*dy*(1-dz);
			weights [1][1][0] = dx*dy*(1-dz);
			weights [0][0][1] = (1-dx)*(1-dy)*dz;
			weights [1][0][1] = dx*(1-dy)*dz;
			weights [0][1][1] = (1-dx)*dy*dz;
			weights [1][1][1] = dx*dy*dz;
*/

			fixedpt64 fixpt_weights [2][2][2];
			fixpt_weights [0][0][0] = fixedpt64_smul((FIXEDPT64_ONE-fixpt_dx), fixedpt64_smul((FIXEDPT64_ONE-fixpt_dy), (FIXEDPT64_ONE-fixpt_dz)));
			fixpt_weights [1][0][0] = fixedpt64_smul(fixpt_dx, fixedpt64_smul((FIXEDPT64_ONE-fixpt_dy), (FIXEDPT64_ONE-fixpt_dz)));
			fixpt_weights [0][1][0] = fixedpt64_smul((FIXEDPT64_ONE-fixpt_dx), fixedpt64_smul(fixpt_dy,(FIXEDPT64_ONE-fixpt_dz)));
			fixpt_weights [1][1][0] = fixedpt64_smul(fixpt_dx, fixedpt64_smul(fixpt_dy, (FIXEDPT64_ONE-fixpt_dz)));
			fixpt_weights [0][0][1] = fixedpt64_smul((FIXEDPT64_ONE-fixpt_dx), fixedpt64_smul((FIXEDPT64_ONE-fixpt_dy), fixpt_dz));
			fixpt_weights [1][0][1] = fixedpt64_smul(fixpt_dx, fixedpt64_smul((FIXEDPT64_ONE-fixpt_dy), fixpt_dz));
			fixpt_weights [0][1][1] = fixedpt64_smul((FIXEDPT64_ONE-fixpt_dx), fixedpt64_smul(fixpt_dy, fixpt_dz));
			fixpt_weights [1][1][1] = fixedpt64_smul(fixpt_dx, fixedpt64_smul(fixpt_dy, fixpt_dz));


//printf("weights [0][0][0]: %-20f %-20f %-20f\n", weights[0][0][0], fixedpt64_tofloat(fixpt_weights[0][0][0]), weights[0][0][0] - fixedpt64_tofloat(fixpt_weights[0][0][0]));
//printf("weights [1][0][0]: %-20f %-20f %-20f\n", weights[1][0][0], fixedpt64_tofloat(fixpt_weights[1][0][0]), weights[1][0][0] - fixedpt64_tofloat(fixpt_weights[1][0][0]));
//printf("weights [0][1][0]: %-20f %-20f %-20f\n", weights[0][1][0], fixedpt64_tofloat(fixpt_weights[0][1][0]), weights[0][1][0] - fixedpt64_tofloat(fixpt_weights[0][1][0]));
//printf("weights [1][1][0]: %-20f %-20f %-20f\n", weights[1][1][0], fixedpt64_tofloat(fixpt_weights[1][1][0]), weights[1][1][0] - fixedpt64_tofloat(fixpt_weights[1][1][0]));				
//printf("weights [0][0][1]: %-20f %-20f %-20f\n", weights[0][0][1], fixedpt64_tofloat(fixpt_weights[0][0][1]), weights[0][0][1] - fixedpt64_tofloat(fixpt_weights[0][0][1]));	
//printf("weights [1][0][1]: %-20f %-20f %-20f\n", weights[1][0][1], fixedpt64_tofloat(fixpt_weights[1][0][1]), weights[1][0][1] - fixedpt64_tofloat(fixpt_weights[1][0][1]));
//printf("weights [0][1][1]: %-20f %-20f %-20f\n", weights[0][1][1], fixedpt64_tofloat(fixpt_weights[0][1][1]), weights[0][1][1] - fixedpt64_tofloat(fixpt_weights[0][1][1]));	
//printf("weights [1][1][1]: %-20f %-20f %-20f\n", weights[1][1][1], fixedpt64_tofloat(fixpt_weights[1][1][1]), weights[1][1][1] - fixedpt64_tofloat(fixpt_weights[1][1][1]));		

			// lvs added temporal variables
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

			//energy contribution of the current grid type

// FLOAT VERSION
/*
			float cube [2][2][2];
	                cube [0][0][0] = GlobFgrids[cube_000 + mul_tmp];
        	        cube [1][0][0] = GlobFgrids[cube_100 + mul_tmp];
        	        cube [0][1][0] = GlobFgrids[cube_010 + mul_tmp];
        	        cube [1][1][0] = GlobFgrids[cube_110 + mul_tmp];
        	        cube [0][0][1] = GlobFgrids[cube_001 + mul_tmp];
        	        cube [1][0][1] = GlobFgrids[cube_101 + mul_tmp];
        	        cube [0][1][1] = GlobFgrids[cube_011 + mul_tmp];
        	        cube [1][1][1] = GlobFgrids[cube_111 + mul_tmp];
*/
			fixedpt64 fixpt_cube [2][2][2];
	                fixpt_cube [0][0][0] = fixedpt64_fromfloat(GlobFgrids[cube_000 + mul_tmp]);
        	        fixpt_cube [1][0][0] = fixedpt64_fromfloat(GlobFgrids[cube_100 + mul_tmp]);
        	        fixpt_cube [0][1][0] = fixedpt64_fromfloat(GlobFgrids[cube_010 + mul_tmp]);
        	        fixpt_cube [1][1][0] = fixedpt64_fromfloat(GlobFgrids[cube_110 + mul_tmp]);
        	        fixpt_cube [0][0][1] = fixedpt64_fromfloat(GlobFgrids[cube_001 + mul_tmp]);
        	        fixpt_cube [1][0][1] = fixedpt64_fromfloat(GlobFgrids[cube_101 + mul_tmp]);
        	        fixpt_cube [0][1][1] = fixedpt64_fromfloat(GlobFgrids[cube_011 + mul_tmp]);
        	        fixpt_cube [1][1][1] = fixedpt64_fromfloat(GlobFgrids[cube_111 + mul_tmp]);
//printf("cube [0][0][0]: %-20f %-20f %-20f\n", cube [0][0][0], fixedpt64_tofloat(fixpt_cube [0][0][0]), cube [0][0][0] - fixedpt64_tofloat(fixpt_cube [0][0][0]));
//printf("cube [1][0][0]: %-20f %-20f %-20f\n", cube [1][0][0], fixedpt64_tofloat(fixpt_cube [1][0][0]), cube [1][0][0] - fixedpt64_tofloat(fixpt_cube [1][0][0]));
//printf("cube [0][1][0]: %-20f %-20f %-20f\n", cube [0][1][0], fixedpt64_tofloat(fixpt_cube [0][1][0]), cube [0][1][0] - fixedpt64_tofloat(fixpt_cube [0][1][0]));
//printf("cube [1][1][0]: %-20f %-20f %-20f\n", cube [1][1][0], fixedpt64_tofloat(fixpt_cube [1][1][0]), cube [1][1][0] - fixedpt64_tofloat(fixpt_cube [1][1][0]));
//printf("cube [0][0][1]: %-20f %-20f %-20f\n", cube [0][0][1], fixedpt64_tofloat(fixpt_cube [0][0][1]), cube [0][0][1] - fixedpt64_tofloat(fixpt_cube [0][0][1]));
//printf("cube [1][0][1]: %-20f %-20f %-20f\n", cube [1][0][1], fixedpt64_tofloat(fixpt_cube [1][0][1]), cube [1][0][1] - fixedpt64_tofloat(fixpt_cube [1][0][1]));
//printf("cube [0][1][1]: %-20f %-20f %-20f\n", cube [0][1][1], fixedpt64_tofloat(fixpt_cube [0][1][1]), cube [0][1][1] - fixedpt64_tofloat(fixpt_cube [0][1][1]));
//printf("cube [1][1][1]: %-20f %-20f %-20f\n", cube [1][1][1], fixedpt64_tofloat(fixpt_cube [1][1][1]), cube [1][1][1] - fixedpt64_tofloat(fixpt_cube [1][1][1]));
		
			/*partialE1 = TRILININTERPOL(cube, weights);*/
// FLOAT VERSION
/*	
			partialE1 = cube[0][0][0] * weights[0][0][0] +
				    cube[1][0][0] * weights[1][0][0] +
				    cube[0][1][0] * weights[0][1][0] +
				    cube[1][1][0] * weights[1][1][0] + 
				    cube[0][0][1] * weights[0][0][1] +
				    cube[1][0][1] * weights[1][0][1] + 
				    cube[0][1][1] * weights[0][1][1] +
				    cube[1][1][1] * weights[1][1][1];
*/		
			fixpt_partialE1 = fixedpt64_smul(fixpt_cube[0][0][0], fixpt_weights[0][0][0]) +
				    	  fixedpt64_smul(fixpt_cube[1][0][0], fixpt_weights[1][0][0]) +
				    	  fixedpt64_smul(fixpt_cube[0][1][0], fixpt_weights[0][1][0]) +
				    	  fixedpt64_smul(fixpt_cube[1][1][0], fixpt_weights[1][1][0]) + 
				    	  fixedpt64_smul(fixpt_cube[0][0][1], fixpt_weights[0][0][1]) +
				     	  fixedpt64_smul(fixpt_cube[1][0][1], fixpt_weights[1][0][1]) + 
				    	  fixedpt64_smul(fixpt_cube[0][1][1], fixpt_weights[0][1][1]) +
				    	  fixedpt64_smul(fixpt_cube[1][1][1], fixpt_weights[1][1][1]);

//printf("partialE1: %-20f %-20f %-20f\n", partialE1, fixedpt64_tofloat(fixpt_partialE1), partialE1 - fixedpt64_tofloat(fixpt_partialE1));

			//energy contribution of the electrostatic grid
			uint mul_tmp2 = Host_mul_tmp2;

// FLOAT VERSION
/*			
			cube [0][0][0] = GlobFgrids[cube_000 + mul_tmp2];
        	        cube [1][0][0] = GlobFgrids[cube_100 + mul_tmp2];
        	        cube [0][1][0] = GlobFgrids[cube_010 + mul_tmp2];
        	        cube [1][1][0] = GlobFgrids[cube_110 + mul_tmp2];
        	        cube [0][0][1] = GlobFgrids[cube_001 + mul_tmp2];
        	        cube [1][0][1] = GlobFgrids[cube_101 + mul_tmp2];
        	        cube [0][1][1] = GlobFgrids[cube_011 + mul_tmp2];
        	        cube [1][1][1] = GlobFgrids[cube_111 + mul_tmp2];
*/			
			fixpt_cube [0][0][0] = fixedpt64_fromfloat(GlobFgrids[cube_000 + mul_tmp2]);
        	        fixpt_cube [1][0][0] = fixedpt64_fromfloat(GlobFgrids[cube_100 + mul_tmp2]);
        	        fixpt_cube [0][1][0] = fixedpt64_fromfloat(GlobFgrids[cube_010 + mul_tmp2]);
        	        fixpt_cube [1][1][0] = fixedpt64_fromfloat(GlobFgrids[cube_110 + mul_tmp2]);
        	        fixpt_cube [0][0][1] = fixedpt64_fromfloat(GlobFgrids[cube_001 + mul_tmp2]);
        	        fixpt_cube [1][0][1] = fixedpt64_fromfloat(GlobFgrids[cube_101 + mul_tmp2]);
        	        fixpt_cube [0][1][1] = fixedpt64_fromfloat(GlobFgrids[cube_011 + mul_tmp2]);
        	        fixpt_cube [1][1][1] = fixedpt64_fromfloat(GlobFgrids[cube_111 + mul_tmp2]);
//printf("cube [0][0][0]: %-20f %-20f %-20f\n", cube [0][0][0], fixedpt64_tofloat(fixpt_cube [0][0][0]), cube [0][0][0] - fixedpt64_tofloat(fixpt_cube [0][0][0]));
//printf("cube [1][0][0]: %-20f %-20f %-20f\n", cube [1][0][0], fixedpt64_tofloat(fixpt_cube [1][0][0]), cube [1][0][0] - fixedpt64_tofloat(fixpt_cube [1][0][0]));
//printf("cube [0][1][0]: %-20f %-20f %-20f\n", cube [0][1][0], fixedpt64_tofloat(fixpt_cube [0][1][0]), cube [0][1][0] - fixedpt64_tofloat(fixpt_cube [0][1][0]));
//printf("cube [1][1][0]: %-20f %-20f %-20f\n", cube [1][1][0], fixedpt64_tofloat(fixpt_cube [1][1][0]), cube [1][1][0] - fixedpt64_tofloat(fixpt_cube [1][1][0]));
//printf("cube [0][0][1]: %-20f %-20f %-20f\n", cube [0][0][1], fixedpt64_tofloat(fixpt_cube [0][0][1]), cube [0][0][1] - fixedpt64_tofloat(fixpt_cube [0][0][1]));
//printf("cube [1][0][1]: %-20f %-20f %-20f\n", cube [1][0][1], fixedpt64_tofloat(fixpt_cube [1][0][1]), cube [1][0][1] - fixedpt64_tofloat(fixpt_cube [1][0][1]));
//printf("cube [0][1][1]: %-20f %-20f %-20f\n", cube [0][1][1], fixedpt64_tofloat(fixpt_cube [0][1][1]), cube [0][1][1] - fixedpt64_tofloat(fixpt_cube [0][1][1]));
//printf("cube [1][1][1]: %-20f %-20f %-20f\n", cube [1][1][1], fixedpt64_tofloat(fixpt_cube [1][1][1]), cube [1][1][1] - fixedpt64_tofloat(fixpt_cube [1][1][1]));


			/*partialE2 = q * TRILININTERPOL(cube, weights);*/

// FLOAT VERSION
/*		
			partialE2 = q * (cube[0][0][0] * weights[0][0][0] +
				    	 cube[1][0][0] * weights[1][0][0] +
				    	 cube[0][1][0] * weights[0][1][0] +
				    	 cube[1][1][0] * weights[1][1][0] + 
				    	 cube[0][0][1] * weights[0][0][1] +
				    	 cube[1][0][1] * weights[1][0][1] + 
				    	 cube[0][1][1] * weights[0][1][1] +
				    	 cube[1][1][1] * weights[1][1][1]);
*/
			
#if 0
			fixpt_partialE2 = /*fixedpt64_smul(fixpt_q, */
							(
						         fixedpt64_smul(fixpt_cube[0][0][0], fixpt_weights[0][0][0]) +
				    			 fixedpt64_smul(fixpt_cube[1][0][0], fixpt_weights[1][0][0]) +
				    	 		 fixedpt64_smul(fixpt_cube[0][1][0], fixpt_weights[0][1][0]) +
						    	 fixedpt64_smul(fixpt_cube[1][1][0], fixpt_weights[1][1][0]) + 
						    	 fixedpt64_smul(fixpt_cube[0][0][1], fixpt_weights[0][0][1]) +
						    	 fixedpt64_smul(fixpt_cube[1][0][1], fixpt_weights[1][0][1]) + 
						    	 fixedpt64_smul(fixpt_cube[0][1][1], fixpt_weights[0][1][1]) +
						    	 fixedpt64_smul(fixpt_cube[1][1][1], fixpt_weights[1][1][1])
							/*)*/
					          );
			fixpt_partialE2 = fixedpt64_fromfloat(q * fixedpt64_tofloat(fixpt_partialE2));
#endif
			fixpt_partialE2 = fixedpt64_smul(fixpt_q, 
								(
						         fixedpt64_smul(fixpt_cube[0][0][0], fixpt_weights[0][0][0]) +
				    			 fixedpt64_smul(fixpt_cube[1][0][0], fixpt_weights[1][0][0]) +
				    	 		 fixedpt64_smul(fixpt_cube[0][1][0], fixpt_weights[0][1][0]) +
						    	 fixedpt64_smul(fixpt_cube[1][1][0], fixpt_weights[1][1][0]) + 
						    	 fixedpt64_smul(fixpt_cube[0][0][1], fixpt_weights[0][0][1]) +
						    	 fixedpt64_smul(fixpt_cube[1][0][1], fixpt_weights[1][0][1]) + 
						    	 fixedpt64_smul(fixpt_cube[0][1][1], fixpt_weights[0][1][1]) +
						    	 fixedpt64_smul(fixpt_cube[1][1][1], fixpt_weights[1][1][1])
								)
							);
			
//printf("partialE2: %-20f %-20f %-20f\n", partialE2, fixedpt64_tofloat(fixpt_partialE2), partialE2 - fixedpt64_tofloat(fixpt_partialE2));
		
			//energy contribution of the desolvation grid
			uint mul_tmp3 = Host_mul_tmp3;

// FLOAT VERSION
/*
			cube [0][0][0] = GlobFgrids[cube_000 + mul_tmp3];
        	        cube [1][0][0] = GlobFgrids[cube_100 + mul_tmp3];
        	        cube [0][1][0] = GlobFgrids[cube_010 + mul_tmp3];
        	        cube [1][1][0] = GlobFgrids[cube_110 + mul_tmp3];
        	        cube [0][0][1] = GlobFgrids[cube_001 + mul_tmp3];
        	        cube [1][0][1] = GlobFgrids[cube_101 + mul_tmp3];
        	        cube [0][1][1] = GlobFgrids[cube_011 + mul_tmp3];
        	        cube [1][1][1] = GlobFgrids[cube_111 + mul_tmp3];
*/			
			fixpt_cube [0][0][0] = fixedpt64_fromfloat(GlobFgrids[cube_000 + mul_tmp3]);
        	        fixpt_cube [1][0][0] = fixedpt64_fromfloat(GlobFgrids[cube_100 + mul_tmp3]);
        	        fixpt_cube [0][1][0] = fixedpt64_fromfloat(GlobFgrids[cube_010 + mul_tmp3]);
        	        fixpt_cube [1][1][0] = fixedpt64_fromfloat(GlobFgrids[cube_110 + mul_tmp3]);
        	        fixpt_cube [0][0][1] = fixedpt64_fromfloat(GlobFgrids[cube_001 + mul_tmp3]);
        	        fixpt_cube [1][0][1] = fixedpt64_fromfloat(GlobFgrids[cube_101 + mul_tmp3]);
        	        fixpt_cube [0][1][1] = fixedpt64_fromfloat(GlobFgrids[cube_011 + mul_tmp3]);
        	        fixpt_cube [1][1][1] = fixedpt64_fromfloat(GlobFgrids[cube_111 + mul_tmp3]);
//printf("cube [0][0][0]: %-20f %-20f %-20f\n", cube [0][0][0], fixedpt64_tofloat(fixpt_cube [0][0][0]), cube [0][0][0] - fixedpt64_tofloat(fixpt_cube [0][0][0]));
//printf("cube [1][0][0]: %-20f %-20f %-20f\n", cube [1][0][0], fixedpt64_tofloat(fixpt_cube [1][0][0]), cube [1][0][0] - fixedpt64_tofloat(fixpt_cube [1][0][0]));
//printf("cube [0][1][0]: %-20f %-20f %-20f\n", cube [0][1][0], fixedpt64_tofloat(fixpt_cube [0][1][0]), cube [0][1][0] - fixedpt64_tofloat(fixpt_cube [0][1][0]));
//printf("cube [1][1][0]: %-20f %-20f %-20f\n", cube [1][1][0], fixedpt64_tofloat(fixpt_cube [1][1][0]), cube [1][1][0] - fixedpt64_tofloat(fixpt_cube [1][1][0]));
//printf("cube [0][0][1]: %-20f %-20f %-20f\n", cube [0][0][1], fixedpt64_tofloat(fixpt_cube [0][0][1]), cube [0][0][1] - fixedpt64_tofloat(fixpt_cube [0][0][1]));
//printf("cube [1][0][1]: %-20f %-20f %-20f\n", cube [1][0][1], fixedpt64_tofloat(fixpt_cube [1][0][1]), cube [1][0][1] - fixedpt64_tofloat(fixpt_cube [1][0][1]));
//printf("cube [0][1][1]: %-20f %-20f %-20f\n", cube [0][1][1], fixedpt64_tofloat(fixpt_cube [0][1][1]), cube [0][1][1] - fixedpt64_tofloat(fixpt_cube [0][1][1]));
//printf("cube [1][1][1]: %-20f %-20f %-20f\n", cube [1][1][1], fixedpt64_tofloat(fixpt_cube [1][1][1]), cube [1][1][1] - fixedpt64_tofloat(fixpt_cube [1][1][1]));


			/*partialE3 = fabs(q) * TRILININTERPOL(cube, weights);*/
			
// FLOAT VERSION
/*
			partialE3 = fabs(q) * (cube[0][0][0] * weights[0][0][0] +
				    	       cube[1][0][0] * weights[1][0][0] +
				    	       cube[0][1][0] * weights[0][1][0] +
				    	       cube[1][1][0] * weights[1][1][0] + 
				    	       cube[0][0][1] * weights[0][0][1] +
				    	       cube[1][0][1] * weights[1][0][1] + 
				    	       cube[0][1][1] * weights[0][1][1] +
				    	       cube[1][1][1] * weights[1][1][1]);
*/
			
			fixpt_partialE3 = fixedpt64_smul(fixedpt64_abs(fixpt_q), 
								  	(
					       			fixedpt64_smul(fixpt_cube[0][0][0], fixpt_weights[0][0][0]) +
				    	       			fixedpt64_smul(fixpt_cube[1][0][0], fixpt_weights[1][0][0]) +
				    	       			fixedpt64_smul(fixpt_cube[0][1][0], fixpt_weights[0][1][0]) +
				    	       			fixedpt64_smul(fixpt_cube[1][1][0], fixpt_weights[1][1][0]) + 
				    	       			fixedpt64_smul(fixpt_cube[0][0][1], fixpt_weights[0][0][1]) +
				    	       			fixedpt64_smul(fixpt_cube[1][0][1], fixpt_weights[1][0][1]) + 
				    	       			fixedpt64_smul(fixpt_cube[0][1][1], fixpt_weights[0][1][1]) +
				    	       			fixedpt64_smul(fixpt_cube[1][1][1], fixpt_weights[1][1][1])
					      		          	)
						  	);
//printf("partialE3: %-20f %-20f %-20f\n", partialE3, fixedpt64_tofloat(fixpt_partialE3), partialE3 - fixedpt64_tofloat(fixpt_partialE3));

		}

// FLOAT VERSION
/*
		interE += partialE1 + partialE2 + partialE3;
*/
		fixpt_interE += fixpt_partialE1 + fixpt_partialE2 + fixpt_partialE3;

	} // End of atom1_id for-loop

	//printf("interE: float: %-20f fixedpt: %-20f, diff: %-20f\n", interE, fixedpt64_tofloat(fixpt_interE), interE - fixedpt64_tofloat(fixpt_interE));

	// --------------------------------------------------------------
	// Send intermolecular energy to chanel
	// --------------------------------------------------------------
	switch (mode) {
		case 0x01:	// IC
			//write_channel_altera(chan_Intere2StoreIC_intere, interE);
			write_channel_altera(chan_Intere2StoreIC_intere, fixedpt64_tofloat(fixpt_interE));
		break;

		case 0x02:	// GG
			//write_channel_altera(chan_Intere2StoreGG_intere, interE);
			write_channel_altera(chan_Intere2StoreGG_intere, fixedpt64_tofloat(fixpt_interE));
		break;

		case 0x03:	// LS 1
			//write_channel_altera(chan_Intere2StoreLS_intere, interE);
			write_channel_altera(chan_Intere2StoreLS_LS1_intere, fixedpt64_tofloat(fixpt_interE));
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
