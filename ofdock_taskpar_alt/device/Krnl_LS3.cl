channel bool  chan_Arbiter_LS3_active;
channel float chan_Arbiter_LS3_energy;
channel float chan_Arbiter_LS3_genotype     __attribute__((depth(MAX_NUM_OF_ROTBONDS+6)));

// --------------------------------------------------------------------------
// --------------------------------------------------------------------------
__kernel __attribute__ ((max_global_work_dim(0)))
void Krnl_LS3_Arbiter(const unsigned int DockConst_num_of_genes){

	bool active = true;
	__local float genotype [ACTUAL_GENOTYPE_LENGTH];
	
while(active) {
	bool LS3_valid = false;
	bool Off_valid = false;

	bool LS3_active;
	bool Off_active;

	while((LS3_valid  == false) &&
	      (Off_valid  == false) 
	){
		LS3_active = read_channel_nb_altera(chan_GA2LS_LS3_active, &LS3_valid);
		Off_active = read_channel_nb_altera(chan_GA2LS_Off3_active, &Off_valid);
	}

	active = (LS3_valid)? LS3_active : 
		 (Off_valid)? Off_active :
		 false; // last case should never occur, otherwise above while would be still running

	float energy =  (LS3_valid)? read_channel_altera(chan_GA2LS_LS3_energy) : 

		 	(Off_valid)? 0.0f :
		 	0.0f; // last case should never occur, otherwise above while would be still running

	for (uchar i=0; i<DockConst_num_of_genes; i++) {
		genotype[i] = (LS3_valid)? read_channel_altera(chan_GA2LS_LS3_genotype) : 
			      (Off_valid)? 0.0f :
		 	      0.0f; // last case should never occur, otherwise above while would be still running
	}

	if ((LS3_valid == true) || (Off_valid == true)) {
		write_channel_altera(chan_Arbiter_LS3_active, active);
		mem_fence(CLK_CHANNEL_MEM_FENCE);
		write_channel_altera(chan_Arbiter_LS3_energy, energy);
		mem_fence(CLK_CHANNEL_MEM_FENCE);
		for (uchar i=0; i<DockConst_num_of_genes; i++) {
			write_channel_altera(chan_Arbiter_LS3_genotype, genotype[i]);
		}
	}
} // End of while(active)

#if defined (DEBUG_ACTIVE_KERNEL)
printf("	%-20s: %s\n", "Krnl_LS3_Arbiter", "disabled");		
#endif

}

