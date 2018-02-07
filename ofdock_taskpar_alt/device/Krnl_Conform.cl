// --------------------------------------------------------------------------
// The function changes the conformation of myligand according to 
// the genotype given by the second parameter.
// Originally from: processligand.c
// --------------------------------------------------------------------------
__kernel __attribute__ ((max_global_work_dim(0)))
void Krnl_Conform(
	     __global const int*  restrict KerConstStatic_rotlist_const,
	     #if defined (FIXED_POINT_CONFORM)
	     __constant fixedpt3* restrict KerConstStatic_ref_coords_const,
	     __constant fixedpt3* restrict KerConstStatic_rotbonds_moving_vectors_const,
	     __constant fixedpt3* restrict KerConstStatic_rotbonds_unit_vectors_const,
	     #else
	     __constant float3*   restrict KerConstStatic_ref_coords_const,
	     __constant float3*   restrict KerConstStatic_rotbonds_moving_vectors_const,
	     __constant float3*   restrict KerConstStatic_rotbonds_unit_vectors_const,
	     #endif    
			      unsigned int          DockConst_rotbondlist_length,
			      unsigned char         DockConst_num_of_atoms,
			      unsigned char         DockConst_num_of_genes,
/*
			      unsigned char         Host_num_of_rotbonds,
*/
	     #if defined (FIXED_POINT_CONFORM)
	     __constant fixedpt4* restrict KerConstStatic_ref_orientation_quats_const,
	     #else
	     __constant float4*   restrict KerConstStatic_ref_orientation_quats_const,
	     #endif
			      unsigned short        Host_RunId
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

/*
	bool active = true;
*/
	char active = 0x01;	

	__local int rotlist_localcache [MAX_NUM_OF_ROTATIONS];
	for (ushort c = 0; c < DockConst_rotbondlist_length; c++) {
		rotlist_localcache [c] = KerConstStatic_rotlist_const [c];
	}

#pragma max_concurrency 32
while(active) {
	char mode;

	#if defined (FIXED_POINT_CONFORM)
	fixedpt  phi;
	fixedpt  theta;
	fixedpt  genrotangle;
/*
	fixedpt  sin_theta, cos_theta;
	fixedpt3 genrot_unitvec;
*/
	fixedpt3 genotype_xyz;
	fixedpt3 __attribute__ ((
			      memory,
			      numbanks(1),
			      bankwidth(16),
			      singlepump,
			      numreadports(3),
			      numwriteports(1)
			    )) loc_coords [MAX_NUM_OF_ATOMS];
	#else
	float  phi;
	float  theta;
	float  genrotangle;
/*
	float  sin_theta, cos_theta;
	float3 genrot_unitvec;
*/
	float3 genotype_xyz;
	float3 __attribute__ ((
			      memory,
			      numbanks(1),
			      bankwidth(16),
			      singlepump,
			      numreadports(3),
			      numwriteports(1)
			    )) loc_coords [MAX_NUM_OF_ATOMS];
	#endif

/*
	active = read_channel_altera(chan_IGL2Conform_active);
	mem_fence(CLK_CHANNEL_MEM_FENCE);
*/
	char2 actmode = read_channel_altera(chan_IGL2Conform_actmode);
	mem_fence(CLK_CHANNEL_MEM_FENCE);

	active = actmode.x;
	mode   = actmode.y;

//printf("Conform: %u\n", mode);

	#if defined (FIXED_POINT_CONFORM)
	fixedpt genotype [ACTUAL_GENOTYPE_LENGTH];
	#else
	float   genotype [ACTUAL_GENOTYPE_LENGTH];
	#endif

	for (uchar i=0; i<DockConst_num_of_genes; i++) {
		/*float fl_tmp = read_channel_altera(chan_IGL2Conform_genotype);*/
		float fl_tmp;
		switch (mode) {
			case 'I':
				fl_tmp = read_channel_altera(chan_IC2Conf_genotype);
			break;

			case 'G':
				fl_tmp = read_channel_altera(chan_GG2Conf_genotype);
			break;

			case 0x01:
				fl_tmp = read_channel_altera(chan_LS2Conf_LS1_genotype);
			break;

			case 0x02:
				fl_tmp = read_channel_altera(chan_LS2Conf_LS2_genotype);
			break;

			case 0x03:
				fl_tmp = read_channel_altera(chan_LS2Conf_LS3_genotype);
			break;

			case 0x04:
				fl_tmp = read_channel_altera(chan_LS2Conf_LS4_genotype);
			break;

			case 0x05:
				fl_tmp = read_channel_altera(chan_LS2Conf_LS5_genotype);
			break;

			case 0x06:
				fl_tmp = read_channel_altera(chan_LS2Conf_LS6_genotype);
			break;

			case 0x07:
				fl_tmp = read_channel_altera(chan_LS2Conf_LS7_genotype);
			break;

			case 0x08:
				fl_tmp = read_channel_altera(chan_LS2Conf_LS8_genotype);
			break;

			case 0x09:
				fl_tmp = read_channel_altera(chan_LS2Conf_LS9_genotype);
			break;
		}
		
		if (i > 2) {
			fl_tmp = fl_tmp * DEG_TO_RAD;
		}

//printf("Conform: %u %u\n", mode, i);

		#if defined (FIXED_POINT_CONFORM)
		// convert float to fixedpt
		fixedpt fx_tmp = fixedpt_fromfloat(fl_tmp);
		switch (i) {
			case 0: genotype_xyz.x = fx_tmp; break;
			case 1: genotype_xyz.y = fx_tmp; break;
			case 2: genotype_xyz.z = fx_tmp; break;
			case 3: phi            = fx_tmp; break;
			case 4: theta          = fx_tmp; break;
			case 5: genrotangle    = fx_tmp; break;
		}
		genotype [i] = fx_tmp;
		#else
		switch (i) {
			case 0: genotype_xyz.x = fl_tmp; break;
			case 1: genotype_xyz.y = fl_tmp; break;
			case 2: genotype_xyz.z = fl_tmp; break;
			case 3: phi            = fl_tmp; break;
			case 4: theta          = fl_tmp; break;
			case 5: genrotangle    = fl_tmp; break;
		}
		genotype [i] = fl_tmp;
		#endif
	}

	#if defined (DEBUG_ACTIVE_KERNEL)
	if (active == 0x00) {printf("	%-20s: %s\n", "Krnl_Conform", "must be disabled");}
	#endif

/*
	#if defined (FIXED_POINT_CONFORM)
	sin_theta = fixedpt_sin(theta);
	cos_theta = fixedpt_cos(theta);
	genrot_unitvec.x = fixedpt_mul(sin_theta, fixedpt_cos(phi));
	genrot_unitvec.y = fixedpt_mul(sin_theta, fixedpt_sin(phi));
	genrot_unitvec.z = cos_theta;
	#else
	sin_theta = native_sin(theta);
	cos_theta = native_cos(theta);
	genrot_unitvec.x = sin_theta*native_cos(phi);
	genrot_unitvec.y = sin_theta*native_sin(phi);
	genrot_unitvec.z = cos_theta;
	#endif
*/

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
				/*atom_to_rotate = ref_coords_localcache [atom_id];*/
				atom_to_rotate = KerConstStatic_ref_coords_const [atom_id];
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
				#if defined (FIXED_POINT_CONFORM)
				fixedpt  sin_theta, cos_theta;
				fixedpt3 genrot_unitvec;
				sin_theta = fixedpt_sin(theta);
				cos_theta = fixedpt_cos(theta);
				genrot_unitvec.x = fixedpt_mul(sin_theta, fixedpt_cos(phi));
				genrot_unitvec.y = fixedpt_mul(sin_theta, fixedpt_sin(phi));
				genrot_unitvec.z = cos_theta;
				#else
				float  sin_theta, cos_theta;
				float3 genrot_unitvec;
				sin_theta = native_sin(theta);
				cos_theta = native_cos(theta);
				genrot_unitvec.x = sin_theta*native_cos(phi);
				genrot_unitvec.y = sin_theta*native_sin(phi);
				genrot_unitvec.z = cos_theta;
				#endif

				rotation_unitvec = genrot_unitvec;

				rotation_angle = genrotangle;

				rotation_movingvec = genotype_xyz;
			}
			else	//if rotating around rotatable bond
			{
				uint rotbond_id = (rotation_list_element & RLIST_RBONDID_MASK) >> RLIST_RBONDID_SHIFT;

				/*rotation_unitvec = rotbonds_unit_vectors_localcache [rotbond_id];*/
				rotation_unitvec = KerConstStatic_rotbonds_unit_vectors_const [rotbond_id];
				
				rotation_angle = genotype [6+rotbond_id];

				/*rotation_movingvec = rotbonds_moving_vectors_localcache [rotbond_id];*/
				rotation_movingvec = KerConstStatic_rotbonds_moving_vectors_const [rotbond_id];

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
			float4 quatrot_left;
			float4 quatrot_temp;
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
			quatrot_left.x = sin_angle*rotation_unitvec.x;
			quatrot_left.y = sin_angle*rotation_unitvec.y;
			quatrot_left.z = sin_angle*rotation_unitvec.z;
			quatrot_left.w = cos_angle;
			#endif

			if ((rotation_list_element & RLIST_GENROT_MASK) != 0)	//if general rotation, 
										//two rotations should be performed 
										//(multiplying the quaternions)
			{
				#if defined (FIXED_POINT_CONFORM)
				const fixedpt4 ref_orientation_quats_const = KerConstStatic_ref_orientation_quats_const[Host_RunId];
				const fixedpt  ref_orientation_quats_const_0 = ref_orientation_quats_const.x;
				const fixedpt  ref_orientation_quats_const_1 = ref_orientation_quats_const.y;
				const fixedpt  ref_orientation_quats_const_2 = ref_orientation_quats_const.z;
				const fixedpt  ref_orientation_quats_const_3 = ref_orientation_quats_const.w;
				#else
				const float4 ref_orientation_quats_const = KerConstStatic_ref_orientation_quats_const[Host_RunId];
				const float  ref_orientation_quats_const_0 = ref_orientation_quats_const.x;
				const float  ref_orientation_quats_const_1 = ref_orientation_quats_const.y;
				const float  ref_orientation_quats_const_2 = ref_orientation_quats_const.z;
				const float  ref_orientation_quats_const_3 = ref_orientation_quats_const.w;
				#endif

				//calculating quatrot_left*ref_orientation_quats_const, 
				//which means that reference orientation rotation is the first
				#if defined (FIXED_POINT_CONFORM)
				quatrot_temp_q = quatrot_left_q;
				quatrot_temp_x = quatrot_left_x;
				quatrot_temp_y = quatrot_left_y;
				quatrot_temp_z = quatrot_left_z;
				#else
				quatrot_temp = quatrot_left;
				#endif

				//taking the first element of ref_orientation_quats_const member
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
				float4 ref4x = {   ref_orientation_quats_const_0,   ref_orientation_quats_const_3, - ref_orientation_quats_const_2, ref_orientation_quats_const_1};
				float4 ref4y = { - ref_orientation_quats_const_3,   ref_orientation_quats_const_0,   ref_orientation_quats_const_1, ref_orientation_quats_const_2};
				float4 ref4z = {   ref_orientation_quats_const_2, - ref_orientation_quats_const_1,   ref_orientation_quats_const_0, ref_orientation_quats_const_3};
				float4 ref4w = { - ref_orientation_quats_const_1, - ref_orientation_quats_const_2, - ref_orientation_quats_const_3, ref_orientation_quats_const_0};

				quatrot_left.x = dot(quatrot_temp, ref4x);
				quatrot_left.y = dot(quatrot_temp, ref4y);
				quatrot_left.z = dot(quatrot_temp, ref4z);
				quatrot_left.w = dot(quatrot_temp, ref4w);
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
			float3 left3x = {  quatrot_left.w, - quatrot_left.z,   quatrot_left.y};
			float3 left3y = {  quatrot_left.z,   quatrot_left.w, - quatrot_left.x};
			float3 left3z = {- quatrot_left.y,   quatrot_left.x,   quatrot_left.w};
			float3 left3w = {- quatrot_left.x, - quatrot_left.y, - quatrot_left.z};

			quatrot_temp.x = dot(left3x, atom_to_rotate);
			quatrot_temp.y = dot(left3y, atom_to_rotate);
			quatrot_temp.z = dot(left3z, atom_to_rotate);
			quatrot_temp.w = dot(left3w, atom_to_rotate);

			float4 left4x = {  quatrot_left.w, - quatrot_left.z,   quatrot_left.y, - quatrot_left.x};
			float4 left4y = {  quatrot_left.z,   quatrot_left.w, - quatrot_left.x, - quatrot_left.y};
			float4 left4z = {- quatrot_left.y,   quatrot_left.x,   quatrot_left.w, - quatrot_left.z};

			atom_to_rotate.x = dot(quatrot_temp, left4x);
			atom_to_rotate.y = dot(quatrot_temp, left4y);
			atom_to_rotate.z = dot(quatrot_temp, left4z);
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


/*
	for (uchar pipe_cnt=0; pipe_cnt<DockConst_num_of_atoms; pipe_cnt++) {
		if (pipe_cnt == 0) {
			char  active_tmp = active;
			char  mode_tmp   = mode;
			char2 actmode    = {active_tmp, mode_tmp};

			write_channel_altera(chan_Conf2Intere_actmode, actmode);
			write_channel_altera(chan_Conf2Intrae_actmode, actmode);
		}
		mem_fence(CLK_CHANNEL_MEM_FENCE);

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
*/



	for (uchar pipe_cnt=0; pipe_cnt<DockConst_num_of_atoms; pipe_cnt+=2) {
		if (pipe_cnt == 0) {
			char  active_tmp = active;
			char  mode_tmp   = mode;
			char2 actmode    = {active_tmp, mode_tmp};

			write_channel_altera(chan_Conf2Intere_actmode, actmode);
			write_channel_altera(chan_Conf2Intrae_actmode, actmode);
		}
		mem_fence(CLK_CHANNEL_MEM_FENCE);

		#if defined (FIXED_POINT_CONFORM)
		fixedpt3 tmp_coords[2];
		#else
		float3 tmp_coords[2];
		#endif

		#pragma unroll
		for (uchar i=0; i<2; i++) {
			tmp_coords[i] = loc_coords[pipe_cnt+i];
		}

		float8 tmp;

		#if defined (FIXED_POINT_CONFORM)
		// convert fixedpt3 to float3
		float tmp_x1 = fixedpt_tofloat(tmp_coords[0].x);
		float tmp_y1 = fixedpt_tofloat(tmp_coords[0].y);
		float tmp_z1 = fixedpt_tofloat(tmp_coords[0].z);
		float tmp_x2 = fixedpt_tofloat(tmp_coords[1].x);
		float tmp_y2 = fixedpt_tofloat(tmp_coords[1].y);
		float tmp_z2 = fixedpt_tofloat(tmp_coords[1].z);
		tmp.s0 = tmp_x1; tmp.s1 = tmp_y1; tmp.s2 = tmp_z1; //tmp.s3
		tmp.s4 = tmp_x2; tmp.s5 = tmp_y2; tmp.s6 = tmp_z2; //tmp.s7
		#else
		tmp.s0 = tmp_coords[0].x; tmp.s1 = tmp_coords[0].y; tmp.s2 = tmp_coords[0].z; //tmp.s3
		tmp.s4 = tmp_coords[1].x; tmp.s5 = tmp_coords[1].y; tmp.s6 = tmp_coords[1].z; //tmp.s7
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
