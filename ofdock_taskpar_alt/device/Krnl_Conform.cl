// --------------------------------------------------------------------------
// The function changes the conformation of myligand according to 
// the genotype given by the second parameter.
// Originally from: processligand.c
// --------------------------------------------------------------------------
__kernel __attribute__ ((max_global_work_dim(0)))
void Krnl_Conform(
	     __constant int*    restrict KerConstStatic_rotlist_const,
	     __constant float3* restrict KerConstDynamic_ref_coords_const,
	     __constant float3* restrict KerConstDynamic_rotbonds_moving_vectors_const,
	     __constant float3* restrict KerConstDynamic_rotbonds_unit_vectors_const,
	    
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

/*
	// check best practices guide
	// Table 11. Effects of numbanks and bankwidth on the Bank Geometry ...
	// only first three indexes of the lower array are used
	// however size of lower array was declared as 4, just to keep sizes equal to power of 2
	__local float  __attribute__((numbanks(8), bankwidth(16))) loc_coords[MAX_NUM_OF_ATOMS][4];
*/

	__local float genotype[ACTUAL_GENOTYPE_LENGTH];

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
	bool IC_valid     = false;
	bool GG_valid     = false;
	bool LS_valid     = false;
	bool Off_valid    = false;

	float IC_active;
	float GG_active;
	float LS_active;
	bool Off_active;

	uchar pipe_cnt = 0;

	while (
/*
	       (IC_valid  == false) && 
	       (GG_valid  == false) && 
	       (LS_valid  == false) &&
*/
	       (Off_valid == false) && (pipe_cnt < DockConst_num_of_genes) 
	) {
		IC_active  = read_channel_nb_altera(chan_IC2Conf_genotype, &IC_valid);
		GG_active  = read_channel_nb_altera(chan_GG2Conf_genotype, &GG_valid);
		LS_active  = read_channel_nb_altera(chan_LS2Conf_genotype, &LS_valid);
		Off_active = read_channel_nb_altera(chan_Off2Conf_active,  &Off_valid);

		if (IC_valid || GG_valid || LS_valid) {
			genotype[pipe_cnt] = (IC_valid)  ?  IC_active :
	       			    	     (GG_valid)  ?  GG_active : 
				     	     (LS_valid)  ?  LS_active :
                                     	     (Off_valid) ?  0.0f:
				     	     0.0f; // last case should never occur, otherwise above while would be still running
			
			if (pipe_cnt > 2) {
				genotype [pipe_cnt] = genotype [pipe_cnt]*DEG_TO_RAD;
			}
			
			pipe_cnt++;
		}
	}

	char mode;

	active = (IC_valid)     ? true :
		 (GG_valid)     ? true :
		 (LS_valid)     ? true :
		 (Off_valid)    ? Off_active :
		 false; // last case should never occur, otherwise above while would be still running

	mode = (IC_valid)     ? 0x01 :
	       (GG_valid)     ? 0x02 :
	       (LS_valid)     ? 0x03 :
	       (Off_valid)    ? 0x05 :
	       0x05; // last case should never occur, otherwise above while would be still running

	// --------------------------------------------------------------
	//printf("AFTER In CONFORM CHANNEL\n");
/*
	float3 __attribute__ ((
			      memory,
			      numbanks(1),
			      bankwidth(16),
			      doublepump,
			      numreadports(3),//3
			      numwriteports(1)
			    )) loc_coords[MAX_NUM_OF_ATOMS];
*/

	float3 loc_coords[MAX_NUM_OF_ATOMS];

	#if defined (DEBUG_ACTIVE_KERNEL)
	if (active == 0) {printf("	%-20s: %s\n", "Krnl_Conform", "must be disabled");}
	#endif
/*
	for(uchar i=3; i<DockConst_num_of_genes; i++) {
		genotype [i] = genotype [i]*DEG_TO_RAD;
	}
*/
/*
	float phi         = genotype [3]*DEG_TO_RAD;
	float theta       = genotype [4]*DEG_TO_RAD;
	float genrotangle = genotype [5]*DEG_TO_RAD;
*/
	float phi         = genotype [3];
	float theta       = genotype [4];
	float genrotangle = genotype [5];

	/*
	float sin_theta = sin(theta);
	*/
	float sin_theta, cos_theta;
	sin_theta = sincos(theta, &cos_theta);

	float3 genrot_unitvec;
	genrot_unitvec.x = sin_theta*cos(phi);
	genrot_unitvec.y = sin_theta*sin(phi);
	/*
	genrot_unitvec.z = cos(theta);
	*/
	genrot_unitvec.z = cos_theta;

	float3 genotype_xyz = {genotype[0], genotype[1], genotype[2]};
	
	for (ushort rotation_counter = 0; rotation_counter < DockConst_rotbondlist_length; rotation_counter++)
	{
		int rotation_list_element = rotlist_localcache [rotation_counter];

		if ((rotation_list_element & RLIST_DUMMY_MASK) == 0)	//if not dummy rotation
		{
			uint atom_id = rotation_list_element & RLIST_ATOMID_MASK;

			//capturing atom coordinates
			//float atom_to_rotate[3];
			float3 atom_to_rotate;

			if ((rotation_list_element & RLIST_FIRSTROT_MASK) != 0)	//if first rotation of this atom
			{	/*
				atom_to_rotate[0] = KerConstDynamic_ref_coords_x_const[atom_id];
				atom_to_rotate[1] = KerConstDynamic_ref_coords_y_const[atom_id];
				atom_to_rotate[2] = KerConstDynamic_ref_coords_z_const[atom_id];
				*/
				atom_to_rotate = KerConstDynamic_ref_coords_const[atom_id];
			}
			else
			{	
				atom_to_rotate = loc_coords[atom_id];
			}

			//capturing rotation vectors and angle
			float3 rotation_unitvec;
			float3 rotation_movingvec;
			float rotation_angle;

			if ((rotation_list_element & RLIST_GENROT_MASK) != 0)	//if general rotation
			{
				rotation_unitvec = genrot_unitvec;

				rotation_angle = genrotangle;

				rotation_movingvec = genotype_xyz;
			}
			else	//if rotating around rotatable bond
			{
				uint rotbond_id = (rotation_list_element & RLIST_RBONDID_MASK) >> RLIST_RBONDID_SHIFT;
	
				rotation_unitvec = KerConstDynamic_rotbonds_unit_vectors_const[rotbond_id];
				
				/*
				rotation_angle = genotype[6+rotbond_id]*DEG_TO_RAD;
				*/
				rotation_angle = genotype[6+rotbond_id];

				rotation_movingvec = KerConstDynamic_rotbonds_moving_vectors_const[rotbond_id];

				//in addition performing the first movement 
				//which is needed only if rotating around rotatable bond
				atom_to_rotate -= rotation_movingvec;
			}

			//performing rotation
			float quatrot_left_x, quatrot_left_y, quatrot_left_z, quatrot_left_q;
			float quatrot_temp_x, quatrot_temp_y, quatrot_temp_z, quatrot_temp_q;

			rotation_angle = rotation_angle*0.5;

			/*
			quatrot_left_q = cos(rotation_angle);
			float sin_angle = sin(rotation_angle);
			*/
			float sin_angle, cos_angle;
			sin_angle = sincos(rotation_angle, &cos_angle);
			quatrot_left_x = sin_angle*rotation_unitvec.x;
			quatrot_left_y = sin_angle*rotation_unitvec.y;
			quatrot_left_z = sin_angle*rotation_unitvec.z;
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

			quatrot_temp_q = - 
					(quatrot_left_x*atom_to_rotate.x +
					 quatrot_left_y*atom_to_rotate.y +
					 quatrot_left_z*atom_to_rotate.z);

			quatrot_temp_x = quatrot_left_q*atom_to_rotate.x +
					 quatrot_left_y*atom_to_rotate.z -
					 quatrot_left_z*atom_to_rotate.y;
			quatrot_temp_y = quatrot_left_q*atom_to_rotate.y -
					 quatrot_left_x*atom_to_rotate.z +
					 quatrot_left_z*atom_to_rotate.x;
			quatrot_temp_z = quatrot_left_q*atom_to_rotate.z +
					 quatrot_left_x*atom_to_rotate.y -
					 quatrot_left_y*atom_to_rotate.x;

			atom_to_rotate.x = quatrot_temp_x*quatrot_left_q - quatrot_temp_q*quatrot_left_x - 
					     quatrot_temp_y*quatrot_left_z + quatrot_temp_z*quatrot_left_y;
			atom_to_rotate.y = quatrot_temp_x*quatrot_left_z + quatrot_temp_y*quatrot_left_q - 
					     quatrot_temp_z*quatrot_left_x - quatrot_temp_q*quatrot_left_y ;
			atom_to_rotate.z = quatrot_temp_y*quatrot_left_x - quatrot_temp_x*quatrot_left_y - 
					     quatrot_temp_q*quatrot_left_z + quatrot_temp_z*quatrot_left_q;

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
