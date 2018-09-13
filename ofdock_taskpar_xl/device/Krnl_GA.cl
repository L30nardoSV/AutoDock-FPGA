//IC:  initial calculation of energy of populations
//GG:  genetic generation 
//LS:  local search
//OFF: turn off 

#include "../defines.h"

#define PIPE_DEPTH_16  16
#define PIPE_DEPTH_64  64
#define PIPE_DEPTH_512 512

// Send active signal to IGL_Arbiter
// Resized to valid SDAccel depths: 16, 32, ...
pipe int    chan_GA2IGL_IC_active	__attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_16)));
pipe int    chan_GA2IGL_GG_active	__attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_16)));

// Send genotypes from producers (IC, GG, LSs) to Conform
pipe float  chan_IC2Conf_genotype          __attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_64)));
pipe float  chan_GG2Conf_genotype          __attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_64)));
pipe float  chan_LS2Conf_LS1_genotype      __attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_64)));
pipe float  chan_LS2Conf_LS2_genotype      __attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_64)));
pipe float  chan_LS2Conf_LS3_genotype      __attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_64)));
pipe float  chan_LS2Conf_LS4_genotype      __attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_64)));
pipe float  chan_LS2Conf_LS5_genotype      __attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_64)));
pipe float  chan_LS2Conf_LS6_genotype      __attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_64)));
pipe float  chan_LS2Conf_LS7_genotype      __attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_64)));
pipe float  chan_LS2Conf_LS8_genotype      __attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_64)));
pipe float  chan_LS2Conf_LS9_genotype      __attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_64)));

// Send ligand-atom positions from Conform to InterE & IntraE
// Resized to valid SDAccel depths: 16, 32, ...
pipe float8  chan_Conf2Intere_xyz           __attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_64)));
pipe char    chan_Conf2Intere_actmode	    __attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_16)));

pipe float8  chan_Conf2Intrae_xyz           __attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_64)));
pipe char    chan_Conf2Intrae_actmode       __attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_16)));

// Send energy values from InterE & IntraE to genotype-senders (IC, GG, LSs)
// Resized to valid SDAccel depths: 16, 32, ...
pipe float  chan_Intere2StoreIC_intere     __attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_16)));
pipe float  chan_Intere2StoreGG_intere     __attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_16)));
pipe float  chan_Intere2StoreLS_LS1_intere __attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_16)));
pipe float  chan_Intere2StoreLS_LS2_intere __attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_16)));
pipe float  chan_Intere2StoreLS_LS3_intere __attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_16)));
pipe float  chan_Intere2StoreLS_LS4_intere __attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_16)));
pipe float  chan_Intere2StoreLS_LS5_intere __attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_16)));
pipe float  chan_Intere2StoreLS_LS6_intere __attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_16)));
pipe float  chan_Intere2StoreLS_LS7_intere __attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_16)));
pipe float  chan_Intere2StoreLS_LS8_intere __attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_16)));
pipe float  chan_Intere2StoreLS_LS9_intere __attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_16)));
pipe float  chan_Intrae2StoreIC_intrae     __attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_16)));
pipe float  chan_Intrae2StoreGG_intrae     __attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_16)));
pipe float  chan_Intrae2StoreLS_LS1_intrae __attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_16)));
pipe float  chan_Intrae2StoreLS_LS2_intrae __attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_16)));
pipe float  chan_Intrae2StoreLS_LS3_intrae __attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_16)));
pipe float  chan_Intrae2StoreLS_LS4_intrae __attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_16)));
pipe float  chan_Intrae2StoreLS_LS5_intrae __attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_16)));
pipe float  chan_Intrae2StoreLS_LS6_intrae __attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_16)));
pipe float  chan_Intrae2StoreLS_LS7_intrae __attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_16)));
pipe float  chan_Intrae2StoreLS_LS8_intrae __attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_16)));
pipe float  chan_Intrae2StoreLS_LS9_intrae __attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_16)));

