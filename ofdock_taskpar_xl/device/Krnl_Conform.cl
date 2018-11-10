// --------------------------------------------------------------------------
// Conform changes the conformation of the ligand according to 
// the genotype fed by any producer logic/kernel (IC, GG, LSs).
// Originally from: processligand.c
// --------------------------------------------------------------------------
/*
__kernel __attribute__ ((max_global_work_dim(0)))
*/
__kernel __attribute__ ((reqd_work_group_size(1,1,1)))
void Krnl_Conform(
	     __global const int*  restrict KerConstStatic_rotlist_const,
	     __constant float3*   restrict KerConstStatic_ref_coords_const,
	     __constant float3*   restrict KerConstStatic_rotbonds_moving_vectors_const,
	     __constant float3*   restrict KerConstStatic_rotbonds_unit_vectors_const,  
			      unsigned int          DockConst_rotbondlist_length,
			      unsigned char         DockConst_num_of_atoms,
			      unsigned char         DockConst_num_of_genes,
	     __constant float4*   restrict KerConstStatic_ref_orientation_quats_const,
			      unsigned short        Host_RunId
)
{
	#if defined (DEBUG_KRNL_Conform) 
	printf("\n");
	printf("%-40s %u\n", "DockConst->rotbondlist_length: ",	DockConst_rotbondlist_length);
	printf("%-40s %u\n", "DockConst->num_of_atoms: ",  	DockConst_num_of_atoms);
	printf("%-40s %u\n", "DockConst_num_of_genes: ",        DockConst_num_of_genes);	
	#endif

	// Check best practices guide
	// Table 11. Effects of numbanks and bankwidth on the Bank Geometry ...
	// Only first three indexes of the lower array are used
	// however size of lower array was declared as 4, 
	// just to keep sizes equal to power of 2
	// __local float  __attribute__((numbanks(8), bankwidth(16))) loc_coords[MAX_NUM_OF_ATOMS][4];

	char active = 0x01;	

	__local int rotlist_localcache [MAX_NUM_OF_ROTATIONS];

	__attribute__((xcl_pipeline_loop))
	LOOP_FOR_CONFORM_ROTBONDLIST:
	for (ushort c = 0; c < DockConst_rotbondlist_length; c++) {
		rotlist_localcache [c] = KerConstStatic_rotlist_const [c];
	}

__attribute__((xcl_pipeline_loop))
LOOP_WHILE_CONFORM_MAIN:
while(active) {
	char mode;


	float  phi;
	float  theta;
	float  genrotangle;
	float3 genotype_xyz;
/*
	float3 __attribute__ ((
			      memory,
			      numbanks(1),
			      bankwidth(16),
			      singlepump,
			      numreadports(3),
			      numwriteports(1)
			    )) loc_coords [MAX_NUM_OF_ATOMS];
*/
	float3 loc_coords [MAX_NUM_OF_ATOMS];

	char actmode;
	read_pipe_block(chan_IGL2Conform_actmode, &actmode);
/*
	mem_fence(CLK_CHANNEL_MEM_FENCE);
*/
	active = actmode;
	mode   = actmode;

//printf("Conform: %u\n", mode);

	float   genotype [ACTUAL_GENOTYPE_LENGTH];

	__attribute__((xcl_pipeline_loop))
	LOOP_FOR_CONFORM_READ_GENOTYPE:
	for (uchar i=0; i<DockConst_num_of_genes; i++) {
		float fl_tmp;
		switch (mode) {
			case 'I':  read_pipe_block(chan_IC2Conf_genotype,     &fl_tmp); break;
			case 'G':  read_pipe_block(chan_GG2Conf_genotype,     &fl_tmp); break;
			case 0x01: read_pipe_block(chan_LS2Conf_LS1_genotype, &fl_tmp); break;
			case 0x02: read_pipe_block(chan_LS2Conf_LS2_genotype, &fl_tmp); break;
			case 0x03: read_pipe_block(chan_LS2Conf_LS3_genotype, &fl_tmp); break;
			case 0x04: read_pipe_block(chan_LS2Conf_LS4_genotype, &fl_tmp); break;
			case 0x05: read_pipe_block(chan_LS2Conf_LS5_genotype, &fl_tmp); break;
			case 0x06: read_pipe_block(chan_LS2Conf_LS6_genotype, &fl_tmp); break;
			case 0x07: read_pipe_block(chan_LS2Conf_LS7_genotype, &fl_tmp); break;
			case 0x08: read_pipe_block(chan_LS2Conf_LS8_genotype, &fl_tmp); break;
			case 0x09: read_pipe_block(chan_LS2Conf_LS9_genotype, &fl_tmp); break;
		}
		
		if (i > 2) {
			fl_tmp = fl_tmp * DEG_TO_RAD;
		}

//printf("Conform: %u %u\n", mode, i);

		switch (i) {
			case 0: genotype_xyz.x = fl_tmp; break;
			case 1: genotype_xyz.y = fl_tmp; break;
			case 2: genotype_xyz.z = fl_tmp; break;
			case 3: phi            = fl_tmp; break;
			case 4: theta          = fl_tmp; break;
			case 5: genrotangle    = fl_tmp; break;
		}
		genotype [i] = fl_tmp;
	}

	#if defined (DEBUG_ACTIVE_KERNEL)
	if (active == 0x00) {printf("	%-20s: %s\n", "Krnl_Conform", "must be disabled");}
	#endif

	__attribute__((xcl_pipeline_loop))
	LOOP_FOR_CONFORM_MAIN:
	for (ushort rotation_counter = 0; rotation_counter < DockConst_rotbondlist_length; rotation_counter++)
	{
		int rotation_list_element = rotlist_localcache [rotation_counter];

		if ((rotation_list_element & RLIST_DUMMY_MASK) == 0)	// If not dummy rotation
		{
			uint atom_id = rotation_list_element & RLIST_ATOMID_MASK;

			// Capturing atom coordinates
			float3 atom_to_rotate;

			if ((rotation_list_element & RLIST_FIRSTROT_MASK) != 0)	// If first rotation of this atom
			{	
				atom_to_rotate = KerConstStatic_ref_coords_const [atom_id];
			}
			else
			{	
				atom_to_rotate = loc_coords[atom_id];
			}

			// Capturing rotation vectors and angle
			float3   rotation_unitvec;
			float3   rotation_movingvec;
			float    rotation_angle;

			if ((rotation_list_element & RLIST_GENROT_MASK) != 0)	// If general rotation
			{
				float  sin_theta, cos_theta;
				float3 genrot_unitvec;
				sin_theta = native_sin(theta);
				cos_theta = native_cos(theta);
				genrot_unitvec.x = sin_theta*native_cos(phi);
				genrot_unitvec.y = sin_theta*native_sin(phi);
				genrot_unitvec.z = cos_theta;

				rotation_unitvec = genrot_unitvec;
				rotation_angle = genrotangle;
				rotation_movingvec = genotype_xyz;
			}
			else	// If rotating around rotatable bond
			{
				uint rotbond_id = (rotation_list_element & RLIST_RBONDID_MASK) >> RLIST_RBONDID_SHIFT;

				rotation_unitvec = KerConstStatic_rotbonds_unit_vectors_const [rotbond_id];
				
				rotation_angle = genotype [6+rotbond_id];

				rotation_movingvec = KerConstStatic_rotbonds_moving_vectors_const [rotbond_id];

				// In addition performing the first movement 
				// which is needed only if rotating around rotatable bond
				atom_to_rotate -= rotation_movingvec;
			}

			// Performing rotation
			float4 quatrot_left;
			float4 quatrot_temp;

			rotation_angle = rotation_angle*0.5f;

			float sin_angle, cos_angle;
			sin_angle      = native_sin(rotation_angle);
			cos_angle      = native_cos(rotation_angle);
			quatrot_left.x = sin_angle*rotation_unitvec.x;
			quatrot_left.y = sin_angle*rotation_unitvec.y;
			quatrot_left.z = sin_angle*rotation_unitvec.z;
			quatrot_left.w = cos_angle;

			if ((rotation_list_element & RLIST_GENROT_MASK) != 0)	// If general rotation, 
										// two rotations should be performed 
										// (multiplying the quaternions)
			{
				const float4 ref_orientation_quats_const = KerConstStatic_ref_orientation_quats_const[Host_RunId];
				const float  ref_orientation_quats_const_0 = ref_orientation_quats_const.x;
				const float  ref_orientation_quats_const_1 = ref_orientation_quats_const.y;
				const float  ref_orientation_quats_const_2 = ref_orientation_quats_const.z;
				const float  ref_orientation_quats_const_3 = ref_orientation_quats_const.w;

				// Calculating quatrot_left*ref_orientation_quats_const, 
				// which means that reference orientation rotation is the first
				quatrot_temp = quatrot_left;

				// Taking the first element of ref_orientation_quats_const member
				float4 ref4x = {   ref_orientation_quats_const_0,   ref_orientation_quats_const_3, - ref_orientation_quats_const_2, ref_orientation_quats_const_1};
				float4 ref4y = { - ref_orientation_quats_const_3,   ref_orientation_quats_const_0,   ref_orientation_quats_const_1, ref_orientation_quats_const_2};
				float4 ref4z = {   ref_orientation_quats_const_2, - ref_orientation_quats_const_1,   ref_orientation_quats_const_0, ref_orientation_quats_const_3};
				float4 ref4w = { - ref_orientation_quats_const_1, - ref_orientation_quats_const_2, - ref_orientation_quats_const_3, ref_orientation_quats_const_0};

				quatrot_left.x = dot(quatrot_temp, ref4x);
				quatrot_left.y = dot(quatrot_temp, ref4y);
				quatrot_left.z = dot(quatrot_temp, ref4z);
				quatrot_left.w = dot(quatrot_temp, ref4w);
			}

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

			// Performing final movement and storing values
			loc_coords[atom_id] = atom_to_rotate + rotation_movingvec;

		} // End if-statement not dummy rotation

		mem_fence(CLK_LOCAL_MEM_FENCE);

	} // End rotation_counter for-loop

	#if defined (DEBUG_KRNL_CONFORM)
	printf("BEFORE Out CONFORM CHANNEL\n");
	#endif

	// --------------------------------------------------------------
	// Send ligand atomic coordinates to channel 
	// --------------------------------------------------------------
	__attribute__((xcl_pipeline_loop))
	LOOP_FOR_CONFORM_WRITE_XYZ:
	for (uchar pipe_cnt=0; pipe_cnt<DockConst_num_of_atoms; pipe_cnt+=2) {
		if (pipe_cnt == 0) {
			write_pipe_block(chan_Conf2Intere_actmode, &mode);
			write_pipe_block(chan_Conf2Intrae_actmode, &mode);
		}
/*
		mem_fence(CLK_CHANNEL_MEM_FENCE);
*/

		float3 tmp_coords[2];

		__attribute__((opencl_unroll_hint))
		LOOP_CONFORM_OUT:
		for (uchar i=0; i<2; i++) {
			tmp_coords[i] = loc_coords[pipe_cnt+i];
		}

		float8 tmp;

		tmp.s0 = tmp_coords[0].x; tmp.s1 = tmp_coords[0].y; tmp.s2 = tmp_coords[0].z; //tmp.s3
		tmp.s4 = tmp_coords[1].x; tmp.s5 = tmp_coords[1].y; tmp.s6 = tmp_coords[1].z; //tmp.s7

		write_pipe_block(chan_Conf2Intere_xyz, &tmp);
		write_pipe_block(chan_Conf2Intrae_xyz, &tmp);
	}

	// --------------------------------------------------------------
	#if defined (DEBUG_KRNL_CONFORM)
	printf("AFTER Out CONFORM CHANNEL\n");
	#endif

} // End of while(active)

#if defined (DEBUG_ACTIVE_KERNEL)
printf("	%-20s: %s\n", "Krnl_Conform", "disabled");
#endif

}
// --------------------------------------------------------------------------
// --------------------------------------------------------------------------
