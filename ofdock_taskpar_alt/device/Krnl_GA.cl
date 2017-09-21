// Enable the channels extension
#pragma OPENCL EXTENSION cl_altera_channels : enable

//IC: initial calculation of energy of populations
//GG: genetic generation 
//LS: pos local search
//LS: neg local search
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
/*
channel bool  	chan_IC2Conf_active;
*/
channel float  	chan_IC2Conf_genotype     __attribute__((depth(MAX_NUM_OF_ROTBONDS+6)));

/*
channel bool  	chan_GG2Conf_active;
*/
channel float  	chan_GG2Conf_genotype     __attribute__((depth(MAX_NUM_OF_ROTBONDS+6)));

/*
channel bool  	chan_LS2Conf_active;
*/
channel float  	chan_LS2Conf_genotype     __attribute__((depth(MAX_NUM_OF_ROTBONDS+6)));

// To turn off Conform, InterE, IntraE
channel bool  	chan_Off2Conf_active;

channel float3  chan_Conf2Intere_xyz      __attribute__((depth(MAX_NUM_OF_ATOMS)));
channel bool  	chan_Conf2Intere_active;
channel char  	chan_Conf2Intere_mode;

channel float3 	chan_Conf2Intrae_xyz      __attribute__((depth(MAX_NUM_OF_ATOMS)));
channel bool  	chan_Conf2Intrae_active;
channel char  	chan_Conf2Intrae_mode;	

channel float 	chan_Intere2StoreIC_intere __attribute__((depth(MAX_POPSIZE)));
channel float 	chan_Intere2StoreGG_intere __attribute__((depth(MAX_POPSIZE)));
channel float 	chan_Intere2StoreLS_intere __attribute__((depth(20)));	// it requires 6% MAX_POPSIZE

channel float 	chan_Intrae2StoreIC_intrae __attribute__((depth(MAX_POPSIZE)));
channel float 	chan_Intrae2StoreGG_intrae __attribute__((depth(MAX_POPSIZE)));
channel float 	chan_Intrae2StoreLS_intrae __attribute__((depth(20)));	// it requires 6% MAX_POPSIZE

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

channel bool  	chan_GA2PRNG_Off_active;










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
/*	                    unsigned int              GlobPRNG,
			    unsigned int              GlobPRNG1,
			    unsigned int              GlobPRNG2,
 		            unsigned int              GlobPRNG3,
			    unsigned int              GlobPRNG4,
 		            unsigned int              GlobPRNG5,
*/

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
	uint tmp_eval_cnt = 0;
	uint generation_cnt = 0;

	// ------------------------------------------------------------------
	// IC: Init Calculation
	// ------------------------------------------------------------------
	for (ushort pop_cnt = 0; pop_cnt < DockConst_pop_size; pop_cnt++) {
/*
		write_channel_altera(chan_IC2Conf_active, true);
		mem_fence(CLK_CHANNEL_MEM_FENCE);
*/
		for (uchar pipe_cnt=0; pipe_cnt<DockConst_num_of_genes; pipe_cnt++) {
			write_channel_altera(chan_IC2Conf_genotype, GlobPopulationCurrent[pop_cnt*ACTUAL_GENOTYPE_LENGTH + pipe_cnt]);
		}
			
		#if defined (DEBUG_KRNL_IC)
		printf("\nIC - tx pop: %u", pop_cnt); 		
		#endif
	} // End of IC tx for-loop pop_cnt	

	for (ushort pop_cnt = 0; pop_cnt < DockConst_pop_size; pop_cnt++) {
		float energyIA_IC_rx = read_channel_altera(chan_Intrae2StoreIC_intrae);
		float energyIE_IC_rx = read_channel_altera(chan_Intere2StoreIC_intere);
		// Store energies to Current-Energies
		GlobEnergyCurrent[pop_cnt] = energyIA_IC_rx + energyIE_IC_rx;

		#if defined (DEBUG_KRNL_IC)
		printf(", IC - rx pop: %u\n", pop_cnt-1); 		
		#endif
	} // End of IC rx for-loop pop_cnt	
	// ------------------------------------------------------------------

	// Find_best 	
	ushort best_entity_id;

	// Binary tournament 	
	ushort parent1, parent2; 


	/*
	float __attribute__ ((
			      memory,
			      numbanks(16),
			      bankwidth(256),
			      singlepump,
			      numreadports(2),
			      numwriteports(1)
			    )) popNext[MAX_POPSIZE][ACTUAL_GENOTYPE_LENGTH];
*/

	//__local float offspring_genotype [ACTUAL_GENOTYPE_LENGTH]; 