// Send PRNG outputs from generators to consumers
// Resized to valid SDAccel depths: 16, 32, ...
pipe float8   chan_PRNG2GA_BT_ushort_float_prng	__attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_16)));
pipe uchar2   chan_PRNG2GA_GG_uchar_prng	__attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_16)));
pipe float    chan_PRNG2GA_GG_float_prng     	__attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_64)));
pipe ushort16 chan_PRNG2GA_LS123_ushort_prng	__attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_16)));
pipe float    chan_PRNG2GA_LS_float_prng     	__attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_64)));
pipe float    chan_PRNG2GA_LS2_float_prng    	__attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_64)));
pipe float    chan_PRNG2GA_LS3_float_prng    	__attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_64)));
pipe float    chan_PRNG2GA_LS4_float_prng   	__attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_64)));
pipe float    chan_PRNG2GA_LS5_float_prng    	__attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_64)));
pipe float    chan_PRNG2GA_LS6_float_prng    	__attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_64)));
pipe float    chan_PRNG2GA_LS7_float_prng    	__attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_64)));
pipe float    chan_PRNG2GA_LS8_float_prng    	__attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_64)));
pipe float    chan_PRNG2GA_LS9_float_prng    	__attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_64)));

// Turn-off signals to PRNG generators

// FIXME: these channels don't go anymore through IGL_Arbiter.
// That was initially the case, but was fixed.
// Name should be changed accordingly (GA instead of Arbiter)
// to avoid misleading data-flow information

// Resized to valid SDAccel depths: 16, 32, ...
pipe int    chan_Arbiter_BT_ushort_float_off	__attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_16)));
pipe int    chan_Arbiter_GG_uchar_off		__attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_16)));
pipe int    chan_Arbiter_GG_float_off		__attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_16)));
pipe int    chan_Arbiter_LS123_ushort_off	__attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_16)));
pipe int    chan_Arbiter_LS_float_off		__attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_16)));
pipe int    chan_Arbiter_LS2_float_off		__attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_16)));
pipe int    chan_Arbiter_LS3_float_off		__attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_16)));
pipe int    chan_Arbiter_LS4_float_off		__attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_16)));
pipe int    chan_Arbiter_LS5_float_off		__attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_16)));
pipe int    chan_Arbiter_LS6_float_off		__attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_16)));
pipe int    chan_Arbiter_LS7_float_off		__attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_16)));
pipe int    chan_Arbiter_LS8_float_off		__attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_16)));
pipe int    chan_Arbiter_LS9_float_off		__attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_16)));

// Send energy values and genotypes to LSs
// Resized to valid SDAccel depths: 16, 32, ...
pipe float   chan_GA2LS_LS1_energy		__attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_16)));
pipe float   chan_GA2LS_LS2_energy		__attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_16)));
pipe float   chan_GA2LS_LS3_energy		__attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_16)));
pipe float   chan_GA2LS_LS4_energy		__attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_16)));
pipe float   chan_GA2LS_LS5_energy		__attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_16)));
pipe float   chan_GA2LS_LS6_energy		__attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_16)));
pipe float   chan_GA2LS_LS7_energy		__attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_16)));
pipe float   chan_GA2LS_LS8_energy		__attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_16)));
pipe float   chan_GA2LS_LS9_energy		__attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_16)));

// Resized to valid SDAccel depths: 16, 32, ...
pipe float   chan_GA2LS_LS1_genotype        	__attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_64)));
pipe float   chan_GA2LS_LS2_genotype        	__attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_64)));
pipe float   chan_GA2LS_LS3_genotype        	__attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_64)));
pipe float   chan_GA2LS_LS4_genotype        	__attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_64)));
pipe float   chan_GA2LS_LS5_genotype        	__attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_64)));
pipe float   chan_GA2LS_LS6_genotype        	__attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_64)));
pipe float   chan_GA2LS_LS7_genotype        	__attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_64)));
pipe float   chan_GA2LS_LS8_genotype        	__attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_64)));
pipe float   chan_GA2LS_LS9_genotype        	__attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_64)));

