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
// mode 1 for I: init calculation energy, 2 for G: genetic generation, 3 for L: local search, 4 for O: off
// cnt: population count


#include "../defines.h"

channel char  	chan_IC2Conf_active;
channel float  	chan_IC2Conf_genotype __attribute__((depth(MAX_NUM_OF_ROTBONDS+6)));

channel char  	chan_GG2Conf_active;
channel float  	chan_GG2Conf_genotype __attribute__((depth(MAX_NUM_OF_ROTBONDS+6)));

channel char  	chan_LS2Conf_active;
channel float  	chan_LS2Conf_genotype __attribute__((depth(MAX_NUM_OF_ROTBONDS+6)));

// To turn off Conform, InterE, IntraE
channel char  	chan_Off2Conf_active;
channel float  	chan_Off2Conf_genotype __attribute__((depth(MAX_NUM_OF_ROTBONDS+6)));

channel float3  chan_Conf2Intere_xyz __attribute__((depth(MAX_NUM_OF_ATOMS)));
channel char  	chan_Conf2Intere_active;
channel char  	chan_Conf2Intere_mode;

channel float3 	chan_Conf2Intrae_xyz __attribute__((depth(MAX_NUM_OF_ATOMS)));
channel char  	chan_Conf2Intrae_active;	
channel char  	chan_Conf2Intrae_mode;	

channel float 	chan_Intere2StoreIC_intere __attribute__((depth(MAX_POPSIZE)));
channel float 	chan_Intere2StoreGG_intere __attribute__((depth(MAX_POPSIZE)));
channel float 	chan_Intere2StoreLS_intere;
channel float 	chan_Intere2StoreOff_intere;

channel float 	chan_Intrae2StoreIC_intrae __attribute__((depth(MAX_POPSIZE)));
channel float 	chan_Intrae2StoreGG_intrae __attribute__((depth(MAX_POPSIZE)));
channel float 	chan_Intrae2StoreLS_intrae;
channel float 	chan_Intrae2StoreOff_intrae;

// Next structures were copied from calcenergy.h
/*
typedef struct
{
	unsigned char  	num_of_atoms;
	unsigned char   num_of_atypes;
	unsigned int    num_of_intraE_contributors;
	unsigned char   gridsize_x;
	unsigned char   gridsize_y;
	unsigned char   gridsize_z;
	unsigned char	g1;
	unsigned int	g2;
	unsigned int 	g3;
	float  		grid_spacing;
	unsigned int    rotbondlist_length;
	float  		coeff_elec;
	float  		coeff_desolv;
	unsigned int    num_of_energy_evals;
	unsigned int    num_of_generations;
	unsigned int 	pop_size;
	unsigned int	num_of_genes;
	float  		tournament_rate;
	float  		crossover_rate;
	float  		mutation_rate;
	float  		abs_max_dmov;
	float  		abs_max_dang;
	float  		lsearch_rate;
	unsigned int 	num_of_lsentities;
	float  		rho_lower_bound;
	float  		base_dmov_mul_sqrt3;
	float  		base_dang_mul_sqrt3;
	unsigned int 	cons_limit;
	unsigned int 	max_num_of_iters;
	float  		qasp;
} Dockparameters;
*/

// Constant structs
typedef struct
{
       float atom_charges_const[MAX_NUM_OF_ATOMS];
       char  atom_types_const  [MAX_NUM_OF_ATOMS];
       char  intraE_contributors_const[3*MAX_INTRAE_CONTRIBUTORS];
       float VWpars_AC_const   [MAX_NUM_OF_ATYPES*MAX_NUM_OF_ATYPES];
       float VWpars_BD_const   [MAX_NUM_OF_ATYPES*MAX_NUM_OF_ATYPES];
       float dspars_S_const    [MAX_NUM_OF_ATYPES];
       float dspars_V_const    [MAX_NUM_OF_ATYPES];
       int   rotlist_const     [MAX_NUM_OF_ROTATIONS];
} kernelconstant_static;

typedef struct
{
       float ref_coords_x_const[MAX_NUM_OF_ATOMS];
       float ref_coords_y_const[MAX_NUM_OF_ATOMS];
       float ref_coords_z_const[MAX_NUM_OF_ATOMS];
       float rotbonds_moving_vectors_const[3*MAX_NUM_OF_ROTBONDS];
       float rotbonds_unit_vectors_const  [3*MAX_NUM_OF_ROTBONDS];
       float ref_orientation_quats_const  [4];
} kernelconstant_dynamic;