// --------------------------------------------------------------------------
// --------------------------------------------------------------------------
__kernel __attribute__ ((max_global_work_dim(0)))
void Krnl_LS3(
		unsigned int              DockConst_max_num_of_iters,
		float                     DockConst_rho_lower_bound,
		float                     DockConst_base_dmov_mul_sqrt3,
		unsigned int              DockConst_num_of_genes,
   		float                     DockConst_base_dang_mul_sqrt3,
		unsigned int              DockConst_cons_limit
)
{	
	__local float genotype [ACTUAL_GENOTYPE_LENGTH];
	__local float entity_possible_new_genotype [ACTUAL_GENOTYPE_LENGTH];
	
	__local float genotype_deviate [ACTUAL_GENOTYPE_LENGTH];
	__local float genotype_bias [ACTUAL_GENOTYPE_LENGTH];  

	//__local float tmp_prng [ACTUAL_GENOTYPE_LENGTH];

	bool active = true;

while(active) {
	active = read_channel_altera(chan_Arbiter_LS3_active);
	mem_fence(CLK_CHANNEL_MEM_FENCE);

	float current_energy = read_channel_altera(chan_Arbiter_LS3_energy);
	mem_fence(CLK_CHANNEL_MEM_FENCE);
	
	for (uchar i=0; i<DockConst_num_of_genes; i++) {
		genotype[i] = read_channel_altera(chan_Arbiter_LS3_genotype);
	}
	
	float rho = 1.0f;
	ushort iteration_cnt = 0;
	uchar  cons_succ     = 0;
	uchar  cons_fail     = 0;
	uint   LS_eval       = 0;
	bool   positive_direction = true;

if (active == true) {
	
	#if defined (DEBUG_KRNL_LS3)
	printf("In of while iter LS3\n");
	#endif

	// performing local search
	while ((iteration_cnt < DockConst_max_num_of_iters) && (rho > DockConst_rho_lower_bound)) {	
		// -----------------------------------------------
		// Exit condition is groups here. It allows pipelining
		if (positive_direction == true) { 
			if (cons_succ >= DockConst_cons_limit) {
				rho = LS_EXP_FACTOR*rho;
				cons_fail = 0;
				cons_succ = 0;
			}
			else {
				if (cons_fail >= DockConst_cons_limit) {
					rho = LS_CONT_FACTOR*rho;
					cons_fail = 0;
					cons_succ = 0;
				}
			}
			iteration_cnt++;
		}

		#if defined (DEBUG_KRNL_LS3)
		printf("LS3 positive?: %u, iteration_cnt: %u, rho: %f, limit rho: %f\n", positive_direction, iteration_cnt, rho, DockConst_rho_lower_bound);
		#endif
		// -----------------------------------------------

		// Tell Krnl_Conf_Arbiter, LS3 is done
		// Not completely strict as the (iteration_cnt < DockConst_max_num_of_iters) is ignored
		// In practice, rho condition dominates most of the cases
		write_channel_altera(chan_LS2Arbiter_LS3_end, (rho < DockConst_rho_lower_bound)?true:false);
		mem_fence(CLK_CHANNEL_MEM_FENCE);

		write_channel_altera(chan_GA2PRNG_LS3_float_active, true);
		mem_fence(CLK_CHANNEL_MEM_FENCE);

		// new random deviate
		// rho is the deviation of the uniform distribution
		for (uchar i=0; i<DockConst_num_of_genes; i++) {
			/*
			write_channel_altera(chan_GA2PRNG_LS3_float_active, true);
			mem_fence(CLK_CHANNEL_MEM_FENCE);
			float tmp_prng = read_channel_altera(chan_PRNG2GA_LS3_float_prng);
			mem_fence(CLK_CHANNEL_MEM_FENCE);
			*/
	
			float tmp_prng = read_channel_altera(chan_PRNG2GA_LS3_float_prng);
			mem_fence(CLK_CHANNEL_MEM_FENCE);

			// tmp1 is genotype_deviate

			float tmp1 = rho * (2.0f*tmp_prng - 1.0f);
			//float tmp1 = rho * (2.0f*tmp_prng[i] - 1.0f);

			if (i<3) {
				tmp1 = tmp1 * DockConst_base_dmov_mul_sqrt3;
			}
			else {
				tmp1 = tmp1 * DockConst_base_dang_mul_sqrt3;
			}

			genotype_deviate [i] = 0.4f*tmp1;

			// tmp2 is the addition: genotype_deviate + genotype_bias
			float tmp2 = tmp1 + ((iteration_cnt == 1)? 0.0f:genotype_bias[i]);

			// tmp3 is entity_possible_new_genotype
			float tmp3; 
			tmp3 = (positive_direction == true)? 
							     (genotype [i] + tmp2): 
						             (genotype [i] - tmp2);
			if (i>3) {
				if (i==4) {
					tmp3 = map_angle_180(tmp3);
				}
				else {
					tmp3 = map_angle_360(tmp3);
				}
			}

			entity_possible_new_genotype [i] = tmp3;
			write_channel_altera(chan_LS2Conf_LS3_genotype, tmp3);

			#if defined (DEBUG_KRNL_LS3)
			printf("LS3_genotype sent: %u\n", i);
			#endif
		}

//printf("Energy to calculate sent from LS3 ... ");

		// calculate energy of genotype
		float energyIA_LS_rx = read_channel_altera(chan_Intrae2StoreLS_LS3_intrae);
//printf("INTRAE received in LS3 ... ");
		float energyIE_LS_rx = read_channel_altera(chan_Intere2StoreLS_LS3_intere);
		mem_fence(CLK_CHANNEL_MEM_FENCE);
//printf("INTERE received in LS3\n");
		float candidate_energy = energyIA_LS_rx + energyIE_LS_rx;

		// update LS energy-evaluation count
		LS_eval++;

		#if defined (DEBUG_KRNL_LS3)
		printf("INTERE received in LS3: %u\n", LS_eval);
		#endif

		for (uchar i=0; i<DockConst_num_of_genes; i++) {
			// updating offspring_genotype
			// updating genotype_bias
			float tmp;
			float a = ((iteration_cnt == 1)? 0.0f:genotype_bias[i]);
			float b = genotype_deviate[i];

			if (candidate_energy < current_energy) {
				genotype [i] = entity_possible_new_genotype [i];
				float c = 0.6f*a;
				tmp = (positive_direction == true) ? (c + b): (c - b);
			}
			else {
				// updating (halving) genotype_bias
				tmp = 0.5f*a;
			}

			genotype_bias[i] = tmp;
		}

		// if the new entity is better
		if (candidate_energy < current_energy)				
		{
			current_energy = candidate_energy;
			cons_succ++;
			cons_fail = 0;
			positive_direction = true;
		}
		else {
			if (positive_direction == false) {
				cons_fail++;
				cons_succ = 0;
			}
			positive_direction = !positive_direction;
		}

	} // end of while (iteration_cnt) && (rho)
	
	#if defined (DEBUG_KRNL_LS3)
	printf("Out of while iter LS3\n");
	#endif

	// write back data to GA
	write_channel_altera(chan_LS2GA_LS3_eval, LS_eval);
	mem_fence(CLK_CHANNEL_MEM_FENCE);

	write_channel_altera(chan_LS2GA_LS3_energy, current_energy);
	mem_fence(CLK_CHANNEL_MEM_FENCE);
	
	for (uchar i=0; i<DockConst_num_of_genes; i++) {
		write_channel_altera(chan_LS2GA_LS3_genotype, genotype[i]);
	}

}
/*
else {
	write_channel_altera(chan_LS2Conf_LS3_Off, false);
}
*/
	
} // End of while (active)		

#if defined (DEBUG_ACTIVE_KERNEL)
printf("	%-20s: %s\n", "Krnl_LS3", "disabled");		
#endif
	
}

// --------------------------------------------------------------------------
// --------------------------------------------------------------------------