// Send LS status from LSs to IGL_Arbiter
pipe int    chan_LS2Arbiter_LS1_end		__attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_16)));
pipe int    chan_LS2Arbiter_LS2_end		__attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_16)));
pipe int    chan_LS2Arbiter_LS3_end		__attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_16)));
pipe int    chan_LS2Arbiter_LS4_end		__attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_16)));
pipe int    chan_LS2Arbiter_LS5_end		__attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_16)));
pipe int    chan_LS2Arbiter_LS6_end		__attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_16)));
pipe int    chan_LS2Arbiter_LS7_end		__attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_16)));
pipe int    chan_LS2Arbiter_LS8_end		__attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_16)));
pipe int    chan_LS2Arbiter_LS9_end		__attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_16)));
// Get LS-eval-count, new energy, new genotype from LSs
// Resized to valid SDAccel depths: 16, 32, ...
pipe float2  chan_LS2GA_LS1_evalenergy      __attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_16)));
pipe float2  chan_LS2GA_LS2_evalenergy      __attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_16)));
pipe float2  chan_LS2GA_LS3_evalenergy      __attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_16)));
pipe float2  chan_LS2GA_LS4_evalenergy      __attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_16)));
pipe float2  chan_LS2GA_LS5_evalenergy      __attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_16)));
pipe float2  chan_LS2GA_LS6_evalenergy      __attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_16)));
pipe float2  chan_LS2GA_LS7_evalenergy      __attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_16)));
pipe float2  chan_LS2GA_LS8_evalenergy      __attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_16)));
pipe float2  chan_LS2GA_LS9_evalenergy      __attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_16)));

// Resized to valid SDAccel depths: 16, 32, ...
pipe float   chan_LS2GA_LS1_genotype        __attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_64)));
pipe float   chan_LS2GA_LS2_genotype        __attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_64)));
pipe float   chan_LS2GA_LS3_genotype        __attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_64)));
pipe float   chan_LS2GA_LS4_genotype        __attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_64)));
pipe float   chan_LS2GA_LS5_genotype        __attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_64)));
pipe float   chan_LS2GA_LS6_genotype        __attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_64)));
pipe float   chan_LS2GA_LS7_genotype        __attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_64)));
pipe float   chan_LS2GA_LS8_genotype        __attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_64)));
pipe float   chan_LS2GA_LS9_genotype        __attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_64)));

// Turn-off signals to LSs
// Resized to valid SDAccel depths: 16, 32, ...
pipe int    chan_GA2LS_Off1_active	    __attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_16)));
pipe int    chan_GA2LS_Off2_active	    __attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_16)));
pipe int    chan_GA2LS_Off3_active	    __attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_16)));
pipe int    chan_GA2LS_Off4_active	    __attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_16)));
pipe int    chan_GA2LS_Off5_active	    __attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_16)));
pipe int    chan_GA2LS_Off6_active	    __attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_16)));
pipe int    chan_GA2LS_Off7_active	    __attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_16)));
pipe int    chan_GA2LS_Off8_active	    __attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_16)));
pipe int    chan_GA2LS_Off9_active	    __attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_16)));

// Send genotype-producer-pipe selector and genotype 
// from IGL_Arbiter to Conform
// Resized to valid SDAccel depths: 16, 32, ...
pipe char   chan_IGL2Conform_actmode	    __attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_16))); // active, mode
pipe float  chan_IGL2Conform_genotype       __attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_512)));