/*	
	__local float loc_energies[MAX_POPSIZE];
*/

/*
	__local uint prngLS0[ACTUAL_GENOTYPE_LENGTH];
	for (uchar i=0; i<ACTUAL_GENOTYPE_LENGTH; i++){
		prngLS0[i] = GlobPRNG1 + i;
	}
*/
	//__local float prngGG[ACTUAL_GENOTYPE_LENGTH];


	//__local float prngLS[ACTUAL_GENOTYPE_LENGTH];

/*
	__local ushort rand_ls_entities[16]; 
*/

	__local float genotype_deviate [ACTUAL_GENOTYPE_LENGTH];
	__local float genotype_bias [ACTUAL_GENOTYPE_LENGTH];  
	__local float entity_possible_new_genotype [ACTUAL_GENOTYPE_LENGTH];

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

/*
		// copy energy to local memory
		for (ushort i=0; i<DockConst_pop_size; i++) {
			loc_energies[i] = GlobEnergyCurrent[i];
		}

		// identifying best entity
		ushort best_entity = 0;
		for (ushort i=1; i<DockConst_pop_size; i++) {
			if (loc_energies[i] < loc_energies[best_entity]) {
				best_entity = i;
			}
		}
*/






#if 1
		// copy energy to local memory
		for (ushort i=0; i<DockConst_pop_size; i++) {
			loc_energies[i] = GlobEnergyCurrent[i];
		}

		float shift_reg[7];
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
#endif	







		// elitism - copying the best entity to new population 	
		for (uchar i=0; i<DockConst_num_of_genes; i++) { 		
			GlobPopulationNext[i] = GlobPopulationCurrent[best_entity*ACTUAL_GENOTYPE_LENGTH+i]; 		
		} 		
		GlobEnergyNext[0] = loc_energies[best_entity];

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
			for (uchar i=0; i<DockConst_num_of_genes; i++) {
				local_entity_1[i] = GlobPopulationCurrent [parent1*ACTUAL_GENOTYPE_LENGTH+i];
				local_entity_2[i] = GlobPopulationCurrent [parent2*ACTUAL_GENOTYPE_LENGTH+i];
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
//				GlobPopulationNext [new_pop_cnt*ACTUAL_GENOTYPE_LENGTH + i] = /*GGoffspring [i]*/tmp_offspring;
//				write_channel_altera(chan_GG2Conf_genotype, /*GGoffspring[i]*/tmp_offspring);
			}






			// calculate energy
/*
			write_channel_altera(chan_GG2Conf_active, true);
			mem_fence(CLK_CHANNEL_MEM_FENCE);
*/


			for (uchar pipe_cnt=0; pipe_cnt<DockConst_num_of_genes; pipe_cnt++) {
				GlobPopulationNext [new_pop_cnt*ACTUAL_GENOTYPE_LENGTH + pipe_cnt] = GGoffspring [pipe_cnt];
				write_channel_altera(chan_GG2Conf_genotype, GGoffspring[pipe_cnt]);
			}




			#if defined (DEBUG_KRNL_GG)
			printf("GG - tx pop: %u", new_pop_cnt); 		
			#endif	
		} // End of GG tx for-loop new_pop_cnt

		for (ushort new_pop_cnt = 1; new_pop_cnt < DockConst_pop_size; new_pop_cnt++) {
			float energyIA_GG_rx = read_channel_altera(chan_Intrae2StoreGG_intrae);
			float energyIE_GG_rx = read_channel_altera(chan_Intere2StoreGG_intere);
			// store energies to Next-Energies
			GlobEnergyNext[new_pop_cnt] = energyIA_GG_rx + energyIE_GG_rx;

			#if defined (DEBUG_KRNL_GG)
			printf(", GG - rx pop: %u\n", new_pop_cnt-1); 		
			#endif
		} // End of GG rx for-loop new_pop_cnt

		// ------------------------------------------------------------------
		/*
		// update energy-evaluation count
		eval_cnt += DockConst_pop_size;
		*/











		// ------------------------------------------------------------------
		// LS: Local Search
		// ------------------------------------------------------------------
		// choose random entities
		/*
		for (ushort ls_ent_cnt=0; ls_ent_cnt<DockConst_num_of_lsentities; ls_ent_cnt++) {
			rand_ls_entities[ls_ent_cnt] = myrand_local_ushort(&prngLS0[ls_ent_cnt], 
						         	           DockConst_pop_size);
		}
		*/

	/*
		ushort __attribute__ ((
			                memory,
			                numbanks(1),
			                bankwidth(64),
			                singlepump,
			                numreadports(1),
			                numwriteports(1)
			             )) rand_ls_entities[16]; 
	*/
		

