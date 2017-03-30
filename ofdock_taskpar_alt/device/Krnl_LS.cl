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
void Krnl_LS(__global       float*           restrict GlobPopulationCurrent,
	     __global       float*           restrict GlobEnergyCurrent,
             __global       unsigned int*    restrict GlobPRNG,
	     //__global const Dockparameters*  restrict DockConst
	     __constant const Dockparameters*  restrict DockConst
		  //    const unsigned int   	      DockConst_num_of_lsentities,
		  //    const unsigned int 	      DockConst_pop_size,
		  //    const unsigned int 	      DockConst_max_num_of_iters,
		  //    const float		      DockConst_rho_lower_bound,
		  //    const float		      DockConst_base_dmov_mul_sqrt3,
	          //    const unsigned int 	      DockConst_num_of_genes,	            
     		  //    const float		      DockConst_base_dang_mul_sqrt3,
		  //    const unsigned int 	      DockConst_cons_limit      
)
{	
	uint eval_cnt = 0; 	
	char active = 1; 	
	char mode   = 3; 	
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
	for (uint ls_ent_cnt=0; ls_ent_cnt<DockConst->num_of_lsentities; ls_ent_cnt++) {
	//for (uint ls_ent_cnt=0; ls_ent_cnt<DockConst_num_of_lsentities; ls_ent_cnt++) { 	
		
		//choosing an entity randomly, 			
		//and without checking if it has already been subjected to LS in this cycle 			
		//entity_for_ls = myrand_uint(GlobPRNG, DockConst->pop_size); 
		entity_for_ls = myrand_uint(&prng, DockConst->pop_size);
		//entity_for_ls = myrand_uint(&prng, DockConst_pop_size);			
		
		//performing local search 
		//for (uint i=0; i<ACTUAL_GENOTYPE_LENGTH; i++) {
		for (uchar i=0; i<ACTUAL_GENOTYPE_LENGTH; i++) {
			offspring_genotype [i] = GlobPopulationCurrent[entity_for_ls*ACTUAL_GENOTYPE_LENGTH + i];
			genotype_bias [i] = 0.0f;
		}
		offspring_energy = GlobEnergyCurrent[entity_for_ls];		
	
		positive_direction = true;
		ls_pass_complete = true;

		LS_eval = 0;

		// ------------------------------------------------------------------------------------------------------------
		while ((iteration_cnt < DockConst->max_num_of_iters) && (rho > DockConst->rho_lower_bound)) {
		//while ((iteration_cnt < DockConst_max_num_of_iters) && (rho > DockConst_rho_lower_bound)) {
			//new random deviate
			//rho is the deviation of the uniform distribution
			//genotype_deviate [0] = rho*DockConst->base_dmov_mul_sqrt3*(2*myrand(GlobPRNG)-1);
			//genotype_deviate [1] = rho*DockConst->base_dmov_mul_sqrt3*(2*myrand(GlobPRNG)-1);
			//genotype_deviate [2] = rho*DockConst->base_dmov_mul_sqrt3*(2*myrand(GlobPRNG)-1);
			genotype_deviate [0] = rho*DockConst->base_dmov_mul_sqrt3*(2*myrand(&prng)-1);
			genotype_deviate [1] = rho*DockConst->base_dmov_mul_sqrt3*(2*myrand(&prng)-1);
			genotype_deviate [2] = rho*DockConst->base_dmov_mul_sqrt3*(2*myrand(&prng)-1);
			//genotype_deviate [0] = rho*DockConst_base_dmov_mul_sqrt3*(2*myrand(&prng)-1);
			//genotype_deviate [1] = rho*DockConst_base_dmov_mul_sqrt3*(2*myrand(&prng)-1);
			//genotype_deviate [2] = rho*DockConst_base_dmov_mul_sqrt3*(2*myrand(&prng)-1);

			//for (uint i=3; i<DockConst->num_of_genes; i++) {
			for (uchar i=3; i<DockConst->num_of_genes; i++) {
			//for (uchar i=3; i<DockConst_num_of_genes; i++) {
			//genotype_deviate [i] = rho*DockConst->base_dang_mul_sqrt3*(2*myrand(GlobPRNG)-1);
			genotype_deviate [i] = rho*DockConst->base_dang_mul_sqrt3*(2*myrand(&prng)-1);
			//genotype_deviate [i] = rho*DockConst_base_dang_mul_sqrt3*(2*myrand(&prng)-1);
			}
			
			if (positive_direction == true) {
				entity_possible_new_genotype[0] = offspring_genotype[0] + genotype_deviate[0] + genotype_bias[0];
				entity_possible_new_genotype[1] = offspring_genotype[1] + genotype_deviate[1] + genotype_bias[1];
				entity_possible_new_genotype[2] = offspring_genotype[2] + genotype_deviate[2] + genotype_bias[2];
				entity_possible_new_genotype[3] = offspring_genotype[3] + genotype_deviate[3] + genotype_bias[3];
				//map_angle(&(entity_possible_new_genotype [3]), 360.0f);
				//map_angle_360(&(entity_possible_new_genotype [3]));
				entity_possible_new_genotype [3] = map_angle_360(entity_possible_new_genotype [3]);

				entity_possible_new_genotype[4] = offspring_genotype[4] + genotype_deviate[4] + genotype_bias[4];
				//map_angle(&(entity_possible_new_genotype [4]), 180.0f);	
				//map_angle_180(&(entity_possible_new_genotype [4]));
				entity_possible_new_genotype [4] = map_angle_180(entity_possible_new_genotype [4]);	

				//for (uint i=5; i<DockConst->num_of_genes; i++) {
				for (uchar i=5; i<DockConst->num_of_genes; i++) {
				//for (uchar i=5; i<DockConst_num_of_genes; i++) {
				entity_possible_new_genotype[i] = offspring_genotype [i] + genotype_deviate [i] + genotype_bias [i];  
				//map_angle(&(entity_possible_new_genotype [i]), 360.0f);
				//map_angle_360(&(entity_possible_new_genotype [i]));
				entity_possible_new_genotype [i] = map_angle_360(entity_possible_new_genotype [i]);
				}
			}
			// negative direction
			else {
				entity_possible_new_genotype[0] = offspring_genotype[0] - genotype_deviate[0] - genotype_bias[0];
				entity_possible_new_genotype[1] = offspring_genotype[1] - genotype_deviate[1] - genotype_bias[1];
				entity_possible_new_genotype[2] = offspring_genotype[2] - genotype_deviate[2] - genotype_bias[2];
				entity_possible_new_genotype[3] = offspring_genotype[3] - genotype_deviate[3] - genotype_bias[3];
				//map_angle(&(entity_possible_new_genotype [3]), 360.0f);
				//map_angle_360(&(entity_possible_new_genotype [3]));
				entity_possible_new_genotype [3] = map_angle_360(entity_possible_new_genotype [3]);

				entity_possible_new_genotype[4] = offspring_genotype[4] - genotype_deviate[4] - genotype_bias[4];
				//map_angle(&(entity_possible_new_genotype [4]), 180.0f);
				//map_angle_180(&(entity_possible_new_genotype [4]));
				entity_possible_new_genotype [4] = map_angle_180(entity_possible_new_genotype [4]);

				//for (uint i=5; i<DockConst->num_of_genes; i++) {
				for (uchar i=5; i<DockConst->num_of_genes; i++) {
				//for (uchar i=5; i<DockConst_num_of_genes; i++) {
				entity_possible_new_genotype[i] = offspring_genotype[i] - genotype_deviate[i] - genotype_bias[i];
				//map_angle(&(entity_possible_new_genotype [i]), 360.0f);
				//map_angle_360(&(entity_possible_new_genotype [i]));
				entity_possible_new_genotype [i] = map_angle_360(entity_possible_new_genotype [i]);
				}
			}
			


			if (active != 0) {

			write_channel_altera(chan_LS2Conf_active, active);
			mem_fence(CLK_CHANNEL_MEM_FENCE);
			write_channel_altera(chan_LS2Conf_mode,   mode);
			mem_fence(CLK_CHANNEL_MEM_FENCE);
			write_channel_altera(chan_LS2Conf_cnt,    iteration_cnt);
			mem_fence(CLK_CHANNEL_MEM_FENCE);

			//for (uint pipe_cnt=0; pipe_cnt<ACTUAL_GENOTYPE_LENGTH; pipe_cnt++) {
			for (uchar pipe_cnt=0; pipe_cnt<ACTUAL_GENOTYPE_LENGTH; pipe_cnt++) {
				write_channel_altera(chan_LS2Conf_genotype, entity_possible_new_genotype[pipe_cnt]);
			}

			mem_fence(CLK_CHANNEL_MEM_FENCE);
			candidate_energy = read_channel_altera(chan_Store2LS_LSenergy);
		

			} // End of if (active != 0)

	
			//if the new entity is better better
			if (candidate_energy < offspring_energy)
			{
				// updating offspring_genotype
				// updating genotype_bias
				if (positive_direction == true) { 
					//for (uint i=0; i<ACTUAL_GENOTYPE_LENGTH; i++) {
					for (uchar i=0; i<ACTUAL_GENOTYPE_LENGTH; i++) {
						offspring_genotype [i] = entity_possible_new_genotype [i];
						genotype_bias [i] = 0.6f*genotype_bias [i] + 0.4f*genotype_deviate [i];
					}

					offspring_energy = candidate_energy;
					cons_succ++;
					cons_fail = 0;	

					ls_pass_complete = true;
				}
				else {
					//for (uint i=0; i<ACTUAL_GENOTYPE_LENGTH; i++) {
					for (uchar i=0; i<ACTUAL_GENOTYPE_LENGTH; i++) {
						offspring_genotype [i] = entity_possible_new_genotype [i];
						genotype_bias [i] = 0.6f*genotype_bias [i] - 0.4f*genotype_deviate [i];
					}

					offspring_energy = candidate_energy;
					cons_succ++;
					cons_fail = 0;
			
					ls_pass_complete = true;
				}
			}
			else {
				if (positive_direction == true) {
					positive_direction = false;
					ls_pass_complete   = false;
					LS_eval++;
				}
				else {
					positive_direction = true;
					ls_pass_complete   = true;

					// updating (halving) genotype_bias
					//for (uint i=0; i<ACTUAL_GENOTYPE_LENGTH; i++) {
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
				//if (cons_succ >= DockConst_cons_limit) {
					//this limitation is necessary in the FPGA due to the number representation
					if ((rho*DockConst->base_dang_mul_sqrt3 < 90) && (rho*DockConst->base_dmov_mul_sqrt3 < 64)) {
					//if ((rho*DockConst_base_dang_mul_sqrt3 < 90) && (rho*DockConst_base_dmov_mul_sqrt3 < 64)) {
						rho = LS_EXP_FACTOR*rho;
					}
					cons_fail = 0;
					cons_succ = 0;
				}
				else {
					if (cons_fail >= DockConst->cons_limit) {
					//if (cons_fail >= DockConst_cons_limit) {
						rho = LS_CONT_FACTOR*rho;
						cons_fail = 0;
						cons_succ = 0;
					}
				}
				iteration_cnt++;
			}

		} // end of while (iteration_cnt)
		// ------------------------------------------------------------------------------------------------------------

		//for (uint i=0; i<ACTUAL_GENOTYPE_LENGTH; i++) {
		for (uchar i=0; i<ACTUAL_GENOTYPE_LENGTH; i++) {
			GlobPopulationCurrent[entity_for_ls*ACTUAL_GENOTYPE_LENGTH + i] = offspring_genotype [i];
		}
		GlobEnergyCurrent[entity_for_ls] = offspring_energy;

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
