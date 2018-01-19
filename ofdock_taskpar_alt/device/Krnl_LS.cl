/*
channel bool  chan_Arbiter_LS1_active;
*/
channel bool chan_LS2Arbiter_LS1_end;

// --------------------------------------------------------------------------
// --------------------------------------------------------------------------

#if 0
__kernel __attribute__ ((max_global_work_dim(0)))
void Krnl_LS_Arbiter(/*unsigned char DockConst_num_of_genes*/){

	bool active = true;
	
while(active) {
	bool LS1_valid = false;
	bool Off_valid = false;

	bool LS1_active;
	bool Off_active;

	while((LS1_valid  == false) &&
	      (Off_valid  == false) 
	){
		LS1_active = read_channel_nb_altera(chan_GA2LS_LS1_active, &LS1_valid);
		Off_active = read_channel_nb_altera(chan_GA2LS_Off1_active, &Off_valid);
	}

	active = (Off_valid)? Off_active : true; 
	write_channel_altera(chan_Arbiter_LS1_active, active);

} // End of while(active)

#if defined (DEBUG_ACTIVE_KERNEL)
printf("	%-20s: %s\n", "Krnl_LS_Arbiter", "disabled");		
#endif

}
#endif

// --------------------------------------------------------------------------
// --------------------------------------------------------------------------

