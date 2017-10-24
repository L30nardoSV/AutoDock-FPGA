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
channel float  	chan_IC2Conf_genotype          __attribute__((depth(MAX_NUM_OF_ROTBONDS+6)));
channel float  	chan_GG2Conf_genotype          __attribute__((depth(MAX_NUM_OF_ROTBONDS+6)));
channel float  	chan_LS2Conf_genotype          __attribute__((depth(MAX_NUM_OF_ROTBONDS+6)));
channel float  	chan_LS2Conf_LS2_genotype      __attribute__((depth(MAX_NUM_OF_ROTBONDS+6)));
channel float  	chan_LS2Conf_LS3_genotype      __attribute__((depth(MAX_NUM_OF_ROTBONDS+6)));

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
channel bool  	chan_GA2PRNG_BT_ushort_active;
channel ushort4 chan_PRNG2GA_BT_ushort_prng;

channel bool  	chan_GA2PRNG_BT_float_active;
channel float4  chan_PRNG2GA_BT_float_prng;

channel bool  	chan_GA2PRNG_GG_uchar_active;
channel uchar2  chan_PRNG2GA_GG_uchar_prng;

channel bool  	chan_GA2PRNG_GG_float_active;
channel float   chan_PRNG2GA_GG_float_prng;

channel bool  	chan_GA2PRNG_LS_ushort_active;
channel ushort  chan_PRNG2GA_LS_ushort_prng;

channel bool  	chan_GA2PRNG_LS_float_active;
channel float   chan_PRNG2GA_LS_float_prng;

channel bool  	chan_GA2PRNG_LS2_float_active;
channel float   chan_PRNG2GA_LS2_float_prng;

channel bool  	chan_GA2PRNG_LS3_float_active;
channel float   chan_PRNG2GA_LS3_float_prng;

channel bool  	chan_GA2PRNG_Off_active;

// LS1, LS2, LS3
channel bool 	chan_GA2LS_LS1_active;
channel float   chan_GA2LS_LS1_energy;
channel float  	chan_GA2LS_LS1_genotype     __attribute__((depth(MAX_NUM_OF_ROTBONDS+6)));

channel bool 	chan_GA2LS_LS2_active;
channel float   chan_GA2LS_LS2_energy;
channel float  	chan_GA2LS_LS2_genotype     __attribute__((depth(MAX_NUM_OF_ROTBONDS+6)));

channel bool 	chan_GA2LS_LS3_active;
channel float   chan_GA2LS_LS3_energy;
channel float  	chan_GA2LS_LS3_genotype     __attribute__((depth(MAX_NUM_OF_ROTBONDS+6)));

channel bool    chan_GA2LS_Off_active;
channel bool    chan_GA2LS_Off2_active;
channel bool    chan_GA2LS_Off3_active;

channel uint 	chan_LS2GA_LS1_eval;
channel float   chan_LS2GA_LS1_energy;
channel float  	chan_LS2GA_LS1_genotype     __attribute__((depth(MAX_NUM_OF_ROTBONDS+6)));

channel uint 	chan_LS2GA_LS2_eval;
channel float   chan_LS2GA_LS2_energy;
channel float  	chan_LS2GA_LS2_genotype     __attribute__((depth(MAX_NUM_OF_ROTBONDS+6)));

