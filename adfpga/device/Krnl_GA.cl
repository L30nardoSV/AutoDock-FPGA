// Enable the Intel channels extension
// Programming Guide v17.1 / 5.4.5
#pragma OPENCL EXTENSION cl_intel_channels : enable

//IC:  initial calculation of energy of populations
//GG:  genetic generation 
//LS:  local search
//OFF: turn off 

#include "../defines.h"

#define CHAN_DEPTH_ATOMXYZ   (MAX_NUM_OF_ATOMS/2)
#define CHAN_DEPTH_GENOTYPE  ACTUAL_GENOTYPE_LENGTH

#define LS_REPLICATION_FACTOR 9

// Send active signal to IGL_Arbiter
channel bool    chan_GA2IGL_IC_active;
channel bool    chan_GA2IGL_GG_active;

// Send genotypes from producers (IC, GG, LSs) to Conform
channel float  	chan_IC2Conf_genotype          			__attribute__((depth(CHAN_DEPTH_GENOTYPE)));
channel float  	chan_GG2Conf_genotype          			__attribute__((depth(CHAN_DEPTH_GENOTYPE)));
channel float  	chan_LS2Conf_genotype[LS_REPLICATION_FACTOR]    __attribute__((depth(CHAN_DEPTH_GENOTYPE)));

// Send ligand-atom positions from Conform to InterE & IntraE
channel float8  chan_Conf2Intere_xyz           __attribute__((depth(CHAN_DEPTH_ATOMXYZ)));
channel char  	chan_Conf2Intere_actmode;

channel float8	chan_Conf2Intrae_xyz           __attribute__((depth(CHAN_DEPTH_ATOMXYZ)));
channel char  	chan_Conf2Intrae_actmode;

// Send energy values from InterE & IntraE to genotype-senders (IC, GG, LSs)
channel float 	chan_Intere2StoreIC_intere     				__attribute__((depth(2)));
channel float 	chan_Intere2StoreGG_intere     				__attribute__((depth(2)));
channel float 	chan_Intere2StoreLS_intere[LS_REPLICATION_FACTOR]  	__attribute__((depth(2)));

channel float 	chan_Intrae2StoreIC_intrae     				__attribute__((depth(2)));
channel float 	chan_Intrae2StoreGG_intrae     				__attribute__((depth(2)));
channel float 	chan_Intrae2StoreLS_intrae[LS_REPLICATION_FACTOR]  	__attribute__((depth(2)));

// Send PRNG outputs from generators to consumers
channel float8   chan_PRNG2GA_BT_ushort_float_prng;
channel uchar2   chan_PRNG2GA_GG_uchar_prng;
channel float    chan_PRNG2GA_GG_float_prng     __attribute__((depth(CHAN_DEPTH_GENOTYPE)));
channel ushort16 chan_PRNG2GA_LS123_ushort_prng;
channel float    chan_PRNG2LS_float_prng[LS_REPLICATION_FACTOR]		__attribute__((depth(CHAN_DEPTH_GENOTYPE)));

// Turn-off signals to PRNG generators
channel bool 	chan_GA2PRNG_BT_ushort_float_off;
channel bool    chan_GA2PRNG_GG_uchar_off;
channel bool    chan_GA2PRNG_GG_float_off;
channel bool    chan_GA2PRNG_LS123_ushort_off;
channel bool    chan_GA2PRNG_LS_float_off[LS_REPLICATION_FACTOR];

// Send energy values and genotypes to LSs
channel float   chan_GA2LS_energy[LS_REPLICATION_FACTOR];
channel float  	chan_GA2LS_genotype[LS_REPLICATION_FACTOR]        __attribute__((depth(CHAN_DEPTH_GENOTYPE)));

// Send LS status from LSs to IGL_Arbiter
channel bool    chan_LS2Arbiter_end[LS_REPLICATION_FACTOR];

// Get LS-eval-count, new energy, new genotype from LSs
channel float2  chan_LS2GA_evalenergy[LS_REPLICATION_FACTOR]      __attribute__((depth(2)));
channel float  	chan_LS2GA_genotype[LS_REPLICATION_FACTOR]        __attribute__((depth(CHAN_DEPTH_GENOTYPE)));

