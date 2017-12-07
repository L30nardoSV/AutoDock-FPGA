// Enable the channels extension
#pragma OPENCL EXTENSION cl_altera_channels : enable

//IC: initial calculation of energy of populations
//GG: genetic generation 
//LS: local search
//OFF: turn off IC, GG, LS

// Define kernel file-scope channel variable
// MAX_NUM_OF_ATOMS = 90
// ACTUAL_GENOTYPE_LENGTH (MAX_NUM_OF_ROTBONDS+6) = 38

// active 1: receiving kernel is active, 0 receiving Kernel is disabled
// mode 1 for I: init calculation energy, 
// 2 for G: genetic generation, 
// 3 for L: local search - positive descent,
// 4 for L: local search - negative descent, 
// 5 for O: off
// cnt: population count


#include "../defines.h"
channel float  	chan_IC2Conf_genotype          __attribute__((depth(ACTUAL_GENOTYPE_LENGTH)));
channel float  	chan_GG2Conf_genotype          __attribute__((depth(ACTUAL_GENOTYPE_LENGTH)));
channel float  	chan_LS2Conf_genotype          __attribute__((depth(ACTUAL_GENOTYPE_LENGTH)));
channel float  	chan_LS2Conf_LS2_genotype      __attribute__((depth(ACTUAL_GENOTYPE_LENGTH)));
channel float  	chan_LS2Conf_LS3_genotype      __attribute__((depth(ACTUAL_GENOTYPE_LENGTH)));

// To turn off Conform, InterE, IntraE
channel bool 	chan_LS2Conf_LS2_active;
channel bool  	chan_Off2Conf_active;

// IC, GG, LS1
channel float3  chan_Conf2Intere_xyz           __attribute__((depth(MAX_NUM_OF_ATOMS)));
channel bool  	chan_Conf2Intere_active;
channel char  	chan_Conf2Intere_mode;

channel float3 	chan_Conf2Intrae_xyz           __attribute__((depth(MAX_NUM_OF_ATOMS)));
channel bool  	chan_Conf2Intrae_active;
channel char  	chan_Conf2Intrae_mode;	

// LS2 and LS3
channel float3  chan_Conf2Intere_LS2_xyz       __attribute__((depth(MAX_NUM_OF_ATOMS)));
channel bool  	chan_Conf2Intere_LS2_active;
channel char    chan_Conf2Intere_LS2_mode;

channel float3 	chan_Conf2Intrae_LS2_xyz       __attribute__((depth(MAX_NUM_OF_ATOMS)));
channel bool  	chan_Conf2Intrae_LS2_active;
channel char    chan_Conf2Intrae_LS2_mode;

channel float 	chan_Intere2StoreIC_intere     __attribute__((depth(MAX_POPSIZE)));
channel float 	chan_Intere2StoreGG_intere     __attribute__((depth(MAX_POPSIZE)));
channel float 	chan_Intere2StoreLS_intere     __attribute__((depth(20)));	// it requires 6% MAX_POPSIZE
channel float 	chan_Intere2StoreLS_LS2_intere __attribute__((depth(20)));	// it requires 6% MAX_POPSIZE
channel float 	chan_Intere2StoreLS_LS3_intere __attribute__((depth(20)));	// it requires 6% MAX_POPSIZE

channel float 	chan_Intrae2StoreIC_intrae     __attribute__((depth(MAX_POPSIZE)));
channel float 	chan_Intrae2StoreGG_intrae     __attribute__((depth(MAX_POPSIZE)));
channel float 	chan_Intrae2StoreLS_intrae     __attribute__((depth(20)));	// it requires 6% MAX_POPSIZE
channel float 	chan_Intrae2StoreLS_LS2_intrae __attribute__((depth(20)));	// it requires 6% MAX_POPSIZE
channel float 	chan_Intrae2StoreLS_LS3_intrae __attribute__((depth(20)));	// it requires 6% MAX_POPSIZE

// PRNG kernerls
channel bool    chan_GA2PRNG_BT_active;
channel ushort  chan_PRNG2GA_BT_ushort_prng    __attribute__((depth(4)));
channel float   chan_PRNG2GA_BT_float_prng     __attribute__((depth(4)));

