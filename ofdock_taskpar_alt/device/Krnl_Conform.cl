// --------------------------------------------------------------------------
// The function changes the conformation of myligand according to 
// the genotype given by the second parameter.
// Originally from: processligand.c
// --------------------------------------------------------------------------
__kernel __attribute__ ((max_global_work_dim(0)))
void Krnl_Conform(
	     __constant int*   restrict KerConstStatic_rotlist_const,
	     __constant float* restrict KerConstDynamic_ref_coords_x_const,
	     __constant float* restrict KerConstDynamic_ref_coords_y_const,
	     __constant float* restrict KerConstDynamic_ref_coords_z_const,
 	     __constant float* restrict KerConstDynamic_rotbonds_moving_vectors_const,
	     __constant float* restrict KerConstDynamic_rotbonds_unit_vectors_const,
	    
			      unsigned int                     DockConst_rotbondlist_length,
			      unsigned char                    DockConst_num_of_atoms,
			      unsigned int                     DockConst_num_of_genes,

			      float                            ref_orientation_quats_const_0,
			      float                            ref_orientation_quats_const_1,
			      float                            ref_orientation_quats_const_2,
			      float                            ref_orientation_quats_const_3
)
{
	#if defined (DEBUG_KRNL_Conform) 
	printf("\n");
	printf("%-40s %u\n", "DockConst->rotbondlist_length: ",	DockConst_rotbondlist_length);
	printf("%-40s %u\n", "DockConst->num_of_atoms: ",  	DockConst_num_of_atoms);
	printf("%-40s %u\n", "DockConst_num_of_genes: ",        DockConst_num_of_genes);	
	#endif

	// local vars are allowed only at kernel scope
/*
	__local float loc_coords_x[MAX_NUM_OF_ATOMS];
	__local float loc_coords_y[MAX_NUM_OF_ATOMS];
	__local float loc_coords_z[MAX_NUM_OF_ATOMS];
*/

/*
	// check best practices guide
	// Table 11. Effects of numbanks and bankwidth on the Bank Geometry ...
	// only first three indexes of the lower array are used
	// however size of lower array was declared as 4, just to keep sizes equal to power of 2
	__local float  __attribute__((numbanks(8), bankwidth(16))) loc_coords[MAX_NUM_OF_ATOMS][4];
*/

/*
	__local float genotype[ACTUAL_GENOTYPE_LENGTH];
*/

	/*char active = 1;*/
	bool active = true;

	// local mem to cache KerConstStatic->rotlist_const[], marked as bottleneck by profiler
	__local int rotlist_localcache [MAX_NUM_OF_ROTATIONS];
	for (ushort c = 0; c < DockConst_rotbondlist_length; c++) {
		rotlist_localcache [c] = KerConstStatic_rotlist_const [c];
	}

while(active) {
	//printf("BEFORE In CONFORM CHANNEL\n");
	// --------------------------------------------------------------
	// Wait for genotypes in channel
	// --------------------------------------------------------------

	bool IC_valid = false;
	bool GG_valid = false;
	bool LS_pos_valid = false;
	bool LS_neg_valid = false;
	bool Off_valid = false;

/*
	char IC_active;
	char GG_active;
	char LS_pos_active;
	char LS_neg_active;
	char Off_active;
*/
	bool IC_active;
	bool GG_active;
	bool LS_pos_active;
	bool LS_neg_active;
	bool Off_active;
	
	while (
	       (IC_valid == false) && 
	       (GG_valid == false) && 
	       (LS_pos_valid == false) && 
	       (LS_neg_valid == false) &&
               (Off_valid == false)
	) {
		IC_active = read_channel_nb_altera(chan_IC2Conf_active, &IC_valid);
		GG_active = read_channel_nb_altera(chan_GG2Conf_active, &GG_valid);
		LS_pos_active = read_channel_nb_altera(chan_LS2Conf_pos_active, &LS_pos_valid);
		LS_neg_active = read_channel_nb_altera(chan_LS2Conf_neg_active, &LS_neg_valid);
		Off_active = read_channel_nb_altera(chan_Off2Conf_active, &Off_valid);
	}

	char mode;


	float genotype[ACTUAL_GENOTYPE_LENGTH];

	if (IC_valid) {
		active = IC_active;
		mode = 0x01;

		for (uchar pipe_cnt=0; pipe_cnt<DockConst_num_of_genes; pipe_cnt++) {
			genotype[pipe_cnt] = read_channel_altera(chan_IC2Conf_genotype);}	
	}
	else {
		if (GG_valid) {
			active = GG_active;
			mode = 0x02;

			for (uchar pipe_cnt=0; pipe_cnt<DockConst_num_of_genes; pipe_cnt++) {
				genotype[pipe_cnt] = read_channel_altera(chan_GG2Conf_genotype);}	
		}
		else {
			if (LS_pos_valid) {
				active = LS_pos_active;
				mode = 0x03;

				for (uchar pipe_cnt=0; pipe_cnt<DockConst_num_of_genes; pipe_cnt++) {
					genotype[pipe_cnt] = read_channel_altera(chan_LS2Conf_pos_genotype);}
			}
			else {
				if (LS_neg_valid) {
					active = LS_neg_active;
					mode = 0x04;

					for (uchar pipe_cnt=0; pipe_cnt<DockConst_num_of_genes; pipe_cnt++) {
						genotype[pipe_cnt] = read_channel_altera(chan_LS2Conf_neg_genotype);}
				}
				else {
					if (Off_valid) {
						active = Off_active;
						mode = 0x05;

						//for (uchar pipe_cnt=0; pipe_cnt<DockConst_num_of_genes; pipe_cnt++) {
						//	genotype[pipe_cnt] = read_channel_altera(chan_Off2Conf_genotype);}

					}
				}

			}
		}	

	}

	// --------------------------------------------------------------
	//printf("AFTER In CONFORM CHANNEL\n");
///*
	float __attribute__ ((
			      memory,
			      numbanks(4),
			      bankwidth(4),
			      singlepump,
			      numreadports(2),//3
			      numwriteports(1)
			    )) loc_coords[MAX_NUM_OF_ATOMS][4];
//*/

	//float loc_coords[MAX_NUM_OF_ATOMS][4];

	#if defined (DEBUG_ACTIVE_KERNEL)
	if (active == 0) {printf("	%-20s: %s\n", "Krnl_Conform", "must be disabled");}
	#endif

	float phi         = genotype [3]*DEG_TO_RAD;
	float theta       = genotype [4]*DEG_TO_RAD;
	float genrotangle = genotype [5]*DEG_TO_RAD;

	float sin_theta = sin(theta);
	float genrot_unitvec [3];
	genrot_unitvec [0] = sin_theta*cos(phi);
	genrot_unitvec [1] = sin_theta*sin(phi);
	genrot_unitvec [2] = cos(theta);
	
	for (ushort rotation_counter = 0; rotation_counter < DockConst_rotbondlist_length; rotation_counter++)
	{
		int rotation_list_element = rotlist_localcache [rotation_counter];

		if ((rotation_list_element & RLIST_DUMMY_MASK) == 0)	//if not dummy rotation
		{
			uint atom_id = rotation_list_element & RLIST_ATOMID_MASK;

			//capturing atom coordinates
			float atom_to_rotate[3];

			if ((rotation_list_element & RLIST_FIRSTROT_MASK) != 0)	//if first rotation of this atom
			{	
				atom_to_rotate[0] = KerConstDynamic_ref_coords_x_const[atom_id];
				atom_to_rotate[1] = KerConstDynamic_ref_coords_y_const[atom_id];
				atom_to_rotate[2] = KerConstDynamic_ref_coords_z_const[atom_id];
			}
			else
			{
/*
				atom_to_rotate[0] = loc_coords_x[atom_id];
				atom_to_rotate[1] = loc_coords_y[atom_id];
				atom_to_rotate[2] = loc_coords_z[atom_id];
*/
///*
				atom_to_rotate[0] = loc_coords[atom_id][0x0];
				atom_to_rotate[1] = loc_coords[atom_id][0x1];
				atom_to_rotate[2] = loc_coords[atom_id][0x2];
//*/
			}

			//capturing rotation vectors and angle
			float rotation_unitvec[3];
			float rotation_movingvec[3];
			float rotation_angle;

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
				uint rotbond_id = (rotation_list_element & RLIST_RBONDID_MASK) >> RLIST_RBONDID_SHIFT;
	
///*
				//#pragma unroll 1
				for (uchar i=0; i<3; i++) {
					rotation_unitvec[i] = KerConstDynamic_rotbonds_unit_vectors_const[3*rotbond_id + i];
				}
//*/
/*
rotation_unitvec[0] = KerConstDynamic_rotbonds_unit_vectors_const[3*rotbond_id];
rotation_unitvec[1] = KerConstDynamic_rotbonds_unit_vectors_const[3*rotbond_id + 1];
rotation_unitvec[2] = KerConstDynamic_rotbonds_unit_vectors_const[3*rotbond_id + 2];
*/

				rotation_angle = genotype[6+rotbond_id]*DEG_TO_RAD;

///*
				//#pragma unroll 1
				for (uchar i=0; i<3; i++) {
					rotation_movingvec[i] = KerConstDynamic_rotbonds_moving_vectors_const[3*rotbond_id + i];
				}
//*/
/*
rotation_movingvec[0] = KerConstDynamic_rotbonds_moving_vectors_const[3*rotbond_id];
rotation_movingvec[1] = KerConstDynamic_rotbonds_moving_vectors_const[3*rotbond_id + 1];
rotation_movingvec[2] = KerConstDynamic_rotbonds_moving_vectors_const[3*rotbond_id + 2];			
*/

				//in addition performing the first movement 
				//which is needed only if rotating around rotatable bond
				atom_to_rotate[0] -= rotation_movingvec[0];
				atom_to_rotate[1] -= rotation_movingvec[1];
				atom_to_rotate[2] -= rotation_movingvec[2];
			}

			//performing rotation
			float quatrot_left_x, quatrot_left_y, quatrot_left_z, quatrot_left_q;
			float quatrot_temp_x, quatrot_temp_y, quatrot_temp_z, quatrot_temp_q;

			rotation_angle = rotation_angle/2;
			quatrot_left_q = cos(rotation_angle);

			float sin_angle = sin(rotation_angle);

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
/*
			loc_coords_x[atom_id] = atom_to_rotate [0] + rotation_movingvec[0];
			loc_coords_y[atom_id] = atom_to_rotate [1] + rotation_movingvec[1];
			loc_coords_z[atom_id] = atom_to_rotate [2] + rotation_movingvec[2];
*/
///*
			loc_coords[atom_id][0x0] = atom_to_rotate [0] + rotation_movingvec[0];
			loc_coords[atom_id][0x1] = atom_to_rotate [1] + rotation_movingvec[1];
			loc_coords[atom_id][0x2] = atom_to_rotate [2] + rotation_movingvec[2];
//*/
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

	//float3 position_xyz;
	for (uchar pipe_cnt=0; pipe_cnt<DockConst_num_of_atoms; pipe_cnt++) {
/*
		write_channel_altera(chan_Conf2Intere_xyz, (float3) (loc_coords_x[pipe_cnt], loc_coords_y[pipe_cnt], loc_coords_z[pipe_cnt]));
		write_channel_altera(chan_Conf2Intrae_xyz, (float3) (loc_coords_x[pipe_cnt], loc_coords_y[pipe_cnt], loc_coords_z[pipe_cnt]));
*/
///*
		write_channel_altera(chan_Conf2Intere_xyz, (float3) (loc_coords[pipe_cnt][0x0], loc_coords[pipe_cnt][0x1], loc_coords[pipe_cnt][0x2]));
		write_channel_altera(chan_Conf2Intrae_xyz, (float3) (loc_coords[pipe_cnt][0x0], loc_coords[pipe_cnt][0x1], loc_coords[pipe_cnt][0x2]));
//*/

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
