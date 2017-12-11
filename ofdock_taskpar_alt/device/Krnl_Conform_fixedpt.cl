#include "../defines_fixedpt.h"

typedef int3          fixedpt3;

// --------------------------------------------------------------------------
// The function changes the conformation of myligand according to 
// the genotype given by the second parameter.
// Originally from: processligand.c
// --------------------------------------------------------------------------
__kernel __attribute__ ((max_global_work_dim(0)))
void Krnl_Conform(
	__constant int*                  restrict KerConstStatic_rotlist_const,			// must be formatted in host
	__constant /*float3**/ fixedpt3* restrict KerConstDynamic_ref_coords_const,		// must be formatted in host
	__constant /*float3**/ fixedpt3* restrict KerConstDynamic_rotbonds_moving_vectors_const,// must be formatted in host
	__constant /*float3**/ fixedpt3* restrict KerConstDynamic_rotbonds_unit_vectors_const,	// must be formatted in host
	    
			      unsigned int                     DockConst_rotbondlist_length,	// counter, leave it as int
			      unsigned char                    DockConst_num_of_atoms,		// counter, leave it as int
			      unsigned int                     DockConst_num_of_genes,		// counter, leave it as int

			      /*float*/ fixedpt                ref_orientation_quats_const_0,	// must be formatted in host
			      /*float*/ fixedpt                ref_orientation_quats_const_1,	// must be formatted in host
			      /*float*/ fixedpt                ref_orientation_quats_const_2,	// must be formatted in host
			      /*float*/ fixedpt                ref_orientation_quats_const_3	// must be formatted in host
)
{
	#if defined (DEBUG_KRNL_Conform) 
	printf("\n");
	printf("%-40s %u\n", "DockConst->rotbondlist_length: ",	DockConst_rotbondlist_length);
	printf("%-40s %u\n", "DockConst->num_of_atoms: ",  	DockConst_num_of_atoms);
	printf("%-40s %u\n", "DockConst_num_of_genes: ",        DockConst_num_of_genes);	
	#endif

/*
	// check best practices guide
	// Table 11. Effects of numbanks and bankwidth on the Bank Geometry ...
	// only first three indexes of the lower array are used
	// however size of lower array was declared as 4, just to keep sizes equal to power of 2
	__local float  __attribute__((numbanks(8), bankwidth(16))) loc_coords[MAX_NUM_OF_ATOMS][4];
*/

	__local /*float*/ fixedpt genotype[ACTUAL_GENOTYPE_LENGTH];

	bool active = true;

	// local mem to cache KerConstStatic->rotlist_const[], marked as bottleneck by profiler
	__local int rotlist_localcache [MAX_NUM_OF_ROTATIONS];
	for (ushort c = 0; c < DockConst_rotbondlist_length; c++) {
		rotlist_localcache [c] = KerConstStatic_rotlist_const [c];
	}

	__local /*float3*/ fixedpt3 ref_coords_localcache [MAX_NUM_OF_ATOMS];
	for (uchar c = 0; c < DockConst_num_of_atoms; c++) {
		ref_coords_localcache [c] = KerConstDynamic_ref_coords_const [c];
	}

	__local /*float3*/ fixedpt3 rotbonds_moving_vectors_localcache[MAX_NUM_OF_ROTBONDS];
	__local /*float3*/ fixedpt3 rotbonds_unit_vectors_localcache[MAX_NUM_OF_ROTBONDS];
	for (uchar c = 0; c < MAX_NUM_OF_ROTBONDS; c++) {
		rotbonds_moving_vectors_localcache [c] = KerConstDynamic_rotbonds_moving_vectors_const[c];
		rotbonds_unit_vectors_localcache   [c] = KerConstDynamic_rotbonds_unit_vectors_const [c];
	}

while(active) {

	char mode;

	active = read_channel_altera(chan_IGL_active);
	mem_fence(CLK_CHANNEL_MEM_FENCE);

	for (uchar i=0; i<DockConst_num_of_genes; i++) {
		if (i == 0) {
			mode = read_channel_altera(chan_IGL_mode);
			mem_fence(CLK_CHANNEL_MEM_FENCE);
		}

		// convert float to fixedpt
		/*
		genotype [i] = read_channel_altera(chan_IGL_genotype);
		*/
		float fl_tmp = read_channel_altera(chan_IGL_genotype);
		genotype [i] = fixedpt_fromfloat(fl_tmp);
		
	}

	fixedpt3 loc_coords[MAX_NUM_OF_ATOMS];

	#if defined (DEBUG_ACTIVE_KERNEL)
	if (active == 0) {printf("	%-20s: %s\n", "Krnl_Conform", "must be disabled");}
	#endif

	fixedpt phi         = genotype [3];
	fixedpt theta       = genotype [4];
	fixedpt genrotangle = genotype [5];

	fixedpt sin_theta, cos_theta;
	sin_theta = fixedpt_sin(theta);
	cos_theta = fixedpt_cos(theta);

	fixedpt3 genrot_unitvec;
	genrot_unitvec.x = fixedpt_mul(sin_theta, fixedpt_cos(phi));
	genrot_unitvec.y = fixedpt_mul(sin_theta, fixedpt_sin(phi));
	genrot_unitvec.z = cos_theta;
	
	fixedpt3 genotype_xyz = {genotype[0], genotype[1], genotype[2]};
	
	for (ushort rotation_counter = 0; rotation_counter < DockConst_rotbondlist_length; rotation_counter++)
	{
		// rotation list, leave it as int
		int rotation_list_element = rotlist_localcache [rotation_counter];

		if ((rotation_list_element & RLIST_DUMMY_MASK) == 0)	//if not dummy rotation
		{
			// index, leave it as uint
			uint atom_id = rotation_list_element & RLIST_ATOMID_MASK;

			//capturing atom coordinates
			fixedpt3 atom_to_rotate;

			if ((rotation_list_element & RLIST_FIRSTROT_MASK) != 0)	//if first rotation of this atom
			{	
				atom_to_rotate = ref_coords_localcache [atom_id];
			}
			else
			{	
				atom_to_rotate = loc_coords[atom_id];
			}

			//capturing rotation vectors and angle
			fixedpt3 rotation_unitvec;
			fixedpt3 rotation_movingvec;
			fixedpt  rotation_angle;

			if ((rotation_list_element & RLIST_GENROT_MASK) != 0)	//if general rotation
			{
				rotation_unitvec = genrot_unitvec;

				rotation_angle = genrotangle;

				rotation_movingvec = genotype_xyz;
			}
			else	//if rotating around rotatable bond
			{
				// index, leave it as uint
				uint rotbond_id = (rotation_list_element & RLIST_RBONDID_MASK) >> RLIST_RBONDID_SHIFT;
				rotation_unitvec = rotbonds_unit_vectors_localcache [rotbond_id];
				
				rotation_angle = genotype[6+rotbond_id];

				rotation_movingvec = rotbonds_moving_vectors_localcache [rotbond_id];

				//in addition performing the first movement 
				//which is needed only if rotating around rotatable bond
				atom_to_rotate -= rotation_movingvec;
			}

			//performing rotation
			fixedpt quatrot_left_x, quatrot_left_y, quatrot_left_z, quatrot_left_q;
			fixedpt quatrot_temp_x, quatrot_temp_y, quatrot_temp_z, quatrot_temp_q;

			rotation_angle = fixedpt_mul(rotation_angle, fixedpt_fromfloat(0.5f));

			fixedpt sin_angle, cos_angle;
			sin_angle = fixedpt_sin(rotation_angle);
			cos_angle = fixedpt_cos(rotation_angle);
			quatrot_left_x = fixedpt_mul(sin_angle, rotation_unitvec.x);
			quatrot_left_y = fixedpt_mul(sin_angle, rotation_unitvec.y);
			quatrot_left_z = fixedpt_mul(sin_angle, rotation_unitvec.z);
			quatrot_left_q = cos_angle;

			if ((rotation_list_element & RLIST_GENROT_MASK) != 0)	//if general rotation, 
										//two rotations should be performed 
										//(multiplying the quaternions)
			{
				//calculating quatrot_left*ref_orientation_quats_const, 
				//which means that reference orientation rotation is the first
				quatrot_temp_q = quatrot_left_q;
				quatrot_temp_x = quatrot_left_x;
				quatrot_temp_y = quatrot_left_y;
				quatrot_temp_z = quatrot_left_z;

				// L30nardoSV: taking the first element of ref_orientation_quats_const member
				quatrot_left_q = fixedpt_mul(quatrot_temp_q, ref_orientation_quats_const_0) -
						 fixedpt_mul(quatrot_temp_x, ref_orientation_quats_const_1) -
						 fixedpt_mul(quatrot_temp_y, ref_orientation_quats_const_2) -
						 fixedpt_mul(quatrot_temp_z, ref_orientation_quats_const_3);

				quatrot_left_x = fixedpt_mul(quatrot_temp_q, ref_orientation_quats_const_1) +
						 fixedpt_mul(quatrot_temp_x, ref_orientation_quats_const_0) +
						 fixedpt_mul(quatrot_temp_y, ref_orientation_quats_const_3) -
						 fixedpt_mul(quatrot_temp_z, ref_orientation_quats_const_2);

				quatrot_left_y = fixedpt_mul(quatrot_temp_q, ref_orientation_quats_const_2) +
						 fixedpt_mul(quatrot_temp_y, ref_orientation_quats_const_0) +
						 fixedpt_mul(quatrot_temp_z, ref_orientation_quats_const_1) -
						 fixedpt_mul(quatrot_temp_x, ref_orientation_quats_const_3);

				quatrot_left_z = fixedpt_mul(quatrot_temp_q, ref_orientation_quats_const_3) +
						 fixedpt_mul(quatrot_temp_z, ref_orientation_quats_const_0) +
						 fixedpt_mul(quatrot_temp_x, ref_orientation_quats_const_2) -
						 fixedpt_mul(quatrot_temp_y, ref_orientation_quats_const_1);
			}

			quatrot_temp_q = - fixedpt_mul(quatrot_left_x, atom_to_rotate.x) 
					 - fixedpt_mul(quatrot_left_y, atom_to_rotate.y) 
					 - fixedpt_mul(quatrot_left_z, atom_to_rotate.z);

			quatrot_temp_x = fixedpt_mul(quatrot_left_q, atom_to_rotate.x) +
					 fixedpt_mul(quatrot_left_y, atom_to_rotate.z) -
					 fixedpt_mul(quatrot_left_z, atom_to_rotate.y);

			quatrot_temp_y = fixedpt_mul(quatrot_left_q, atom_to_rotate.y) -
					 fixedpt_mul(quatrot_left_x, atom_to_rotate.z) +
					 fixedpt_mul(quatrot_left_z, atom_to_rotate.x);

			quatrot_temp_z = fixedpt_mul(quatrot_left_q, atom_to_rotate.z) +
					 fixedpt_mul(quatrot_left_x, atom_to_rotate.y) -
					 fixedpt_mul(quatrot_left_y, atom_to_rotate.x);

			atom_to_rotate.x = fixedpt_mul(quatrot_temp_x, quatrot_left_q) - 
					   fixedpt_mul(quatrot_temp_q, quatrot_left_x) - 
					   fixedpt_mul(quatrot_temp_y, quatrot_left_z) + 
					   fixedpt_mul(quatrot_temp_z, quatrot_left_y);

			atom_to_rotate.y = fixedpt_mul(quatrot_temp_x, quatrot_left_z) + 
					   fixedpt_mul(quatrot_temp_y, quatrot_left_q) - 
					   fixedpt_mul(quatrot_temp_z, quatrot_left_x) - 
					   fixedpt_mul(quatrot_temp_q, quatrot_left_y);

			atom_to_rotate.z = fixedpt_mul(quatrot_temp_y, quatrot_left_x) - 
					   fixedpt_mul(quatrot_temp_x, quatrot_left_y) - 
					   fixedpt_mul(quatrot_temp_q, quatrot_left_z) + 
					   fixedpt_mul(quatrot_temp_z, quatrot_left_q);

			//performing final movement and storing values
			loc_coords[atom_id] = atom_to_rotate + rotation_movingvec;

		} // End if-statement not dummy rotation
	} // End rotation_counter for-loop

	#if defined (DEBUG_KRNL_CONFORM)
	printf("BEFORE Out CONFORM CHANNEL\n");
	#endif

	// --------------------------------------------------------------
	// Send ligand atomic coordinates to channel 
	// --------------------------------------------------------------
	for (uchar pipe_cnt=0; pipe_cnt<DockConst_num_of_atoms; pipe_cnt++) {
		if (pipe_cnt == 0) {
			write_channel_altera(chan_Conf2Intere_active, active);
			write_channel_altera(chan_Conf2Intrae_active, active);
			mem_fence(CLK_CHANNEL_MEM_FENCE);

			write_channel_altera(chan_Conf2Intere_mode,   mode);
			write_channel_altera(chan_Conf2Intrae_mode,   mode);
			mem_fence(CLK_CHANNEL_MEM_FENCE);
		}

		// convert fixedpt3 to float3
		float tmp_x = fixedpt_tofloat(loc_coords[pipe_cnt].x);
		float tmp_y = fixedpt_tofloat(loc_coords[pipe_cnt].y);
		float tmp_z = fixedpt_tofloat(loc_coords[pipe_cnt].z);
		float3 tmp = {tmp_x, tmp_y, tmp_z};

		write_channel_altera(chan_Conf2Intere_xyz, tmp);
		write_channel_altera(chan_Conf2Intrae_xyz, tmp);
	}

	// --------------------------------------------------------------
	#if defined (DEBUG_KRNL_CONFORM)
	printf("AFTER Out CONFORM CHANNEL\n");
	#endif

} // End of while(1)

#if defined (DEBUG_ACTIVE_KERNEL)
printf("	%-20s: %s\n", "Krnl_Conform", "disabled");
#endif

}
// --------------------------------------------------------------------------
// --------------------------------------------------------------------------