// Turn-off signal to IGL_Arbiter, Conform, InterE, IntraE
// Resized to valid SDAccel depths: 16, 32, ...
pipe int   chan_IGLArbiter_Off		    __attribute__((xcl_reqd_pipe_depth(PIPE_DEPTH_16)));

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
/*
__kernel __attribute__ ((max_global_work_dim(0)))
*/
__kernel __attribute__ ((reqd_work_group_size(1,1,1)))
void Krnl_GA(
	     __global       float*           restrict GlobPopulationCurrent,
	     __global       float*           restrict GlobEnergyCurrent,
	     #if defined(SINGLE_COPY_POP_ENE)
   	     __global       unsigned int*    restrict GlobEvals_performed,
             __global       unsigned int*    restrict GlobGens_performed,
	     #else
	     __global       unsigned int*    restrict GlobEvalsGenerations_performed,
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
	__attribute__((xcl_pipeline_loop))
	LOOP_FOR_GA_IC_OUTER:
	for (ushort pop_cnt = 0; pop_cnt < DockConst_pop_size; pop_cnt++) {
		// Calculate energy
		const int tmp_int_zero = 0;
		write_pipe_block(chan_GA2IGL_IC_active, &tmp_int_zero);
/*
		mem_fence(CLK_CHANNEL_MEM_FENCE);
*/
		__attribute__((xcl_pipeline_loop))
		LOOP_FOR_GA_IC_INNER_WRITE_GENOTYPE:
		for (uchar pipe_cnt=0; pipe_cnt<DockConst_num_of_genes; pipe_cnt++) {
			float tmp_ic;
			#if defined(SINGLE_COPY_POP_ENE)
			tmp_ic = GlobPopCurr[pop_cnt*ACTUAL_GENOTYPE_LENGTH + pipe_cnt];
			#else
			tmp_ic = GlobPopulationCurrent[pop_cnt*ACTUAL_GENOTYPE_LENGTH + pipe_cnt];
			#endif

			LocalPopCurr[pop_cnt][pipe_cnt & MASK_GENOTYPE] = tmp_ic;
			write_pipe_block(chan_IC2Conf_genotype, &tmp_ic);	
		}

		#if defined (DEBUG_KRNL_IC)
		printf("\nIC - tx pop: %u", pop_cnt); 		
		#endif

		// Read energy
		float energyIA_IC_rx;
		float energyIE_IC_rx;
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
		LOOP_WHILE_GA_IC_INNER_READ_ENERGY:
		while( (intra_valid != 0) || (inter_valid != 0)) {

/*
			if (intra_valid == false) {
*/
			if (intra_valid != 0) {
				intra_valid = read_pipe(chan_Intrae2StoreIC_intrae, &energyIA_IC_rx);
			}
/*
			else if (inter_valid == false) {
*/
			else if (inter_valid != 0) {
				inter_valid = read_pipe(chan_Intere2StoreIC_intere, &energyIE_IC_rx);
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

	__attribute__((xcl_pipeline_loop))
	LOOP_WHILE_GA_MAIN:
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
		float LocalPopNext[MAX_POPSIZE][ACTUAL_GENOTYPE_LENGTH];

/*
		float __attribute__ ((
				       memory,
		   		       numbanks(4),
			               bankwidth(4),
			              )) LocalEneNext[MAX_POPSIZE];
*/
		float LocalEneNext[MAX_POPSIZE];

		// ------------------------------------------------------------------
		// Genetic Generation (GG)
		// ------------------------------------------------------------------
/*
		float __attribute__ ((
				       memory,
		   		       numbanks(1),
			               bankwidth(64),
			               singlepump,
 			               numreadports(6),
			               numwriteports(1)
			              )) loc_energies[MAX_POPSIZE];
*/
		float loc_energies[MAX_POPSIZE];

		ushort best_entity = 0;

		__attribute__((xcl_pipeline_loop))
		LOOP_FOR_GA_SHIFT: 
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

		/*
		#pragma ivdep array (LocalPopNext)
		#pragma ivdep array (LocalEneNext)
		*/
		__attribute__((xcl_pipeline_loop))
		LOOP_FOR_GA_OUTER_GLOBAL: 
		for (ushort new_pop_cnt = 1; new_pop_cnt < DockConst_pop_size; new_pop_cnt++) {

			// ---------------------------------------------------
			// Elitism: copying the best entity to new population
			// ---------------------------------------------------
			if (new_pop_cnt == 1) {
				__attribute__((xcl_pipeline_loop))
				LOOP_FOR_GA_INNER_ELITISM:
				for (uchar gene_cnt=0; gene_cnt<DockConst_num_of_genes; gene_cnt++) {
					LocalPopNext[0][gene_cnt & MASK_GENOTYPE] = LocalPopCurr[best_entity][gene_cnt & MASK_GENOTYPE]; 	
				} 		
				LocalEneNext[0] = loc_energies[best_entity];
			}

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
			float8 bt_tmp;
			read_pipe_block(chan_PRNG2GA_BT_ushort_float_prng, &bt_tmp);
/*
			mem_fence(CLK_CHANNEL_MEM_FENCE);
*/
//printf("test point 1\n");
			// Convert: float prng that must be still converted to short
			float bt_tmp_uf0 = bt_tmp.s0;
			float bt_tmp_uf1 = bt_tmp.s2;
			float bt_tmp_uf2 = bt_tmp.s4;
			float bt_tmp_uf3 = bt_tmp.s6;

			// short prng ready to be used, replace ushort prng_BT_U[4];
/*
			ushort bt_tmp_u0 = *(uint*)&bt_tmp_uf0;
			ushort bt_tmp_u1 = *(uint*)&bt_tmp_uf1;
			ushort bt_tmp_u2 = *(uint*)&bt_tmp_uf2;
			ushort bt_tmp_u3 = *(uint*)&bt_tmp_uf3;
*/
			// Check "Krnl_Prng_BT_ushort_float"
			// To surpass error in hw_emu		
			ushort bt_tmp_u0 = bt_tmp_uf0;
			ushort bt_tmp_u1 = bt_tmp_uf1;
			ushort bt_tmp_u2 = bt_tmp_uf2;
			ushort bt_tmp_u3 = bt_tmp_uf3;

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

			__attribute__((xcl_pipeline_loop))
			LOOP_FOR_GA_INNER_BT:
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
			uchar2 prng_GG_C;
			read_pipe_block(chan_PRNG2GA_GG_uchar_prng, &prng_GG_C);
/*
			mem_fence(CLK_CHANNEL_MEM_FENCE);
*/
//printf("test point 2\n");

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

			const int tmp_int_zero = 0;
			write_pipe_block(chan_GA2IGL_GG_active, &tmp_int_zero);
/*
			mem_fence(CLK_CHANNEL_MEM_FENCE);
*/
//printf("test point 3\n");

			__attribute__((xcl_pipeline_loop))
			LOOP_FOR_GA_INNER_CROSS_MUT:
			for (uchar gene_cnt=0; gene_cnt<DockConst_num_of_genes; gene_cnt++) {
				float prngGG;
				read_pipe_block(chan_PRNG2GA_GG_float_prng, &prngGG);
/*
				mem_fence(CLK_CHANNEL_MEM_FENCE);
*/
//printf("test point 4\n");

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
				write_pipe_block(chan_GG2Conf_genotype, &tmp_offspring);
//printf("test point 5\n");
			}

			#if defined (DEBUG_KRNL_GG)
			printf("GG - tx pop: %u", new_pop_cnt); 		
			#endif	

			// Read energy
			float energyIA_GG_rx;
			float energyIE_GG_rx;
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
			LOOP_WHILE_GA_INNER_READ_ENERGIES:
			while( (intra_valid != 0) || (inter_valid != 0)) {
/*
				if (intra_valid == false) {
*/
				if (intra_valid != 0) {
					intra_valid = read_pipe(chan_Intrae2StoreGG_intrae, &energyIA_GG_rx);
				}
/*
				else if (inter_valid == false) {
*/
				else if (inter_valid != 0) {
					inter_valid = read_pipe(chan_Intere2StoreGG_intere, &energyIE_GG_rx);
				}

//printf("intra_valid: %i, inter_valid: %i\n", intra_valid, inter_valid);
			}
//printf("test point 5\n");			
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

		/*
		#pragma ivdep
		*/
		__attribute__((xcl_pipeline_loop))
		LOOP_FOR_GA_LS_OUTER:
		for (ushort ls_ent_cnt=0; ls_ent_cnt<DockConst_num_of_lsentities; ls_ent_cnt+=9) {

			// Choose random & different entities on every iteration
			ushort16 entity_ls;
			read_pipe_block(chan_PRNG2GA_LS123_ushort_prng, &entity_ls);
/*
			mem_fence(CLK_CHANNEL_MEM_FENCE);
*/
//printf("test point LS 1\n");

			ushort entity_ls1 = entity_ls.s0;
			ushort entity_ls2 = entity_ls.s1;
			ushort entity_ls3 = entity_ls.s2;
			ushort entity_ls4 = entity_ls.s3;
			ushort entity_ls5 = entity_ls.s4;
			ushort entity_ls6 = entity_ls.s5;
			ushort entity_ls7 = entity_ls.s6;
			ushort entity_ls8 = entity_ls.s7;
			ushort entity_ls9 = entity_ls.s8;

			write_pipe_block(chan_GA2LS_LS1_energy, &LocalEneNext[entity_ls1]);
			write_pipe_block(chan_GA2LS_LS2_energy, &LocalEneNext[entity_ls2]);
			write_pipe_block(chan_GA2LS_LS3_energy, &LocalEneNext[entity_ls3]);
			write_pipe_block(chan_GA2LS_LS4_energy, &LocalEneNext[entity_ls4]);
			write_pipe_block(chan_GA2LS_LS5_energy, &LocalEneNext[entity_ls5]);
			write_pipe_block(chan_GA2LS_LS6_energy, &LocalEneNext[entity_ls6]);
			write_pipe_block(chan_GA2LS_LS7_energy, &LocalEneNext[entity_ls7]);
			write_pipe_block(chan_GA2LS_LS8_energy, &LocalEneNext[entity_ls8]);
			write_pipe_block(chan_GA2LS_LS9_energy, &LocalEneNext[entity_ls9]);

//printf("test point LS 2\n");
/*
			mem_fence(CLK_CHANNEL_MEM_FENCE);
*/
			__attribute__((xcl_pipeline_loop))
			LOOP_GA_LS_INNER_WRITE_GENOTYPE:
			for (uchar gene_cnt=0; gene_cnt<DockConst_num_of_genes; gene_cnt++) {
				write_pipe_block(chan_GA2LS_LS1_genotype, &LocalPopNext[entity_ls1][gene_cnt & MASK_GENOTYPE]);
				write_pipe_block(chan_GA2LS_LS2_genotype, &LocalPopNext[entity_ls2][gene_cnt & MASK_GENOTYPE]);
				write_pipe_block(chan_GA2LS_LS3_genotype, &LocalPopNext[entity_ls3][gene_cnt & MASK_GENOTYPE]);
				write_pipe_block(chan_GA2LS_LS4_genotype, &LocalPopNext[entity_ls4][gene_cnt & MASK_GENOTYPE]);
				write_pipe_block(chan_GA2LS_LS5_genotype, &LocalPopNext[entity_ls5][gene_cnt & MASK_GENOTYPE]);
				write_pipe_block(chan_GA2LS_LS6_genotype, &LocalPopNext[entity_ls6][gene_cnt & MASK_GENOTYPE]);
				write_pipe_block(chan_GA2LS_LS7_genotype, &LocalPopNext[entity_ls7][gene_cnt & MASK_GENOTYPE]);
				write_pipe_block(chan_GA2LS_LS8_genotype, &LocalPopNext[entity_ls8][gene_cnt & MASK_GENOTYPE]);
				write_pipe_block(chan_GA2LS_LS9_genotype, &LocalPopNext[entity_ls9][gene_cnt & MASK_GENOTYPE]);
			}
/*
			mem_fence(CLK_CHANNEL_MEM_FENCE);
*/
//printf("test point LS 3\n");

			float2 evalenergy_tmp1;
			float2 evalenergy_tmp2;
			float2 evalenergy_tmp3;
			float2 evalenergy_tmp4;
			float2 evalenergy_tmp5;
			float2 evalenergy_tmp6;
			float2 evalenergy_tmp7;
			float2 evalenergy_tmp8;
			float2 evalenergy_tmp9;
/*
			bool ls1_done = false;
			bool ls2_done = false;
			bool ls3_done = false;
			bool ls4_done = false;
			bool ls5_done = false;
			bool ls6_done = false;
			bool ls7_done = false;
			bool ls8_done = false;
			bool ls9_done = false;  
*/
			int ls1_done = 1;
			int ls2_done = 1;
			int ls3_done = 1;
		 	int ls4_done = 1;
			int ls5_done = 1;
			int ls6_done = 1;
			int ls7_done = 1;
			int ls8_done = 1;
			int ls9_done = 1;  

/*
			while( (ls1_done == false) || 
			       (ls2_done == false) || 
			       (ls3_done == false) || 
			       (ls4_done == false) || 
			       (ls5_done == false) ||
			       (ls6_done == false) || 
			       (ls7_done == false) || 
			       (ls8_done == false) || 
			       (ls9_done == false) 
*/
			__attribute__((xcl_pipeline_loop))
			LOOP_WHILE_GA_LS_INNER_READ_ENERGIES:
			while( (ls1_done != 0) || 
			       (ls2_done != 0) || 
			       (ls3_done != 0) || 
			       (ls4_done != 0) || 
			       (ls5_done != 0) ||
			       (ls6_done != 0) || 
			       (ls7_done != 0) || 
			       (ls8_done != 0) || 
			       (ls9_done != 0) 
			)
			{
/*
				if (ls1_done == false) {
*/
				if (ls1_done != 0) {
					ls1_done = read_pipe(chan_LS2GA_LS1_evalenergy, &evalenergy_tmp1);
				}
/*
				else if (ls2_done == false) {
*/
				else if (ls2_done != 0) {
					ls2_done = read_pipe(chan_LS2GA_LS2_evalenergy, &evalenergy_tmp2);
				}
/*
				else if (ls3_done == false) {
*/
				else if (ls3_done != 0) {
					ls3_done = read_pipe(chan_LS2GA_LS3_evalenergy, &evalenergy_tmp3);
				}
/*
				else if (ls4_done == false) {
*/
				else if (ls4_done != 0) {
					ls4_done = read_pipe(chan_LS2GA_LS4_evalenergy, &evalenergy_tmp4);
				}
/*
				else if (ls5_done == false) {
*/
				else if (ls5_done != 0) {
					ls5_done = read_pipe(chan_LS2GA_LS5_evalenergy, &evalenergy_tmp5);
				}
/*
				else if (ls6_done == false) {
*/
				else if (ls6_done != 0) {
					ls6_done = read_pipe(chan_LS2GA_LS6_evalenergy, &evalenergy_tmp6);
				}
/*
				else if (ls7_done == false) {
*/
				else if (ls7_done != 0) {
					ls7_done = read_pipe(chan_LS2GA_LS7_evalenergy, &evalenergy_tmp7);
				}
/*
				else if (ls8_done == false) {
*/
				else if (ls8_done != 0) {
					ls8_done = read_pipe(chan_LS2GA_LS8_evalenergy, &evalenergy_tmp8);
				}
/*
				else if (ls9_done == false) {
*/
				else if (ls9_done != 0) {
					ls9_done = read_pipe(chan_LS2GA_LS9_evalenergy, &evalenergy_tmp9);
				}
			}
		
			#if defined (DEBUG_KRNL_LS)
			printf("LS - got all eval & energies back\n");
			#endif

			float eetmp1 = evalenergy_tmp1.x;
			float eetmp2 = evalenergy_tmp2.x;
			float eetmp3 = evalenergy_tmp3.x;
			float eetmp4 = evalenergy_tmp4.x;
			float eetmp5 = evalenergy_tmp5.x;
			float eetmp6 = evalenergy_tmp6.x;
			float eetmp7 = evalenergy_tmp7.x;
			float eetmp8 = evalenergy_tmp8.x;
			float eetmp9 = evalenergy_tmp9.x;

			uint eval_tmp1 = *(uint*)&eetmp1;
			uint eval_tmp2 = *(uint*)&eetmp2;
			uint eval_tmp3 = *(uint*)&eetmp3;
			uint eval_tmp4 = *(uint*)&eetmp4;
			uint eval_tmp5 = *(uint*)&eetmp5;
			uint eval_tmp6 = *(uint*)&eetmp6;
			uint eval_tmp7 = *(uint*)&eetmp7;
			uint eval_tmp8 = *(uint*)&eetmp8;
			uint eval_tmp9 = *(uint*)&eetmp9;

			LocalEneNext[entity_ls1] = evalenergy_tmp1.y;
			LocalEneNext[entity_ls2] = evalenergy_tmp2.y;
			LocalEneNext[entity_ls3] = evalenergy_tmp3.y;
			LocalEneNext[entity_ls4] = evalenergy_tmp4.y;
			LocalEneNext[entity_ls5] = evalenergy_tmp5.y;
			LocalEneNext[entity_ls6] = evalenergy_tmp6.y;
			LocalEneNext[entity_ls7] = evalenergy_tmp7.y;
			LocalEneNext[entity_ls8] = evalenergy_tmp8.y;
			LocalEneNext[entity_ls9] = evalenergy_tmp9.y;

			/*
			#pragma ivdep
			*/
			__attribute__((xcl_pipeline_loop))
			LOOP_FOR_GA_LS_INNER_READ_GENOTYPE:
			for (uchar gene_cnt=0; gene_cnt<DockConst_num_of_genes; gene_cnt++) {

				read_pipe_block(chan_LS2GA_LS1_genotype, &LocalPopNext[entity_ls1][gene_cnt & MASK_GENOTYPE]);
				read_pipe_block(chan_LS2GA_LS2_genotype, &LocalPopNext[entity_ls2][gene_cnt & MASK_GENOTYPE]);
				read_pipe_block(chan_LS2GA_LS3_genotype, &LocalPopNext[entity_ls3][gene_cnt & MASK_GENOTYPE]);
				read_pipe_block(chan_LS2GA_LS4_genotype, &LocalPopNext[entity_ls4][gene_cnt & MASK_GENOTYPE]);
				read_pipe_block(chan_LS2GA_LS5_genotype, &LocalPopNext[entity_ls5][gene_cnt & MASK_GENOTYPE]);
				read_pipe_block(chan_LS2GA_LS6_genotype, &LocalPopNext[entity_ls6][gene_cnt & MASK_GENOTYPE]);
				read_pipe_block(chan_LS2GA_LS7_genotype, &LocalPopNext[entity_ls7][gene_cnt & MASK_GENOTYPE]);
				read_pipe_block(chan_LS2GA_LS8_genotype, &LocalPopNext[entity_ls8][gene_cnt & MASK_GENOTYPE]);
				read_pipe_block(chan_LS2GA_LS9_genotype, &LocalPopNext[entity_ls9][gene_cnt & MASK_GENOTYPE]);
			}

			ls_eval_cnt += eval_tmp1 + eval_tmp2 + eval_tmp3 + eval_tmp4 + eval_tmp5 + eval_tmp6 + eval_tmp7 + eval_tmp8 + eval_tmp9;

			#if defined (DEBUG_KRNL_LS)
			printf("%u, ls_eval_cnt: %u\n", ls_ent_cnt, ls_eval_cnt);
			printf("LS - got all genotypes back\n");
			#endif
		} // End of for-loop ls_ent_cnt
		// ------------------------------------------------------------------

		// Update current pops & energies
		__attribute__((xcl_pipeline_loop))
		LOOP_FOR_GA_UPDATEPOP_OUTER:
		for (ushort pop_cnt=0; pop_cnt<DockConst_pop_size; pop_cnt++) {

			__attribute__((xcl_pipeline_loop))
			LOOP_GA_UPDATEPOP_INNER:
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
	const int tmp_int_one = 1;
	write_pipe_block(chan_Arbiter_BT_ushort_float_off,  	&tmp_int_one);
	write_pipe_block(chan_Arbiter_GG_uchar_off, 		&tmp_int_one);
	write_pipe_block(chan_Arbiter_GG_float_off, 		&tmp_int_one);
	write_pipe_block(chan_Arbiter_LS123_ushort_off,  	&tmp_int_one);
	write_pipe_block(chan_Arbiter_LS_float_off, 		&tmp_int_one);
	write_pipe_block(chan_Arbiter_LS2_float_off, 		&tmp_int_one);
	write_pipe_block(chan_Arbiter_LS3_float_off, 		&tmp_int_one);
	write_pipe_block(chan_Arbiter_LS4_float_off, 		&tmp_int_one);
	write_pipe_block(chan_Arbiter_LS5_float_off, 		&tmp_int_one);
	write_pipe_block(chan_Arbiter_LS6_float_off, 		&tmp_int_one);
	write_pipe_block(chan_Arbiter_LS7_float_off, 		&tmp_int_one);
	write_pipe_block(chan_Arbiter_LS8_float_off, 		&tmp_int_one);
	write_pipe_block(chan_Arbiter_LS9_float_off, 		&tmp_int_one);
/*
	mem_fence(CLK_CHANNEL_MEM_FENCE);
*/

	// Turn off LS kernels
	write_pipe_block(chan_GA2LS_Off1_active,  		&tmp_int_one);
	write_pipe_block(chan_GA2LS_Off2_active,  		&tmp_int_one);
	write_pipe_block(chan_GA2LS_Off3_active,  		&tmp_int_one);
	write_pipe_block(chan_GA2LS_Off4_active,  		&tmp_int_one);
	write_pipe_block(chan_GA2LS_Off5_active,  		&tmp_int_one);
	write_pipe_block(chan_GA2LS_Off6_active,  		&tmp_int_one);
	write_pipe_block(chan_GA2LS_Off7_active,  		&tmp_int_one);
	write_pipe_block(chan_GA2LS_Off8_active,  		&tmp_int_one);
	write_pipe_block(chan_GA2LS_Off9_active,  		&tmp_int_one);
/*
	mem_fence(CLK_CHANNEL_MEM_FENCE);
*/

	// Turn off IGL_Arbiter, Conform, InterE, IntraE kernerls
	write_pipe_block(chan_IGLArbiter_Off,     		&tmp_int_one);
/*
	mem_fence(CLK_CHANNEL_MEM_FENCE);
*/

	// Write final pop & energies back to FPGA-board DDRs
	__attribute__((xcl_pipeline_loop))
	LOOP_GA_WRITEPOP2DDR_OUTER:
	for (ushort pop_cnt=0;pop_cnt<DockConst_pop_size; pop_cnt++) { 	

		__attribute__((xcl_pipeline_loop))
		LOOP_GA_WRITEPOP2DDR_INNER:
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