/*
		// get ushort LS entity
		write_channel_altera(chan_GA2PRNG_LS_ushort_active, true);
		mem_fence(CLK_CHANNEL_MEM_FENCE);
		for (uchar i=0; i<16; i++) {
			rand_ls_entities[i] = read_channel_altera(chan_PRNG2GA_LS_ushort_prng);
		}		  
*/
	
		tmp_eval_cnt = 0;

		// subject num_of_entity_for_ls pieces of offsprings to LS 	
		for (ushort ls_ent_cnt=0; ls_ent_cnt<DockConst_num_of_lsentities; ls_ent_cnt++) {

			//float genotype_bias [ACTUAL_GENOTYPE_LENGTH]; 
			/*
			float __attribute__ ((
			                       memory,
			                       numbanks(1),
			                       bankwidth(64),
			                       singlepump,
			                       numreadports(2),
			                       numwriteports(1)
			                    )) genotype_bias [ACTUAL_GENOTYPE_LENGTH]; 
			*/

			//float entity_possible_new_genotype [ACTUAL_GENOTYPE_LENGTH];
			
			//float genotype_deviate [ACTUAL_GENOTYPE_LENGTH]; 	
			/*
			float __attribute__ ((
			                       memory,
			                       numbanks(1),
			                       bankwidth(64),
			                       singlepump,
			                       numreadports(1),
			                       numwriteports(1)
			                    )) genotype_deviate [ACTUAL_GENOTYPE_LENGTH]; 
			*/
			float rho = 1.0f;
			ushort iteration_cnt = 0;
			uchar  cons_succ     = 0;
			uchar  cons_fail     = 0;
			uint   LS_eval       = 0;
			bool   positive_direction = true;
			bool   ls_pass_complete   = false;

			// choose a random entity without checking if it has already been subjected to LS in this cycle 
			write_channel_altera(chan_GA2PRNG_LS_ushort_active, true);
			mem_fence(CLK_CHANNEL_MEM_FENCE);
			ushort entity_for_ls = read_channel_altera(chan_PRNG2GA_LS_ushort_prng);

			//__local float offspring_genotype [ACTUAL_GENOTYPE_LENGTH]; 
			float __attribute__ ((
			                       memory,
			                       numbanks(1),
			                       bankwidth(64),
			                       singlepump,
			                       numreadports(2),
			                       numwriteports(1)
			                    )) offspring_genotype [ACTUAL_GENOTYPE_LENGTH]; 

			// read population, init genotype bias
			for (uchar i=0; i<DockConst_num_of_genes; i++) {
				offspring_genotype [i] = GlobPopulationNext[entity_for_ls*ACTUAL_GENOTYPE_LENGTH + i];
				genotype_bias [i] = 0.0f;
			}

			// read energy
			float offspring_energy = GlobEnergyNext[entity_for_ls];

			// performing local search
			while ((iteration_cnt < DockConst_max_num_of_iters)  && (rho > DockConst_rho_lower_bound)) {

				// -----------------------------------------------
				// Exit condition is groups here. It allows pipelining

				if (ls_pass_complete == true) { 
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
				// -----------------------------------------------

/*
				float __attribute__ ((
			      			       memory,
			                               numbanks(1),
			                               bankwidth(64),
			                               singlepump,
			                               numreadports(2),
			                               numwriteports(1)
			                            )) prngLS [ACTUAL_GENOTYPE_LENGTH]; 

				write_channel_altera(chan_GA2PRNG_LS_float_active, true);
				mem_fence(CLK_CHANNEL_MEM_FENCE);
				for (uchar i=0; i<DockConst_num_of_genes; i++) {
					prngLS[i] = read_channel_altera(chan_PRNG2GA_LS_float_prng);
				}
*/
	
/*
				float __attribute__ ((
			      			       memory,
			                               numbanks(1),
			                               bankwidth(64),
			                               singlepump,
			                               numreadports(2),
			                               numwriteports(1)
			                            )) entity_possible_new_genotype [ACTUAL_GENOTYPE_LENGTH]; 
*/

				// new random deviate
				// rho is the deviation of the uniform distribution
/*
				#pragma unroll
				for (uchar i=0; i<3; i++) {
					genotype_deviate [i] = rho*DockConst_base_dmov_mul_sqrt3*(2.0f *prngLS[i]-1);
				}
				for (uchar i=3; i<DockConst_num_of_genes; i++) {
					genotype_deviate [i] = rho*DockConst_base_dang_mul_sqrt3*(2.0f *prngLS[i]-1);
				}
*/


/*
				for (uchar i=0; i<DockConst_num_of_genes; i++) {
					float tmp = rho * (2.0f *prngLS[i]-1);

					if (i<3) {
						tmp = tmp * DockConst_base_dmov_mul_sqrt3;
					}
					else {
						tmp = tmp * DockConst_base_dang_mul_sqrt3;
					}

					genotype_deviate [i] = tmp;
				}

				// define genotype values depending on descent direction
				for (uchar i=0; i<DockConst_num_of_genes; i++) {
					float tmp = genotype_deviate[i] + genotype_bias[i];
					entity_possible_new_genotype[i] = (positive_direction == true)? 
									  (offspring_genotype[i] + tmp): 
								          (offspring_genotype[i] - tmp);

				}
*/

/*
				for (uchar i=0; i<DockConst_num_of_genes; i++) {
					float tmp1 = rho * (2.0f *prngLS[i]-1);

					if (i<3) {
						tmp1 = tmp1 * DockConst_base_dmov_mul_sqrt3;
					}
					else {
						tmp1 = tmp1 * DockConst_base_dang_mul_sqrt3;
					}

					genotype_deviate [i] = tmp1;

					float tmp2 = tmp1 + genotype_bias[i];
					entity_possible_new_genotype[i] = (positive_direction == true)? 
									  (offspring_genotype[i] + tmp2): 
								          (offspring_genotype[i] - tmp2);
				}

				entity_possible_new_genotype [3] = map_angle_360(entity_possible_new_genotype [3]);
				entity_possible_new_genotype [4] = map_angle_180(entity_possible_new_genotype [4]);

				for (uchar i=5; i<DockConst_num_of_genes; i++) {
					entity_possible_new_genotype [i] = map_angle_360(entity_possible_new_genotype [i]);
				}
*/  


				for (uchar i=0; i<DockConst_num_of_genes; i++) {
					write_channel_altera(chan_GA2PRNG_LS_float_active, true);
					mem_fence(CLK_CHANNEL_MEM_FENCE);
					float tmp_prng = read_channel_altera(chan_PRNG2GA_LS_float_prng);

					float tmp1 = rho * (2.0f*tmp_prng - 1);

					if (i<3) {
						tmp1 = tmp1 * DockConst_base_dmov_mul_sqrt3;
					}
					else {
						tmp1 = tmp1 * DockConst_base_dang_mul_sqrt3;
					}

					genotype_deviate [i] = tmp1;

					float tmp2 = tmp1 + genotype_bias[i];
					float tmp3; // entity_possible_new_genotype [i]
					tmp3 = (positive_direction == true)? 
									     (offspring_genotype[i] + tmp2): 
								             (offspring_genotype[i] - tmp2);

					if (i>3) {
						if (i==4) {
							tmp3 = map_angle_180(tmp3);
						}
						else {
							tmp3 = map_angle_360(tmp3);
						}
					}

					entity_possible_new_genotype [i] = tmp3;
					write_channel_altera(chan_LS2Conf_genotype, tmp3);
				}


				// calculate energy of genotype
/*
				write_channel_altera(chan_LS2Conf_active, true);
				mem_fence(CLK_CHANNEL_MEM_FENCE);
*/
/*
				for (uchar pipe_cnt=0; pipe_cnt<DockConst_num_of_genes; pipe_cnt++) {
					write_channel_altera(chan_LS2Conf_genotype, entity_possible_new_genotype[pipe_cnt]);
				}
				mem_fence(CLK_CHANNEL_MEM_FENCE);
*/

				float energyIA_LS_rx = read_channel_altera(chan_Intrae2StoreLS_intrae);
				float energyIE_LS_rx = read_channel_altera(chan_Intere2StoreLS_intere);
				float candidate_energy = energyIA_LS_rx + energyIE_LS_rx;

				// update LS energy-evaluation count
				LS_eval++;



				for (uchar i=0; i<DockConst_num_of_genes; i++) {
					// updating offspring_genotype
					// updating genotype_bias

					float tmp;
					float a = genotype_bias [i];
					float b = 0.4f*genotype_deviate[i];
					if (candidate_energy < offspring_energy) {
						offspring_genotype [i] = entity_possible_new_genotype [i];
						float c = 0.6 * a;
						tmp = (positive_direction == true) ? (c + b): (c - b);
					}
					else {
						// updating (halving) genotype_bias
						tmp = 0.5f*a;
					}

					genotype_bias[i] = tmp;
				}




				// if the new entity is better
				if (candidate_energy < offspring_energy)
				{
					offspring_energy = candidate_energy;
					cons_succ++;
					cons_fail = 0;
					ls_pass_complete = true;
				}
				else {
					if (positive_direction == true) {
						positive_direction = false;
						ls_pass_complete   = false;
					}
					else {	// failure in both directions
						positive_direction = true;
						ls_pass_complete   = true;
	
						cons_fail++;
						cons_succ = 0;
					}

					/*
					ls_pass_complete = (positive_direction)? false:true;
					if (positive_direction == false) {
						cons_fail++;
						cons_succ = 0;
					}
					positive_direction = !positive_direction;
					*/
				}

			} // end of while (iteration_cnt)
			//------------------------------------------------------------------------------------------------------------

			// store pops & energies to Next
			for (uchar i=0; i<DockConst_num_of_genes; i++) {
				GlobPopulationNext[entity_for_ls*ACTUAL_GENOTYPE_LENGTH + i] = offspring_genotype [i];
			}
			GlobEnergyNext[entity_for_ls] = offspring_energy;

			tmp_eval_cnt += LS_eval;
		} // End of for-loop ls_ent_cnt
		// ------------------------------------------------------------------

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
	write_channel_altera(chan_Off2Conf_active, false);
	write_channel_altera(chan_GA2PRNG_Off_active, false);


	//mem_fence(CLK_CHANNEL_MEM_FENCE);
	
	#if defined (DEBUG_KRNL_GA)
	printf("GA: %u %u\n", active, DockConst_pop_size -1);
	#endif

	#if defined (DEBUG_ACTIVE_KERNEL)
	printf("	%-20s: %s\n", "Krnl_GA", "disabled");
	#endif
/*
	uint array_evals_and_generations_performed [2];
	array_evals_and_generations_performed [0] = eval_cnt;
	array_evals_and_generations_performed [1] = generation_cnt;
	
	//#pragma unroll 1
	for (uchar i=0; i<2; i++) {
		GlobEvalsGenerations_performed[i] = array_evals_and_generations_performed [i];
	}
*/
	GlobEvalsGenerations_performed[0] = eval_cnt;
	GlobEvalsGenerations_performed[1] = generation_cnt;
}

// --------------------------------------------------------------------------
// --------------------------------------------------------------------------

#include "Krnl_PRNG.cl"
#include "Krnl_Conform.cl"
#include "Krnl_InterE.cl"
#include "Krnl_IntraE.cl"