// Turn-off signals to LSs
channel bool    chan_GA2LS_Off_active[LS_REPLICATION_FACTOR];

// Send genotype-producer-channel selector and genotype 
// from IGL_Arbiter to Conform
channel char   chan_IGL2Conform_actmode	       __attribute__((depth(LS_REPLICATION_FACTOR))); // active, mode
channel float  chan_IGL2Conform_genotype       __attribute__((depth(LS_REPLICATION_FACTOR*CHAN_DEPTH_GENOTYPE)));

// Turn-off signal to IGL_Arbiter, Conform, InterE, IntraE
channel bool   chan_IGLArbiter_Off;

#if defined (FIXED_POINT_CONFORM) || \
    defined (FIXED_POINT_LS1)     || \
    defined (FIXED_POINT_LS2)     || \
    defined (FIXED_POINT_LS3)     || \
    defined (FIXED_POINT_LS4)     || \
    defined (FIXED_POINT_LS5)     || \
    defined (FIXED_POINT_LS6)     || \
    defined (FIXED_POINT_LS7)     || \
    defined (FIXED_POINT_LS8)     || \
    defined (FIXED_POINT_LS9)
#include "../defines_fixedpt.h"

typedef int3          fixedpt3;
typedef int4	      fixedpt4;
#endif

#if defined (FIXED_POINT_INTERE) || defined (FIXED_POINT_INTRAE)
#include "../defines_fixedpt_64.h"
#endif

// --------------------------------------------------------------------------
// Map the argument into the interval 0 - 180, or 0 - 360
// by adding/subtracting n*ang_max to/from it.
// Originally from: searchoptimum.c
// --------------------------------------------------------------------------

float map_angle_180(float angle)
{
	float x = angle;
	//while (x < 0.0f)
	if (x < 0.0f)   
	{ x += 180.0f; }
	//while (x > 180.0f)
	if (x > 180.0f) 
	{ x -= 180.0f; }
	return x;
}

float map_angle_360(float angle)
{
	float x = angle;
	//while (x < 0.0f)
	if (x < 0.0f)
	{ x += 360.0f; }
	//while (x > 360.0f)
	if (x > 360.0f)
	{ x -= 360.0f;}
	return x;
}

#if defined (FIXED_POINT_LS1) || \
    defined (FIXED_POINT_LS2) || \
    defined (FIXED_POINT_LS3) || \
    defined (FIXED_POINT_LS4) || \
    defined (FIXED_POINT_LS5) || \
    defined (FIXED_POINT_LS6) || \
    defined (FIXED_POINT_LS7) || \
    defined (FIXED_POINT_LS8) || \
    defined (FIXED_POINT_LS9)
#define FIXEDPT_180	0xB40000
#define FIXEDPT_360	0x1680000

fixedpt fixedpt_map_angle_180(fixedpt angle)
{
	fixedpt x = angle;
	//while (x < 0.0f) 
	if (x < 0)
	{ x += FIXEDPT_180; }
	//while (x > 180.0f)
	if (x > FIXEDPT_180)
	{ x -= FIXEDPT_180; }
	return x;
}

fixedpt fixedpt_map_angle_360(fixedpt angle)
{
	fixedpt x = angle;
	//while (x < 0.0f) 
	if (x < 0)
	{ x += FIXEDPT_360; }
	//while (x > 360.0f)
	if (x > FIXEDPT_360)
	{ x -= FIXEDPT_360;}
	return x;
}
#endif

