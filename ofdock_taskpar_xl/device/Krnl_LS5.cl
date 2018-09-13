// --------------------------------------------------------------------------
// --------------------------------------------------------------------------
/*
__kernel __attribute__ ((max_global_work_dim(0)))
*/
__kernel __attribute__ ((reqd_work_group_size(1,1,1)))
void Krnl_LS5(
		unsigned short            DockConst_max_num_of_iters,		
		#if defined (FIXED_POINT_LS5)
		fixedpt                   DockConst_rho_lower_bound,
		fixedpt                   DockConst_base_dmov_mul_sqrt3,
		#else
		float                     DockConst_rho_lower_bound,
		float                     DockConst_base_dmov_mul_sqrt3,
		#endif
		unsigned char             DockConst_num_of_genes,
		#if defined (FIXED_POINT_LS5)
		fixedpt                   DockConst_base_dang_mul_sqrt3,
		#else
   		float                     DockConst_base_dang_mul_sqrt3,
		#endif

		unsigned char             DockConst_cons_limit

#if !defined(SW_EMU)
		// IMPORTANT: enable this dummy global argument only for "hw" build.
		// Check ../common_xilinx/utility/boards.mk
		// https://forums.xilinx.com/t5/SDAccel/ERROR-KernelCheck-83-114-in-sdx-2017-4/td-p/818135
		,
		__global int *dummy
#endif
)
{
	#if 0
	printf("\nLS5: DockConst_max_num_of_iters: %u\n",   DockConst_max_num_of_iters);
	printf("LS5: DockConst_rho_lower_bound: %f\n",      DockConst_rho_lower_bound);
	printf("LS5: DockConst_base_dmov_mul_sqrt3: %f\n",  DockConst_base_dmov_mul_sqrt3);
	printf("LS5: DockConst_num_of_genes: %u\n",  	    DockConst_num_of_genes);
	printf("LS5: DockConst_base_dang_mul_sqrt3: %f\n",  DockConst_base_dang_mul_sqrt3);
	printf("LS5: DockConst_cons_limit: %u\n",           DockConst_cons_limit);
	#endif

	bool valid = true;

__attribute__((xcl_pipeline_loop))
LOOP_WHILE_LS5_MAIN:
while(valid) {
/*
	bool active;
*/
	int active;
/*
	bool valid_active = false;
*/
	int valid_active= 1;

	float current_energy;
/*
	bool valid_energy = false;
*/
	int valid_energy = 1;

/*
	while( (valid_active == false) && (valid_energy == false)) {
*/
	__attribute__((xcl_pipeline_loop))
	LOOP_WHILE_LS5_ACTIVE:
	while( (valid_active != 0) && (valid_energy != 0)) {
		valid_active = read_pipe(chan_GA2LS_Off5_active, &active);
		valid_energy = read_pipe(chan_GA2LS_LS5_energy,  &current_energy);
	}
/*
	valid = active || valid_energy;
*/
/*
	valid = active || (valid_energy == 0);
*/
	// (active == 1) means stop LS
	valid = (active != 1) || (valid_energy == 0);

	if (valid) {

		#if defined (FIXED_POINT_LS5)
		fixedpt genotype [ACTUAL_GENOTYPE_LENGTH];
		#else
		float   genotype [ACTUAL_GENOTYPE_LENGTH];
		#endif

		__attribute__((xcl_pipeline_loop))
		LOOP_FOR_LS5_READ_INPUT_GENOTYPE:
		for (uchar i=0; i<DockConst_num_of_genes; i++) {
			#if defined (FIXED_POINT_LS5)
			float tmp_gene;
			read_pipe_block(chan_GA2LS_LS5_genotype, &tmp_gene);
			genotype [i] = fixedpt_fromfloat(tmp_gene);
			#else
			read_pipe_block(chan_GA2LS_LS5_genotype, &genotype [i]);
			#endif
		}
	
		#if defined (DEBUG_KRNL_LS5)
		printf("In of while iter LS5\n");
		#endif

		#if defined (FIXED_POINT_LS5)
		fixedpt fixpt_rho = FIXEDPT_ONE;
		#else
		float rho = 1.0f;
		#endif
		ushort iteration_cnt = 0;
		uchar  cons_succ     = 0;
		uchar  cons_fail     = 0;
		uint   LS_eval       = 0;
		bool   positive_direction = true;

		// performing local search
		__attribute__((xcl_pipeline_loop))
		LOOP_WHILE_LS5_ITERATION_RHO:
		#if defined (FIXED_POINT_LS5)
		while ((iteration_cnt < DockConst_max_num_of_iters) && (fixpt_rho > DockConst_rho_lower_bound)) {
		#else
		while ((iteration_cnt < DockConst_max_num_of_iters) && (rho > DockConst_rho_lower_bound)) {	
		#endif
			// -----------------------------------------------
			// Exit condition is groups here. It allows pipelining
			if (positive_direction == true) { 
				if (cons_succ >= DockConst_cons_limit) {
					#if defined (FIXED_POINT_LS5)
					fixpt_rho = fixpt_rho << 1;
					#else
					rho = LS_EXP_FACTOR*rho;
					#endif
					cons_fail = 0;
					cons_succ = 0;
				}
				else if (cons_fail >= DockConst_cons_limit) {
					#if defined (FIXED_POINT_LS5)
					fixpt_rho = fixpt_rho >> 1;
					#else
					rho = LS_CONT_FACTOR*rho;
					#endif
					cons_fail = 0;
					cons_succ = 0;
				}
				iteration_cnt++;
			}

			#if defined (DEBUG_KRNL_LS5)
			printf("LS5 positive?: %u, iteration_cnt: %u, rho: %f, limit rho: %f\n", positive_direction, iteration_cnt, rho, DockConst_rho_lower_bound);
			#endif
			// -----------------------------------------------

			#if defined (FIXED_POINT_LS5)
			fixedpt entity_possible_new_genotype [ACTUAL_GENOTYPE_LENGTH];
			fixedpt genotype_bias                [ACTUAL_GENOTYPE_LENGTH];
			fixedpt deviate_plus_bias            [ACTUAL_GENOTYPE_LENGTH];
			fixedpt deviate_minus_bias           [ACTUAL_GENOTYPE_LENGTH];
			#else
			float entity_possible_new_genotype   [ACTUAL_GENOTYPE_LENGTH];
			float genotype_bias                  [ACTUAL_GENOTYPE_LENGTH];
			float deviate_plus_bias              [ACTUAL_GENOTYPE_LENGTH];
			float deviate_minus_bias             [ACTUAL_GENOTYPE_LENGTH];
			#endif

			// Tell Krnl_Conf_Arbiter, LS5 is done
			// Not completely strict as the (iteration_cnt < DockConst_max_num_of_iters) is ignored
			// In practice, rho condition dominates most of the cases
			#if defined (FIXED_POINT_LS5)
			int tmp_int = (fixpt_rho < DockConst_rho_lower_bound)?0:1;
			write_pipe_block(chan_LS2Arbiter_LS5_end, &tmp_int);
			#else
			int tmp_int = (rho < DockConst_rho_lower_bound)?0:1;
			write_pipe_block(chan_LS2Arbiter_LS5_end, &tmp_int);
			#endif
/*
			mem_fence(CLK_CHANNEL_MEM_FENCE);
*/		
			// new random deviate
			// rho is the deviation of the uniform distribution
			__attribute__((xcl_pipeline_loop))
			LOOP_FOR_LS5_WRITE_GENOTYPE:
			for (uchar i=0; i<DockConst_num_of_genes; i++) {
/*
				float tmp_prng = read_channel_altera(chan_PRNG2GA_LS5_float_prng);
*/
				float tmp_prng;
				read_pipe_block(chan_PRNG2GA_LS5_float_prng, &tmp_prng);
/*
				mem_fence(CLK_CHANNEL_MEM_FENCE);
*/

				#if defined (FIXED_POINT_LS5)
				fixedpt fixpt_tmp_prng = *(fixedpt*) &tmp_prng;

				// tmp1 is genotype_deviate
				fixedpt fixpt_tmp1 = fixedpt_mul(fixpt_rho, ((fixpt_tmp_prng << 1) - FIXEDPT_ONE));

				if (i<3) { fixpt_tmp1 = fixedpt_mul(fixpt_tmp1, DockConst_base_dmov_mul_sqrt3); }
				else     { fixpt_tmp1 = fixedpt_mul(fixpt_tmp1, DockConst_base_dang_mul_sqrt3); }

				fixedpt deviate = fixedpt_mul(0x6666, fixpt_tmp1);

				// tmp2 is the addition: genotype_deviate + genotype_bias
				// tmp3 is entity_possible_new_genotype
				fixedpt tmp_bias = (iteration_cnt == 1)? 0:genotype_bias [i];
				fixedpt bias = fixedpt_mul(0x9999, tmp_bias);

				deviate_plus_bias  [i] = deviate + bias;
				deviate_minus_bias [i] = deviate - bias;

				fixedpt fixpt_tmp2 = fixpt_tmp1 + tmp_bias;
				fixedpt fixpt_tmp3 = (positive_direction == true)? (genotype [i] + fixpt_tmp2): 
								                   (genotype [i] - fixpt_tmp2);

				if (i>2) {if (i==4) { fixpt_tmp3 = fixedpt_map_angle_180(fixpt_tmp3);}
					  else      { fixpt_tmp3 = fixedpt_map_angle_360(fixpt_tmp3);}}

				entity_possible_new_genotype [i] = fixpt_tmp3;
				float tmp_float = fixedpt_tofloat(fixpt_tmp3);
				write_pipe_block(chan_LS2Conf_LS5_genotype, &tmp_float);

				#else
				// tmp1 is genotype_deviate
				float tmp1 = rho * (2.0f*tmp_prng - 1.0f);

				if (i<3) { tmp1 = tmp1 * DockConst_base_dmov_mul_sqrt3; }
				else 	 { tmp1 = tmp1 * DockConst_base_dang_mul_sqrt3; }

				float deviate = 0.4f*tmp1;

				// tmp2 is the addition: genotype_deviate + genotype_bias
				// tmp3 is entity_possible_new_genotype
				float tmp_bias = (iteration_cnt == 1)? 0.0f:genotype_bias [i];
				float bias = 0.6f * tmp_bias;

				deviate_plus_bias  [i] = deviate + bias;
				deviate_minus_bias [i] = deviate - bias;

				float tmp2 = tmp1 + tmp_bias;
				float tmp3 = (positive_direction == true)? (genotype [i] + tmp2): (genotype [i] - tmp2);

				if (i>2) {if (i==4) { tmp3 = map_angle_180(tmp3);}
					  else      { tmp3 = map_angle_360(tmp3);}}

				entity_possible_new_genotype [i] = tmp3;
				write_pipe_block(chan_LS2Conf_LS5_genotype, &tmp3);
				#endif

				#if defined (DEBUG_KRNL_LS5)
				printf("LS5_genotype sent: %u\n", i);
				#endif
			}

			//printf("Energy to calculate sent from LS5 ... ");

			float energyIA_LS_rx;
			float energyIE_LS_rx;
/*
			bool intra_valid = false;
			bool inter_valid = false;
*/
			int intra_valid = 1;
			int inter_valid = 1;

/*
			while( (intra_valid == false) || (inter_valid == false)) {
*/
			__attribute__((xcl_pipeline_loop))
			LOOP_WHILE_LS5_READ_ENERGIES:
			while( (intra_valid != 0) || (inter_valid != 0)) {
/*
				if (intra_valid == false) {
*/
				if (intra_valid != 0) {
					intra_valid = read_pipe(chan_Intrae2StoreLS_LS5_intrae, &energyIA_LS_rx);
				}
/*
				else if (inter_valid == false) {
*/
				else if (inter_valid != 0) {
					inter_valid = read_pipe(chan_Intere2StoreLS_LS5_intere, &energyIE_LS_rx);
				}
			}

			float candidate_energy = energyIA_LS_rx + energyIE_LS_rx;

			// update LS energy-evaluation count
			LS_eval++;

			#if defined (DEBUG_KRNL_LS5)
			printf("INTERE received in LS5: %u\n", LS_eval);
			#endif

			#if defined (FIXED_POINT_LS5)
			if (candidate_energy < current_energy) {

				// updating offspring_genotype
				// updating genotype_bias
				__attribute__((xcl_pipeline_loop))
				LOOP_FOR_LS5_FIXEDPT_UPDATE_POS_GENOTYPE:
				for (uchar i=0; i<DockConst_num_of_genes; i++) {
					genotype_bias [i] = (positive_direction == true) ? deviate_plus_bias  [i]: 
											   deviate_minus_bias [i]; 

					genotype [i] = entity_possible_new_genotype [i];
				}

				current_energy = candidate_energy;
				cons_succ++;
				cons_fail = 0;
				positive_direction = true;

			}
			else {
				// updating (halving) genotype_bias
				__attribute__((xcl_pipeline_loop))
				LOOP_FOR_LS5_FIXEDPT_UPDATE_NEG_GENOTYPE:
				for (uchar i=0; i<DockConst_num_of_genes; i++) {
					genotype_bias [i] = (iteration_cnt == 1)? 0: (genotype_bias [i] >> 1);
				}

				if (positive_direction == false) {
					cons_fail++;
					cons_succ = 0;
				}
				positive_direction = !positive_direction;
			}
			#else
			if (candidate_energy < current_energy) {

				// updating offspring_genotype
				// updating genotype_bias
				__attribute__((xcl_pipeline_loop))
				LOOP_FOR_LS5_FLOATPT_UPDATE_POS_GENOTYPE:
				for (uchar i=0; i<DockConst_num_of_genes; i++) {
					genotype_bias [i] = (positive_direction == true) ?  deviate_plus_bias  [i] : 
											    deviate_minus_bias [i] ;
					genotype [i] = entity_possible_new_genotype [i];
				}	

				current_energy = candidate_energy;
				cons_succ++;
				cons_fail = 0;
				positive_direction = true;				
			}
			else {
				// updating (halving) genotype_bias
				__attribute__((xcl_pipeline_loop))
				LOOP_FOR_LS5_FLOATPT_UPDATE_NEG_GENOTYPE:
				for (uchar i=0; i<DockConst_num_of_genes; i++) {
					genotype_bias [i] = (iteration_cnt == 1)? 0.0f: (0.5f*genotype_bias [i]);
				}

				if (positive_direction == false) {
					cons_fail++;
					cons_succ = 0;
				}
				positive_direction = !positive_direction;
			}
			#endif

		} // end of while (iteration_cnt) && (rho)
	
		#if defined (DEBUG_KRNL_LS5)
		printf("Out of while iter LS5\n");
		#endif

		// write back data to GA
		__attribute__((xcl_pipeline_loop))
		LOOP_FOR_LS5_WRITEBACK2GA:
		for (uchar i=0; i<DockConst_num_of_genes; i++) {
			if (i == 0) {
				float2 evalenergy  = {*(float*)&LS_eval, current_energy};
				write_pipe_block(chan_LS2GA_LS5_evalenergy, &evalenergy);
			}
/*
			mem_fence(CLK_CHANNEL_MEM_FENCE);
*/

			#if defined (FIXED_POINT_LS5)
			float tmp_float = fixedpt_tofloat(genotype [i]);
			write_pipe_block(chan_LS2GA_LS5_genotype, &tmp_float);
			#else
			write_pipe_block(chan_LS2GA_LS5_genotype, &genotype [i]);	
			#endif
		}

	} // End of if (valid)
	
} // End of while (valid)		

#if defined (DEBUG_ACTIVE_KERNEL)
printf("	%-20s: %s\n", "Krnl_LS5", "disabled");		
#endif
	
}

// --------------------------------------------------------------------------
// --------------------------------------------------------------------------