channel bool  	chan_GA2PRNG_GG_active;
channel uchar   chan_PRNG2GA_GG_uchar_prng     __attribute__((depth(2)));
channel float   chan_PRNG2GA_GG_float_prng     __attribute__((depth(ACTUAL_GENOTYPE_LENGTH)));

channel bool  	chan_GA2PRNG_LS_ushort_active;
channel ushort  chan_PRNG2GA_LS_ushort_prng;
channel ushort  chan_PRNG2GA_LS2_ushort_prng;
channel ushort  chan_PRNG2GA_LS3_ushort_prng;

channel bool  	chan_GA2PRNG_LS_float_active;
channel float   chan_PRNG2GA_LS_float_prng     __attribute__((depth(ACTUAL_GENOTYPE_LENGTH)));

channel bool  	chan_GA2PRNG_LS2_float_active;
channel float   chan_PRNG2GA_LS2_float_prng    __attribute__((depth(ACTUAL_GENOTYPE_LENGTH)));

channel bool  	chan_GA2PRNG_LS3_float_active;
channel float   chan_PRNG2GA_LS3_float_prng    __attribute__((depth(ACTUAL_GENOTYPE_LENGTH)));

channel bool  	chan_GA2PRNG_Off_active;

// LS1, LS2, LS3
channel bool 	chan_GA2LS_LS1_active;
channel float   chan_GA2LS_LS1_energy;
channel float  	chan_GA2LS_LS1_genotype        __attribute__((depth(ACTUAL_GENOTYPE_LENGTH)));

channel bool 	chan_GA2LS_LS2_active;
channel float   chan_GA2LS_LS2_energy;
channel float  	chan_GA2LS_LS2_genotype        __attribute__((depth(ACTUAL_GENOTYPE_LENGTH)));

channel bool 	chan_GA2LS_LS3_active;
channel float   chan_GA2LS_LS3_energy;
channel float  	chan_GA2LS_LS3_genotype        __attribute__((depth(ACTUAL_GENOTYPE_LENGTH)));

channel uint 	chan_LS2GA_LS1_eval	       __attribute__((depth(8)));	// it requires 6% MAX_POPSIZE
channel float   chan_LS2GA_LS1_energy	       __attribute__((depth(8)));	// it requires 6% MAX_POPSIZE
channel float  	chan_LS2GA_LS1_genotype        __attribute__((depth(ACTUAL_GENOTYPE_LENGTH)));

channel uint 	chan_LS2GA_LS2_eval	       __attribute__((depth(8)));	// it requires 6% MAX_POPSIZE
channel float   chan_LS2GA_LS2_energy	       __attribute__((depth(8)));	// it requires 6% MAX_POPSIZE
channel float  	chan_LS2GA_LS2_genotype        __attribute__((depth(ACTUAL_GENOTYPE_LENGTH)));

channel uint 	chan_LS2GA_LS3_eval	       __attribute__((depth(8)));	// it requires 6% MAX_POPSIZE
channel float   chan_LS2GA_LS3_energy          __attribute__((depth(8)));	// it requires 6% MAX_POPSIZE
channel float  	chan_LS2GA_LS3_genotype        __attribute__((depth(ACTUAL_GENOTYPE_LENGTH)));

channel bool    chan_GA2LS_Off_active;
channel bool    chan_GA2LS_Off2_active;
channel bool    chan_GA2LS_Off3_active;

channel bool    chan_ConfArbiter_Off;

// --------------------------------------------------------------------------
// These functions map the argument into the interval 0 - 180, or 0 - 360
// by adding/subtracting n*ang_max to/from it.
// Originally from: searchoptimum.c
// --------------------------------------------------------------------------

float map_angle_180(float angle)
{
	float x = angle;
	//while (x < 0.0f) {
	if (x < 0.0f)   { x += 180.0f; }
	//while (x > 180.0f) {
	if (x > 180.0f) { x -= 180.0f; }
	return x;
}

float map_angle_360(float angle)
{
	float x = angle;
	//while (x < 0.0f) {
	if (x < 0.0f)   { x += 360.0f; }
	//while (x > 360.0f) {
	if (x > 360.0f) { x -= 360.0f;}
	return x;
}