// --------------------------------------------------------------------------
// Lamarckian Genetic-Algorithm (GA): GA + LS (Local Search) 
// Originally from: searchoptimum.c
// --------------------------------------------------------------------------
__kernel __attribute__ ((max_global_work_dim(0)))
void Krnl_GA(__global       float*           __restrict GlobPopulationCurrent,
	     __global       float*           __restrict GlobEnergyCurrent,
	     #if defined(SINGLE_COPY_POP_ENE)
   	     __global       unsigned int*    __restrict GlobEvals_performed,
             __global       unsigned int*    __restrict GlobGens_performed,
	     #else
	     __global       unsigned int*    __restrict GlobEvalsGenerations_performed,
	     #endif
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
			    unsigned char             DockConst_num_of_genes
	     #if defined(SINGLE_COPY_POP_ENE)
	     					      ,
	                    unsigned short            Host_RunId,
			    unsigned int 	      Host_Offset_Pop,
			    unsigned int	      Host_Offset_Ene
	     #endif
	     )
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

	// Other banking configuration (see PopNext, eneNext) might reduce logic
	// but makes PopCurr stallable
	__local float LocalPopCurr[MAX_POPSIZE][ACTUAL_GENOTYPE_LENGTH];
	__local float LocalEneCurr[MAX_POPSIZE];

	#if defined(SINGLE_COPY_POP_ENE)
	__global float* GlobPopCurr = & GlobPopulationCurrent [Host_Offset_Pop];
	__global float* GlobEneCurr = & GlobEnergyCurrent     [Host_Offset_Ene];
	#endif

	// ------------------------------------------------------------------
	// Initial Calculation (IC) of scores
	// ------------------------------------------------------------------
	for (ushort pop_cnt = 0; pop_cnt < DockConst_pop_size; pop_cnt++) {
		// Calculate energy
		write_channel_intel(chan_GA2IGL_IC_active, true);
		mem_fence(CLK_CHANNEL_MEM_FENCE);

		for (uchar gene_cnt=0; gene_cnt<DockConst_num_of_genes; gene_cnt++) {
			float tmp_ic;
			#if defined(SINGLE_COPY_POP_ENE)
			tmp_ic = GlobPopCurr[pop_cnt*ACTUAL_GENOTYPE_LENGTH + gene_cnt];
			#else
			tmp_ic = GlobPopulationCurrent[pop_cnt*ACTUAL_GENOTYPE_LENGTH + gene_cnt];
			#endif
		
			LocalPopCurr[pop_cnt][gene_cnt & MASK_GENOTYPE] = tmp_ic;
			write_channel_intel(chan_IC2Conf_genotype, tmp_ic);
		}

		#if defined (DEBUG_KRNL_IC)
		printf("\nIC - tx pop: %u", pop_cnt); 		
		#endif

		// Read energy
		float energyIA_IC_rx;
		float energyIE_IC_rx;
		bool intra_valid = false;
		bool inter_valid = false;
		while( (intra_valid == false) || (inter_valid == false)) {
			if (intra_valid == false) {
				energyIA_IC_rx = read_channel_nb_intel(chan_Intrae2StoreIC_intrae, &intra_valid);
			}
			else if (inter_valid == false) {
				energyIE_IC_rx = read_channel_nb_intel(chan_Intere2StoreIC_intere, &inter_valid);
			}
		}

		LocalEneCurr[pop_cnt] = energyIA_IC_rx + energyIE_IC_rx;

		#if defined (DEBUG_KRNL_IC)
		printf(", IC - rx pop: %u\n", pop_cnt); 		
		#endif
	}
	// ------------------------------------------------------------------

	uint eval_cnt = DockConst_pop_size; // takes into account the IC evals

	uint generation_cnt = 0;

	while ((eval_cnt < DockConst_num_of_energy_evals) && (generation_cnt < DockConst_num_of_generations)) {

		//float LocalPopNext[MAX_POPSIZE][ACTUAL_GENOTYPE_LENGTH];
		//float LocalEneNext[MAX_POPSIZE];

		// This configuration reduces logic and does not increase block RAM usage
/*
		float __attribute__ ((
				       memory,
		   		       numbanks(4),
			               bankwidth(32),
			              )) LocalPopNext[MAX_POPSIZE][ACTUAL_GENOTYPE_LENGTH];
*/

		float __attribute__ ((
				       memory,
		   		       numbanks(4),
			               bankwidth(32),
				       singlepump,
				       numreadports(10),
			               numwriteports(1) 
			              )) LocalPopNext[MAX_POPSIZE][ACTUAL_GENOTYPE_LENGTH];

/*
		float __attribute__ ((
				       memory,
		   		       numbanks(4),
			               bankwidth(4),
			              )) LocalEneNext[MAX_POPSIZE];
*/

		float __attribute__ ((
				       memory,
		   		       numbanks(1),
			               bankwidth(4),
				       singlepump,
				       numreadports(10),
			               numwriteports(1)  
			              )) LocalEneNext[MAX_POPSIZE];

		// ------------------------------------------------------------------
		// Genetic Generation (GG)
		// ------------------------------------------------------------------
		float __attribute__ ((
				       memory,
		   		       numbanks(1),
			               bankwidth(64),
			               singlepump,
 			               numreadports(6),
			               numwriteports(1)
			              )) loc_energies[MAX_POPSIZE];

		ushort best_entity = 0;

//		for (ushort pop_cnt=1; pop_cnt<DockConst_pop_size; pop_cnt++) {
		for (ushort pop_cnt=0; pop_cnt<DockConst_pop_size; pop_cnt++) {
			// copy energy to local memory
			loc_energies[pop_cnt] = LocalEneCurr[pop_cnt];

			#if defined (DEBUG_KRNL_GA)
			if (pop_cnt==0) {printf("\n");}
			printf("%3u %20.6f\n", pop_cnt, loc_energies[pop_cnt]);
			#endif

			if (loc_energies[pop_cnt] < loc_energies[best_entity]) {
				best_entity = pop_cnt;
			}
		}

		#if defined (DEBUG_KRNL_GA)
		printf("best_entity: %3u, energy: %20.6f\n", best_entity, loc_energies[best_entity]);
		#endif

		// ---------------------------------------------------
		// Elitism: copying the best entity to new population
		// ---------------------------------------------------
		for (uchar gene_cnt=0; gene_cnt<DockConst_num_of_genes; gene_cnt++) { 		
			LocalPopNext[0][gene_cnt & MASK_GENOTYPE] = LocalPopCurr[best_entity][gene_cnt & MASK_GENOTYPE]; 	
		} 		
		LocalEneNext[0] = loc_energies[best_entity];

		#pragma ivdep array (LocalPopNext)
		#pragma ivdep array (LocalEneNext)
		for (ushort new_pop_cnt = 1; new_pop_cnt < DockConst_pop_size; new_pop_cnt++) {

			#if defined (DEBUG_KRNL_GA)
			printf("Krnl_GA: %u\n", new_pop_cnt);
			#endif

			float local_entity_1 [ACTUAL_GENOTYPE_LENGTH];
			float local_entity_2 [ACTUAL_GENOTYPE_LENGTH]; 
		
			// ---------------------------------------------------
			// Binary-Tournament (BT) selection
			// ---------------------------------------------------

			// Get ushort binary_tournament selection prngs (parent index)
			// Get float binary_tournament selection prngs (tournament rate)
			float8 bt_tmp = read_channel_intel(chan_PRNG2GA_BT_ushort_float_prng);
			mem_fence(CLK_CHANNEL_MEM_FENCE);

			// Convert: float prng that must be still converted to short
			float bt_tmp_uf0 = bt_tmp.s0;
			float bt_tmp_uf1 = bt_tmp.s2;
			float bt_tmp_uf2 = bt_tmp.s4;
			float bt_tmp_uf3 = bt_tmp.s6;

			// short prng ready to be used, replace ushort prng_BT_U[4];
			ushort bt_tmp_u0 = *(uint*)&bt_tmp_uf0;
			ushort bt_tmp_u1 = *(uint*)&bt_tmp_uf1;
			ushort bt_tmp_u2 = *(uint*)&bt_tmp_uf2;
			ushort bt_tmp_u3 = *(uint*)&bt_tmp_uf3;

			// float prng ready to used, replace float prng_BT_F[4];
			float bt_tmp_f0 = bt_tmp.s1;
			float bt_tmp_f1 = bt_tmp.s3;
			float bt_tmp_f2 = bt_tmp.s5;
			float bt_tmp_f3 = bt_tmp.s7;

			ushort parent1;
			ushort parent2; 

			// First parent
			if (loc_energies[bt_tmp_u0] < loc_energies[bt_tmp_u1]) {
				if (bt_tmp_f0 < DockConst_tournament_rate) {parent1 = bt_tmp_u0;}
				else				           {parent1 = bt_tmp_u1;}}
			else {
				if (bt_tmp_f1 < DockConst_tournament_rate) {parent1 = bt_tmp_u1;}
				else				           {parent1 = bt_tmp_u0;}}

			// The better will be the second parent
			if (loc_energies[bt_tmp_u2] < loc_energies[bt_tmp_u3]) {
				if (bt_tmp_f2 < DockConst_tournament_rate) {parent2 = bt_tmp_u2;}
				else		          	           {parent2 = bt_tmp_u3;}}
			else {
				if (bt_tmp_f3 < DockConst_tournament_rate) {parent2 = bt_tmp_u3;}
				else			                   {parent2 = bt_tmp_u2;}}

			// local_entity_1 and local_entity_2 are population-parent1, population-parent2
			for (uchar gene_cnt=0; gene_cnt<DockConst_num_of_genes; gene_cnt++) {
				local_entity_1[gene_cnt & MASK_GENOTYPE] = LocalPopCurr[parent1][gene_cnt & MASK_GENOTYPE];
				local_entity_2[gene_cnt & MASK_GENOTYPE] = LocalPopCurr[parent2][gene_cnt & MASK_GENOTYPE];
			}

			// ---------------------------------------------------
			// Mating parents
			// ---------------------------------------------------	

			// get uchar genetic_generation prngs (gene index)
			// get float genetic_generation prngs (mutation rate)
			uchar2 prng_GG_C = read_channel_intel(chan_PRNG2GA_GG_uchar_prng);
			mem_fence(CLK_CHANNEL_MEM_FENCE);

			uchar covr_point_low;
			uchar covr_point_high;
			bool twopoint_cross_yes = false;

			if (prng_GG_C.x == prng_GG_C.y) {covr_point_low = prng_GG_C.x;}
			else {
				twopoint_cross_yes = true;
				if (prng_GG_C.x < prng_GG_C.y) { covr_point_low  = prng_GG_C.x;
					                         covr_point_high = prng_GG_C.y; }
				else {		      		 covr_point_low  = prng_GG_C.y;
   								 covr_point_high = prng_GG_C.x; }
			}
			
			// Reuse of bt prng float as crossover-rate
			bool crossover_yes = (DockConst_crossover_rate > bt_tmp_f0);

			write_channel_intel(chan_GA2IGL_GG_active, true);
			mem_fence(CLK_CHANNEL_MEM_FENCE);

			for (uchar gene_cnt=0; gene_cnt<DockConst_num_of_genes; gene_cnt++) {

				float prngGG = read_channel_intel(chan_PRNG2GA_GG_float_prng);
				mem_fence(CLK_CHANNEL_MEM_FENCE);

				float tmp_offspring;

				// Performing crossover
				if (   	(
					crossover_yes && (										// crossover
					( (twopoint_cross_yes == true)  && ((gene_cnt <= covr_point_low) || (gene_cnt > covr_point_high)) )  ||	// two-point crossover 			 		
					( (twopoint_cross_yes == false) && (gene_cnt <= covr_point_low))  					// one-point crossover
					)) || 
					(!crossover_yes)	// no crossover
				   ) {
					tmp_offspring = local_entity_1[gene_cnt & MASK_GENOTYPE];
				}
				else {
					tmp_offspring = local_entity_2[gene_cnt & MASK_GENOTYPE];
				}

				// Performing mutation
				if (DockConst_mutation_rate > prngGG) {
					if(gene_cnt<3) {
						tmp_offspring = tmp_offspring + Host_two_absmaxdmov*prngGG-DockConst_abs_max_dmov;
					}
					else {
						float tmp;
						tmp = tmp_offspring + Host_two_absmaxdang*prngGG-DockConst_abs_max_dang;

						if (gene_cnt==4) { tmp_offspring = map_angle_180(tmp); }
						else             { tmp_offspring = map_angle_360(tmp); }
					}
				}

				// Calculate energy
				LocalPopNext [new_pop_cnt][gene_cnt & MASK_GENOTYPE] = tmp_offspring;
				write_channel_intel(chan_GG2Conf_genotype, tmp_offspring);
			}

			#if defined (DEBUG_KRNL_GG)
			printf("GG - tx pop: %u", new_pop_cnt); 		
			#endif	

			// Read energy
			float energyIA_GG_rx;
			float energyIE_GG_rx;
			bool intra_valid = false;
			bool inter_valid = false;
			while( (intra_valid == false) || (inter_valid == false)) {
				if (intra_valid == false) {
					energyIA_GG_rx = read_channel_nb_intel(chan_Intrae2StoreGG_intrae, &intra_valid);
				}
				else if (inter_valid == false) {
					energyIE_GG_rx = read_channel_nb_intel(chan_Intere2StoreGG_intere, &inter_valid);
				}
			}
			
			LocalEneNext[new_pop_cnt] = energyIA_GG_rx + energyIE_GG_rx;

			#if defined (DEBUG_KRNL_GG)
			printf(", GG - rx pop: %u\n", new_pop_cnt); 		
			#endif
		} 
		// ------------------------------------------------------------------
		// LS: Local Search
		// Subject num_of_entity_for_ls pieces of offsprings to LS 
		// ------------------------------------------------------------------

		uint ls_eval_cnt = 0;

		#pragma ivdep
		for (ushort ls_ent_cnt=0; ls_ent_cnt<DockConst_num_of_lsentities; ls_ent_cnt+=LS_REPLICATION_FACTOR) {

			// Choose random & different entities on every iteration
			ushort16 entity_ls = read_channel_intel(chan_PRNG2GA_LS123_ushort_prng);
			mem_fence(CLK_CHANNEL_MEM_FENCE);
			
			// https://forums.khronos.org/showthread.php/7397-How-to-read-elements-from-a-float16-(or-other)-using-index
			union
			{
				ushort   arr[16];
				ushort16 vec;
			}
			u_entity_ls;

			u_entity_ls.vec = entity_ls;

			// Here you can (in theory) read from u_entity_ls.arr[i] safely thanks to sec 6.2.4.1
			// A nice property of OpenCL C that does not exist in C99
			#pragma unroll
			for (uchar j=0; j<LS_REPLICATION_FACTOR; j++) {
				write_channel_intel(chan_GA2LS_energy[j], LocalEneNext[u_entity_ls.arr[j]]);
			}
			mem_fence(CLK_CHANNEL_MEM_FENCE);

			for (uchar gene_cnt=0; gene_cnt<DockConst_num_of_genes; gene_cnt++) {
				#pragma unroll
				for (uchar j=0; j<LS_REPLICATION_FACTOR; j++) {
					write_channel_intel(chan_GA2LS_genotype[j], LocalPopNext[u_entity_ls.arr[j]][gene_cnt & MASK_GENOTYPE]);
				}
			}
			mem_fence(CLK_CHANNEL_MEM_FENCE);

			float2 evalenergy_tmp[LS_REPLICATION_FACTOR];

			bool ls_done[LS_REPLICATION_FACTOR];
			#pragma unroll
			for (uchar j=0; j<LS_REPLICATION_FACTOR; j++) {
				ls_done[j] = false;
			}
  
			while( (ls_done[0] == false) || 
			       (ls_done[1] == false) || 
			       (ls_done[2] == false) || 
			       (ls_done[3] == false) || 
			       (ls_done[4] == false) ||
			       (ls_done[5] == false) || 
			       (ls_done[6] == false) || 
			       (ls_done[7] == false) || 
			       (ls_done[8] == false) 
			)
			{
				if (ls_done[0] == false) {
					evalenergy_tmp[0] = read_channel_nb_intel(chan_LS2GA_evalenergy[0], &ls_done[0]);
				}
				else if (ls_done[1] == false) {
					evalenergy_tmp[1] = read_channel_nb_intel(chan_LS2GA_evalenergy[1], &ls_done[1]);
				}
				else if (ls_done[2] == false) {
					evalenergy_tmp[2] = read_channel_nb_intel(chan_LS2GA_evalenergy[2], &ls_done[2]);
				}
				else if (ls_done[3] == false) {
					evalenergy_tmp[3] = read_channel_nb_intel(chan_LS2GA_evalenergy[3], &ls_done[3]);
				}
				else if (ls_done[4] == false) {
					evalenergy_tmp[4] = read_channel_nb_intel(chan_LS2GA_evalenergy[4], &ls_done[4]);
				}
				else if (ls_done[5] == false) {
					evalenergy_tmp[5] = read_channel_nb_intel(chan_LS2GA_evalenergy[5], &ls_done[5]);
				}
				else if (ls_done[6] == false) {
					evalenergy_tmp[6] = read_channel_nb_intel(chan_LS2GA_evalenergy[6], &ls_done[6]);
				}
				else if (ls_done[7] == false) {
					evalenergy_tmp[7] = read_channel_nb_intel(chan_LS2GA_evalenergy[7], &ls_done[7]);
				}
				else if (ls_done[8] == false) {
					evalenergy_tmp[8] = read_channel_nb_intel(chan_LS2GA_evalenergy[8], &ls_done[8]);
				}
			}
		
			#if defined (DEBUG_KRNL_LS)
			printf("LS - got all eval & energies back\n");
			#endif

			// Temporal number of energy evals: evalenergy_tmp[j].x
			// Energy values: evalenergy_tmp[j].y
			float eetmp[LS_REPLICATION_FACTOR];
			uint eval_tmp[LS_REPLICATION_FACTOR];
			#pragma unroll
			for (uchar j=0; j<LS_REPLICATION_FACTOR; j++) {
				eetmp[j]    = evalenergy_tmp[j].x;
				eval_tmp[j] = *(uint*)&eetmp[j];
				LocalEneNext[u_entity_ls.arr[j]] = evalenergy_tmp[j].y;
			}

			// Reading back updated genotypes
			#pragma ivdep
			for (uchar gene_cnt=0; gene_cnt<DockConst_num_of_genes; gene_cnt++) {
				#pragma unroll
				for (uchar j=0; j<LS_REPLICATION_FACTOR; j++) {
					LocalPopNext[u_entity_ls.arr[j]][gene_cnt & MASK_GENOTYPE] = read_channel_intel(chan_LS2GA_genotype[j]);
				}
			}

			// Accumulating number of energy evals
			uint tmp_eval_cnt = 0;
			#pragma unroll
			for (uchar j=0; j<LS_REPLICATION_FACTOR; j++) {
				tmp_eval_cnt += eval_tmp[j];
			}
			ls_eval_cnt += tmp_eval_cnt;
			
			#if defined (DEBUG_KRNL_LS)
			printf("%u, ls_eval_cnt: %u\n", ls_ent_cnt, ls_eval_cnt);
			printf("LS - got all genotypes back\n");
			#endif
		} // End of for-loop ls_ent_cnt
		// ------------------------------------------------------------------

		// Update current pops & energies
		for (ushort pop_cnt=0; pop_cnt<DockConst_pop_size; pop_cnt++) {
			for (uchar gene_cnt=0; gene_cnt<DockConst_num_of_genes; gene_cnt++) {
				LocalPopCurr[pop_cnt][gene_cnt & MASK_GENOTYPE] = LocalPopNext[pop_cnt][gene_cnt & MASK_GENOTYPE];
			}

			LocalEneCurr[pop_cnt] = LocalEneNext[pop_cnt];
		}

		// Update energy evaluations count: count LS and GG evals
		eval_cnt += ls_eval_cnt + DockConst_pop_size; 

		// Update generation count
		generation_cnt++;

		#if defined (DEBUG_KRNL_GA)
		printf("eval_cnt: %u, generation_cnt: %u\n", eval_cnt, generation_cnt);
		#endif
	} // End while eval_cnt & generation_cnt

	// ------------------------------------------------------------------
	// Off: turn off all other kernels
	// ------------------------------------------------------------------

	// Turn off PRNG kernels
	write_channel_intel(chan_GA2PRNG_BT_ushort_float_off,   false);
	write_channel_intel(chan_GA2PRNG_GG_uchar_off, 		false);
	write_channel_intel(chan_GA2PRNG_GG_float_off, 		false);
	write_channel_intel(chan_GA2PRNG_LS123_ushort_off,  	false);

	#pragma unroll
	for (uchar j=0; j<LS_REPLICATION_FACTOR; j++) {
		write_channel_intel(chan_GA2PRNG_LS_float_off[j], false);
	}
	mem_fence(CLK_CHANNEL_MEM_FENCE);

	// Turn off LS kernels
	#pragma unroll
	for (uchar j=0; j<LS_REPLICATION_FACTOR; j++) {
		write_channel_intel(chan_GA2LS_Off_active[j], false);
	}
	mem_fence(CLK_CHANNEL_MEM_FENCE);

	// Turn off IGL_Arbiter, Conform, InterE, IntraE kernerls
	write_channel_intel(chan_IGLArbiter_Off, false);
	mem_fence(CLK_CHANNEL_MEM_FENCE);

	// Write final pop & energies back to FPGA-board DDRs
	for (ushort pop_cnt=0;pop_cnt<DockConst_pop_size; pop_cnt++) { 	

		for (uchar gene_cnt=0; gene_cnt<DockConst_num_of_genes; gene_cnt++) {
			#if defined(SINGLE_COPY_POP_ENE)
			GlobPopCurr[pop_cnt*ACTUAL_GENOTYPE_LENGTH + gene_cnt] = LocalPopCurr[pop_cnt][gene_cnt & MASK_GENOTYPE];
			#else
			GlobPopulationCurrent[pop_cnt*ACTUAL_GENOTYPE_LENGTH + gene_cnt] = LocalPopCurr[pop_cnt][gene_cnt & MASK_GENOTYPE];
			#endif
		}

		#if defined(SINGLE_COPY_POP_ENE)
		GlobEneCurr[pop_cnt] = LocalEneCurr[pop_cnt];
		#else
		GlobEnergyCurrent[pop_cnt] = LocalEneCurr[pop_cnt];
		#endif
	}

	#if defined (DEBUG_KRNL_GA)
	printf("GA: %u %u\n", active, DockConst_pop_size -1);
	#endif

	#if defined (DEBUG_ACTIVE_KERNEL)
	printf("	%-20s: %s\n", "Krnl_GA", "disabled");
	#endif

	// Write final evals & generation counts to FPGA-board DDRs
	#if defined(SINGLE_COPY_POP_ENE)
	GlobEvals_performed[Host_RunId] = eval_cnt;
	GlobGens_performed [Host_RunId] = generation_cnt;
	#else
	GlobEvalsGenerations_performed[0] = eval_cnt;
	GlobEvalsGenerations_performed[1] = generation_cnt;
	#endif
}

// --------------------------------------------------------------------------
// --------------------------------------------------------------------------

#include "Krnl_PRNG.cl"

#include "Krnl_LS.cl"
#include "Krnl_LS2.cl"
#include "Krnl_LS3.cl"
#include "Krnl_LS4.cl"
#include "Krnl_LS5.cl"
#include "Krnl_LS6.cl"
#include "Krnl_LS7.cl"
#include "Krnl_LS8.cl"
#include "Krnl_LS9.cl"

#include "Krnl_IGL_Arbiter.cl"
//#include "Krnl_IGL_SimplifArbiter.cl"

#include "Krnl_Conform.cl"
#include "Krnl_InterE.cl"
#include "Krnl_IntraE.cl"