#include "auxiliary_genetic.cl"

// --------------------------------------------------------------------------
// The function performs a generational genetic algorithm based search 
// on the search space.
// Originally from: searchoptimum.c
// --------------------------------------------------------------------------
__kernel __attribute__ ((max_global_work_dim(0)))
void Krnl_GA(__global       float*           restrict GlobPopulationCurrent,
	     __global       float*           restrict GlobEnergyCurrent,
	     __global 	    float*           restrict GlobPopulationNext,
	     __global       float*           restrict GlobEnergyNext,
/*
             __global       unsigned int*    restrict GlobPRNG,	
*/
	                    unsigned int              GlobPRNG,
			    unsigned int              GlobPRNG1,
			    unsigned int              GlobPRNG2,
 		            unsigned int              GlobPRNG3,
			    unsigned int              GlobPRNG4,
 		            unsigned int              GlobPRNG5,

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
			    unsigned int              DockConst_max_num_of_iters,
	                    float                     DockConst_rho_lower_bound,
			    float                     DockConst_base_dmov_mul_sqrt3,
			    unsigned int              DockConst_num_of_genes,
   		            float                     DockConst_base_dang_mul_sqrt3,
			    unsigned int              DockConst_cons_limit
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
	uint generation_cnt = 1;

	char active = 1;

	// ------------------------------------------------------------------
	// IC: Init Calculation
	// ------------------------------------------------------------------
	__local float energyIE_ICGG_rx [MAX_POPSIZE];
	__local float energyIA_ICGG_rx [MAX_POPSIZE];

	for (ushort pop_cnt = 0; pop_cnt < DockConst_pop_size; pop_cnt++) {
		write_channel_altera(chan_IC2Conf_active, active);
		mem_fence(CLK_CHANNEL_MEM_FENCE);

		for (uchar pipe_cnt=0; pipe_cnt<DockConst_num_of_genes; pipe_cnt++) {
			write_channel_altera(chan_IC2Conf_genotype, GlobPopulationCurrent[pop_cnt*ACTUAL_GENOTYPE_LENGTH + pipe_cnt]);
		}
			
		#if defined (DEBUG_KRNL_IC)
		printf("\nIC - tx pop: %u", pop_cnt); 		
		#endif
	} // End of IC tx for-loop pop_cnt	

	for (ushort pop_cnt = 0; pop_cnt < DockConst_pop_size; pop_cnt++) {
		energyIA_ICGG_rx[pop_cnt] = read_channel_altera(chan_Intrae2StoreIC_intrae);
		energyIE_ICGG_rx[pop_cnt] = read_channel_altera(chan_Intere2StoreIC_intere);
		// Store energies to Current-Energies
		GlobEnergyCurrent[pop_cnt] = energyIA_ICGG_rx[pop_cnt] + energyIE_ICGG_rx[pop_cnt];

		#if defined (DEBUG_KRNL_IC)
		printf(", IC - rx pop: %u\n", pop_cnt-1); 		
		#endif
	} // End of IC rx for-loop pop_cnt	

/*
	// Store energies to Current-Energies
	for (ushort pop_cnt = 0; pop_cnt < DockConst_pop_size; pop_cnt++) {
		GlobEnergyCurrent[pop_cnt] = energyIA_ICGG_rx[pop_cnt] + energyIE_ICGG_rx[pop_cnt];
	}
*/
	// ------------------------------------------------------------------


	uint array_evals_and_generations_performed [2];

	// ---------------------------
	// Temporal storage for GG
	// ---------------------------
	// Find_best 	
	uint best_entity_id; 	
/*	
	__local float loc_energies[MAX_POPSIZE]; 

*/
	__local float loc_energies1[MAX_POPSIZE]; 
	__local float loc_energies2[MAX_POPSIZE]; 

	// Binary tournament 	
	uint parent1, parent2; 
	float __attribute__ ((
			      memory,
			      numbanks(1),
			      bankwidth(64),
			      singlepump,
			      numreadports(3),
			      numwriteports(1)
			    )) local_entity_1 [ACTUAL_GENOTYPE_LENGTH]; 	
	float __attribute__ ((
			      memory,
			      numbanks(1),
			      bankwidth(64),
			      singlepump,
			      numreadports(3),
			      numwriteports(1)
			     )) local_entity_2 [ACTUAL_GENOTYPE_LENGTH];	

	// Offspring
	__local float offspring_genotype [ACTUAL_GENOTYPE_LENGTH]; 

	// ---------------------------
	// Temporal storage for LS
	// ---------------------------

	// read GlobPRNG
	// GG: 0 - 2
	// LS: 3 - 5
	uint prng  = GlobPRNG;
	uint prng1 = GlobPRNG1;
	uint prng2 = GlobPRNG2;
	uint prng3 = GlobPRNG3;
	uint prng4 = GlobPRNG4;
	uint prng5 = GlobPRNG5;

/*
	// prng distribution
	uint prng[20];
	for (uint prng_cnt = 0; prng_cnt < 20; prng_cnt++) {
		prng[prng_cnt] = GlobPRNG[prng_cnt];
	}
*/
	while ((eval_cnt < DockConst_num_of_energy_evals) && (generation_cnt < DockConst_num_of_generations)) {

		// ------------------------------------------------------------------
		// GG: Genetic Generation
		// ------------------------------------------------------------------
		active = 1;
	
		// copy energy to local memory
		for (ushort i=0; i<DockConst_pop_size; i++) {
			loc_energies1[i] = GlobEnergyCurrent[i];
			/*loc_energies2[i] = GlobEnergyCurrent[i];*/
			loc_energies2[i] = loc_energies1[i];
		}

		// identifying best entity 		
		best_entity_id = find_best(loc_energies1, loc_energies2, DockConst_pop_size);


		// elitism - copying the best entity to new population 		
		for (uchar i=0; i<DockConst_num_of_genes; i++) { 		
			GlobPopulationNext[i] = GlobPopulationCurrent[best_entity_id*ACTUAL_GENOTYPE_LENGTH+i]; 		
		} 		
		GlobEnergyNext[0] = loc_energies1[best_entity_id];

		for (ushort new_pop_cnt = 1; new_pop_cnt < DockConst_pop_size; new_pop_cnt++) {
			//selecting two individuals randomly 			
			binary_tournament_selection(
						    &prng,
						    loc_energies1,
						    loc_energies2,
						    &parent1,
						    &parent2,			    
				                    DockConst_pop_size,
						    DockConst_tournament_rate);

			//mating parents	
			for (uchar i=0; i<DockConst_num_of_genes; i++) {
				local_entity_1[i] = GlobPopulationCurrent[parent1*ACTUAL_GENOTYPE_LENGTH+i];
				local_entity_2[i] = GlobPopulationCurrent[parent2*ACTUAL_GENOTYPE_LENGTH+i];
			}

			// first two args are population [parent1], population [parent2] 		
			gen_new_genotype(
					 &prng1,
					 &prng2,
					 local_entity_1, 
					 local_entity_2,
					 DockConst_num_of_genes,				 
			 		 DockConst_mutation_rate, 
					 DockConst_abs_max_dmov, 
				         DockConst_abs_max_dang,			 
				         DockConst_crossover_rate, 
				         offspring_genotype);

			write_channel_altera(chan_GG2Conf_active, active);
			mem_fence(CLK_CHANNEL_MEM_FENCE);


			for (uchar pipe_cnt=0; pipe_cnt<DockConst_num_of_genes; pipe_cnt++) {
				GlobPopulationNext [new_pop_cnt*ACTUAL_GENOTYPE_LENGTH + pipe_cnt] = offspring_genotype [pipe_cnt];
				write_channel_altera(chan_GG2Conf_genotype, offspring_genotype[pipe_cnt]);
			}

/*
			for (uchar pipe_cnt=0; pipe_cnt<DockConst_num_of_genes; pipe_cnt++) {
				write_channel_altera(chan_GG2Conf_genotype, offspring_genotype[pipe_cnt]);
			}
	
			for (uchar pipe_cnt=0; pipe_cnt<DockConst_num_of_genes; pipe_cnt++) {
				GlobPopulationNext [new_pop_cnt*ACTUAL_GENOTYPE_LENGTH + pipe_cnt] = offspring_genotype [pipe_cnt];
			}
*/

			#if defined (DEBUG_KRNL_GG)
			printf("GG - tx pop: %u", new_pop_cnt); 		
			#endif	
		} // End of GG tx for-loop new_pop_cnt

		for (ushort new_pop_cnt = 1; new_pop_cnt < DockConst_pop_size; new_pop_cnt++) {
			energyIA_ICGG_rx[new_pop_cnt] = read_channel_altera(chan_Intrae2StoreGG_intrae);
			energyIE_ICGG_rx[new_pop_cnt] = read_channel_altera(chan_Intere2StoreGG_intere);

			#if defined (DEBUG_KRNL_GG)
			printf(", GG - rx pop: %u\n", new_pop_cnt-1); 		
			#endif
		} // End of GG rx for-loop new_pop_cnt

		// store energies to Next-Energies
		for (ushort pop_cnt = 1; pop_cnt < DockConst_pop_size; pop_cnt++) {
			GlobEnergyNext[pop_cnt] = energyIA_ICGG_rx[pop_cnt] + energyIE_ICGG_rx[pop_cnt];
		}
		// ------------------------------------------------------------------

		// update energy-evaluation count
		eval_cnt += DockConst_pop_size;

		// ------------------------------------------------------------------
		// LS: Local Search
		// ------------------------------------------------------------------
		active = 1;

		//__local float entity_possible_new_genotype [ACTUAL_GENOTYPE_LENGTH]; 
		float entity_possible_new_genotype [ACTUAL_GENOTYPE_LENGTH]; 
		float genotype_deviate  [ACTUAL_GENOTYPE_LENGTH];
		float genotype_bias     [ACTUAL_GENOTYPE_LENGTH];

		float rho = 1.0f;
		uint iteration_cnt = 0;
		uint cons_succ = 0;
		uint cons_fail = 0;	
		
		bool positive_direction = true;
		bool ls_pass_complete = false;

		// subject num_of_entity_for_ls pieces of offsprings to LS 		
		for (ushort ls_ent_cnt=0; ls_ent_cnt<DockConst_num_of_lsentities; ls_ent_cnt++) {

			// choosing an entity randomly, 			
			// and without checking if it has already been subjected to LS in this cycle 			
			uint entity_for_ls = myrand_uint(
							 &prng3, 
						         DockConst_pop_size);

			// performing local search
			for (uchar i=0; i<DockConst_num_of_genes; i++) {
				offspring_genotype [i] = GlobPopulationNext[entity_for_ls*ACTUAL_GENOTYPE_LENGTH + i];
				genotype_bias [i] = 0.0f;
			}

			// read energy
			float offspring_energy = GlobEnergyNext[entity_for_ls];

			positive_direction = true;
			ls_pass_complete = true;

			uint LS_eval = 0;
			//------------------------------------------------------------------------------------------------------------
			while ((iteration_cnt < DockConst_max_num_of_iters) && (rho > DockConst_rho_lower_bound)) {
				//new random deviate
				//rho is the deviation of the uniform distribution

				for (uchar i=0; i<3; i++) {
					genotype_deviate [i] = rho*DockConst_base_dmov_mul_sqrt3*(2*myrand(&prng4)-1);
				}
				for (uchar i=3; i<DockConst_num_of_genes; i++) {
					genotype_deviate [i] = rho*DockConst_base_dang_mul_sqrt3*(2*myrand(&prng5)-1);
				}

				// define genotype values depending on descent direction
				if (positive_direction == true) {
					for (uchar i=0; i<DockConst_num_of_genes; i++) {
						entity_possible_new_genotype[i] = offspring_genotype[i] + genotype_deviate[i] + genotype_bias[i];  
					}
				}
				else {
					for (uchar i=0; i<DockConst_num_of_genes; i++) {
						entity_possible_new_genotype[i] = offspring_genotype[i] - genotype_deviate[i] - genotype_bias[i];
					}
				}

				entity_possible_new_genotype [3] = map_angle_360(entity_possible_new_genotype [3]);
				entity_possible_new_genotype [4] = map_angle_180(entity_possible_new_genotype [4]);

				for (uchar i=5; i<DockConst_num_of_genes; i++) {
					entity_possible_new_genotype [i] = map_angle_360(entity_possible_new_genotype [i]);
				}


				// calculate energy of genotype
				write_channel_altera(chan_LS2Conf_active, active);
				mem_fence(CLK_CHANNEL_MEM_FENCE);

				for (uchar pipe_cnt=0; pipe_cnt<DockConst_num_of_genes; pipe_cnt++) {
					write_channel_altera(chan_LS2Conf_genotype, entity_possible_new_genotype[pipe_cnt]);
				}
				mem_fence(CLK_CHANNEL_MEM_FENCE);

				float energyIA_LS_rx = read_channel_altera(chan_Intrae2StoreLS_intrae);
				float energyIE_LS_rx = read_channel_altera(chan_Intere2StoreLS_intere);
				float candidate_energy = energyIA_LS_rx + energyIE_LS_rx;

				// update LS energy-evaluation count
				LS_eval++;
				
				// if the new entity is better
				if (candidate_energy < offspring_energy)
				{
					// temporal 
					float g_bias_tmp     [ACTUAL_GENOTYPE_LENGTH];
					float g_deviate_tmp  [ACTUAL_GENOTYPE_LENGTH];

					// updating offspring_genotype
					for (uchar i=0; i<DockConst_num_of_genes; i++) {
						offspring_genotype [i] = entity_possible_new_genotype [i];
						g_bias_tmp [i] = 0.6f * genotype_bias [i];
						g_deviate_tmp [i] = 0.4f * genotype_deviate [i];
					}

					// updating genotype_bias
					if (positive_direction == true) { 
						for (uchar i=0; i<DockConst_num_of_genes; i++) {
							genotype_bias [i] = g_bias_tmp [i] + g_deviate_tmp [i];
						}
					}
					else {
						for (uchar i=0; i<DockConst_num_of_genes; i++) {
							genotype_bias [i] = g_bias_tmp [i] - g_deviate_tmp [i];
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
						for (uchar i=0; i<DockConst_num_of_genes; i++) {
							genotype_bias [i] = 0.5f*genotype_bias [i];
						}

						cons_fail++;
						cons_succ = 0;
					}
				}

				if (ls_pass_complete == true) { 
					//Changing deviation (rho), if needed
					if (cons_succ >= DockConst_cons_limit) {
						//this limitation is necessary in the FPGA due to the number representation
						//if ((rho*DockConst_base_dang_mul_sqrt3 < 90) && (rho*DockConst_base_dmov_mul_sqrt3 < 64)) {
						rho = LS_EXP_FACTOR*rho;
					//}
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

			} // end of while (iteration_cnt)
			//------------------------------------------------------------------------------------------------------------

			rho = 1.0f;
			iteration_cnt = 0;

			// store pops & energies to Next
			for (uchar i=0; i<DockConst_num_of_genes; i++) {
				GlobPopulationNext[entity_for_ls*ACTUAL_GENOTYPE_LENGTH + i] = offspring_genotype [i];
			}
			GlobEnergyNext[entity_for_ls] = offspring_energy;

			eval_cnt += LS_eval;
		} // End of for-loop ls_ent_cnt

		// ------------------------------------------------------------------

		// update generations
		generation_cnt++;
		
		// update current pops & energies
		for (ushort i=0;i<DockConst_pop_size*ACTUAL_GENOTYPE_LENGTH; i++) { 	
			GlobPopulationCurrent[i] = GlobPopulationNext[i];
			if (i<DockConst_pop_size) {
				GlobEnergyCurrent[i] = GlobEnergyNext[i];
			}
		}

		#if defined (DEBUG_KRNL_GA)
		printf("eval_cnt: %u, generation_cnt: %u\n", eval_cnt, generation_cnt);
		#endif
			
	} // End while eval_cnt & generation_cnt

	// ------------------------------------------------------------------
	// Off: turn off Conform, InterE, IntraE
	// ------------------------------------------------------------------
	active = 0;

	write_channel_altera(chan_Off2Conf_active, active);
	mem_fence(CLK_CHANNEL_MEM_FENCE);

	for (uchar pipe_cnt=0; pipe_cnt<DockConst_num_of_genes; pipe_cnt++) {
		write_channel_altera(chan_Off2Conf_genotype, 0);
	}
	
	#if defined (DEBUG_KRNL_GA)
	printf("GA: %u %u\n", active, DockConst_pop_size -1);
	#endif

	// read latest energies but do not use them
	float energyIA_LS_rx_dummy = read_channel_altera(chan_Intrae2StoreOff_intrae);
	float energyIE_LS_rx_dummy = read_channel_altera(chan_Intere2StoreOff_intere);

	#if defined (DEBUG_ACTIVE_KERNEL)
	printf("	%-20s: %s\n", "Krnl_GA", "disabled");
	#endif

	array_evals_and_generations_performed [0] = eval_cnt;
	array_evals_and_generations_performed [1] = generation_cnt;
	
	//#pragma unroll 1
	for (uchar i=0; i<2; i++) {
		GlobEvalsGenerations_performed[i] = array_evals_and_generations_performed [i];
	}
}

// --------------------------------------------------------------------------
// --------------------------------------------------------------------------

#include "Krnl_Conform.cl"
#include "Krnl_InterE.cl"
#include "Krnl_IntraE.cl"
