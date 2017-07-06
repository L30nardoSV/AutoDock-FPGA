// --------------------------------------------------------------------------
// The function performs the Solis-Wets local search algorithm on the 
// entity whose genotype is the first parameter. 
// The parameters which allows the evaluation of the solution and 
// the local search algorithm parameters must be accessible for the funciton, too. 
// The evals_performed parameter will be equal to the number of evaluations 
// which was used during the iteration. 
// If the debug parameter is 1, debug messages will be printed to the standard output.
// Originally from: searchoptimum.c
// --------------------------------------------------------------------------

__kernel __attribute__ ((max_global_work_dim(0)))
void Krnl_LS(////__global       float*           restrict GlobPopulationCurrent,
	     __global       float*           restrict GlobPopulationNext,
	     ////__global       float*           restrict GlobEnergyCurrent,
	     __global       float*           restrict GlobEnergyNext,
             __global       unsigned int*    restrict GlobPRNG,
	     __constant     Dockparameters*  restrict DockConst    
)
{	
	      uint eval_cnt = 0; 	
	      char active = 1; 	
	const char mode   = 3; 	
	//char ack    = 0;

	float rho = 1.0f;
	uint entity_for_ls; 	
	
	__local float offspring_genotype [ACTUAL_GENOTYPE_LENGTH];	
	float offspring_energy;

	//__local float entity_possible_new_genotype [ACTUAL_GENOTYPE_LENGTH]; 
	float entity_possible_new_genotype [ACTUAL_GENOTYPE_LENGTH]; 

	float candidate_energy;

	float genotype_deviate  [ACTUAL_GENOTYPE_LENGTH];
	float genotype_bias     [ACTUAL_GENOTYPE_LENGTH];

	uint cons_succ = 0;
	uint cons_fail = 0;	
	uint iteration_cnt = 0;

	uint LS_eval = 0;
	bool positive_direction = true;
	bool ls_pass_complete = false;

while(active) {
	active = read_channel_altera(chan_GA2LS_active);
	
	#if defined (DEBUG_ACTIVE_KERNEL)
	if (active == 0) {printf("	%-20s: %s\n", "Krnl_LS", "must be disabled");}
	#endif	
	
	eval_cnt = 0;

	//read GlobPRNG
	uint prng = GlobPRNG[0];

	//subjecting num_of_entity_for_ls pieces of offsprings to LS 		
	for (ushort ls_ent_cnt=0; ls_ent_cnt<DockConst->num_of_lsentities; ls_ent_cnt++) {
		
		//choosing an entity randomly, 			
		//and without checking if it has already been subjected to LS in this cycle 			
		entity_for_ls = myrand_uint(&prng, DockConst->pop_size);			
		
		//performing local search 
		for (uchar i=0; i<ACTUAL_GENOTYPE_LENGTH; i++) {
			////offspring_genotype [i] = GlobPopulationCurrent[entity_for_ls*ACTUAL_GENOTYPE_LENGTH + i];
			offspring_genotype [i] = GlobPopulationNext[entity_for_ls*ACTUAL_GENOTYPE_LENGTH + i];
			genotype_bias [i] = 0.0f;
		}
		////offspring_energy = GlobEnergyCurrent[entity_for_ls];
		offspring_energy = GlobEnergyNext[entity_for_ls];		
	
		positive_direction = true;
		ls_pass_complete = true;

		LS_eval = 0;

		// ------------------------------------------------------------------------------------------------------------
		while ((iteration_cnt < DockConst->max_num_of_iters) && (rho > DockConst->rho_lower_bound)) {
			//new random deviate
			//rho is the deviation of the uniform distribution
			for (uchar i=0; i<3; i++) {
				genotype_deviate [i] = rho*DockConst->base_dmov_mul_sqrt3*(2*myrand(&prng)-1);
			}
			for (uchar i=3; i<DockConst->num_of_genes; i++) {
				genotype_deviate [i] = rho*DockConst->base_dang_mul_sqrt3*(2*myrand(&prng)-1);
			}
			
			if (positive_direction == true) {
				for (uchar i=0; i<DockConst->num_of_genes; i++) {
					entity_possible_new_genotype[i] = offspring_genotype[i] + genotype_deviate[i] + genotype_bias[i];  
				}
			}
			// negative direction
			else {
				for (uchar i=0; i<DockConst->num_of_genes; i++) {
					entity_possible_new_genotype[i] = offspring_genotype[i] - genotype_deviate[i] - genotype_bias[i];
				}
			}

			entity_possible_new_genotype [3] = map_angle_360(entity_possible_new_genotype [3]);
			entity_possible_new_genotype [4] = map_angle_180(entity_possible_new_genotype [4]);

			for (uchar i=5; i<DockConst->num_of_genes; i++) {
				entity_possible_new_genotype [i] = map_angle_360(entity_possible_new_genotype [i]);
			}




/*
			for (uchar i=3; i<DockConst->num_of_genes; i++) {
				if (i == 4) {
					entity_possible_new_genotype [i] = map_angle_180(entity_possible_new_genotype [i]);
				} else {
					entity_possible_new_genotype [i] = map_angle_360(entity_possible_new_genotype [i]);
				}
			}
*/








			if (active != 0) {

			write_channel_altera(chan_LS2Conf_active, active);
			mem_fence(CLK_CHANNEL_MEM_FENCE);
			write_channel_altera(chan_LS2Conf_mode,   mode);
			mem_fence(CLK_CHANNEL_MEM_FENCE);
			write_channel_altera(chan_LS2Conf_cnt,    iteration_cnt);
			mem_fence(CLK_CHANNEL_MEM_FENCE);

			for (uchar pipe_cnt=0; pipe_cnt<ACTUAL_GENOTYPE_LENGTH; pipe_cnt++) {
				write_channel_altera(chan_LS2Conf_genotype, entity_possible_new_genotype[pipe_cnt]);
			}

			mem_fence(CLK_CHANNEL_MEM_FENCE);
			candidate_energy = read_channel_altera(chan_Store2LS_LSenergy);
		

			LS_eval++;

			} // End of if (active != 0)










	
			//if the new entity is better
			if (candidate_energy < offspring_energy)
			{
				// updating offspring_genotype
				// updating genotype_bias
				if (positive_direction == true) { 
					for (uchar i=0; i<ACTUAL_GENOTYPE_LENGTH; i++) {
						offspring_genotype [i] = entity_possible_new_genotype [i];
						genotype_bias [i] = 0.6f*genotype_bias [i] + 0.4f*genotype_deviate [i];
					}
				}
				else {
					for (uchar i=0; i<ACTUAL_GENOTYPE_LENGTH; i++) {
						offspring_genotype [i] = entity_possible_new_genotype [i];
						genotype_bias [i] = 0.6f*genotype_bias [i] - 0.4f*genotype_deviate [i];
					}
				}

				offspring_energy = candidate_energy;
				cons_succ++;
				cons_fail = 0;
				ls_pass_complete = true;
			}
			else {
				if (positive_direction == true) {
					positive_direction = false;
					ls_pass_complete   = false;
					//LS_eval++;
				}
				else {	// failure in both directions
					positive_direction = true;
					ls_pass_complete   = true;

					// updating (halving) genotype_bias
					for (uchar i=0; i<ACTUAL_GENOTYPE_LENGTH; i++) {
						genotype_bias [i] = 0.5f*genotype_bias [i];
					}

					cons_fail++;
					cons_succ = 0;
				}
			}
			
			if (ls_pass_complete == true) { 
				//Changing deviation (rho), if needed
				if (cons_succ >= DockConst->cons_limit) {
					//this limitation is necessary in the FPGA due to the number representation
					//if ((rho*DockConst->base_dang_mul_sqrt3 < 90) && (rho*DockConst->base_dmov_mul_sqrt3 < 64)) {
						rho = LS_EXP_FACTOR*rho;
					//}
					cons_fail = 0;
					cons_succ = 0;
				}
				else {
					if (cons_fail >= DockConst->cons_limit) {
						rho = LS_CONT_FACTOR*rho;
						cons_fail = 0;
						cons_succ = 0;
					}
				}
				iteration_cnt++;
			}

		} // end of while (iteration_cnt)
		// ------------------------------------------------------------------------------------------------------------

		rho = 1.0f;
		iteration_cnt = 0;

		for (uchar i=0; i<ACTUAL_GENOTYPE_LENGTH; i++) {
			////GlobPopulationCurrent[entity_for_ls*ACTUAL_GENOTYPE_LENGTH + i] = offspring_genotype [i];
			GlobPopulationNext[entity_for_ls*ACTUAL_GENOTYPE_LENGTH + i] = offspring_genotype [i];
		}
		////GlobEnergyCurrent[entity_for_ls] = offspring_energy;
		GlobEnergyNext[entity_for_ls] = offspring_energy;

		eval_cnt += LS_eval;

	} // End of for-loop ls_ent_cnt

	//write back to GlobPRNG
	GlobPRNG[0] = prng;

	write_channel_altera(chan_LS2GA_eval_cnt, eval_cnt);
	
} // End of while (active)		

#if defined (DEBUG_ACTIVE_KERNEL)
printf("	%-20s: %s\n", "Krnl_LS", "disabled");		
#endif
	
}
