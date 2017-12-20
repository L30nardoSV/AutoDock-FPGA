#if defined (FIXED_POINT_CONFORM)
#include "../defines_fixedpt.h"

typedef int3          fixedpt3;
#endif

// --------------------------------------------------------------------------
// The function changes the conformation of myligand according to 
// the genotype given by the second parameter.
// Originally from: processligand.c
// --------------------------------------------------------------------------
__kernel __attribute__ ((max_global_work_dim(0)))
void Krnl_Conform(
	     __constant int*    restrict KerConstStatic_rotlist_const,
	     #if defined (FIXED_POINT_CONFORM)
	     __constant fixedpt3* restrict KerConstStatic_ref_coords_const,		 // must be formatted in host
	     __constant fixedpt3* restrict KerConstStatic_rotbonds_moving_vectors_const, // must be formatted in host
	     __constant fixedpt3* restrict KerConstStatic_rotbonds_unit_vectors_const,	 // must be formatted in host
	     #else
	     __constant float3*   restrict KerConstStatic_ref_coords_const,
	     __constant float3*   restrict KerConstStatic_rotbonds_moving_vectors_const,
	     __constant float3*   restrict KerConstStatic_rotbonds_unit_vectors_const,
	     #endif    
			      unsigned int          DockConst_rotbondlist_length,
			      unsigned char         DockConst_num_of_atoms,
			      unsigned char         DockConst_num_of_genes,
			      unsigned char         Host_num_of_rotbonds,

	     #if defined (FIXED_POINT_CONFORM)
			      fixedpt               ref_orientation_quats_const_0,	// must be formatted in host
			      fixedpt               ref_orientation_quats_const_1,	// must be formatted in host
			      fixedpt               ref_orientation_quats_const_2,	// must be formatted in host
			      fixedpt               ref_orientation_quats_const_3	// must be formatted in host
	     #else
			      float                 ref_orientation_quats_const_0,
			      float                 ref_orientation_quats_const_1,
			      float                 ref_orientation_quats_const_2,
			      float                 ref_orientation_quats_const_3
	     #endif
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

	#if defined (FIXED_POINT_CONFORM)
	__local fixedpt genotype[ACTUAL_GENOTYPE_LENGTH];
	#else
	__local float   genotype[ACTUAL_GENOTYPE_LENGTH];
	#endif

	bool active = true;

	__local int rotlist_localcache [MAX_NUM_OF_ROTATIONS];
	for (ushort c = 0; c < DockConst_rotbondlist_length; c++) {
		rotlist_localcache [c] = KerConstStatic_rotlist_const [c];
	}

	#if defined (FIXED_POINT_CONFORM)
	__local fixedpt3 ref_coords_localcache [MAX_NUM_OF_ATOMS];
	#else
	__local float3   ref_coords_localcache [MAX_NUM_OF_ATOMS];
	#endif
	for (uchar c = 0; c < DockConst_num_of_atoms; c++) {
		ref_coords_localcache [c] = KerConstStatic_ref_coords_const [c];
	}

	#if defined (FIXED_POINT_CONFORM)
	__local fixedpt3 rotbonds_moving_vectors_localcache[MAX_NUM_OF_ROTBONDS];
	__local fixedpt3 rotbonds_unit_vectors_localcache[MAX_NUM_OF_ROTBONDS];
	#else
	__local float3   rotbonds_moving_vectors_localcache[MAX_NUM_OF_ROTBONDS];
	__local float3   rotbonds_unit_vectors_localcache[MAX_NUM_OF_ROTBONDS];
	#endif
	for (uchar c = 0; c < Host_num_of_rotbonds; c++) {
		rotbonds_moving_vectors_localcache [c] = KerConstStatic_rotbonds_moving_vectors_const[c];
		rotbonds_unit_vectors_localcache   [c] = KerConstStatic_rotbonds_unit_vectors_const [c];
	}

while(active) {
	char mode;

	active = read_channel_altera(/*chan_IGL_active*/ chan_IGL2Conform_active);
	mem_fence(CLK_CHANNEL_MEM_FENCE);

	for (uchar i=0; i<DockConst_num_of_genes; i++) {
		if (i == 0) {
			mode = read_channel_altera(/*chan_IGL_mode*/ chan_IGL2Conform_mode);
			mem_fence(CLK_CHANNEL_MEM_FENCE);
		}

		#if defined (FIXED_POINT_CONFORM)
		// convert float to fixedpt
		float fl_tmp = read_channel_altera(/*chan_IGL_genotype*/ chan_IGL2Conform_genotype);
		genotype [i] = fixedpt_fromfloat(fl_tmp);
		#else
		genotype [i] = read_channel_altera(/*chan_IGL_genotype*/chan_IGL2Conform_genotype);
		#endif
	}

	#if defined (FIXED_POINT_CONFORM)
	fixedpt3 loc_coords[MAX_NUM_OF_ATOMS];
	#else
	float3   loc_coords[MAX_NUM_OF_ATOMS];
	#endif

	#if defined (DEBUG_ACTIVE_KERNEL)
	if (active == 0) {printf("	%-20s: %s\n", "Krnl_Conform", "must be disabled");}
	#endif

	#if defined (FIXED_POINT_CONFORM)
	fixedpt phi         = genotype [3];
	fixedpt theta       = genotype [4];
	fixedpt genrotangle = genotype [5];

	fixedpt sin_theta, cos_theta;
	sin_theta = fixedpt_sin(theta);
	cos_theta = fixedpt_cos(theta);

	fixedpt3 genrot_unitvec;
	genrot_unitvec.x = /*fixedpt_mul*/ fixedpt_mul(sin_theta, fixedpt_cos(phi));
	genrot_unitvec.y = /*fixedpt_mul*/ fixedpt_mul(sin_theta, fixedpt_sin(phi));
	genrot_unitvec.z = cos_theta;
	
	fixedpt3 genotype_xyz = {genotype[0], genotype[1], genotype[2]};
	#else
	float phi         = genotype [3];
	float theta       = genotype [4];
	float genrotangle = genotype [5];

	float sin_theta, cos_theta;
	sin_theta = native_sin(theta);
	cos_theta = native_cos(theta);

	float3 genrot_unitvec;
	genrot_unitvec.x = sin_theta*native_cos(phi);
	genrot_unitvec.y = sin_theta*native_sin(phi);
	genrot_unitvec.z = cos_theta;
	
	float3 genotype_xyz = {genotype[0], genotype[1], genotype[2]};
	#endif
	
	for (ushort rotation_counter = 0; rotation_counter < DockConst_rotbondlist_length; rotation_counter++)
	{
		int rotation_list_element = rotlist_localcache [rotation_counter];

		if ((rotation_list_element & RLIST_DUMMY_MASK) == 0)	//if not dummy rotation
		{
			uint atom_id = rotation_list_element & RLIST_ATOMID_MASK;

			//capturing atom coordinates
			#if defined (FIXED_POINT_CONFORM)
			fixedpt3 atom_to_rotate;
			#else
			float3 atom_to_rotate;
			#endif

			if ((rotation_list_element & RLIST_FIRSTROT_MASK) != 0)	//if first rotation of this atom
			{	
				atom_to_rotate = ref_coords_localcache [atom_id];
			}
			else
			{	
				atom_to_rotate = loc_coords[atom_id];
			}

			//capturing rotation vectors and angle
			#if defined (FIXED_POINT_CONFORM)
			fixedpt3 rotation_unitvec;
			fixedpt3 rotation_movingvec;
			fixedpt  rotation_angle;
			#else
			float3   rotation_unitvec;
			float3   rotation_movingvec;
			float    rotation_angle;
			#endif

			if ((rotation_list_element & RLIST_GENROT_MASK) != 0)	//if general rotation
			{
				rotation_unitvec = genrot_unitvec;

				rotation_angle = genrotangle;

				rotation_movingvec = genotype_xyz;
			}
			else	//if rotating around rotatable bond
			{
				uint rotbond_id = (rotation_list_element & RLIST_RBONDID_MASK) >> RLIST_RBONDID_SHIFT;
				rotation_unitvec = rotbonds_unit_vectors_localcache [rotbond_id];
				
				rotation_angle = genotype[6+rotbond_id];

				rotation_movingvec = rotbonds_moving_vectors_localcache [rotbond_id];

				//in addition performing the first movement 
				//which is needed only if rotating around rotatable bond

				#if defined (FIXED_POINT_CONFORM)
				atom_to_rotate.x = fixedpt_sub(atom_to_rotate.x, rotation_movingvec.x);
				atom_to_rotate.y = fixedpt_sub(atom_to_rotate.y, rotation_movingvec.y);
				atom_to_rotate.z = fixedpt_sub(atom_to_rotate.z, rotation_movingvec.z);
				#else
				atom_to_rotate -= rotation_movingvec;
				#endif
			}

			//performing rotation
			#if defined (FIXED_POINT_CONFORM)
			fixedpt quatrot_left_x, quatrot_left_y, quatrot_left_z, quatrot_left_q;
			fixedpt quatrot_temp_x, quatrot_temp_y, quatrot_temp_z, quatrot_temp_q;
			#else
			float quatrot_left_x, quatrot_left_y, quatrot_left_z, quatrot_left_q;
			float quatrot_temp_x, quatrot_temp_y, quatrot_temp_z, quatrot_temp_q;
			#endif

			#if defined (FIXED_POINT_CONFORM)
			rotation_angle = rotation_angle >> 1;
			#else
			rotation_angle = rotation_angle*0.5f;
			#endif

			#if defined (FIXED_POINT_CONFORM)
			fixedpt sin_angle, cos_angle;
			sin_angle      = fixedpt_sin(rotation_angle);
			cos_angle      = fixedpt_cos(rotation_angle);
			quatrot_left_x = fixedpt_mul(sin_angle, rotation_unitvec.x);
			quatrot_left_y = fixedpt_mul(sin_angle, rotation_unitvec.y);
			quatrot_left_z = fixedpt_mul(sin_angle, rotation_unitvec.z);
			quatrot_left_q = cos_angle;
			#else
			float sin_angle, cos_angle;
			sin_angle      = native_sin(rotation_angle);
			cos_angle      = native_cos(rotation_angle);
			quatrot_left_x = sin_angle*rotation_unitvec.x;
			quatrot_left_y = sin_angle*rotation_unitvec.y;
			quatrot_left_z = sin_angle*rotation_unitvec.z;
			quatrot_left_q = cos_angle;
			#endif

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
				#if defined (FIXED_POINT_CONFORM)
				quatrot_left_q =   fixedpt_mul(quatrot_temp_q, ref_orientation_quats_const_0) 
						 - fixedpt_mul(quatrot_temp_x, ref_orientation_quats_const_1) 
						 - fixedpt_mul(quatrot_temp_y, ref_orientation_quats_const_2) 
						 - fixedpt_mul(quatrot_temp_z, ref_orientation_quats_const_3);

				quatrot_left_x =   fixedpt_mul(quatrot_temp_q, ref_orientation_quats_const_1) 
						 + fixedpt_mul(quatrot_temp_x, ref_orientation_quats_const_0) 
					         + fixedpt_mul(quatrot_temp_y, ref_orientation_quats_const_3) 
						 - fixedpt_mul(quatrot_temp_z, ref_orientation_quats_const_2);

				quatrot_left_y =   fixedpt_mul(quatrot_temp_q, ref_orientation_quats_const_2)
						 - fixedpt_mul(quatrot_temp_x, ref_orientation_quats_const_3) 
  						 + fixedpt_mul(quatrot_temp_y, ref_orientation_quats_const_0) 
						 + fixedpt_mul(quatrot_temp_z, ref_orientation_quats_const_1);

				quatrot_left_z =   fixedpt_mul(quatrot_temp_q, ref_orientation_quats_const_3)
						 + fixedpt_mul(quatrot_temp_x, ref_orientation_quats_const_2) 
						 - fixedpt_mul(quatrot_temp_y, ref_orientation_quats_const_1) 
						 + fixedpt_mul(quatrot_temp_z, ref_orientation_quats_const_0);
				#else
				quatrot_left_q =   quatrot_temp_q * ref_orientation_quats_const_0
						 - quatrot_temp_x * ref_orientation_quats_const_1
						 - quatrot_temp_y * ref_orientation_quats_const_2
						 - quatrot_temp_z * ref_orientation_quats_const_3;

				quatrot_left_x =   quatrot_temp_q * ref_orientation_quats_const_1
						 + quatrot_temp_x * ref_orientation_quats_const_0
						 + quatrot_temp_y * ref_orientation_quats_const_3
						 - quatrot_temp_z * ref_orientation_quats_const_2;

				quatrot_left_y =   quatrot_temp_q * ref_orientation_quats_const_2 
						 - quatrot_temp_x * ref_orientation_quats_const_3
						 + quatrot_temp_y * ref_orientation_quats_const_0
						 + quatrot_temp_z * ref_orientation_quats_const_1 ;

				quatrot_left_z =   quatrot_temp_q * ref_orientation_quats_const_3
						 + quatrot_temp_x * ref_orientation_quats_const_2 
						 - quatrot_temp_y * ref_orientation_quats_const_1
						 + quatrot_temp_z * ref_orientation_quats_const_0;
				#endif
			}

			#if defined (FIXED_POINT_CONFORM)
			quatrot_temp_q = - fixedpt_mul(quatrot_left_x, atom_to_rotate.x) 
					 - fixedpt_mul(quatrot_left_y, atom_to_rotate.y)
					 - fixedpt_mul(quatrot_left_z, atom_to_rotate.z);

			quatrot_temp_x =   fixedpt_mul(quatrot_left_q, atom_to_rotate.x) 
					 + fixedpt_mul(quatrot_left_y, atom_to_rotate.z)
					 - fixedpt_mul(quatrot_left_z, atom_to_rotate.y);

			quatrot_temp_y =   fixedpt_mul(quatrot_left_q, atom_to_rotate.y)
					 - fixedpt_mul(quatrot_left_x, atom_to_rotate.z)
					 + fixedpt_mul(quatrot_left_z, atom_to_rotate.x);

			quatrot_temp_z =   fixedpt_mul(quatrot_left_q, atom_to_rotate.z)
					 + fixedpt_mul(quatrot_left_x, atom_to_rotate.y)
					 - fixedpt_mul(quatrot_left_y, atom_to_rotate.x);

			atom_to_rotate.x = - fixedpt_mul(quatrot_temp_q, quatrot_left_x)
					   + fixedpt_mul(quatrot_temp_x, quatrot_left_q)
					   - fixedpt_mul(quatrot_temp_y, quatrot_left_z)
					   + fixedpt_mul(quatrot_temp_z, quatrot_left_y);

			atom_to_rotate.y = - fixedpt_mul(quatrot_temp_q, quatrot_left_y)
					   + fixedpt_mul(quatrot_temp_x, quatrot_left_z)
					   + fixedpt_mul(quatrot_temp_y, quatrot_left_q)
					   - fixedpt_mul(quatrot_temp_z, quatrot_left_x);

			atom_to_rotate.z = - fixedpt_mul(quatrot_temp_q, quatrot_left_z)
					   - fixedpt_mul(quatrot_temp_x, quatrot_left_y)
					   + fixedpt_mul(quatrot_temp_y, quatrot_left_x)
					   + fixedpt_mul(quatrot_temp_z, quatrot_left_q);
			#else
			quatrot_temp_q = - quatrot_left_x * atom_to_rotate.x 
					 - quatrot_left_y * atom_to_rotate.y 
					 - quatrot_left_z * atom_to_rotate.z;

			quatrot_temp_x =   quatrot_left_q * atom_to_rotate.x 
					 + quatrot_left_y * atom_to_rotate.z 
					 - quatrot_left_z * atom_to_rotate.y;

			quatrot_temp_y =   quatrot_left_q * atom_to_rotate.y 
					 - quatrot_left_x * atom_to_rotate.z 
					 + quatrot_left_z * atom_to_rotate.x;

			quatrot_temp_z =   quatrot_left_q * atom_to_rotate.z 
					 + quatrot_left_x * atom_to_rotate.y 
					 - quatrot_left_y * atom_to_rotate.x;
			
			atom_to_rotate.x = - quatrot_temp_q * quatrot_left_x 
					   + quatrot_temp_x * quatrot_left_q
					   - quatrot_temp_y * quatrot_left_z
					   + quatrot_temp_z * quatrot_left_y;

			atom_to_rotate.y = - quatrot_temp_q * quatrot_left_y
					   + quatrot_temp_x * quatrot_left_z
					   + quatrot_temp_y * quatrot_left_q
					   - quatrot_temp_z * quatrot_left_x;

			atom_to_rotate.z = - quatrot_temp_q * quatrot_left_z
					   - quatrot_temp_x * quatrot_left_y
					   + quatrot_temp_y * quatrot_left_x
					   + quatrot_temp_z * quatrot_left_q;
			#endif

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
	/*
	write_channel_altera(chan_Conf2Intere_active, active);
	write_channel_altera(chan_Conf2Intrae_active, active);
	mem_fence(CLK_CHANNEL_MEM_FENCE);

	write_channel_altera(chan_Conf2Intere_mode,   mode);
	write_channel_altera(chan_Conf2Intrae_mode,   mode);
	mem_fence(CLK_CHANNEL_MEM_FENCE);

	//float3 position_xyz;
	for (uchar pipe_cnt=0; pipe_cnt<DockConst_num_of_atoms; pipe_cnt++) {
		write_channel_altera(chan_Conf2Intere_xyz, loc_coords[pipe_cnt]);
		write_channel_altera(chan_Conf2Intrae_xyz, loc_coords[pipe_cnt]);
	}*/


	for (uchar pipe_cnt=0; pipe_cnt<DockConst_num_of_atoms; pipe_cnt++) {
		if (pipe_cnt == 0) {
			write_channel_altera(chan_Conf2Intere_active, active);
			write_channel_altera(chan_Conf2Intrae_active, active);
			mem_fence(CLK_CHANNEL_MEM_FENCE);

			write_channel_altera(chan_Conf2Intere_mode,   mode);
			write_channel_altera(chan_Conf2Intrae_mode,   mode);
			mem_fence(CLK_CHANNEL_MEM_FENCE);
		}

		#if defined (FIXED_POINT_CONFORM)
		// convert fixedpt3 to float3
		float tmp_x = fixedpt_tofloat(loc_coords[pipe_cnt].x);
		float tmp_y = fixedpt_tofloat(loc_coords[pipe_cnt].y);
		float tmp_z = fixedpt_tofloat(loc_coords[pipe_cnt].z);
		float3 tmp = {tmp_x, tmp_y, tmp_z};
		#else
		float3 tmp = loc_coords[pipe_cnt];
		#endif

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