channel uint 	chan_LS2GA_LS3_eval;
channel float   chan_LS2GA_LS3_energy;
channel float  	chan_LS2GA_LS3_genotype     __attribute__((depth(MAX_NUM_OF_ROTBONDS+6)));

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
			    float                     DockConst_crossover_rate,
			    unsigned int              DockConst_num_of_lsentities,
			    //unsigned int              DockConst_max_num_of_iters,
	                    //float                     DockConst_rho_lower_bound,
			    //float                     DockConst_base_dmov_mul_sqrt3,
			    unsigned int              DockConst_num_of_genes //,
   		            //float                     DockConst_base_dang_mul_sqrt3,
			    //unsigned int              DockConst_cons_limit
	     )
{
	//Print algorithm parameters

	#if defined (DEBUG_KRNL_GA)
	printf("\n");
	//printf("%-40s %u\n", "DockConst->num_of_atypes: ",        	DockConst_num_of_atypes);
	//printf("%-40s %u\n", "DockConst->num_of_intraE_contributors: ",DockConst_num_of_intraE_contributors);
	//printf("%-40s %u\n", "DockConst->gridsize_x: ",		DockConst_gridsize_x);
	//printf("%-40s %u\n", "DockConst->gridsize_y: ",  		DockConst_gridsize_y);
	//printf("%-40s %u\n", "DockConst->gridsize_z: ",   		DockConst_gridsize_z);
	//printf("%-40s %u\n", "DockConst->g1: ",			DockConst_g1);
	//printf("%-40s %u\n", "DockConst->g2: ",  			DockConst_g2);
	//printf("%-40s %u\n", "DockConst->g3: ",  			DockConst_g3);
	//printf("%-40s %f\n", "DockConst->grid_spacing: ", 		DockConst_grid_spacing);
	//printf("%-40s %f\n", "DockConst->coeff_elecc: ", 		DockConst_coeff_elec);
	//printf("%-40s %f\n", "DockConst->coeff_desolv: ", 		DockConst_coeff_desolv);
	printf("%-40s %u\n", "DockConst_pop_size: ",        		DockConst_pop_size);
	printf("%-40s %u\n", "DockConst_num_of_energy_evals: ",  	DockConst_num_of_energy_evals);
	printf("%-40s %u\n", "DockConst_num_of_generations: ",  	DockConst_num_of_generations);
	printf("%-40s %f\n", "DockConst_tournament_rate: ", 		DockConst_tournament_rate);
	printf("%-40s %f\n", "DockConst_mutation_rate: ", 		DockConst_mutation_rate);
	printf("%-40s +/-%fA\n", "DockConst_abs_max_dmov: ",		DockConst_abs_max_dmov);
	printf("%-40s +/-%f°\n", "DockConst_abs_max_dang: ",  		DockConst_abs_max_dang);
	printf("%-40s %f\n", "DockConst_crossover_rate: ", 		DockConst_crossover_rate);
	//printf("%-40s %f\n", "DockConst->lsearch_rate: ", 		DockConst_lsearch_rate);
	printf("%-40s %u\n", "DockConst_num_of_lsentities: ",   	DockConst_num_of_lsentities);
	printf("%-40s %u\n", "DockConst_max_num_of_iters: ",    	DockConst_max_num_of_iters);
	printf("%-40s %f\n", "DockConst_rho_lower_bound: ",     	DockConst_rho_lower_bound);
	printf("%-40s %f\n", "DockConst_base_dmov_mul_sqrt3: ", 	DockConst_base_dmov_mul_sqrt3);
	printf("%-40s %u\n", "DockConst_num_of_genes: ",        	DockConst_num_of_genes);
	printf("%-40s %f\n", "DockConst_base_dang_mul_sqrt3: ", 	DockConst_base_dang_mul_sqrt3);
	printf("%-40s %u\n", "DockConst_cons_limit: ",          	DockConst_cons_limit);
	//printf("%-40s %f\n", "DockConst->qasp: ",    			DockConst_qasp);
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

	// Find_best 	
	ushort best_entity_id;

	// Binary tournament 	
	ushort parent1, parent2; 

/*
	__local float genotype_deviate [ACTUAL_GENOTYPE_LENGTH];
	__local float genotype_bias [ACTUAL_GENOTYPE_LENGTH];  
	__local float entity_possible_new_genotype [ACTUAL_GENOTYPE_LENGTH];
*/
	
	__local ushort entity_ls[20];


	__local float LocalPopNext[MAX_POPSIZE][ACTUAL_GENOTYPE_LENGTH];
/*
	__local float __attribute__ ((numbanks(2),
				      bankwidth(16)
				    ))LocalPopNext[MAX_POPSIZE][ACTUAL_GENOTYPE_LENGTH];
*/
	__local float LocalEneNext[MAX_POPSIZE];

	while ((eval_cnt < DockConst_num_of_energy_evals) && (generation_cnt < DockConst_num_of_generations)) {

		// update energy evaluations
		eval_cnt += tmp_eval_cnt + DockConst_pop_size;

		// update generations
		generation_cnt++;

		// ------------------------------------------------------------------
		// GG: Genetic Generation
		// ------------------------------------------------------------------
		/*
		float loc_energies[MAX_POPSIZE]; 
		*/
		float __attribute__ ((
				       memory,
		   		       numbanks(1),
			               bankwidth(64),
			               singlepump,
 			               numreadports(7),
			               numwriteports(1)
			              )) loc_energies[MAX_POPSIZE];

		// copy energy to local memory
		#pragma ivdep
		for (ushort i=0; i<DockConst_pop_size; i++) {
			loc_energies[i] = LocalEneCurr[i];
		}

		// create shift register to reduce II (initially II=6) of best entity for-loop 
		float shift_reg[7];

		#pragma unroll
		for (uchar i=0; i<7; i++) {
			shift_reg[i] = 0.0f;
		}

		// identifying best entity
		ushort best_entity = 0;
		for (ushort i=1; i<DockConst_pop_size; i++) {
			shift_reg[6] = loc_energies[best_entity];

			#pragma unroll
			for (uchar j=0; j<6; j++) {
				shift_reg[j] = shift_reg[j+1];
			}
				
			if (loc_energies[i] < shift_reg[0]) {
				best_entity = i;
			}
		}

		// elitism - copying the best entity to new population 	
		#pragma ivdep
		for (uchar i=0; i<DockConst_num_of_genes; i++) { 		
			LocalPopNext[0][i & 0x3F] = LocalPopCurr[best_entity][i & 0x3F]; 	
		} 		
		LocalEneNext[0] = loc_energies[best_entity];

		for (ushort new_pop_cnt = 1; new_pop_cnt < DockConst_pop_size; new_pop_cnt++) {

			float local_entity_1 [ACTUAL_GENOTYPE_LENGTH];
			float local_entity_2 [ACTUAL_GENOTYPE_LENGTH]; 
		
			// ----------------------------------------
			// binary_tournament_selection
			// ----------------------------------------

			// get ushort binary_tournament selection prngs (parent index)
			write_channel_altera(chan_GA2PRNG_BT_ushort_active, true);
			mem_fence(CLK_CHANNEL_MEM_FENCE);
			ushort4 prng_BT_U = read_channel_altera(chan_PRNG2GA_BT_ushort_prng);

			// get float binary_tournament selection prngs (tournament rate)
			write_channel_altera(chan_GA2PRNG_BT_float_active, true);
			mem_fence(CLK_CHANNEL_MEM_FENCE);
			float4 prng_BT_F = read_channel_altera(chan_PRNG2GA_BT_float_prng);

			// first parent
			if (loc_energies[prng_BT_U.x] < loc_energies[prng_BT_U.y]) {
				if (prng_BT_F.x < DockConst_tournament_rate) {parent1 = prng_BT_U.x;}
				else				             {parent1 = prng_BT_U.y;}}
			else {
				if (prng_BT_F.y < DockConst_tournament_rate) {parent1 = prng_BT_U.y;}
				else				             {parent1 = prng_BT_U.x;}}

			// the better will be the second parent
			if (loc_energies[prng_BT_U.z] < loc_energies[prng_BT_U.w]) {
				if (prng_BT_F.z < DockConst_tournament_rate) {parent2 = prng_BT_U.z;}
				else		          	             {parent2 = prng_BT_U.w;}}
			else {
				if (prng_BT_F.w < DockConst_tournament_rate) {parent2 = prng_BT_U.w;}
				else			                     {parent2 = prng_BT_U.z;}}
			
			// local_entity_1 and local_entity_2 are population-parent1, population-parent2
			#pragma ivdep
			for (uchar i=0; i<DockConst_num_of_genes; i++) {
				local_entity_1[i] = LocalPopCurr[parent1][i & 0x3F];
				local_entity_2[i] = LocalPopCurr[parent2][i & 0x3F];
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
			write_channel_altera(chan_GA2PRNG_GG_uchar_active, true);
			mem_fence(CLK_CHANNEL_MEM_FENCE);
			uchar2 prng_GG_C = read_channel_altera(chan_PRNG2GA_GG_uchar_prng);
			
			// get float genetic_generation prngs (mutation rate)
			write_channel_altera(chan_GA2PRNG_GG_float_active, true);
			mem_fence(CLK_CHANNEL_MEM_FENCE);

			#pragma ivdep
			for (uchar i=0; i<DockConst_num_of_genes; i++) {
				prngGG[i] = read_channel_altera(chan_PRNG2GA_GG_float_prng);
			}

			uchar covr_point_low;
			uchar covr_point_high;
			bool twopoint_cross_yes = false;
			if (prng_GG_C.x == prng_GG_C.y) {covr_point_low = prng_GG_C.x;}
			else {
				twopoint_cross_yes = true;
				if (prng_GG_C.x < prng_GG_C.y) {
					covr_point_low  = prng_GG_C.x;
					covr_point_high = prng_GG_C.y;
				}
				else {		    
					covr_point_low  = prng_GG_C.y;
					covr_point_high = prng_GG_C.x;
				}
			}
			
			float __attribute__ ((
			      		       memory,
			                       numbanks(1),
			                       bankwidth(16),
			                       singlepump,
			                       numreadports(2), //3
			                       numwriteports(1)
			                    )) GGoffspring [ACTUAL_GENOTYPE_LENGTH]; 

			// performing crossover
			bool crossover_yes = (DockConst_crossover_rate > prngGG[ACTUAL_GENOTYPE_LENGTH-1]);

			#pragma ivdep	
			for (uchar i=0; i<DockConst_num_of_genes; i++) {
				if (   	(
					crossover_yes && (										// crossover
					( (twopoint_cross_yes == true)  && ((i <= covr_point_low) || (i > covr_point_high)) )  ||	// two-point crossover 			 		
					( (twopoint_cross_yes == false) && (i <= covr_point_low))  					// one-point crossover
					)) || 
					(!crossover_yes)	// no crossover
				   ) {
					GGoffspring[i] = local_entity_1[i];
				}
				else {
					GGoffspring[i] = local_entity_2[i];
				}
			}

			// performing mutation
			const float two_absmaxdmov = 2.0f * DockConst_abs_max_dmov;
			const float two_absmaxdang = 2.0f * DockConst_abs_max_dang;


			for (uchar i=0; i<DockConst_num_of_genes; i++) {
				//float tmp_offspring;
				if (DockConst_mutation_rate > prngGG[i]) {
					if(i<3) {
						GGoffspring[i]/*tmp_offspring*/ = GGoffspring[i] + two_absmaxdmov*prngGG[i]-DockConst_abs_max_dmov;
					}
					else {
						float tmp;
						tmp = GGoffspring[i] + two_absmaxdang*prngGG[i]-DockConst_abs_max_dang;
						if (i==4) {
							GGoffspring[i] /*tmp_offspring*/ = map_angle_180(tmp);
						}
						else {
							GGoffspring[i] /*tmp_offspring*/ = map_angle_360(tmp);
						}
					}
				}
			}

			// calculate energy
			#pragma ivdep
			for (uchar pipe_cnt=0; pipe_cnt<DockConst_num_of_genes; pipe_cnt++) {
				LocalPopNext [new_pop_cnt][pipe_cnt & 0x3F] = GGoffspring [pipe_cnt];
				write_channel_altera(chan_GG2Conf_genotype, GGoffspring[pipe_cnt]);
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
		/*
		// update energy-evaluation count
		eval_cnt += DockConst_pop_size;
		*/

		// choose all random entities
		// without checking if it has already been subjected to LS in this cycle 
		write_channel_altera(chan_GA2PRNG_LS_ushort_active, true);
		mem_fence(CLK_CHANNEL_MEM_FENCE);

		#pragma ivdep
		for(uchar i=0; i<DockConst_num_of_lsentities; i++) {
			entity_ls [i] = read_channel_altera(chan_PRNG2GA_LS_ushort_prng);
/*
printf("LS entities idx: %u\n", entity_ls [i]);
*/
		}
		

		// ------------------------------------------------------------------
		// LS: Local Search
		// ------------------------------------------------------------------
		tmp_eval_cnt = 0;


		// subject num_of_entity_for_ls pieces of offsprings to LS 	
/*
		for (ushort ls_ent_cnt=0; ls_ent_cnt<DockConst_num_of_lsentities; ls_ent_cnt++) {
*/

		//#pragma ivdep
		//for (ushort ls_ent_cnt=0; ls_ent_cnt<DockConst_num_of_lsentities; ls_ent_cnt+=2) {
		for (ushort ls_ent_cnt=0; ls_ent_cnt<DockConst_num_of_lsentities; ls_ent_cnt+=3) {

			// LS1
			// LS2
			// LS3
			write_channel_altera(chan_GA2LS_LS1_active, true);
			write_channel_altera(chan_GA2LS_LS2_active, true);
			write_channel_altera(chan_GA2LS_LS3_active, true);
			mem_fence(CLK_CHANNEL_MEM_FENCE);

			write_channel_altera(chan_GA2LS_LS1_energy, LocalEneNext[entity_ls[ls_ent_cnt]]);
			write_channel_altera(chan_GA2LS_LS2_energy, LocalEneNext[entity_ls[ls_ent_cnt+1]]);
			write_channel_altera(chan_GA2LS_LS3_energy, LocalEneNext[entity_ls[ls_ent_cnt+2]]);
			mem_fence(CLK_CHANNEL_MEM_FENCE);

			#pragma ivdep
			for (uchar i=0; i<DockConst_num_of_genes; i++) {
				write_channel_altera(chan_GA2LS_LS1_genotype, LocalPopNext[entity_ls[ls_ent_cnt]][i & 0x3F]);
				write_channel_altera(chan_GA2LS_LS2_genotype, LocalPopNext[entity_ls[ls_ent_cnt+1]][i & 0x3F]);
				write_channel_altera(chan_GA2LS_LS3_genotype, LocalPopNext[entity_ls[ls_ent_cnt+2]][i & 0x3F]);
			}
			mem_fence(CLK_CHANNEL_MEM_FENCE);

			// LS1
			// LS2
			// LS3
			uint eval_tmp1 = read_channel_altera(chan_LS2GA_LS1_eval);
			uint eval_tmp2 = read_channel_altera(chan_LS2GA_LS2_eval);
			uint eval_tmp3 = read_channel_altera(chan_LS2GA_LS3_eval);
//printf("Got all LS eval\n");
			mem_fence(CLK_CHANNEL_MEM_FENCE);
	
			uint LS_eval = eval_tmp1 + eval_tmp2 + eval_tmp3;
			
			LocalEneNext[entity_ls[ls_ent_cnt]] = read_channel_altera(chan_LS2GA_LS1_energy);	
			LocalEneNext[entity_ls[ls_ent_cnt+1]] = read_channel_altera(chan_LS2GA_LS2_energy);
			LocalEneNext[entity_ls[ls_ent_cnt+2]] = read_channel_altera(chan_LS2GA_LS3_energy);
//printf("Got all LS ener\n");
			mem_fence(CLK_CHANNEL_MEM_FENCE);

			#pragma ivdep
			for (uchar i=0; i<DockConst_num_of_genes; i++) {
				LocalPopNext[entity_ls[ls_ent_cnt]][i & 0x3F]   = read_channel_altera(chan_LS2GA_LS1_genotype);
				LocalPopNext[entity_ls[ls_ent_cnt+1]][i & 0x3F] = read_channel_altera(chan_LS2GA_LS2_genotype);
				LocalPopNext[entity_ls[ls_ent_cnt+2]][i & 0x3F] = read_channel_altera(chan_LS2GA_LS3_genotype);
			}
			mem_fence(CLK_CHANNEL_MEM_FENCE);
//printf("Got all LS geno\n");
			tmp_eval_cnt += LS_eval;
		} // End of for-loop ls_ent_cnt
		// ------------------------------------------------------------------



		// update current pops & energies
		#pragma ivdep
		for (ushort pop_cnt=0;pop_cnt<DockConst_pop_size; pop_cnt++) { 	

			#pragma ivdep
			for (uchar i=0; i<DockConst_num_of_genes; i++) {
				LocalPopCurr[pop_cnt][i & 0x3F] = LocalPopNext[pop_cnt][i & 0x3F];
			}

			LocalEneCurr[pop_cnt] = LocalEneNext[pop_cnt];
		}



		#if defined (DEBUG_KRNL_GA)
		printf("eval_cnt: %u, generation_cnt: %u\n", eval_cnt, generation_cnt);
		#endif
			
	} // End while eval_cnt & generation_cnt

	// ------------------------------------------------------------------
	// Off: turn off Conform, InterE, IntraE
	// ------------------------------------------------------------------
	write_channel_altera(chan_GA2LS_Off_active, false);	// turn off LS_Arbiter, LS
	write_channel_altera(chan_GA2LS_Off2_active, false);	// turn off LS2_Arbiter, LS2 
	write_channel_altera(chan_GA2LS_Off3_active, false);	// turn off LS3_Arbiter, LS3 
	write_channel_altera(chan_GA2PRNG_Off_active, false);	// turn off all PRNGs kernels
	write_channel_altera(chan_Off2Conf_active, false);	// turn off Conform, InterE, IntraE

	write_channel_altera(chan_ConfArbiter_Off, false);      // turn off Krnl_Conf_Arbiter,Conform2, InterE2, IntraE2
	
	

	//mem_fence(CLK_CHANNEL_MEM_FENCE);
	#pragma ivdep	
	for (ushort pop_cnt=0;pop_cnt<DockConst_pop_size; pop_cnt++) { 	
		#pragma ivdep
		for (uchar i=0; i<DockConst_num_of_genes; i++) {
			GlobPopulationCurrent[pop_cnt*ACTUAL_GENOTYPE_LENGTH + i] = LocalPopCurr[pop_cnt][i & 0x3F];
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

#include "Krnl_LS.cl"
#include "Krnl_Conform.cl"
#include "Krnl_InterE.cl"
#include "Krnl_IntraE.cl"

#include "Krnl_LS2.cl"
#include "Krnl_LS3.cl"
#include "Krnl_Conform2.cl"
#include "Krnl_InterE2.cl"
#include "Krnl_IntraE2.cl"