__kernel __attribute__ ((max_global_work_dim(0)))
void Krnl_LS(
		//unsigned int              DockConst_max_num_of_iters,
		unsigned short            DockConst_max_num_of_iters,
		#if defined (FIXED_POINT_LS1)
		fixedpt                   DockConst_rho_lower_bound,
		fixedpt                   DockConst_base_dmov_mul_sqrt3,
		#else
		float                     DockConst_rho_lower_bound,
		float                     DockConst_base_dmov_mul_sqrt3,
		#endif
		unsigned char             DockConst_num_of_genes,
		#if defined (FIXED_POINT_LS1)
		fixedpt                   DockConst_base_dang_mul_sqrt3,
		#else
   		float                     DockConst_base_dang_mul_sqrt3,
		#endif

		//unsigned int              DockConst_cons_limit
		unsigned char              DockConst_cons_limit
)
{	
	#if defined (FIXED_POINT_LS1)
	__local fixedpt genotype [ACTUAL_GENOTYPE_LENGTH];
	#else
	__local float genotype [ACTUAL_GENOTYPE_LENGTH];
	#endif

	bool valid = true;
	/*
	// added to find out which fixed-point precision is needed
	// 16.16 is enough
	fixedpt fp1 = fixedpt_fromfloat(DockConst_rho_lower_bound);
	fixedpt fp2 = fixedpt_fromfloat(DockConst_base_dmov_mul_sqrt3);
	fixedpt fp3 = fixedpt_fromfloat(DockConst_base_dang_mul_sqrt3);
	printf("DockConst_rho_lower_bound: %f %f\n", DockConst_rho_lower_bound, fixedpt_tofloat(fp1));
	printf("DockConst_base_dmov_mul_sqrt3: %f %f\n", DockConst_base_dmov_mul_sqrt3, fixedpt_tofloat(fp2));
	printf("DockConst_base_dang_mul_sqrt3: %f %f\n", DockConst_base_dang_mul_sqrt3, fixedpt_tofloat(fp3));
	*/
	
	/*
	// print fixedpt representation of 180.0f and 360.0f
	printf("180f: %f %i %x\n", 180.0f, fixedpt_fromfloat(180.0f), fixedpt_fromfloat(180.0f)); 
	printf("360f: %f %i %x\n", 360.0f, fixedpt_fromfloat(360.0f), fixedpt_fromfloat(360.0f)); 
	// 180f: 180.000000 11796480 b40000
	// 360f: 360.000000 23592960 1680000
	*/
	
	/*
	// print fixedpt representation of 0.4f and 0.6f
	printf("0.4f: %f %i %x\n", 0.4f, fixedpt_fromfloat(0.4f), fixedpt_fromfloat(0.4f));
	printf("0.6f: %f %i %x\n", 0.6f, fixedpt_fromfloat(0.6f), fixedpt_fromfloat(0.6f)); 
	//0.4f: 0.400000 26214 6666
	//0.6f: 0.600000 39321 9999
	*/

while(valid) {

	bool active;
	bool valid_active= false;

	float current_energy;
	bool valid_energy = false;

	while( (valid_active == false) && (valid_energy == false)) {
		active         = read_channel_nb_altera(chan_GA2LS_Off1_active, &valid_active);
		current_energy = read_channel_nb_altera(chan_GA2LS_LS1_energy,  &valid_energy);
	}
	valid = active || valid_energy;

if (valid) {

	for (uchar i=0; i<DockConst_num_of_genes; i++) {
		#if defined (FIXED_POINT_LS1)
		float tmp_gene = read_channel_altera(chan_GA2LS_LS1_genotype);
		genotype [i] = fixedpt_fromfloat(tmp_gene);
		#else
		genotype [i] = read_channel_altera(chan_GA2LS_LS1_genotype);
		#endif
	}
	
	#if defined (FIXED_POINT_LS1)
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
	#if defined (FIXED_POINT_LS1)
	while ((iteration_cnt < DockConst_max_num_of_iters) && (fixpt_rho > DockConst_rho_lower_bound)) {
	#else
	while ((iteration_cnt < DockConst_max_num_of_iters) && (rho > DockConst_rho_lower_bound)) {
	#endif
		// -----------------------------------------------
		// Exit condition is groups here. It allows pipelining
		if (positive_direction == true) { 
			if (cons_succ >= DockConst_cons_limit) {
				#if defined (FIXED_POINT_LS1)
				fixpt_rho = fixpt_rho << 1;
				#else
				rho = LS_EXP_FACTOR*rho;
				#endif
				cons_fail = 0;
				cons_succ = 0;
			}
			else if (cons_fail >= DockConst_cons_limit) {
				#if defined (FIXED_POINT_LS1)
				fixpt_rho = fixpt_rho >> 1;
				#else
				rho = LS_CONT_FACTOR*rho;
				#endif
				cons_fail = 0;
				cons_succ = 0;
			}
			iteration_cnt++;
		}

		#if defined (DEBUG_KRNL_LS)
		printf("positive?: %u, iteration_cnt: %u, rho: %f, limit rho: %f\n", positive_direction, iteration_cnt, rho, DockConst_rho_lower_bound);
		#endif
		// -----------------------------------------------

		#if defined (FIXED_POINT_LS1)
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

		// Tell Krnl_Conf_Arbiter, LS1 is done
		// Not completely strict as the (iteration_cnt < DockConst_max_num_of_iters) is ignored
		// In practice, rho condition dominates most of the cases
		#if defined (FIXED_POINT_LS1)
		write_channel_altera(chan_LS2Arbiter_LS1_end, (fixpt_rho < DockConst_rho_lower_bound)?true:false);
		#else
		write_channel_altera(chan_LS2Arbiter_LS1_end, (rho < DockConst_rho_lower_bound)?true:false);
		#endif
		mem_fence(CLK_CHANNEL_MEM_FENCE);

		// new random deviate
		// rho is the deviation of the uniform distribution
		for (uchar i=0; i<DockConst_num_of_genes; i++) {

			float tmp_prng = read_channel_altera(chan_PRNG2GA_LS_float_prng);
			mem_fence(CLK_CHANNEL_MEM_FENCE);

			#if defined (FIXED_POINT_LS1)
			fixedpt fixpt_tmp_prng = *(fixedpt*) &tmp_prng;

			// tmp1 is genotype_deviate
			fixedpt fixpt_tmp1 = fixedpt_mul(fixpt_rho, ((fixpt_tmp_prng << 1) - FIXEDPT_ONE));

			if (i<3) { fixpt_tmp1 = fixedpt_mul(fixpt_tmp1, DockConst_base_dmov_mul_sqrt3); }
			else     { fixpt_tmp1 = fixedpt_mul(fixpt_tmp1, DockConst_base_dang_mul_sqrt3); }

			fixedpt deviate = fixedpt_mul(0x6666, fixpt_tmp1);

			// tmp2 is the addition: genotype_deviate + genotype_bias
			// tmp3 is entity_possible_new_genotype
			fixedpt tmp_bias = (iteration_cnt == 1)? 0:genotype_bias[i];
			fixedpt bias = fixedpt_mul(0x9999, tmp_bias);

			deviate_plus_bias  [i] = deviate + bias;
			deviate_minus_bias [i] = deviate - bias;
			
			fixedpt fixpt_tmp2 = fixpt_tmp1 + tmp_bias;
			fixedpt fixpt_tmp3 = (positive_direction == true)? (genotype [i] + fixpt_tmp2): 
									   (genotype [i] - fixpt_tmp2);

			if (i>3) {if (i==4) { fixpt_tmp3 = fixedpt_map_angle_180(fixpt_tmp3); }
				  else      { fixpt_tmp3 = fixedpt_map_angle_360(fixpt_tmp3); }}

			entity_possible_new_genotype [i] = fixpt_tmp3;
			write_channel_altera(chan_LS2Conf_LS1_genotype, fixedpt_tofloat(fixpt_tmp3));

			#else
			// tmp1 is genotype_deviate
			float tmp1 = rho * (2.0f*tmp_prng - 1.0f);

			if (i<3) { tmp1 = tmp1 * DockConst_base_dmov_mul_sqrt3; }
			else     { tmp1 = tmp1 * DockConst_base_dang_mul_sqrt3; }

			float deviate = 0.4f*tmp1;

			// tmp2 is the addition: genotype_deviate + genotype_bias
			// tmp3 is entity_possible_new_genotype
			float tmp_bias = (iteration_cnt == 1)? 0.0f:genotype_bias[i];
			float bias = 0.6 * tmp_bias;

			deviate_plus_bias  [i] = deviate + bias;
			deviate_minus_bias [i] = deviate - bias;

			float tmp2 = tmp1 + tmp_bias;
			float tmp3 = (positive_direction == true)? (genotype [i] + tmp2): (genotype [i] - tmp2);

			if (i>3) {if (i==4) { tmp3 = map_angle_180(tmp3); }
				  else      { tmp3 = map_angle_360(tmp3); }}

			entity_possible_new_genotype [i] = tmp3;
			write_channel_altera(chan_LS2Conf_LS1_genotype, tmp3);
			#endif

			#if defined (DEBUG_KRNL_LS)
			printf("LS1_genotype sent\n");
			#endif
		}

		//printf("Energy to calculate sent from LS ... ");

/*
		// calculate energy of genotype
		float energyIA_LS_rx = read_channel_altera(chan_Intrae2StoreLS_LS1_intrae);
		//printf("INTRAE received in LS1 ... ");
		float energyIE_LS_rx = read_channel_altera(chan_Intere2StoreLS_LS1_intere);
		//printf("INTERE received in LS1 ... ");
*/
		float energyIA_LS_rx;
		float energyIE_LS_rx;
		bool intra_valid = false;
		bool inter_valid = false;
		while( (intra_valid == false) || (inter_valid == false)) {
			if (intra_valid == false) {
				energyIA_LS_rx = read_channel_nb_altera(chan_Intrae2StoreLS_LS1_intrae, &intra_valid);
			}
			if (inter_valid == false) {
				energyIE_LS_rx = read_channel_nb_altera(chan_Intere2StoreLS_LS1_intere, &inter_valid);
			}
		}

		float candidate_energy = energyIA_LS_rx + energyIE_LS_rx;

		// update LS energy-evaluation count
		LS_eval++;

		#if defined (FIXED_POINT_LS1)
		if (candidate_energy < current_energy) {
			// updating offspring_genotype
			// updating genotype_bias
	
			#pragma unroll 16
			for (uchar i=0; i<DockConst_num_of_genes; i++) {
/*
			#pragma unroll
			for (uchar i=0; i<ACTUAL_GENOTYPE_LENGTH; i++) {
*/
				genotype_bias [i] = (positive_direction == true) ? deviate_plus_bias  [i] : 
										   deviate_minus_bias [i] ;
				genotype      [i] = entity_possible_new_genotype [i];
			}

			current_energy = candidate_energy;
			cons_succ++;
			cons_fail = 0;
			positive_direction = true;

		}
		else {
			// updating (halving) genotype_bias

			#pragma unroll 16
			for (uchar i=0; i<DockConst_num_of_genes; i++) {
/*
			#pragma unroll
			for (uchar i=0; i<ACTUAL_GENOTYPE_LENGTH; i++) {
*/
				genotype_bias[i] = (iteration_cnt == 1)? 0: (genotype_bias[i] >> 1);
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

			#pragma unroll 16
			for (uchar i=0; i<DockConst_num_of_genes; i++) {
/*
			#pragma unroll
			for (uchar i=0; i<ACTUAL_GENOTYPE_LENGTH; i++) {
*/
				genotype_bias [i] = (positive_direction == true) ? deviate_plus_bias  [i] : 
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

			#pragma unroll 16
			for (uchar i=0; i<DockConst_num_of_genes; i++) {

/*
			#pragma unroll
			for (uchar i=0; i<ACTUAL_GENOTYPE_LENGTH; i++) {
*/
				genotype_bias[i] = (iteration_cnt == 1)? 0.0f: (0.5f*genotype_bias[i]);
			}

			if (positive_direction == false) {
				cons_fail++;
				cons_succ = 0;
			}
			positive_direction = !positive_direction;
		}
		#endif

	} // end of while (iteration_cnt) && (rho)

	#if defined (DEBUG_KRNL_LS)
	printf("Out of while iter LS\n");
	#endif
		
	// write back data to GA
	for (uchar i=0; i<DockConst_num_of_genes; i++) {
		if (i == 0) {
/*
			write_channel_altera(chan_LS2GA_LS1_eval, LS_eval);
			mem_fence(CLK_CHANNEL_MEM_FENCE);

			write_channel_altera(chan_LS2GA_LS1_energy, current_energy);
			mem_fence(CLK_CHANNEL_MEM_FENCE);
*/
			float2 evalenergy  = {*(float*)&LS_eval, current_energy};
			write_channel_altera(chan_LS2GA_LS1_evalenergy, evalenergy);		
		}
		mem_fence(CLK_CHANNEL_MEM_FENCE);

		#if defined (FIXED_POINT_LS1)
		write_channel_altera(chan_LS2GA_LS1_genotype, fixedpt_tofloat(genotype[i]));
		#else
		write_channel_altera(chan_LS2GA_LS1_genotype, genotype[i]);
		#endif
	}
}


} // End of while (valid)		


#if defined (DEBUG_ACTIVE_KERNEL)
printf("	%-20s: %s\n", "Krnl_LS", "disabled");		
#endif
	
}
// --------------------------------------------------------------------------
// --------------------------------------------------------------------------
