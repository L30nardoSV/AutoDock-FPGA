// --------------------------------------------------------------------------
// The function changes the conformation of myligand according to 
// the genotype given by the second parameter.
// Originally from: processligand.c
// --------------------------------------------------------------------------
__kernel __attribute__ ((max_global_work_dim(0)))
void Krnl_Conform(
             __global   const kernelconstant_static*  restrict KerConstStatic,
	     __global   const kernelconstant_dynamic* restrict KerConstDynamic,
	     __constant       Dockparameters*  restrict DockConst
)
{
	__local float loc_coords_x[MAX_NUM_OF_ATOMS];
	__local float loc_coords_y[MAX_NUM_OF_ATOMS];
	__local float loc_coords_z[MAX_NUM_OF_ATOMS];
	__local float genotype[ACTUAL_GENOTYPE_LENGTH];

	/*
	float __attribute__((memory, numbanks(1), bankwidth(4), singlepump, numreadports(3), numwriteports(1))) loc_coords_x[MAX_NUM_OF_ATOMS];
	float __attribute__((memory, numbanks(1), bankwidth(4), singlepump, numreadports(3), numwriteports(1))) loc_coords_y[MAX_NUM_OF_ATOMS];
	float __attribute__((memory, numbanks(1), bankwidth(4), singlepump, numreadports(3), numwriteports(1))) loc_coords_z[MAX_NUM_OF_ATOMS];
	//float __attribute__((register)) genotype[ACTUAL_GENOTYPE_LENGTH];
	*/

	char active = 1;
	char mode   = 0;
	uint cnt    = 0;    

	char IC_active, GG_active, LS_active;
	bool IC_valid = false;
	bool GG_valid = false;
	bool LS_valid = false;
	char IC_mode, GG_mode, LS_mode = 0;
	

	float phi, theta, genrotangle;
	float genrot_unitvec [3];

	int rotation_list_element;
	uint atom_id, rotbond_id;
	float atom_to_rotate[3];
	float rotation_unitvec[3];
	float rotation_movingvec[3];
	float rotation_angle;
	float sin_angle;
	float quatrot_left_x, quatrot_left_y, quatrot_left_z, quatrot_left_q;
	float quatrot_temp_x, quatrot_temp_y, quatrot_temp_z, quatrot_temp_q;
	
	float ref_orientation_quats_const_0 = KerConstDynamic->ref_orientation_quats_const[0]; 
	float ref_orientation_quats_const_1 = KerConstDynamic->ref_orientation_quats_const[1];
	float ref_orientation_quats_const_2 = KerConstDynamic->ref_orientation_quats_const[2];
	float ref_orientation_quats_const_3 = KerConstDynamic->ref_orientation_quats_const[3];

while(active) {

	#if defined (DEBUG_KRNL_CONFORM)
	printf("BEFORE In CONFORM CHANNEL\n");
	#endif
	// --------------------------------------------------------------
	// Wait for genotypes in channel
	// --------------------------------------------------------------
	while ((IC_valid == false) && (GG_valid == false) && (LS_valid == false)) {
		IC_active = read_channel_nb_altera(chan_IC2Conf_active, &IC_valid);
		GG_active = read_channel_nb_altera(chan_GG2Conf_active, &GG_valid);
		LS_active = read_channel_nb_altera(chan_LS2Conf_active, &LS_valid);
	}

	if (IC_valid) {
		active = IC_active;
		mem_fence(CLK_CHANNEL_MEM_FENCE);
		mode   = read_channel_altera(chan_IC2Conf_mode);
		mem_fence(CLK_CHANNEL_MEM_FENCE);
		cnt    = read_channel_altera(chan_IC2Conf_cnt);
		mem_fence(CLK_CHANNEL_MEM_FENCE);

		for (uchar pipe_cnt=0; pipe_cnt<ACTUAL_GENOTYPE_LENGTH; pipe_cnt++) {
			genotype[pipe_cnt] = read_channel_altera(chan_IC2Conf_genotype);}	
	}
	else {
		if (GG_valid) {
			active = GG_active;
			mem_fence(CLK_CHANNEL_MEM_FENCE);
			mode   = read_channel_altera(chan_GG2Conf_mode);
			mem_fence(CLK_CHANNEL_MEM_FENCE);
			cnt    = read_channel_altera(chan_GG2Conf_cnt);
			mem_fence(CLK_CHANNEL_MEM_FENCE);

			for (uchar pipe_cnt=0; pipe_cnt<ACTUAL_GENOTYPE_LENGTH; pipe_cnt++) {
				genotype[pipe_cnt] = read_channel_altera(chan_GG2Conf_genotype);}	
		}
		else {
			if (LS_valid) {
				active = LS_active;
				mem_fence(CLK_CHANNEL_MEM_FENCE);
				mode   = read_channel_altera(chan_LS2Conf_mode);
				mem_fence(CLK_CHANNEL_MEM_FENCE);
				cnt    = read_channel_altera(chan_LS2Conf_cnt);
				mem_fence(CLK_CHANNEL_MEM_FENCE);

				for (uchar pipe_cnt=0; pipe_cnt<ACTUAL_GENOTYPE_LENGTH; pipe_cnt++) {
					genotype[pipe_cnt] = read_channel_altera(chan_LS2Conf_genotype);}
			}
		}	
	}

	IC_valid = false;	
	GG_valid = false;
	LS_valid = false;

	IC_active = 0;
	GG_active = 0;
	LS_active = 0; 
	
	#if defined (DEBUG_ACTIVE_KERNEL)
	if (active == 0) {printf("	%-20s: %s\n", "Krnl_Conform", "must be disabled");}
	#endif
	
	// --------------------------------------------------------------
	#if defined (DEBUG_KRNL_CONFORM)
	printf("AFTER In CONFORM CHANNEL\n");
	#endif

	phi         = genotype [3]*DEG_TO_RAD;
	theta       = genotype [4]*DEG_TO_RAD;
	genrotangle = genotype [5]*DEG_TO_RAD;

	float sin_theta = sin(theta);
	genrot_unitvec [0] = sin_theta*cos(phi);
	genrot_unitvec [1] = sin_theta*sin(phi);
	genrot_unitvec [2] = cos(theta);
	
	// **********************************************
	// ADD VENDOR SPECIFIC PRAGMA
	// **********************************************
	for (ushort rotation_counter = 0; rotation_counter < DockConst->rotbondlist_length; rotation_counter++)
	{
		rotation_list_element = KerConstStatic->rotlist_const[rotation_counter];

		if ((rotation_list_element & RLIST_DUMMY_MASK) == 0)	//if not dummy rotation
		{
			atom_id = rotation_list_element & RLIST_ATOMID_MASK;

			//capturing atom coordinates
			if ((rotation_list_element & RLIST_FIRSTROT_MASK) != 0)	//if first rotation of this atom
			{	
				atom_to_rotate[0] = KerConstDynamic->ref_coords_x_const[atom_id];
				atom_to_rotate[1] = KerConstDynamic->ref_coords_y_const[atom_id];
				atom_to_rotate[2] = KerConstDynamic->ref_coords_z_const[atom_id];
			}
			else
			{
				atom_to_rotate[0] = loc_coords_x[atom_id];
				atom_to_rotate[1] = loc_coords_y[atom_id];
				atom_to_rotate[2] = loc_coords_z[atom_id];
			}

			//capturing rotation vectors and angle
			if ((rotation_list_element & RLIST_GENROT_MASK) != 0)	//if general rotation
			{
				rotation_unitvec[0] = genrot_unitvec[0];
				rotation_unitvec[1] = genrot_unitvec[1];
				rotation_unitvec[2] = genrot_unitvec[2];

				rotation_angle = genrotangle;

				rotation_movingvec[0] = genotype[0];
				rotation_movingvec[1] = genotype[1];
				rotation_movingvec[2] = genotype[2];				
			}
			else	//if rotating around rotatable bond
			{
				rotbond_id = (rotation_list_element & RLIST_RBONDID_MASK) >> RLIST_RBONDID_SHIFT;
	
				//#pragma unroll 1
				for (uchar i=0; i<3; i++) {
					rotation_unitvec[i] = KerConstDynamic->rotbonds_unit_vectors_const[3*rotbond_id + i];
				}

				rotation_angle = genotype[6+rotbond_id]*DEG_TO_RAD;

				//#pragma unroll 1
				for (uchar i=0; i<3; i++) {
					rotation_movingvec[i] = KerConstDynamic->rotbonds_moving_vectors_const[3*rotbond_id + i];
				}

				//in addition performing the first movement 
				//which is needed only if rotating around rotatable bond
				atom_to_rotate[0] -= rotation_movingvec[0];
				atom_to_rotate[1] -= rotation_movingvec[1];
				atom_to_rotate[2] -= rotation_movingvec[2];
			}

			//performing rotation
			rotation_angle = rotation_angle/2;
			quatrot_left_q = cos(rotation_angle);
			sin_angle = sin(rotation_angle);

			quatrot_left_x = sin_angle*rotation_unitvec[0];
			quatrot_left_y = sin_angle*rotation_unitvec[1];
			quatrot_left_z = sin_angle*rotation_unitvec[2];

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
				quatrot_left_q = quatrot_temp_q*ref_orientation_quats_const_0-
						 quatrot_temp_x*ref_orientation_quats_const_1-
						 quatrot_temp_y*ref_orientation_quats_const_2-
						 quatrot_temp_z*ref_orientation_quats_const_3;
				quatrot_left_x = quatrot_temp_q*ref_orientation_quats_const_1+
						 ref_orientation_quats_const_0*quatrot_temp_x+
						 quatrot_temp_y*ref_orientation_quats_const_3-
						 ref_orientation_quats_const_2*quatrot_temp_z;
				quatrot_left_y = quatrot_temp_q*ref_orientation_quats_const_2+
						 ref_orientation_quats_const_0*quatrot_temp_y+
						 ref_orientation_quats_const_1*quatrot_temp_z-
						 quatrot_temp_x*ref_orientation_quats_const_3;
				quatrot_left_z = quatrot_temp_q*ref_orientation_quats_const_3+
						 ref_orientation_quats_const_0*quatrot_temp_z+
						 quatrot_temp_x*ref_orientation_quats_const_2-
						 ref_orientation_quats_const_1*quatrot_temp_y;
			}
			
			quatrot_temp_q = 0 -
					 quatrot_left_x*atom_to_rotate [0] -
					 quatrot_left_y*atom_to_rotate [1] -
					 quatrot_left_z*atom_to_rotate [2];
			quatrot_temp_x = quatrot_left_q*atom_to_rotate [0] +
					 quatrot_left_y*atom_to_rotate [2] -
					 quatrot_left_z*atom_to_rotate [1];
			quatrot_temp_y = quatrot_left_q*atom_to_rotate [1] -
					 quatrot_left_x*atom_to_rotate [2] +
					 quatrot_left_z*atom_to_rotate [0];
			quatrot_temp_z = quatrot_left_q*atom_to_rotate [2] +
					 quatrot_left_x*atom_to_rotate [1] -
					 quatrot_left_y*atom_to_rotate [0];

			atom_to_rotate [0] = quatrot_temp_x*quatrot_left_q - quatrot_temp_q*quatrot_left_x - 
					     quatrot_temp_y*quatrot_left_z + quatrot_temp_z*quatrot_left_y;
			atom_to_rotate [1] = quatrot_temp_x*quatrot_left_z + quatrot_temp_y*quatrot_left_q - 
					     quatrot_temp_z*quatrot_left_x - quatrot_temp_q*quatrot_left_y ;
			atom_to_rotate [2] = quatrot_temp_y*quatrot_left_x - quatrot_temp_x*quatrot_left_y - 
					     quatrot_temp_q*quatrot_left_z + quatrot_temp_z*quatrot_left_q;

			//performing final movement and storing values
			loc_coords_x[atom_id] = atom_to_rotate [0] + rotation_movingvec[0];
			loc_coords_y[atom_id] = atom_to_rotate [1] + rotation_movingvec[1];
			loc_coords_z[atom_id] = atom_to_rotate [2] + rotation_movingvec[2];
		} // End if-statement not dummy rotation
	} // End rotation_counter for-loop

	#if defined (DEBUG_KRNL_CONFORM)
	printf("BEFORE Out CONFORM CHANNEL\n");
	#endif

	// --------------------------------------------------------------
	// Send ligand atomic coordinates to channel 
	// --------------------------------------------------------------
	write_channel_altera(chan_Conf2Intere_active, active);
	write_channel_altera(chan_Conf2Intrae_active, active);
	mem_fence(CLK_CHANNEL_MEM_FENCE);
	write_channel_altera(chan_Conf2Intere_mode,   mode);
	write_channel_altera(chan_Conf2Intrae_mode,   mode);
	mem_fence(CLK_CHANNEL_MEM_FENCE);
	write_channel_altera(chan_Conf2Intere_cnt,    cnt);
	write_channel_altera(chan_Conf2Intrae_cnt,    cnt);
	mem_fence(CLK_CHANNEL_MEM_FENCE);

	//float3 position_xyz;
	for (uchar pipe_cnt=0; pipe_cnt<DockConst->num_of_atoms; pipe_cnt++) {
		/*
		write_channel_altera(chan_Conf2Intere_x, loc_coords_x[pipe_cnt]);
		write_channel_altera(chan_Conf2Intrae_x, loc_coords_x[pipe_cnt]);
		mem_fence(CLK_CHANNEL_MEM_FENCE);
		write_channel_altera(chan_Conf2Intere_y, loc_coords_y[pipe_cnt]);
		write_channel_altera(chan_Conf2Intrae_y, loc_coords_y[pipe_cnt]);
		mem_fence(CLK_CHANNEL_MEM_FENCE);
		write_channel_altera(chan_Conf2Intere_z, loc_coords_z[pipe_cnt]);
		write_channel_altera(chan_Conf2Intrae_z, loc_coords_z[pipe_cnt]);
		*/
		write_channel_altera(chan_Conf2Intere_xyz, (float3) (loc_coords_x[pipe_cnt], loc_coords_y[pipe_cnt], loc_coords_z[pipe_cnt]));
		write_channel_altera(chan_Conf2Intrae_xyz, (float3) (loc_coords_x[pipe_cnt], loc_coords_y[pipe_cnt], loc_coords_z[pipe_cnt]));
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