// --------------------------------------------------------------------------
// The function performs a generational genetic algorithm based search 
// on the search space.
// Originally from: searchoptimum.c
// --------------------------------------------------------------------------
__kernel __attribute__ ((max_global_work_dim(0)))
void Krnl_GA(__global       float*           restrict GlobPopulationCurrent,
	     __global       float*           restrict GlobEnergyCurrent,
	     __global       unsigned int*    restrict GlobEvalsGenerations_performed,
			    unsigned int              DockConst_pop_size,
		     	    unsigned int              DockConst_num_of_energy_evals,
			    unsigned int              DockConst_num_of_generations,
		      	    float                     DockConst_tournament_rate,
			    float                     DockConst_mutation_rate,
		    	    float                     DockConst_abs_max_dmov,
			    float                     DockConst_abs_max_dang,
		    	    float                     Host_two_absmaxdmov,
			    float                     Host_two_absmaxdang,
			    float                     DockConst_crossover_rate,
			    unsigned int              DockConst_num_of_lsentities,
			    unsigned int              DockConst_num_of_genes)
{
	#if defined (DEBUG_KRNL_GA)
	printf("\n");
	printf("%-40s %u\n", "DockConst_pop_size: ",        		DockConst_pop_size);
	printf("%-40s %u\n", "DockConst_num_of_energy_evals: ",  	DockConst_num_of_energy_evals);
	printf("%-40s %u\n", "DockConst_num_of_generations: ",  	DockConst_num_of_generations);
	printf("%-40s %f\n", "DockConst_tournament_rate: ", 		DockConst_tournament_rate);
	printf("%-40s %f\n", "DockConst_mutation_rate: ", 		DockConst_mutation_rate);
	printf("%-40s +/-%fA\n", "DockConst_abs_max_dmov: ",		DockConst_abs_max_dmov);
	printf("%-40s +/-%f°\n", "DockConst_abs_max_dang: ",  		DockConst_abs_max_dang);
	printf("%-40s +/-%fA\n", "Host_two_absmaxdmov: ",		Host_two_absmaxdmov);
	printf("%-40s +/-%f°\n", "Host_two_absmaxdang: ",  		Host_two_absmaxdang);
	printf("%-40s %f\n", "DockConst_crossover_rate: ", 		DockConst_crossover_rate);
	printf("%-40s %u\n", "DockConst_num_of_lsentities: ",   	DockConst_num_of_lsentities);
	printf("%-40s %u\n", "DockConst_num_of_genes: ",        	DockConst_num_of_genes);
	#endif

	uint eval_cnt = 0;
	uint tmp_eval_cnt = 0;
	uint generation_cnt = 0;

	__local float LocalPopCurr[MAX_POPSIZE][ACTUAL_GENOTYPE_LENGTH];
	__local float LocalEneCurr[MAX_POPSIZE];

	// ------------------------------------------------------------------
	// IC: Init Calculation
	// ------------------------------------------------------------------
	for (ushort pop_cnt = 0; pop_cnt < DockConst_pop_size; pop_cnt++) {
		// calculate energy
		for (uchar pipe_cnt=0; pipe_cnt<DockConst_num_of_genes; pipe_cnt++) {
			LocalPopCurr[pop_cnt][pipe_cnt & 0x3F] = GlobPopulationCurrent[pop_cnt*ACTUAL_GENOTYPE_LENGTH + pipe_cnt];
			write_channel_altera(chan_IC2Conf_genotype, LocalPopCurr[pop_cnt][pipe_cnt & 0x3F]);	
		}	
		#if defined (DEBUG_KRNL_IC)
		printf("\nIC - tx pop: %u", pop_cnt); 		
		#endif

		// read energy
		float energyIA_IC_rx = read_channel_altera(chan_Intrae2StoreIC_intrae);
		float energyIE_IC_rx = read_channel_altera(chan_Intere2StoreIC_intere);
		LocalEneCurr[pop_cnt] = energyIA_IC_rx + energyIE_IC_rx;
		#if defined (DEBUG_KRNL_IC)
		printf(", IC - rx pop: %u\n", pop_cnt); 		
		#endif
	}
	// ------------------------------------------------------------------

	__local float LocalPopNext[MAX_POPSIZE][ACTUAL_GENOTYPE_LENGTH];
	__local float LocalEneNext[MAX_POPSIZE];

	while ((eval_cnt < DockConst_num_of_energy_evals) && (generation_cnt < DockConst_num_of_generations)) {

		// update energy evaluations
		eval_cnt += tmp_eval_cnt + DockConst_pop_size;

		// update generations
		generation_cnt++;

		// ------------------------------------------------------------------
		// GG: Genetic Generation
		// ------------------------------------------------------------------

		float __attribute__ ((
				       memory,
		   		       numbanks(1),
			               bankwidth(64),
			               singlepump,
 			               numreadports(7),
			               numwriteports(1)
			              )) loc_energies[MAX_POPSIZE];

		// copy energy to local memory
		for (ushort pop_cnt=0; pop_cnt<DockConst_pop_size; pop_cnt++) {
			loc_energies[pop_cnt] = LocalEneCurr[pop_cnt];
		}

		// create shift register to reduce II (initially II=6) of best entity for-loop 
		float shift_reg[7];

		#pragma unroll
		for (uchar i=0; i<7; i++) {
			shift_reg[i] = 0.0f;
		}

		// identifying best entity
		ushort best_entity = 0;
		for (ushort pop_cnt=1; pop_cnt<DockConst_pop_size; pop_cnt++) {
			shift_reg[6] = loc_energies[best_entity];

			#pragma unroll
			for (uchar j=0; j<6; j++) {
				shift_reg[j] = shift_reg[j+1];
			}
				
			if (loc_energies[pop_cnt] < shift_reg[0]) {
				best_entity = pop_cnt;
			}
		}

		// elitism - copying the best entity to new population 	
		for (uchar gene_cnt=0; gene_cnt<DockConst_num_of_genes; gene_cnt++) { 		
			LocalPopNext[0][gene_cnt & 0x3F] = LocalPopCurr[best_entity][gene_cnt & 0x3F]; 	
		} 		
		LocalEneNext[0] = loc_energies[best_entity];

		for (ushort new_pop_cnt = 1; new_pop_cnt < DockConst_pop_size; new_pop_cnt++) {

			float local_entity_1 [ACTUAL_GENOTYPE_LENGTH];
			float local_entity_2 [ACTUAL_GENOTYPE_LENGTH]; 
		
			// ----------------------------------------
			// binary_tournament_selection
			// ----------------------------------------

			// get ushort binary_tournament selection prngs (parent index)
			// get float binary_tournament selection prngs (tournament rate)
			write_channel_altera(chan_GA2PRNG_BT_active, true);
			mem_fence(CLK_CHANNEL_MEM_FENCE);

			ushort prng_BT_U[4];
			float  prng_BT_F[4];

			for (uchar j=0; j<4; j++) {
				prng_BT_U[j] = read_channel_altera(chan_PRNG2GA_BT_ushort_prng);
				prng_BT_F[j] = read_channel_altera(chan_PRNG2GA_BT_float_prng);
			}
			mem_fence(CLK_CHANNEL_MEM_FENCE);

			ushort parent1;
			ushort parent2; 

			// first parent
			if (loc_energies[prng_BT_U[0]] < loc_energies[prng_BT_U[1]]) {
				if (prng_BT_F[0] < DockConst_tournament_rate) {parent1 = prng_BT_U[0];}
				else				             {parent1 = prng_BT_U[1];}}
			else {
				if (prng_BT_F[1] < DockConst_tournament_rate) {parent1 = prng_BT_U[1];}
				else				             {parent1 = prng_BT_U[0];}}

			// the better will be the second parent
			if (loc_energies[prng_BT_U[2]] < loc_energies[prng_BT_U[3]]) {
				if (prng_BT_F[2] < DockConst_tournament_rate) {parent2 = prng_BT_U[2];}
				else		          	             {parent2 = prng_BT_U[3];}}
			else {
				if (prng_BT_F[3] < DockConst_tournament_rate) {parent2 = prng_BT_U[3];}
				else			                     {parent2 = prng_BT_U[2];}}

			// local_entity_1 and local_entity_2 are population-parent1, population-parent2
			for (uchar gene_cnt=0; gene_cnt<DockConst_num_of_genes; gene_cnt++) {
				local_entity_1[gene_cnt] = LocalPopCurr[parent1][gene_cnt & 0x3F];
				local_entity_2[gene_cnt] = LocalPopCurr[parent2][gene_cnt & 0x3F];
			}

			// ----------------------------------------
			// genetic generation (mating parents)
			// ----------------------------------------	

			float __attribute__ ((
					       memory,
		   			       numbanks(1),
			                       bankwidth(16),
			                       singlepump,
 			                       numreadports(2),//3
			                       numwriteports(1)
			                    )) prngGG [ACTUAL_GENOTYPE_LENGTH]; 		

			// get uchar genetic_generation prngs (gene index)
			// get float genetic_generation prngs (mutation rate)
			write_channel_altera(chan_GA2PRNG_GG_active, true);
			mem_fence(CLK_CHANNEL_MEM_FENCE);

			uchar prng_GG_C[2];

			for (uchar gene_cnt=0; gene_cnt<DockConst_num_of_genes; gene_cnt++) {
				if (gene_cnt < 2) {
					prng_GG_C[gene_cnt] = read_channel_altera(chan_PRNG2GA_GG_uchar_prng);
				}
				prngGG[gene_cnt] = read_channel_altera(chan_PRNG2GA_GG_float_prng);
			}
			mem_fence(CLK_CHANNEL_MEM_FENCE);

			uchar covr_point_low;
			uchar covr_point_high;
			bool twopoint_cross_yes = false;

			if (prng_GG_C[0] == prng_GG_C[1]) {covr_point_low = prng_GG_C[0];}
			else {
				twopoint_cross_yes = true;
				if (prng_GG_C[0] < prng_GG_C[1]) {
					covr_point_low  = prng_GG_C[0];
					covr_point_high = prng_GG_C[1];
				}
				else {		    
					covr_point_low  = prng_GG_C[1];
					covr_point_high = prng_GG_C[0];
				}
			}
			
/*
			float __attribute__ ((
			      		       memory,
			                       numbanks(1),
			                       bankwidth(16),
			                       singlepump,
			                       numreadports(2),
			                       numwriteports(1)
			                    )) GGoffspring [ACTUAL_GENOTYPE_LENGTH]; 
*/

			bool crossover_yes = (DockConst_crossover_rate > prngGG[0]);
			
			for (uchar gene_cnt=0; gene_cnt<DockConst_num_of_genes; gene_cnt++) {
				float tmp_offspring;

				// performing crossover
				if (   	(
					crossover_yes && (										// crossover
					( (twopoint_cross_yes == true)  && ((gene_cnt <= covr_point_low) || (gene_cnt > covr_point_high)) )  ||	// two-point crossover 			 		
					( (twopoint_cross_yes == false) && (gene_cnt <= covr_point_low))  					// one-point crossover
					)) || 
					(!crossover_yes)	// no crossover
				   ) {
					/*GGoffspring[gene_cnt]*/ tmp_offspring = local_entity_1[gene_cnt];
				}
				else {
					/*GGoffspring[gene_cnt]*/ tmp_offspring = local_entity_2[gene_cnt];
				}

				// performing mutation
				if (DockConst_mutation_rate > prngGG[gene_cnt]) {
					if(gene_cnt<3) {
						/*GGoffspring[gene_cnt]*/ tmp_offspring = /*GGoffspring[gene_cnt]*/ tmp_offspring + Host_two_absmaxdmov*prngGG[gene_cnt]-DockConst_abs_max_dmov;
					}
					else {
						float tmp;
						tmp = /*GGoffspring[gene_cnt]*/ tmp_offspring + Host_two_absmaxdang*prngGG[gene_cnt]-DockConst_abs_max_dang;
						if (gene_cnt==4) {
							/*GGoffspring[gene_cnt]*/ tmp_offspring = map_angle_180(tmp);
						}
						else {
							/*GGoffspring[gene_cnt]*/ tmp_offspring = map_angle_360(tmp);
						}
					}
				}

				// calculate energy
				LocalPopNext [new_pop_cnt][gene_cnt & 0x3F] = /*GGoffspring [gene_cnt]*/ tmp_offspring;
				write_channel_altera(chan_GG2Conf_genotype, /*GGoffspring[gene_cnt]*/ tmp_offspring);
			}

			#if defined (DEBUG_KRNL_GG)
			printf("GG - tx pop: %u", new_pop_cnt); 		
			#endif	

			// read energy
			float energyIA_GG_rx = read_channel_altera(chan_Intrae2StoreGG_intrae);
			float energyIE_GG_rx = read_channel_altera(chan_Intere2StoreGG_intere);
			LocalEneNext[new_pop_cnt] = energyIA_GG_rx + energyIE_GG_rx;

			#if defined (DEBUG_KRNL_GG)
			printf(", GG - rx pop: %u\n", new_pop_cnt); 		
			#endif
		} 
		// ------------------------------------------------------------------


		// ------------------------------------------------------------------
		// LS: Local Search
		// subject num_of_entity_for_ls pieces of offsprings to LS 
		// LS1
		// LS2
		// LS3	
		// ------------------------------------------------------------------
		tmp_eval_cnt = 0;

		#pragma ivdep
		//for (ushort ls_ent_cnt=0; ls_ent_cnt<DockConst_num_of_lsentities; ls_ent_cnt++) {
		for (ushort ls_ent_cnt=0; ls_ent_cnt<DockConst_num_of_lsentities; ls_ent_cnt+=3) {

			// choose all random entities
			// without checking if it has already been subjected to LS in this cycle
			write_channel_altera(chan_GA2PRNG_LS_ushort_active, true);
			mem_fence(CLK_CHANNEL_MEM_FENCE);

			ushort entity_ls1 = read_channel_altera(chan_PRNG2GA_LS_ushort_prng);
			ushort entity_ls2 = read_channel_altera(chan_PRNG2GA_LS2_ushort_prng);
			ushort entity_ls3 = read_channel_altera(chan_PRNG2GA_LS3_ushort_prng);
			mem_fence(CLK_CHANNEL_MEM_FENCE);

			write_channel_altera(chan_GA2LS_LS1_active, true);
			write_channel_altera(chan_GA2LS_LS2_active, true);
			write_channel_altera(chan_GA2LS_LS3_active, true);
			mem_fence(CLK_CHANNEL_MEM_FENCE);

			write_channel_altera(chan_GA2LS_LS1_energy, LocalEneNext[entity_ls1]);
			write_channel_altera(chan_GA2LS_LS2_energy, LocalEneNext[entity_ls2]);
			write_channel_altera(chan_GA2LS_LS3_energy, LocalEneNext[entity_ls3]);
			mem_fence(CLK_CHANNEL_MEM_FENCE);

			for (uchar gene_cnt=0; gene_cnt<DockConst_num_of_genes; gene_cnt++) {
				write_channel_altera(chan_GA2LS_LS1_genotype, LocalPopNext[entity_ls1][gene_cnt & 0x3F]);
				write_channel_altera(chan_GA2LS_LS2_genotype, LocalPopNext[entity_ls2][gene_cnt & 0x3F]);
				write_channel_altera(chan_GA2LS_LS3_genotype, LocalPopNext[entity_ls3][gene_cnt & 0x3F]);
			}
			mem_fence(CLK_CHANNEL_MEM_FENCE);

			uint eval_tmp1 = read_channel_altera(chan_LS2GA_LS1_eval);
			uint eval_tmp2 = read_channel_altera(chan_LS2GA_LS2_eval);
			uint eval_tmp3 = read_channel_altera(chan_LS2GA_LS3_eval);
			mem_fence(CLK_CHANNEL_MEM_FENCE);

			#if defined (DEBUG_KRNL_LS)
			printf("LS - got all eval back\n");
			#endif

			uint LS_eval = eval_tmp1 + eval_tmp2 + eval_tmp3;
			
			LocalEneNext[entity_ls1] = read_channel_altera(chan_LS2GA_LS1_energy);	
			LocalEneNext[entity_ls2] = read_channel_altera(chan_LS2GA_LS2_energy);
			LocalEneNext[entity_ls3] = read_channel_altera(chan_LS2GA_LS3_energy);
			mem_fence(CLK_CHANNEL_MEM_FENCE);

			#if defined (DEBUG_KRNL_LS)
			printf("LS - got all energies back\n");
			#endif

			#pragma ivdep
			for (uchar gene_cnt=0; gene_cnt<DockConst_num_of_genes; gene_cnt++) {
				LocalPopNext[entity_ls1][gene_cnt & 0x3F] = read_channel_altera(chan_LS2GA_LS1_genotype);
				LocalPopNext[entity_ls2][gene_cnt & 0x3F] = read_channel_altera(chan_LS2GA_LS2_genotype);
				LocalPopNext[entity_ls3][gene_cnt & 0x3F] = read_channel_altera(chan_LS2GA_LS3_genotype);
			}
			tmp_eval_cnt += LS_eval;

			#if defined (DEBUG_KRNL_LS)
			printf("LS - got all genotypes back\n");
			#endif
		} // End of for-loop ls_ent_cnt
		// ------------------------------------------------------------------

		// update current pops & energies
		for (ushort pop_cnt=0; pop_cnt<DockConst_pop_size; pop_cnt++) { 	
			for (uchar gene_cnt=0; gene_cnt<DockConst_num_of_genes; gene_cnt++) {
				LocalPopCurr[pop_cnt][gene_cnt & 0x3F] = LocalPopNext[pop_cnt][gene_cnt & 0x3F];
			}

			LocalEneCurr[pop_cnt] = LocalEneNext[pop_cnt];
		}

		#if defined (DEBUG_KRNL_GA)
		printf("eval_cnt: %u, generation_cnt: %u\n", eval_cnt, generation_cnt);
		#endif
			
	} // End while eval_cnt & generation_cnt

	// ------------------------------------------------------------------
	// Off: turn off all other kernels
	// ------------------------------------------------------------------
	write_channel_altera(chan_GA2LS_Off_active,   false);	// turn off LS_Arbiter, LS
	write_channel_altera(chan_GA2LS_Off2_active,  false);	// turn off LS2_Arbiter, LS2 
	write_channel_altera(chan_GA2LS_Off3_active,  false);	// turn off LS3_Arbiter, LS3 
	write_channel_altera(chan_GA2PRNG_Off_active, false);	// turn off all PRNGs kernels
	write_channel_altera(chan_Off2Conf_active,    false);	// turn off Conform, InterE, IntraE
	write_channel_altera(chan_ConfArbiter_Off,    false);   // turn off Krnl_Conf_Arbiter,Conform2, InterE2, IntraE2
	
	for (ushort pop_cnt=0;pop_cnt<DockConst_pop_size; pop_cnt++) { 	
		for (uchar gene_cnt=0; gene_cnt<DockConst_num_of_genes; gene_cnt++) {
			GlobPopulationCurrent[pop_cnt*ACTUAL_GENOTYPE_LENGTH + gene_cnt] = LocalPopCurr[pop_cnt][gene_cnt & 0x3F];
		}
		GlobEnergyCurrent[pop_cnt] = LocalEneCurr[pop_cnt];
	}

	#if defined (DEBUG_KRNL_GA)
	printf("GA: %u %u\n", active, DockConst_pop_size -1);
	#endif

	#if defined (DEBUG_ACTIVE_KERNEL)
	printf("	%-20s: %s\n", "Krnl_GA", "disabled");
	#endif

	GlobEvalsGenerations_performed[0] = eval_cnt;
	GlobEvalsGenerations_performed[1] = generation_cnt;
}

// --------------------------------------------------------------------------
// --------------------------------------------------------------------------

#include "Krnl_PRNG.cl"
#include "Krnl_Conf_Arbiter.cl"
#include "Krnl_Conf_Arbiter2.cl"

#include "Krnl_LS.cl"
#include "Krnl_Conform.cl"
#include "Krnl_InterE.cl"
#include "Krnl_IntraE.cl"

#include "Krnl_LS2.cl"
#include "Krnl_LS3.cl"
#include "Krnl_Conform2.cl"
#include "Krnl_InterE2.cl"
#include "Krnl_IntraE2.cl"
