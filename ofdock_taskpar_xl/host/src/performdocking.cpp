/*
 * (C) 2013. Evopro Innovation Kft.
 *
 * performdocking.cu
 *
 * Created on: 2010.04.20.
 * Author: pechan.imre
 */

//// ------------------------
//// Correct time measurement
//// Moved from main.cpp to performdocking.cpp
//// to skip measuring build time
//#include <sys/time.h>
//// ------------------------
#include "performdocking.h"

//// --------------------------------
//// Altera OpenCL Helper Variables
//// --------------------------------
#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <cstring>
#include "CL/opencl.h"
#include "AOCLUtils/aocl_utils.h"

using namespace aocl_utils;

#define STRING_BUFFER_LEN 1024

// OpenCL runtime configuration
static cl_platform_id   platform      = NULL;
static cl_device_id     device        = NULL;
static cl_context       context       = NULL;

// Kernel name, as defined in the CL file
#ifdef ENABLE_KERNEL1
static cl_command_queue command_queue1 = NULL;
static cl_kernel kernel1  = NULL;
static const char *name_k1 = "Krnl_GA";
#endif

#ifdef ENABLE_KERNEL2
static cl_command_queue command_queue2 = NULL;
static cl_kernel kernel2  = NULL;
static const char *name_k2 = "Krnl_Conform";
#endif

#ifdef ENABLE_KERNEL3
static cl_command_queue command_queue3 = NULL;
static cl_kernel kernel3  = NULL;
static const char *name_k3 = "Krnl_InterE";
#endif

#ifdef ENABLE_KERNEL4
static cl_command_queue command_queue4 = NULL;
static cl_kernel kernel4  = NULL;
static const char *name_k4 = "Krnl_IntraE";
#endif




#if 0
#ifdef ENABLE_KERNEL8
static cl_command_queue command_queue8 = NULL;
static cl_kernel kernel8  = NULL;
static const char *name_k8 = "Krnl_Prng_BT_ushort";
#endif
#endif

#if 0
#ifdef ENABLE_KERNEL5
static cl_command_queue command_queue5 = NULL;
static cl_kernel kernel5  = NULL;
static const char *name_k5 = "Krnl_Prng_BT_float";
#endif
#endif

#ifdef ENABLE_KERNEL10
static cl_command_queue command_queue10 = NULL;
static cl_kernel kernel10  = NULL;
static const char *name_k10 = "Krnl_Prng_GG_uchar";
#endif

#ifdef ENABLE_KERNEL6
static cl_command_queue command_queue6 = NULL;
static cl_kernel kernel6  = NULL;
static const char *name_k6 = "Krnl_Prng_GG_float";
#endif

#if 0
#ifdef ENABLE_KERNEL9
static cl_command_queue command_queue9 = NULL;
static cl_kernel kernel9  = NULL;
static const char *name_k9 = "Krnl_Prng_LS_ushort";
#endif
#endif

#ifdef ENABLE_KERNEL7
static cl_command_queue command_queue7 = NULL;
static cl_kernel kernel7  = NULL;
static const char *name_k7 = "Krnl_Prng_LS_float";
#endif

#if 0
#ifdef ENABLE_KERNEL11
static cl_command_queue command_queue11 = NULL;
static cl_kernel kernel11  = NULL;
static const char *name_k11 = "Krnl_Prng_Arbiter";
#endif
#endif

#ifdef ENABLE_KERNEL12
static cl_command_queue command_queue12 = NULL;
static cl_kernel kernel12  = NULL;
static const char *name_k12 = "Krnl_LS";
#endif

#if 0
#ifdef ENABLE_KERNEL13
static cl_command_queue command_queue13 = NULL;
static cl_kernel kernel13  = NULL;
static const char *name_k13 = "Krnl_LS_Arbiter";
#endif
#endif




#ifdef ENABLE_KERNEL14
static cl_command_queue command_queue14 = NULL;
static cl_kernel kernel14  = NULL;
static const char *name_k14 = "Krnl_Prng_LS2_float";
#endif

#ifdef ENABLE_KERNEL15
static cl_command_queue command_queue15 = NULL;
static cl_kernel kernel15  = NULL;
static const char *name_k15 = "Krnl_LS2";
#endif

#if 0
#ifdef ENABLE_KERNEL16
static cl_command_queue command_queue16 = NULL;
static cl_kernel kernel16  = NULL;
static const char *name_k16 = "Krnl_LS2_Arbiter";
#endif
#endif

#if 0
#ifdef ENABLE_KERNEL17
static cl_command_queue command_queue17 = NULL;
static cl_kernel kernel17  = NULL;
static const char *name_k17 = "Krnl_Conform2";
#endif
#endif

#if 0
#ifdef ENABLE_KERNEL18
static cl_command_queue command_queue18 = NULL;
static cl_kernel kernel18  = NULL;
static const char *name_k18 = "Krnl_InterE2";
#endif
#endif

#if 0
#ifdef ENABLE_KERNEL19
static cl_command_queue command_queue19 = NULL;
static cl_kernel kernel19  = NULL;
static const char *name_k19 = "Krnl_IntraE2";
#endif
#endif








#ifdef ENABLE_KERNEL20
static cl_command_queue command_queue20 = NULL;
static cl_kernel kernel20  = NULL;
static const char *name_k20 = "Krnl_Prng_LS3_float";
#endif

#ifdef ENABLE_KERNEL21
static cl_command_queue command_queue21 = NULL;
static cl_kernel kernel21  = NULL;
static const char *name_k21 = "Krnl_LS3";
#endif

#if 0
#ifdef ENABLE_KERNEL22
static cl_command_queue command_queue22 = NULL;
static cl_kernel kernel22  = NULL;
static const char *name_k22 = "Krnl_LS3_Arbiter";
#endif
#endif

#if 0
#ifdef ENABLE_KERNEL23
static cl_command_queue command_queue23 = NULL;
static cl_kernel kernel23  = NULL;
static const char *name_k23 = "Krnl_Conf_Arbiter";
#endif
#endif

#if 0
#ifdef ENABLE_KERNEL24
static cl_command_queue command_queue24 = NULL;
static cl_kernel kernel24  = NULL;
static const char *name_k24 = "Krnl_Conf_Arbiter2";
#endif
#endif

#if 0
#ifdef ENABLE_KERNEL25
static cl_command_queue command_queue25 = NULL;
static cl_kernel kernel25  = NULL;
static const char *name_k25 = "Krnl_Prng_LS2_ushort";
#endif
#endif

#if 0
#ifdef ENABLE_KERNEL26
static cl_command_queue command_queue26 = NULL;
static cl_kernel kernel26  = NULL;
static const char *name_k26 = "Krnl_Prng_LS3_ushort";
#endif
#endif

#ifdef ENABLE_KERNEL27
static cl_command_queue command_queue27 = NULL;
static cl_kernel kernel27  = NULL;
static const char *name_k27 = "Krnl_IGL_Arbiter";
#endif

#if 0
#ifdef ENABLE_KERNEL28
static cl_command_queue command_queue28 = NULL;
static cl_kernel kernel28  = NULL;
static const char *name_k28 = "Krnl_IA_pipeline_Arbiter";
#endif
#endif

#if 0
#ifdef ENABLE_KERNEL29
static cl_command_queue command_queue29 = NULL;
static cl_kernel kernel29  = NULL;
static const char *name_k29 = "Krnl_IA_pipeline";
#endif
#endif

#if 0
#ifdef ENABLE_KERNEL30
static cl_command_queue command_queue30 = NULL;
static cl_kernel kernel30  = NULL;
static const char *name_k30 = "Krnl_IA_pipeline2";
#endif
#endif

#if 0
#ifdef ENABLE_KERNEL31
static cl_command_queue command_queue31 = NULL;
static cl_kernel kernel31  = NULL;
static const char *name_k31 = "Krnl_Prng_BT_Arbiter";
#endif
#endif

#if 0
#ifdef ENABLE_KERNEL32
static cl_command_queue command_queue32 = NULL;
static cl_kernel kernel32  = NULL;
static const char *name_k32 = "Krnl_Prng_GG_Arbiter";
#endif
#endif

#if 0
#ifdef ENABLE_KERNEL33
static cl_command_queue command_queue33 = NULL;
static cl_kernel kernel33  = NULL;
static const char *name_k33 = "Krnl_Prng_LS_ushort_Arbiter";
#endif
#endif

#if 0
#ifdef ENABLE_KERNEL34
static cl_command_queue command_queue34 = NULL;
static cl_kernel kernel34  = NULL;
static const char *name_k34 = "Krnl_Prng_LS_float_Arbiter";
#endif
#endif

#ifdef ENABLE_KERNEL35
static cl_command_queue command_queue35 = NULL;
static cl_kernel kernel35  = NULL;
static const char *name_k35 = "Krnl_Prng_LS123_ushort";
#endif

#ifdef ENABLE_KERNEL36
static cl_command_queue command_queue36 = NULL;
static cl_kernel kernel36  = NULL;
static const char *name_k36 = "Krnl_Prng_BT_ushort_float";
#endif






#ifdef ENABLE_KERNEL37
static cl_command_queue command_queue37 = NULL;
static cl_kernel kernel37  = NULL;
static const char *name_k37 = "Krnl_Prng_LS4_float";
#endif

#ifdef ENABLE_KERNEL38
static cl_command_queue command_queue38 = NULL;
static cl_kernel kernel38  = NULL;
static const char *name_k38 = "Krnl_Prng_LS5_float";
#endif

#ifdef ENABLE_KERNEL39
static cl_command_queue command_queue39 = NULL;
static cl_kernel kernel39  = NULL;
static const char *name_k39 = "Krnl_LS4";
#endif

#ifdef ENABLE_KERNEL40
static cl_command_queue command_queue40 = NULL;
static cl_kernel kernel40  = NULL;
static const char *name_k40 = "Krnl_LS5";
#endif






#ifdef ENABLE_KERNEL41
static cl_command_queue command_queue41 = NULL;
static cl_kernel kernel41  = NULL;
static const char *name_k41 = "Krnl_Prng_LS6_float";
#endif

#ifdef ENABLE_KERNEL42
static cl_command_queue command_queue42 = NULL;
static cl_kernel kernel42  = NULL;
static const char *name_k42 = "Krnl_Prng_LS7_float";
#endif

#ifdef ENABLE_KERNEL43
static cl_command_queue command_queue43 = NULL;
static cl_kernel kernel43  = NULL;
static const char *name_k43 = "Krnl_Prng_LS8_float";
#endif

#ifdef ENABLE_KERNEL44
static cl_command_queue command_queue44 = NULL;
static cl_kernel kernel44  = NULL;
static const char *name_k44 = "Krnl_Prng_LS9_float";
#endif



#ifdef ENABLE_KERNEL45
static cl_command_queue command_queue45 = NULL;
static cl_kernel kernel45  = NULL;
static const char *name_k45 = "Krnl_LS6";
#endif

#ifdef ENABLE_KERNEL46
static cl_command_queue command_queue46 = NULL;
static cl_kernel kernel46  = NULL;
static const char *name_k46 = "Krnl_LS7";
#endif

#ifdef ENABLE_KERNEL47
static cl_command_queue command_queue47 = NULL;
static cl_kernel kernel47  = NULL;
static const char *name_k47 = "Krnl_LS8";
#endif

#ifdef ENABLE_KERNEL48
static cl_command_queue command_queue48 = NULL;
static cl_kernel kernel48  = NULL;
static const char *name_k48 = "Krnl_LS9";
#endif




static cl_program program = NULL;

// Function prototypes
bool init();
void cleanup();
static void device_info_ulong( cl_device_id device, cl_device_info param, const char* name);
static void device_info_uint ( cl_device_id device, cl_device_info param, const char* name);
static void device_info_bool ( cl_device_id device, cl_device_info param, const char* name);
static void device_info_string( cl_device_id device, cl_device_info param, const char* name);
static void display_device_info( cl_device_id device );





//// --------------------------------
//// Host constant struct
//// --------------------------------
Dockparameters dockpars;
kernelconstant_static  KerConstStatic;
#if defined(SINGLE_COPY_POP_ENE)

#else
kernelconstant_dynamic KerConstDynamic;
#endif

//// --------------------------------
//// Host memory buffers
//// --------------------------------
float* cpu_init_populations;
float* cpu_final_populations;
float* cpu_energies;
Ligandresult* cpu_result_ligands;
unsigned int* cpu_prng_seeds;
#if defined(SINGLE_COPY_POP_ENE)
int *cpu_evals_of_runs;
int *cpu_gens_of_runs;
#endif
float* cpu_ref_ori_angles;

//// --------------------------------
//// Device memory buffers
//// --------------------------------
// Altera Issue
// Constant data holding struct data
// Created because structs containing array
// are not supported as OpenCL kernel args

#if defined (FIXED_POINT_INTERE)
cl_mem mem_KerConstStatic_fixpt64_atom_charges_const;
#endif
cl_mem mem_KerConstStatic_atom_charges_const;
cl_mem mem_KerConstStatic_atom_types_const;
cl_mem mem_KerConstStatic_intraE_contributors_const;
cl_mem mem_KerConstStatic_VWpars_AC_const;
cl_mem mem_KerConstStatic_VWpars_BD_const;
cl_mem mem_KerConstStatic_dspars_S_const;
cl_mem mem_KerConstStatic_dspars_V_const;
cl_mem mem_KerConstStatic_rotlist_const;
cl_mem mem_KerConstStatic_ref_coords_const;
cl_mem mem_KerConstStatic_rotbonds_moving_vectors_const;
cl_mem mem_KerConstStatic_rotbonds_unit_vectors_const;
cl_mem mem_KerConstStatic_ref_orientation_quats_const;

/*								                  // Nr elements	// Nr bytes
cl_mem mem_atom_charges_const;		// float [MAX_NUM_OF_ATOMS];			// 90	 = 90	//360
cl_mem mem_atom_types_const;		// char  [MAX_NUM_OF_ATOMS];			// 90	 = 90	//360
cl_mem mem_intraE_contributors_const;	// char  [3*MAX_INTRAE_CONTRIBUTORS];		// 3*8128=28384 //24384	
cl_mem mem_VWpars_AC_const;		// float [MAX_NUM_OF_ATYPES*MAX_NUM_OF_ATYPES];	// 14*14 = 196  //784
cl_mem mem_VWpars_BD_const;		// float [MAX_NUM_OF_ATYPES*MAX_NUM_OF_ATYPES]; // 14*14 = 196	//784
cl_mem mem_dspars_S_const;		// float [MAX_NUM_OF_ATYPES];			// 14    = 14   //56
cl_mem mem_dspars_V_const;		// float [MAX_NUM_OF_ATYPES];			// 14    = 14   //56
cl_mem mem_rotlist_const;		// int   [MAX_NUM_OF_ROTATIONS];		// 4096  = 4096 //16384
cl_mem mem_ref_coords_x_const;		// float [MAX_NUM_OF_ATOMS];			// 90    = 90   //360
cl_mem mem_ref_coords_y_const;		// float [MAX_NUM_OF_ATOMS];			// 90    = 90   //360
cl_mem mem_ref_coords_z_const;		// float [MAX_NUM_OF_ATOMS];			// 90	 = 90   //360
cl_mem mem_rotbonds_moving_vectors_const;// float [3*MAX_NUM_OF_ROTBONDS];		// 3*32  = 96   //384
cl_mem mem_rotbonds_unit_vectors_const;	// float [3*MAX_NUM_OF_ROTBONDS];		// 3*32  = 96   //384
cl_mem mem_ref_orientation_quats_const;	// float [4*MAX_NUM_OF_RUNS];			// 4*100 = 400  //1600
*/

cl_mem mem_dockpars_fgrids;

#if defined(SEPARATE_FGRID_INTERE)
cl_mem mem_dockpars_fgrids2;
cl_mem mem_dockpars_fgrids3;
#endif

cl_mem mem_dockpars_conformations_current;
cl_mem mem_dockpars_energies_current;
/*
cl_mem mem_dockpars_prng_states;
*/

#if defined(SINGLE_COPY_POP_ENE)
cl_mem mem_evals_performed;
cl_mem mem_gens_performed;
#else
cl_mem mem_evals_and_generations_performed;
#endif



































//#if defined (FIXED_POINT_INTERE)
#if 0
//#include "defines_fixedpt_64.h"
fixedpt64* cpu_fixedpt64grids;

#endif



//// --------------------------------
//// Docking
//// --------------------------------
int docking_with_gpu(const Gridinfo*   mygrid,
	             /*const*/ float*  cpu_floatgrids,
                           Dockpars*   mypars,
		     const Liganddata* myligand_init,
		     const int*        argc,
		           char**      argv,
		           clock_t     clock_start_program)
/* The function performs the docking algorithm and generates the corresponding result files.
parameter mygrid:
		describes the grid
		filled with get_gridinfo()
parameter cpu_floatgrids:
		points to the memory region containing the grids
		filled with get_gridvalues_f()
parameter mypars:
		describes the docking parameters
		filled with get_commandpars()
parameter myligand_init:
		describes the ligands
		filled with get_liganddata()
parameters argc and argv:
		are the corresponding command line arguments parameter clock_start_program:
		contains the state of the clock tick counter at the beginning of the program
filled with clock() */
{
	//// ------------------------
	//// OpenCL Host Setup
        //// ------------------------
	if(!init()) {
    		return -1;
  	}
	printf("Init complete!\n"); fflush(stdout);

	Liganddata myligand_reference;
	//Dockparameters dockpars;
	

//#if defined (FIXED_POINT_INTERE)
#if 0
	size_t size_fixedpt64grids;
#else
	size_t size_floatgrids;

	#if defined(SEPARATE_FGRID_INTERE)
	size_t size_floatgrids2;
	size_t size_floatgrids3;
	#endif

#endif

	size_t size_populations;
	size_t size_energies;
	size_t size_prng_seeds;
#if defined(SINGLE_COPY_POP_ENE)
	size_t size_evals_of_runs;
#endif

	clock_t clock_start_docking;
	clock_t	clock_stop_docking;
	clock_t clock_stop_program_before_clustering;

	//allocating CPU memory for initial populations
#if defined(SINGLE_COPY_POP_ENE)
	size_populations = mypars->num_of_runs * mypars->pop_size * ACTUAL_GENOTYPE_LENGTH * sizeof(float);
#else
	//size_populations = mypars->pop_size * GENOTYPE_LENGTH_IN_GLOBMEM * sizeof(float);
	size_populations = mypars->pop_size * ACTUAL_GENOTYPE_LENGTH * sizeof(float);
#endif
        cpu_init_populations = (float*) alignedMalloc(size_populations);
	memset(cpu_init_populations, 0, size_populations);

	//allocating CPU memory for results
#if defined(SINGLE_COPY_POP_ENE)
	size_energies = mypars->num_of_runs * mypars->pop_size * sizeof(float);
#else
	size_energies = mypars->pop_size * sizeof(float);
#endif
	cpu_energies = (float*) alignedMalloc(size_energies);		
	cpu_result_ligands = (Ligandresult*) alignedMalloc(sizeof(Ligandresult)*(mypars->num_of_runs));	
	cpu_final_populations = (float*) alignedMalloc(size_populations);

	//allocating memory in CPU for reference orientation angles
#if defined(SINGLE_COPY_POP_ENE)
	cpu_ref_ori_angles = (float*) alignedMalloc(mypars->num_of_runs*3*sizeof(float));
#else
	cpu_ref_ori_angles = (float*) alignedMalloc(3*sizeof(float));
#endif

	//generating initial populations and random orientation angles of reference ligand
	//(ligand will be moved to origo and scaled as well)
	myligand_reference = *myligand_init;
	gen_initpop_and_reflig(mypars, cpu_init_populations, cpu_ref_ori_angles, &myligand_reference, mygrid);

	//allocating memory in CPU for pseudorandom number generator seeds and
	//generating them (seed for each thread during GA)
	unsigned int num_of_prng_blocks = 25;
	size_prng_seeds = num_of_prng_blocks * mypars->num_of_runs * sizeof(unsigned int);
	cpu_prng_seeds = (unsigned int*) alignedMalloc(size_prng_seeds);
	genseed(time(NULL));	//initializing seed generator

	for (unsigned int i=0; i<num_of_prng_blocks*mypars->num_of_runs; i++) {
#if defined (REPRO)
		cpu_prng_seeds[i] = 1u;
#else
		cpu_prng_seeds[i] = genseed(0u);
#endif
	}

	//srand(time(NULL));

#if defined(SINGLE_COPY_POP_ENE)
	// allocating memory in CPU for evaluation counters
	size_evals_of_runs = mypars->num_of_runs*sizeof(int);
	cpu_evals_of_runs = (int*) alignedMalloc(size_evals_of_runs);
	memset(cpu_evals_of_runs, 0, size_evals_of_runs);

	// allocating memory in CPU for generation counters
	cpu_gens_of_runs = (int*) alignedMalloc(size_evals_of_runs);
	memset(cpu_gens_of_runs, 0, size_evals_of_runs);
#endif

	//preparing the constant data fields for the GPU
	// ----------------------------------------------------------------------
	// The original function does CUDA calls initializing const Kernel data.
	// We create a struct to hold those constants
	// and return them <here> (<here> = where prepare_const_fields_for_gpu() is called),
	// so we can send them to Kernels from <here>, instead of from calcenergy.cpp as originally.
	// ----------------------------------------------------------------------
#if defined(SINGLE_COPY_POP_ENE)
	if (prepare_conststatic_fields_for_gpu(&myligand_reference, mypars, cpu_ref_ori_angles, &KerConstStatic) == 1)
#else
	if (prepare_conststatic_fields_for_gpu(&myligand_reference, mypars, &KerConstStatic) == 1)
#endif
		return 1;

	//preparing parameter struct
	dockpars.num_of_atoms  = ((unsigned char) myligand_reference.num_of_atoms);
	dockpars.num_of_atypes = ((unsigned char) myligand_reference.num_of_atypes);
	dockpars.num_of_intraE_contributors = ((unsigned int) myligand_reference.num_of_intraE_contributors);
	dockpars.gridsize_x    = ((unsigned char)  mygrid->size_xyz[0]);
	dockpars.gridsize_y    = ((unsigned char)  mygrid->size_xyz[1]);
	dockpars.gridsize_z    = ((unsigned char)  mygrid->size_xyz[2]);
	dockpars.g1	       = dockpars.gridsize_x ;
	dockpars.g2	       = dockpars.gridsize_x * dockpars.gridsize_y;
	dockpars.g3	       = dockpars.gridsize_x * dockpars.gridsize_y * dockpars.gridsize_z;
	dockpars.grid_spacing  = ((float) mygrid->spacing);
	dockpars.rotbondlist_length = ((unsigned int) NUM_OF_THREADS_PER_BLOCK*(myligand_reference.num_of_rotcyc));
	dockpars.coeff_elec    = ((float) mypars->coeffs.scaled_AD4_coeff_elec);
	dockpars.coeff_desolv  = ((float) mypars->coeffs.AD4_coeff_desolv);
	// L30nardoSV added
	dockpars.num_of_energy_evals = (unsigned int) mypars->num_of_energy_evals;
	dockpars.num_of_generations  = (unsigned int) mypars->num_of_generations;

	dockpars.pop_size      = (unsigned int) mypars->pop_size;
	dockpars.num_of_genes  = (unsigned int)(myligand_reference.num_of_rotbonds + 6);
	dockpars.tournament_rate = (mypars->tournament_rate)/100;//dockpars.tournament_rate = mypars->tournament_rate;
	dockpars.crossover_rate  = (mypars->crossover_rate)/100; //dockpars.crossover_rate  = mypars->crossover_rate;
	dockpars.mutation_rate   = (mypars->mutation_rate)/100;	 //dockpars.mutation_rate   = mypars->mutation_rate;
	dockpars.abs_max_dang    = mypars->abs_max_dang;
	dockpars.abs_max_dmov    = mypars->abs_max_dmov;
	dockpars.lsearch_rate    = mypars->lsearch_rate;
	dockpars.num_of_lsentities = (unsigned int) (mypars->lsearch_rate/100.0*mypars->pop_size + 0.5);
	dockpars.rho_lower_bound   = mypars->rho_lower_bound;
	dockpars.base_dmov_mul_sqrt3 = mypars->base_dmov_mul_sqrt3;
	dockpars.base_dang_mul_sqrt3 = mypars->base_dang_mul_sqrt3;
	dockpars.cons_limit        = (unsigned int) mypars->cons_limit;
	dockpars.max_num_of_iters  = (unsigned int) mypars->max_num_of_iters;
	dockpars.qasp = mypars->qasp;

/*
// passed correctly
printf("%i %i\n", dockpars.num_of_intraE_contributors, myligand_reference.num_of_intraE_contributors);
*/

	// these variables hold multiplications between kernel-constants
	// better calculate them here and then pass them to Krnl_GA
	const float two_absmaxdmov = 2.0 * dockpars.abs_max_dmov;
	const float two_absmaxdang = 2.0 * dockpars.abs_max_dang;

	// these variables hold multiplications between kernel-constants
	// better calculate them here and then pass them to Krnl_InterE and Krnl_InterE2
	#if defined(SEPARATE_FGRID_INTERE)

	#else
	const unsigned int mul_tmp2 = dockpars.num_of_atypes * dockpars.g3;
	const unsigned int mul_tmp3 = (dockpars.num_of_atypes + 1) * dockpars.g3;
	#endif

	// this variable holds a multiplication between kernel-constants
	// better calculate them it and then pass them to Krnl_IntraE and Krnl_IntraE2
	const unsigned int square_num_of_atypes = dockpars.num_of_atypes * dockpars.num_of_atypes;

	// num of rotbonds
	const unsigned char num_rotbonds = myligand_reference.num_of_rotbonds;

 	//allocating GPU memory for populations, floatgrids,
	//energies, evaluation counters and random number generator states
//#if defined (FIXED_POINT_INTERE)
#if 0
	size_fixedpt64grids = (sizeof(fixedpt64)) * (mygrid->num_of_atypes+2) * (mygrid->size_xyz[0]) * (mygrid->size_xyz[1]) * (mygrid->size_xyz[2]);
#else
	#if defined(SEPARATE_FGRID_INTERE)
	size_floatgrids = sizeof(float) * mygrid->num_of_atypes * mygrid->size_xyz[0]*mygrid->size_xyz[1]* mygrid->size_xyz[2];
	size_floatgrids2= sizeof(float) * mygrid->size_xyz[0] * mygrid->size_xyz[1] * mygrid->size_xyz[2];
	size_floatgrids3= sizeof(float) * mygrid->size_xyz[0] * mygrid->size_xyz[1] * mygrid->size_xyz[2];
	#else
	size_floatgrids = (sizeof(float)) * (mygrid->num_of_atypes+2) * (mygrid->size_xyz[0]) * (mygrid->size_xyz[1]) * (mygrid->size_xyz[2]);
	#endif
#endif

#if defined (FIXED_POINT_INTERE)
	mallocBufferObject(context,CL_MEM_READ_ONLY, MAX_NUM_OF_ATOMS*sizeof(fixedpt64),                &mem_KerConstStatic_fixpt64_atom_charges_const);
#endif
	mallocBufferObject(context,CL_MEM_READ_ONLY, MAX_NUM_OF_ATOMS*sizeof(float),                    &mem_KerConstStatic_atom_charges_const);

	mallocBufferObject(context,CL_MEM_READ_ONLY, MAX_NUM_OF_ATOMS*sizeof(char),                     &mem_KerConstStatic_atom_types_const);

/*
	mallocBufferObject(context,CL_MEM_READ_ONLY, 3*MAX_INTRAE_CONTRIBUTORS*sizeof(char),            &mem_KerConstStatic_intraE_contributors_const);
*/
	mallocBufferObject(context,CL_MEM_READ_ONLY, MAX_INTRAE_CONTRIBUTORS*sizeof(cl_char3),            &mem_KerConstStatic_intraE_contributors_const);


	mallocBufferObject(context,CL_MEM_READ_ONLY, MAX_NUM_OF_ATYPES*MAX_NUM_OF_ATYPES*sizeof(float), &mem_KerConstStatic_VWpars_AC_const);
	mallocBufferObject(context,CL_MEM_READ_ONLY, MAX_NUM_OF_ATYPES*MAX_NUM_OF_ATYPES*sizeof(float), &mem_KerConstStatic_VWpars_BD_const);
	mallocBufferObject(context,CL_MEM_READ_ONLY, MAX_NUM_OF_ATYPES*sizeof(float), 			&mem_KerConstStatic_dspars_S_const);
	mallocBufferObject(context,CL_MEM_READ_ONLY, MAX_NUM_OF_ATYPES*sizeof(float), 			&mem_KerConstStatic_dspars_V_const);
	#if defined (FIXED_POINT_CONFORM)
	// fixed-point
	mallocBufferObject(context,CL_MEM_READ_ONLY, MAX_NUM_OF_ROTATIONS*sizeof(fixedpt), 		&mem_KerConstStatic_rotlist_const);
	mallocBufferObject(context,CL_MEM_READ_ONLY, MAX_NUM_OF_ATOMS*sizeof(cl_int3), 		        &mem_KerConstStatic_ref_coords_const);
	mallocBufferObject(context,CL_MEM_READ_ONLY, MAX_NUM_OF_ROTBONDS*sizeof(cl_int3), 		&mem_KerConstStatic_rotbonds_moving_vectors_const);
	mallocBufferObject(context,CL_MEM_READ_ONLY, MAX_NUM_OF_ROTBONDS*sizeof(cl_int3), 		&mem_KerConstStatic_rotbonds_unit_vectors_const);
	mallocBufferObject(context,CL_MEM_READ_ONLY, MAX_NUM_OF_RUNS*sizeof(cl_int4),			&mem_KerConstStatic_ref_orientation_quats_const);
	#else
	// floating-point (original)
	mallocBufferObject(context,CL_MEM_READ_ONLY, MAX_NUM_OF_ROTATIONS*sizeof(int), 			&mem_KerConstStatic_rotlist_const);
	mallocBufferObject(context,CL_MEM_READ_ONLY, MAX_NUM_OF_ATOMS*sizeof(cl_float3), 		&mem_KerConstStatic_ref_coords_const);
	mallocBufferObject(context,CL_MEM_READ_ONLY, MAX_NUM_OF_ROTBONDS*sizeof(cl_float3), 		&mem_KerConstStatic_rotbonds_moving_vectors_const);
	mallocBufferObject(context,CL_MEM_READ_ONLY, MAX_NUM_OF_ROTBONDS*sizeof(cl_float3), 		&mem_KerConstStatic_rotbonds_unit_vectors_const);
	mallocBufferObject(context,CL_MEM_READ_ONLY, MAX_NUM_OF_RUNS*sizeof(cl_float4),			&mem_KerConstStatic_ref_orientation_quats_const);
	#endif

//#if defined (FIXED_POINT_INTERE)
#if 0
	mallocBufferObject(context,CL_MEM_READ_ONLY,size_fixedpt64grids,   	&mem_dockpars_fgrids);
#else
	mallocBufferObject(context,CL_MEM_READ_ONLY,size_floatgrids,   		&mem_dockpars_fgrids);

	#if defined(SEPARATE_FGRID_INTERE)
	mallocBufferObject(context,CL_MEM_READ_ONLY,size_floatgrids2,   	&mem_dockpars_fgrids2);
	mallocBufferObject(context,CL_MEM_READ_ONLY,size_floatgrids3,   	&mem_dockpars_fgrids3);
	#endif
#endif

	mallocBufferObject(context,CL_MEM_READ_WRITE,size_populations,  	&mem_dockpars_conformations_current);
	mallocBufferObject(context,CL_MEM_READ_WRITE,size_energies,    		&mem_dockpars_energies_current);

#if defined(SINGLE_COPY_POP_ENE)
	mallocBufferObject(context,CL_MEM_WRITE_ONLY,size_evals_of_runs,  	&mem_evals_performed);
	mallocBufferObject(context,CL_MEM_WRITE_ONLY,size_evals_of_runs,  	&mem_gens_performed);
#else
	mallocBufferObject(context,CL_MEM_WRITE_ONLY,2*sizeof(unsigned int),  	&mem_evals_and_generations_performed);
#endif

#if defined(SINGLE_COPY_POP_ENE)

#else
	unsigned int array_evals_and_generations_performed [2]; // [0]: evals, [1]: generations 
#endif

#if defined (FIXED_POINT_INTERE)
	memcopyBufferObjectToDevice(command_queue1,mem_KerConstStatic_fixpt64_atom_charges_const,            &KerConstStatic.fixpt64_atom_charges_const[0],            MAX_NUM_OF_ATOMS*sizeof(fixedpt64));
#endif
	memcopyBufferObjectToDevice(command_queue1,mem_KerConstStatic_atom_charges_const,            &KerConstStatic.atom_charges_const[0],            MAX_NUM_OF_ATOMS*sizeof(float));

	memcopyBufferObjectToDevice(command_queue1,mem_KerConstStatic_atom_types_const,              &KerConstStatic.atom_types_const[0],              MAX_NUM_OF_ATOMS*sizeof(char));

/*
	memcopyBufferObjectToDevice(command_queue1,mem_KerConstStatic_intraE_contributors_const,     &KerConstStatic.intraE_contributors_const[0],     3*MAX_INTRAE_CONTRIBUTORS*sizeof(char));
*/
	memcopyBufferObjectToDevice(command_queue1,mem_KerConstStatic_intraE_contributors_const,     &KerConstStatic.intraE_contributors_const[0],     MAX_INTRAE_CONTRIBUTORS*sizeof(cl_char3));

	memcopyBufferObjectToDevice(command_queue1,mem_KerConstStatic_VWpars_AC_const,               &KerConstStatic.VWpars_AC_const[0],               MAX_NUM_OF_ATYPES*MAX_NUM_OF_ATYPES*sizeof(float));
	memcopyBufferObjectToDevice(command_queue1,mem_KerConstStatic_VWpars_BD_const,               &KerConstStatic.VWpars_BD_const[0],               MAX_NUM_OF_ATYPES*MAX_NUM_OF_ATYPES*sizeof(float));
	memcopyBufferObjectToDevice(command_queue1,mem_KerConstStatic_dspars_S_const,                &KerConstStatic.dspars_S_const[0], 	       MAX_NUM_OF_ATYPES*sizeof(float));
	memcopyBufferObjectToDevice(command_queue1,mem_KerConstStatic_dspars_V_const,                &KerConstStatic.dspars_V_const[0], 	       MAX_NUM_OF_ATYPES*sizeof(float));
	#if defined (FIXED_POINT_CONFORM)
	// fixed-point
	memcopyBufferObjectToDevice(command_queue1,mem_KerConstStatic_rotlist_const,                 &KerConstStatic.rotlist_const[0], 		       MAX_NUM_OF_ROTATIONS*sizeof(fixedpt));
	memcopyBufferObjectToDevice(command_queue1,mem_KerConstStatic_ref_coords_const, 	     &KerConstStatic.ref_coords_const[0],              MAX_NUM_OF_ATOMS*sizeof(cl_int3));
	memcopyBufferObjectToDevice(command_queue1,mem_KerConstStatic_rotbonds_moving_vectors_const, &KerConstStatic.rotbonds_moving_vectors_const[0], MAX_NUM_OF_ROTBONDS*sizeof(cl_int3));
	memcopyBufferObjectToDevice(command_queue1,mem_KerConstStatic_rotbonds_unit_vectors_const,   &KerConstStatic.rotbonds_unit_vectors_const[0],   MAX_NUM_OF_ROTBONDS*sizeof(cl_int3));
	memcopyBufferObjectToDevice(command_queue1,mem_KerConstStatic_ref_orientation_quats_const,   &KerConstStatic.ref_orientation_quats_const[0],   MAX_NUM_OF_RUNS*sizeof(cl_int4));
	#else
	// floating-point (original)
	memcopyBufferObjectToDevice(command_queue1,mem_KerConstStatic_rotlist_const,                 &KerConstStatic.rotlist_const[0], 		       MAX_NUM_OF_ROTATIONS*sizeof(int));
	memcopyBufferObjectToDevice(command_queue1,mem_KerConstStatic_ref_coords_const, 	     &KerConstStatic.ref_coords_const[0],              MAX_NUM_OF_ATOMS*sizeof(cl_float3));
	memcopyBufferObjectToDevice(command_queue1,mem_KerConstStatic_rotbonds_moving_vectors_const, &KerConstStatic.rotbonds_moving_vectors_const[0], MAX_NUM_OF_ROTBONDS*sizeof(cl_float3));
	memcopyBufferObjectToDevice(command_queue1,mem_KerConstStatic_rotbonds_unit_vectors_const,   &KerConstStatic.rotbonds_unit_vectors_const[0],   MAX_NUM_OF_ROTBONDS*sizeof(cl_float3));
	memcopyBufferObjectToDevice(command_queue1,mem_KerConstStatic_ref_orientation_quats_const,   &KerConstStatic.ref_orientation_quats_const[0],   MAX_NUM_OF_RUNS*sizeof(cl_float4));
	#endif

//#if defined (FIXED_POINT_INTERE)
#if 0
/*
	cpu_fixedpt64grids = (fixedpt64*) alignedMalloc((sizeof(fixedpt64))*(mygrid->num_of_atypes+2)*
						  			    (mygrid->size_xyz[0])*
			   					            (mygrid->size_xyz[1])*
									    (mygrid->size_xyz[2]));
*/
	cpu_fixedpt64grids = (fixedpt64*) alignedMalloc(size_fixedpt64grids);

	float* mypoi;
	fixedpt64* myqoi;
	mypoi = cpu_floatgrids;
	myqoi = cpu_fixedpt64grids;

	for (int t=0; t < mygrid->num_of_atypes+2; t++) {
		//reading values
		for (int z=0; z < mygrid->size_xyz[2]; z++)
			for (int y=0; y < mygrid->size_xyz[1]; y++)
				for (int x=0; x < mygrid->size_xyz[0]; x++)
				{
					//fscanf(fp, "%f", mypoi);
					//mypoi++;
					float tmp_grids = *mypoi;
					mypoi++;
					*myqoi = fixedpt64_fromfloat(tmp_grids);

					// test to prove that it requires 32.32
					// and 16.16 is not enough
					//fixedpt myqoi16 = fixedpt_fromfloat(tmp_grids);
					//printf("%-10f %-10f %-10f\n", tmp_grids, fixedpt64_tofloat(*myqoi), fixedpt_tofloat(myqoi16));
					
					myqoi++;

					
				}
	}

	memcopyBufferObjectToDevice(command_queue1,mem_dockpars_fgrids, 	cpu_fixedpt64grids,       size_fixedpt64grids);
#else
	memcopyBufferObjectToDevice(command_queue1,mem_dockpars_fgrids, 	cpu_floatgrids,       size_floatgrids);

	#if defined(SEPARATE_FGRID_INTERE)
	memcopyBufferObjectToDevice(command_queue1,mem_dockpars_fgrids2, 	cpu_floatgrids + mygrid->num_of_atypes     * mygrid->size_xyz[0]*mygrid->size_xyz[1]* mygrid->size_xyz[2],       size_floatgrids2);
	memcopyBufferObjectToDevice(command_queue1,mem_dockpars_fgrids3, 	cpu_floatgrids + (mygrid->num_of_atypes+1) * mygrid->size_xyz[0]*mygrid->size_xyz[1]* mygrid->size_xyz[2],       size_floatgrids3);
	#endif
#endif

	clock_start_docking = clock();

#ifdef ENABLE_KERNEL1 // Krnl_GA
	#if defined(SINGLE_COPY_POP_ENE)
        setKernelArg(kernel1,0,  sizeof(mem_dockpars_conformations_current),    &mem_dockpars_conformations_current);
        setKernelArg(kernel1,1,  sizeof(mem_dockpars_energies_current),         &mem_dockpars_energies_current);
	setKernelArg(kernel1,2,  sizeof(mem_evals_performed),   		&mem_evals_performed);
	setKernelArg(kernel1,3,  sizeof(mem_gens_performed),    		&mem_gens_performed);
	setKernelArg(kernel1,4,  sizeof(unsigned int),                  	&dockpars.pop_size);
	setKernelArg(kernel1,5,  sizeof(unsigned int),                 		&dockpars.num_of_energy_evals);
	setKernelArg(kernel1,6,  sizeof(unsigned int),                 		&dockpars.num_of_generations);
	setKernelArg(kernel1,7,  sizeof(float),                          	&dockpars.tournament_rate);
	setKernelArg(kernel1,8,  sizeof(float),                          	&dockpars.mutation_rate);
	setKernelArg(kernel1,9,  sizeof(float),                          	&dockpars.abs_max_dmov);
	setKernelArg(kernel1,10, sizeof(float),                          	&dockpars.abs_max_dang);
	setKernelArg(kernel1,11, sizeof(float),                                 &two_absmaxdmov);
	setKernelArg(kernel1,12, sizeof(float),                                 &two_absmaxdang);
	setKernelArg(kernel1,13, sizeof(float),                          	&dockpars.crossover_rate);
	setKernelArg(kernel1,14, sizeof(unsigned int),                          &dockpars.num_of_lsentities);
	setKernelArg(kernel1,15, sizeof(unsigned char),                         &dockpars.num_of_genes);
	//setKernelArg(kernel1,16, sizeof(unsigned short),                      run_cnt);
	//setKernelArg(kernel1,17, sizeof(unsigned int),                        offset_pop);
	//setKernelArg(kernel1,18, sizeof(unsigned int),                        offset_ene);
	#else
        setKernelArg(kernel1,0,  sizeof(mem_dockpars_conformations_current),    &mem_dockpars_conformations_current);
        setKernelArg(kernel1,1,  sizeof(mem_dockpars_energies_current),         &mem_dockpars_energies_current);
	setKernelArg(kernel1,2,  sizeof(mem_evals_and_generations_performed),   &mem_evals_and_generations_performed);
	setKernelArg(kernel1,3,  sizeof(unsigned int),                  	&dockpars.pop_size);
	setKernelArg(kernel1,4,  sizeof(unsigned int),                 		&dockpars.num_of_energy_evals);
	setKernelArg(kernel1,5,  sizeof(unsigned int),                 		&dockpars.num_of_generations);
	setKernelArg(kernel1,6,  sizeof(float),                          	&dockpars.tournament_rate);
	setKernelArg(kernel1,7,  sizeof(float),                          	&dockpars.mutation_rate);
	setKernelArg(kernel1,8,  sizeof(float),                          	&dockpars.abs_max_dmov);
	setKernelArg(kernel1,9,  sizeof(float),                          	&dockpars.abs_max_dang);
	setKernelArg(kernel1,10, sizeof(float),                                 &two_absmaxdmov);
	setKernelArg(kernel1,11, sizeof(float),                                 &two_absmaxdang);
	setKernelArg(kernel1,12, sizeof(float),                          	&dockpars.crossover_rate);
	setKernelArg(kernel1,13, sizeof(unsigned int),                          &dockpars.num_of_lsentities);
	setKernelArg(kernel1,14, sizeof(unsigned char),                         &dockpars.num_of_genes);
	#endif
#endif // End of ENABLE_KERNEL1

#ifdef ENABLE_KERNEL2 // Krnl_Conform
	setKernelArg(kernel2,0,  sizeof(mem_KerConstStatic_rotlist_const),      	   &mem_KerConstStatic_rotlist_const);
	setKernelArg(kernel2,1,  sizeof(mem_KerConstStatic_ref_coords_const),              &mem_KerConstStatic_ref_coords_const);
	setKernelArg(kernel2,2,  sizeof(mem_KerConstStatic_rotbonds_moving_vectors_const), &mem_KerConstStatic_rotbonds_moving_vectors_const);
	setKernelArg(kernel2,3,  sizeof(mem_KerConstStatic_rotbonds_unit_vectors_const),   &mem_KerConstStatic_rotbonds_unit_vectors_const);
	setKernelArg(kernel2,4,  sizeof(unsigned int),       &dockpars.rotbondlist_length);
	setKernelArg(kernel2,5,  sizeof(unsigned char),      &dockpars.num_of_atoms);
	setKernelArg(kernel2,6,  sizeof(unsigned char),      &dockpars.num_of_genes);
/*
	setKernelArg(kernel2,7,  sizeof(unsigned char),      &num_rotbonds);
	setKernelArg(kernel2,8,  sizeof(mem_KerConstStatic_ref_orientation_quats_const),   &mem_KerConstStatic_ref_orientation_quats_const);
*/
	setKernelArg(kernel2,7,  sizeof(mem_KerConstStatic_ref_orientation_quats_const),   &mem_KerConstStatic_ref_orientation_quats_const);
	#if defined(SINGLE_COPY_POP_ENE)

	#else
		#if defined (FIXED_POINT_CONFORM)
	// fixed-point
	setKernelArg(kernel2,8,  sizeof(fixedpt),            &KerConstDynamic.ref_orientation_quats_const[0]);
	setKernelArg(kernel2,9,  sizeof(fixedpt),            &KerConstDynamic.ref_orientation_quats_const[1]);
	setKernelArg(kernel2,10, sizeof(fixedpt),            &KerConstDynamic.ref_orientation_quats_const[2]);
	setKernelArg(kernel2,11, sizeof(fixedpt),            &KerConstDynamic.ref_orientation_quats_const[3]);
		#else
	// floating-point (original)
	setKernelArg(kernel2,8,  sizeof(float),              &KerConstDynamic.ref_orientation_quats_const[0]);
	setKernelArg(kernel2,9,  sizeof(float),              &KerConstDynamic.ref_orientation_quats_const[1]);
	setKernelArg(kernel2,10, sizeof(float),              &KerConstDynamic.ref_orientation_quats_const[2]);
	setKernelArg(kernel2,11, sizeof(float),              &KerConstDynamic.ref_orientation_quats_const[3]);
		#endif
	#endif
#endif // End of ENABLE_KERNEL2


	unsigned char gridsizex_minus1 = dockpars.gridsize_x - 1;
	unsigned char gridsizey_minus1 = dockpars.gridsize_y - 1;
	unsigned char gridsizez_minus1 = dockpars.gridsize_z - 1;

#if defined (FIXED_POINT_INTERE)

#else
	float fgridsizex_minus1 = (float) gridsizex_minus1;
	float fgridsizey_minus1 = (float) gridsizey_minus1;
	float fgridsizez_minus1 = (float) gridsizez_minus1;

#endif


#ifdef ENABLE_KERNEL3 // Krnl_InterE
        setKernelArg(kernel3,0,  sizeof(mem_dockpars_fgrids),                    &mem_dockpars_fgrids);
	#if defined (FIXED_POINT_INTERE)
	setKernelArg(kernel3,1,  sizeof(mem_KerConstStatic_fixpt64_atom_charges_const),  &mem_KerConstStatic_fixpt64_atom_charges_const);
	#else
	setKernelArg(kernel3,1,  sizeof(mem_KerConstStatic_atom_charges_const),  &mem_KerConstStatic_atom_charges_const);
	#endif
	setKernelArg(kernel3,2,  sizeof(mem_KerConstStatic_atom_types_const),    &mem_KerConstStatic_atom_types_const);
	setKernelArg(kernel3,3,  sizeof(unsigned char),                          &dockpars.g1);
	setKernelArg(kernel3,4,  sizeof(unsigned int),                           &dockpars.g2);
	setKernelArg(kernel3,5,  sizeof(unsigned int),                           &dockpars.g3);
	setKernelArg(kernel3,6,  sizeof(unsigned char),                          &dockpars.num_of_atoms);

	#if defined (FIXED_POINT_INTERE)
	setKernelArg(kernel3,7,  sizeof(unsigned char),                          &gridsizex_minus1);
	setKernelArg(kernel3,8,  sizeof(unsigned char),                          &gridsizey_minus1);
	setKernelArg(kernel3,9,  sizeof(unsigned char),                          &gridsizez_minus1);
	#else
	setKernelArg(kernel3,7,  sizeof(float),                          	 &fgridsizex_minus1);
	setKernelArg(kernel3,8,  sizeof(float),                          	 &fgridsizey_minus1);
	setKernelArg(kernel3,9,  sizeof(float),                          	 &fgridsizez_minus1);
	#endif

	#if defined(SEPARATE_FGRID_INTERE)
	setKernelArg(kernel3,10, sizeof(mem_dockpars_fgrids2),                   &mem_dockpars_fgrids2);
	setKernelArg(kernel3,11, sizeof(mem_dockpars_fgrids3),                   &mem_dockpars_fgrids3);
	#else
	setKernelArg(kernel3,10, sizeof(unsigned int),                           &mul_tmp2);
	setKernelArg(kernel3,11, sizeof(unsigned int),                           &mul_tmp3);
	#endif
#endif // End of ENABLE_KERNEL3

#ifdef ENABLE_KERNEL4 // Krnl_IntraE
	setKernelArg(kernel4,0,  sizeof(mem_KerConstStatic_atom_charges_const),        &mem_KerConstStatic_atom_charges_const);
	setKernelArg(kernel4,1,  sizeof(mem_KerConstStatic_atom_types_const),          &mem_KerConstStatic_atom_types_const);
	setKernelArg(kernel4,2/*0*/,  sizeof(mem_KerConstStatic_intraE_contributors_const), &mem_KerConstStatic_intraE_contributors_const);
	setKernelArg(kernel4,3,  sizeof(mem_KerConstStatic_VWpars_AC_const),           &mem_KerConstStatic_VWpars_AC_const);
	setKernelArg(kernel4,4,  sizeof(mem_KerConstStatic_VWpars_BD_const),           &mem_KerConstStatic_VWpars_BD_const);
	setKernelArg(kernel4,5,  sizeof(mem_KerConstStatic_dspars_S_const),            &mem_KerConstStatic_dspars_S_const);
	setKernelArg(kernel4,6,  sizeof(mem_KerConstStatic_dspars_V_const),            &mem_KerConstStatic_dspars_V_const);

	setKernelArg(kernel4,7 /*1*/, sizeof(unsigned char),                    &dockpars.num_of_atoms);
	setKernelArg(kernel4,8 /*2*/, sizeof(unsigned int),                     &dockpars.num_of_intraE_contributors);
	setKernelArg(kernel4,9,  sizeof(float),                          	&dockpars.grid_spacing);
	setKernelArg(kernel4,10, sizeof(unsigned char),                    	&dockpars.num_of_atypes);
	setKernelArg(kernel4,11, sizeof(float),                          	&dockpars.coeff_elec);
	setKernelArg(kernel4,12, sizeof(float),                          	&dockpars.qasp);
	setKernelArg(kernel4,13, sizeof(float),                          	&dockpars.coeff_desolv);
/*
	setKernelArg(kernel4,14, sizeof(unsigned int),                     	&square_num_of_atypes);
*/
#endif // End of ENABLE_KERNEL4

#ifdef ENABLE_KERNEL6 // Krnl_PRNG_GG_float
	setKernelArg(kernel6,1, sizeof(unsigned char),  &dockpars.num_of_genes);
#endif // End of ENABLE_KERNEL6


#ifdef ENABLE_KERNEL7 // Krnl_PRNG_float
	setKernelArg(kernel7,1, sizeof(unsigned char),  &dockpars.num_of_genes);
#endif // End of ENABLE_KERNEL7

#if 0
#ifdef ENABLE_KERNEL8 // Krnl_PRNG_ushort
	setKernelArg(kernel8,1, sizeof(unsigned int),  &dockpars.pop_size);
#endif // End of ENABLE_KERNEL8
#endif

#if 0
#ifdef ENABLE_KERNEL9 // Krnl_PRNG_LS_ushort
	setKernelArg(kernel9,1, sizeof(unsigned int),  &dockpars.pop_size);
#endif // End of ENABLE_KERNEL9
#endif

#ifdef ENABLE_KERNEL10 // Krnl_PRNG_uchar
	setKernelArg(kernel10,1, sizeof(unsigned char),  &dockpars.num_of_genes);
#endif // End of ENABLE_KERNEL10

// Kernel 11 has no args

#if defined (FIXED_POINT_LS1) || defined (FIXED_POINT_LS2) || defined (FIXED_POINT_LS3)
fixedpt fixpt_base_dmov_mul_sqrt3 = fixedpt_fromfloat(dockpars.base_dmov_mul_sqrt3);
fixedpt fixpt_base_dang_mul_sqrt3 = fixedpt_fromfloat(dockpars.base_dang_mul_sqrt3);
fixedpt fixpt_rho_lower_bound = fixedpt_fromfloat(dockpars.rho_lower_bound);
#endif

unsigned short Host_max_num_of_iters = (unsigned short)dockpars.max_num_of_iters;
unsigned char  Host_cons_limit       = (unsigned char) dockpars.cons_limit;

#ifdef ENABLE_KERNEL12 // Krnl_LS
	//setKernelArg(kernel12,0, sizeof(unsigned int),  &dockpars.max_num_of_iters);
	setKernelArg(kernel12,0, sizeof(unsigned short),  &Host_max_num_of_iters);

	#if defined (FIXED_POINT_LS1)
	setKernelArg(kernel12,1, sizeof(fixedpt),  	&fixpt_rho_lower_bound);
	setKernelArg(kernel12,2, sizeof(fixedpt),  	&fixpt_base_dmov_mul_sqrt3);
	#else
	setKernelArg(kernel12,1, sizeof(float),  	&dockpars.rho_lower_bound);
	setKernelArg(kernel12,2, sizeof(float),  	&dockpars.base_dmov_mul_sqrt3);
	#endif
	setKernelArg(kernel12,3, sizeof(unsigned char), &dockpars.num_of_genes);
	#if defined (FIXED_POINT_LS1)
	setKernelArg(kernel12,4, sizeof(fixedpt),  	&fixpt_base_dang_mul_sqrt3);
	#else
	setKernelArg(kernel12,4, sizeof(float),  	&dockpars.base_dang_mul_sqrt3);
	#endif

	//setKernelArg(kernel12,5, sizeof(unsigned int),  &dockpars.cons_limit);
	setKernelArg(kernel12,5, sizeof(unsigned char),   &Host_cons_limit);
#endif // End of ENABLE_KERNEL12

/*
#ifdef ENABLE_KERNEL13 // Krnl_LS_Arbiter
	setKernelArg(kernel13,0, sizeof(unsigned char),  &dockpars.num_of_genes);
#endif // End of ENABLE_KERNEL12
*/

#ifdef ENABLE_KERNEL14 // Krnl_PRNG_LS2_float
	setKernelArg(kernel14,1, sizeof(unsigned char),  &dockpars.num_of_genes);
#endif // End of ENABLE_KERNEL14

#ifdef ENABLE_KERNEL15 // Krnl_LS2
	//setKernelArg(kernel15,0, sizeof(unsigned int),  &dockpars.max_num_of_iters);
	setKernelArg(kernel15,0, sizeof(unsigned short),  &Host_max_num_of_iters);
	#if defined (FIXED_POINT_LS2)
	setKernelArg(kernel15,1, sizeof(fixedpt),  	&fixpt_rho_lower_bound);
	setKernelArg(kernel15,2, sizeof(fixedpt),  	&fixpt_base_dmov_mul_sqrt3);
	#else
	setKernelArg(kernel15,1, sizeof(float),  	&dockpars.rho_lower_bound);
	setKernelArg(kernel15,2, sizeof(float),  	&dockpars.base_dmov_mul_sqrt3);
	#endif
	setKernelArg(kernel15,3, sizeof(unsigned char), &dockpars.num_of_genes);
	#if defined (FIXED_POINT_LS2)
	setKernelArg(kernel15,4, sizeof(fixedpt),  	&fixpt_base_dang_mul_sqrt3);
	#else
	setKernelArg(kernel15,4, sizeof(float),  	&dockpars.base_dang_mul_sqrt3);
	#endif

	//setKernelArg(kernel15,5, sizeof(unsigned int),  &dockpars.cons_limit);
	setKernelArg(kernel15,5, sizeof(unsigned char),   &Host_cons_limit);
#endif // End of ENABLE_KERNEL15

/*
#ifdef ENABLE_KERNEL16 // Krnl_LS2_Arbiter
	setKernelArg(kernel16,0, sizeof(unsigned char),  &dockpars.num_of_genes);
#endif // End of ENABLE_KERNEL12
*/

#if 0
#ifdef ENABLE_KERNEL17 // Krnl_Conform2

#endif // End of ENABLE_KERNEL17
#endif

#if 0
#ifdef ENABLE_KERNEL18 // Krnl_InterE2

#endif // End of ENABLE_KERNEL18
#endif

#if 0
#ifdef ENABLE_KERNEL19 // Krnl_IntraE2

#endif // End of ENABLE_KERNEL19
#endif

#ifdef ENABLE_KERNEL20 // Krnl_PRNG_LS3_float
	setKernelArg(kernel20,1, sizeof(unsigned char),  &dockpars.num_of_genes);
#endif // End of ENABLE_KERNEL20

#ifdef ENABLE_KERNEL21 // Krnl_LS3
	//setKernelArg(kernel21,0, sizeof(unsigned int),  &dockpars.max_num_of_iters);
	setKernelArg(kernel21,0, sizeof(unsigned short),  &Host_max_num_of_iters);
	#if defined (FIXED_POINT_LS3)
	setKernelArg(kernel21,1, sizeof(fixedpt),  	&fixpt_rho_lower_bound);
	setKernelArg(kernel21,2, sizeof(fixedpt),  	&fixpt_base_dmov_mul_sqrt3);
	#else
	setKernelArg(kernel21,1, sizeof(float),  	&dockpars.rho_lower_bound);
	setKernelArg(kernel21,2, sizeof(float),  	&dockpars.base_dmov_mul_sqrt3);
	#endif
	setKernelArg(kernel21,3, sizeof(unsigned char), &dockpars.num_of_genes);
	#if defined (FIXED_POINT_LS3)
	setKernelArg(kernel21,4, sizeof(fixedpt),  	&fixpt_base_dang_mul_sqrt3);
	#else
	setKernelArg(kernel21,4, sizeof(float),  	&dockpars.base_dang_mul_sqrt3);
	#endif

	//setKernelArg(kernel21,5, sizeof(unsigned int),  &dockpars.cons_limit);
	setKernelArg(kernel21,5, sizeof(unsigned char),   &Host_cons_limit);
#endif // End of ENABLE_KERNEL21

/*
#ifdef ENABLE_KERNEL22 // Krnl_LS3_Arbiter
	setKernelArg(kernel22,0, sizeof(unsigned char),  &dockpars.num_of_genes);
#endif // End of ENABLE_KERNEL22
*/

#if 0
#ifdef ENABLE_KERNEL23 // Krnl_Conf_Arbiter
	setKernelArg(kernel23,0, sizeof(unsigned char),  &dockpars.num_of_genes);
#endif // End of ENABLE_KERNEL23
#endif

#if 0
#ifdef ENABLE_KERNEL24 // Krnl_Conf_Arbiter2
	setKernelArg(kernel24,0, sizeof(unsigned char),  &dockpars.num_of_genes);
#endif // End of ENABLE_KERNEL24
#endif

#if 0
#ifdef ENABLE_KERNEL25 // Krnl_PRNG_LS2_ushort
	setKernelArg(kernel25,1, sizeof(unsigned int),  &dockpars.pop_size);
#endif // End of ENABLE_KERNEL25
#endif

#if 0
#ifdef ENABLE_KERNEL26 // Krnl_PRNG_LS3_ushort
	setKernelArg(kernel26,1, sizeof(unsigned int),  &dockpars.pop_size);
#endif // End of ENABLE_KERNEL26
#endif

#ifdef ENABLE_KERNEL27 // Krnl_IGL_Arbiter
/*	
	setKernelArg(kernel27,0, sizeof(unsigned char),  &dockpars.num_of_genes);
*/
#endif // End of ENABLE_KERNEL27

#if 0
#ifdef ENABLE_KERNEL28 // 

#endif // End of ENABLE_KERNEL28
#endif

#if 0
#ifdef ENABLE_KERNEL29 // 

#endif // 
#endif

#if 0
#ifdef ENABLE_KERNEL30 // 

#endif // 
#endif

#ifdef ENABLE_KERNEL35 // Krnl_PRNG_LS123_ushort
	setKernelArg(kernel35,9, sizeof(unsigned int),  &dockpars.pop_size);
#endif // End of ENABLE_KERNEL35

#ifdef ENABLE_KERNEL36 // Krnl_PRNG_ushort_float
	setKernelArg(kernel36,2, sizeof(unsigned int),  &dockpars.pop_size);
#endif // End of ENABLE_KERNEL36

#ifdef ENABLE_KERNEL37 // Krnl_PRNG_LS4_float
	setKernelArg(kernel37,1, sizeof(unsigned char),  &dockpars.num_of_genes);
#endif // End of ENABLE_KERNEL37

#ifdef ENABLE_KERNEL38 // Krnl_PRNG_LS5_float
	setKernelArg(kernel38,1, sizeof(unsigned char),  &dockpars.num_of_genes);
#endif // End of ENABLE_KERNEL38

#ifdef ENABLE_KERNEL39 // Krnl_LS4
	setKernelArg(kernel39,0, sizeof(unsigned short),  &Host_max_num_of_iters);
	#if defined (FIXED_POINT_LS4)
	setKernelArg(kernel39,1, sizeof(fixedpt),  	  &fixpt_rho_lower_bound);
	setKernelArg(kernel39,2, sizeof(fixedpt),  	  &fixpt_base_dmov_mul_sqrt3);
	#else
	setKernelArg(kernel39,1, sizeof(float),  	  &dockpars.rho_lower_bound);
	setKernelArg(kernel39,2, sizeof(float),  	  &dockpars.base_dmov_mul_sqrt3);
	#endif
	setKernelArg(kernel39,3, sizeof(unsigned char),   &dockpars.num_of_genes);
	#if defined (FIXED_POINT_LS4)
	setKernelArg(kernel39,4, sizeof(fixedpt),  	  &fixpt_base_dang_mul_sqrt3);
	#else
	setKernelArg(kernel39,4, sizeof(float),  	  &dockpars.base_dang_mul_sqrt3);
	#endif
	setKernelArg(kernel39,5, sizeof(unsigned char),   &Host_cons_limit);
#endif // End of ENABLE_KERNEL39

#ifdef ENABLE_KERNEL40 // Krnl_LS5
	setKernelArg(kernel40,0, sizeof(unsigned short),  &Host_max_num_of_iters);
	#if defined (FIXED_POINT_LS4)
	setKernelArg(kernel40,1, sizeof(fixedpt),  	  &fixpt_rho_lower_bound);
	setKernelArg(kernel40,2, sizeof(fixedpt),  	  &fixpt_base_dmov_mul_sqrt3);
	#else
	setKernelArg(kernel40,1, sizeof(float),  	  &dockpars.rho_lower_bound);
	setKernelArg(kernel40,2, sizeof(float),  	  &dockpars.base_dmov_mul_sqrt3);
	#endif
	setKernelArg(kernel40,3, sizeof(unsigned char),   &dockpars.num_of_genes);
	#if defined (FIXED_POINT_LS4)
	setKernelArg(kernel40,4, sizeof(fixedpt),  	  &fixpt_base_dang_mul_sqrt3);
	#else
	setKernelArg(kernel40,4, sizeof(float),  	  &dockpars.base_dang_mul_sqrt3);
	#endif
	setKernelArg(kernel40,5, sizeof(unsigned char),   &Host_cons_limit);
#endif // End of ENABLE_KERNEL40

#ifdef ENABLE_KERNEL41 // Krnl_PRNG_LS6_float
	setKernelArg(kernel41,1, sizeof(unsigned char),  &dockpars.num_of_genes);
#endif // End of ENABLE_KERNEL41

#ifdef ENABLE_KERNEL42 // Krnl_PRNG_LS7_float
	setKernelArg(kernel42,1, sizeof(unsigned char),  &dockpars.num_of_genes);
#endif // End of ENABLE_KERNEL42

#ifdef ENABLE_KERNEL43 // Krnl_PRNG_LS8_float
	setKernelArg(kernel43,1, sizeof(unsigned char),  &dockpars.num_of_genes);
#endif // End of ENABLE_KERNEL43

#ifdef ENABLE_KERNEL44 // Krnl_PRNG_LS9_float
	setKernelArg(kernel44,1, sizeof(unsigned char),  &dockpars.num_of_genes);
#endif // End of ENABLE_KERNEL44

#ifdef ENABLE_KERNEL45 // Krnl_LS6
	setKernelArg(kernel45,0, sizeof(unsigned short),  &Host_max_num_of_iters);
	#if defined (FIXED_POINT_LS6)
	setKernelArg(kernel45,1, sizeof(fixedpt),  	  &fixpt_rho_lower_bound);
	setKernelArg(kernel45,2, sizeof(fixedpt),  	  &fixpt_base_dmov_mul_sqrt3);
	#else
	setKernelArg(kernel45,1, sizeof(float),  	  &dockpars.rho_lower_bound);
	setKernelArg(kernel45,2, sizeof(float),  	  &dockpars.base_dmov_mul_sqrt3);
	#endif
	setKernelArg(kernel45,3, sizeof(unsigned char),   &dockpars.num_of_genes);
	#if defined (FIXED_POINT_LS6)
	setKernelArg(kernel45,4, sizeof(fixedpt),  	  &fixpt_base_dang_mul_sqrt3);
	#else
	setKernelArg(kernel45,4, sizeof(float),  	  &dockpars.base_dang_mul_sqrt3);
	#endif
	setKernelArg(kernel45,5, sizeof(unsigned char),   &Host_cons_limit);
#endif // End of ENABLE_KERNEL45

#ifdef ENABLE_KERNEL46 // Krnl_LS7
	setKernelArg(kernel46,0, sizeof(unsigned short),  &Host_max_num_of_iters);
	#if defined (FIXED_POINT_LS7)
	setKernelArg(kernel46,1, sizeof(fixedpt),  	  &fixpt_rho_lower_bound);
	setKernelArg(kernel46,2, sizeof(fixedpt),  	  &fixpt_base_dmov_mul_sqrt3);
	#else
	setKernelArg(kernel46,1, sizeof(float),  	  &dockpars.rho_lower_bound);
	setKernelArg(kernel46,2, sizeof(float),  	  &dockpars.base_dmov_mul_sqrt3);
	#endif
	setKernelArg(kernel46,3, sizeof(unsigned char),   &dockpars.num_of_genes);
	#if defined (FIXED_POINT_LS7)
	setKernelArg(kernel46,4, sizeof(fixedpt),  	  &fixpt_base_dang_mul_sqrt3);
	#else
	setKernelArg(kernel46,4, sizeof(float),  	  &dockpars.base_dang_mul_sqrt3);
	#endif
	setKernelArg(kernel46,5, sizeof(unsigned char),   &Host_cons_limit);
#endif // End of ENABLE_KERNEL46

#ifdef ENABLE_KERNEL47 // Krnl_LS8
	setKernelArg(kernel47,0, sizeof(unsigned short),  &Host_max_num_of_iters);
	#if defined (FIXED_POINT_LS8)
	setKernelArg(kernel47,1, sizeof(fixedpt),  	  &fixpt_rho_lower_bound);
	setKernelArg(kernel47,2, sizeof(fixedpt),  	  &fixpt_base_dmov_mul_sqrt3);
	#else
	setKernelArg(kernel47,1, sizeof(float),  	  &dockpars.rho_lower_bound);
	setKernelArg(kernel47,2, sizeof(float),  	  &dockpars.base_dmov_mul_sqrt3);
	#endif
	setKernelArg(kernel47,3, sizeof(unsigned char),   &dockpars.num_of_genes);
	#if defined (FIXED_POINT_LS8)
	setKernelArg(kernel47,4, sizeof(fixedpt),  	  &fixpt_base_dang_mul_sqrt3);
	#else
	setKernelArg(kernel47,4, sizeof(float),  	  &dockpars.base_dang_mul_sqrt3);
	#endif
	setKernelArg(kernel47,5, sizeof(unsigned char),   &Host_cons_limit);
#endif // End of ENABLE_KERNEL47

#ifdef ENABLE_KERNEL48 // Krnl_LS9
	setKernelArg(kernel48,0, sizeof(unsigned short),  &Host_max_num_of_iters);
	#if defined (FIXED_POINT_LS9)
	setKernelArg(kernel48,1, sizeof(fixedpt),  	  &fixpt_rho_lower_bound);
	setKernelArg(kernel48,2, sizeof(fixedpt),  	  &fixpt_base_dmov_mul_sqrt3);
	#else
	setKernelArg(kernel48,1, sizeof(float),  	  &dockpars.rho_lower_bound);
	setKernelArg(kernel48,2, sizeof(float),  	  &dockpars.base_dmov_mul_sqrt3);
	#endif
	setKernelArg(kernel48,3, sizeof(unsigned char),   &dockpars.num_of_genes);
	#if defined (FIXED_POINT_LS9)
	setKernelArg(kernel48,4, sizeof(fixedpt),  	  &fixpt_base_dang_mul_sqrt3);
	#else
	setKernelArg(kernel48,4, sizeof(float),  	  &dockpars.base_dang_mul_sqrt3);
	#endif
	setKernelArg(kernel48,5, sizeof(unsigned char),   &Host_cons_limit);
#endif // End of ENABLE_KERNEL48


#if defined(SINGLE_COPY_POP_ENE)
	memcopyBufferObjectToDevice(command_queue1,mem_dockpars_conformations_current, 	cpu_init_populations, size_populations);
#endif


	printf("Docking runs to be executed: %u\n", mypars->num_of_runs); 
	printf("Execution run: ");

	for (unsigned int run_cnt = 0; run_cnt < mypars->num_of_runs; run_cnt++)
	{
/*
		printf("Run %3u started ...     \n", run_cnt+1); 
		fflush(stdout);
*/
		printf(" %u", run_cnt+1); 
		fflush(stdout);

#if defined(SINGLE_COPY_POP_ENE)

#else
		myligand_reference = *myligand_init;
		gen_initpop_and_reflig(mypars, cpu_init_populations, cpu_ref_ori_angles, &myligand_reference, mygrid);

		if (prepare_constdynamic_fields_for_gpu(&myligand_reference, mypars, cpu_ref_ori_angles, &KerConstDynamic) == 1)
			return 1;

 		memcopyBufferObjectToDevice(command_queue1,mem_dockpars_conformations_current, 	cpu_init_populations, size_populations);
#endif

#if defined(SINGLE_COPY_POP_ENE)
	#ifdef ENABLE_KERNEL1
		unsigned int Host_Offset_Pop = run_cnt * dockpars.pop_size * ACTUAL_GENOTYPE_LENGTH;
		unsigned int Host_Offset_Ene = run_cnt * dockpars.pop_size;
		setKernelArg(kernel1,16,  sizeof(unsigned short), &run_cnt);
		setKernelArg(kernel1,17,  sizeof(unsigned int),   &Host_Offset_Pop);
		setKernelArg(kernel1,18,  sizeof(unsigned int),   &Host_Offset_Ene);

	#endif
#endif

#ifdef ENABLE_KERNEL2 // Krnl_Conform
	/*
	#if defined(SINGLE_COPY_POP_ENE)
		#if defined (FIXED_POINT_CONFORM)
		setKernelArg(kernel2,8,  sizeof(fixedpt),        &KerConstStatic.ref_orientation_quats_const[4*run_cnt]);
		setKernelArg(kernel2,9,  sizeof(fixedpt),        &KerConstStatic.ref_orientation_quats_const[4*run_cnt + 1]);	
		setKernelArg(kernel2,10, sizeof(fixedpt),        &KerConstStatic.ref_orientation_quats_const[4*run_cnt + 2]);	
		setKernelArg(kernel2,11, sizeof(fixedpt),        &KerConstStatic.ref_orientation_quats_const[4*run_cnt + 3]);
		#else
		setKernelArg(kernel2,8,  sizeof(float),          &KerConstStatic.ref_orientation_quats_const[4*run_cnt]);
		setKernelArg(kernel2,9,  sizeof(float),          &KerConstStatic.ref_orientation_quats_const[4*run_cnt + 1]);	
		setKernelArg(kernel2,10, sizeof(float),          &KerConstStatic.ref_orientation_quats_const[4*run_cnt + 2]);	
		setKernelArg(kernel2,11, sizeof(float),          &KerConstStatic.ref_orientation_quats_const[4*run_cnt + 3]);
		#endif
	#else
		#if defined (FIXED_POINT_CONFORM)
		setKernelArg(kernel2,8,  sizeof(fixedpt),        &KerConstDynamic.ref_orientation_quats_const[0]);
		setKernelArg(kernel2,9,  sizeof(fixedpt),        &KerConstDynamic.ref_orientation_quats_const[1]);	
		setKernelArg(kernel2,10, sizeof(fixedpt),        &KerConstDynamic.ref_orientation_quats_const[2]);	
		setKernelArg(kernel2,11, sizeof(fixedpt),        &KerConstDynamic.ref_orientation_quats_const[3]);
		#else
		setKernelArg(kernel2,8,  sizeof(float),          &KerConstDynamic.ref_orientation_quats_const[0]);
		setKernelArg(kernel2,9,  sizeof(float),          &KerConstDynamic.ref_orientation_quats_const[1]);	
		setKernelArg(kernel2,10, sizeof(float),          &KerConstDynamic.ref_orientation_quats_const[2]);	
		setKernelArg(kernel2,11, sizeof(float),          &KerConstDynamic.ref_orientation_quats_const[3]);
		#endif
	#endif
	*/
	/*
	setKernelArg(kernel2,9,  sizeof(unsigned short), &run_cnt);
	*/
	setKernelArg(kernel2,8,  sizeof(unsigned short), &run_cnt);
#endif // End of ENABLE_KERNEL2

#if 0
	#ifdef ENABLE_KERNEL5 // Krnl_PRNG_BT_float
			setKernelArg(kernel5,0, sizeof(unsigned int),  &cpu_prng_seeds[num_of_prng_blocks * run_cnt]);
	#endif // End of ENABLE_KERNEL5
#endif

#ifdef ENABLE_KERNEL6 // Krnl_PRNG_GG_float
		setKernelArg(kernel6,0, sizeof(unsigned int),   &cpu_prng_seeds[num_of_prng_blocks * run_cnt]);
#endif // End of ENABLE_KERNEL6


#ifdef ENABLE_KERNEL7 // Krnl_PRNG_LS_float
		setKernelArg(kernel7,0, sizeof(unsigned int),   &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 1]);
#endif // End of ENABLE_KERNEL7

#if 0
	#ifdef ENABLE_KERNEL8 // Krnl_PRNG_ushort
			setKernelArg(kernel8,0, sizeof(unsigned int),   &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 3]);
	#endif // End of ENABLE_KERNEL8
#endif

#if 0
	#ifdef ENABLE_KERNEL9 // Krnl_PRNG_LS_ushort
			setKernelArg(kernel9,0, sizeof(unsigned int),   &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 4]);
	#endif // End of ENABLE_KERNEL9
#endif

#ifdef ENABLE_KERNEL10 // Krnl_Prng_GG_uchar
		setKernelArg(kernel10,0, sizeof(unsigned int),   &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 2]);
#endif // End of ENABLE_KERNEL10

#ifdef ENABLE_KERNEL14 // Krnl_PRNG_LS2_float
		setKernelArg(kernel14,0, sizeof(unsigned int),   &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 3]);
#endif // End of ENABLE_KERNEL7

#if 0
#ifdef ENABLE_KERNEL17 // Krnl_Conform2

#endif // End of ENABLE_KERNEL17
#endif

#ifdef ENABLE_KERNEL20 // Krnl_PRNG_LS3_float
		setKernelArg(kernel20,0, sizeof(unsigned int),   &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 4]);
#endif // End of ENABLE_KERNEL20

#if 0
#ifdef ENABLE_KERNEL25 // Krnl_PRNG_LS2_ushort
		setKernelArg(kernel25,0, sizeof(unsigned int),   &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 8]);
#endif // End of ENABLE_KERNEL25
#endif

#if 0
#ifdef ENABLE_KERNEL26 // Krnl_PRNG_LS3_ushort
		setKernelArg(kernel26,0, sizeof(unsigned int),   &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 9]);
#endif // End of ENABLE_KERNEL26
#endif

#ifdef ENABLE_KERNEL35 // Krnl_PRNG_LS123_ushort
		setKernelArg(kernel35,0, sizeof(unsigned int),   &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 5]);
		setKernelArg(kernel35,1, sizeof(unsigned int),   &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 6]);
		setKernelArg(kernel35,2, sizeof(unsigned int),   &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 7]);
		setKernelArg(kernel35,3, sizeof(unsigned int),   &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 8]);
		setKernelArg(kernel35,4, sizeof(unsigned int),   &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 9]);
		setKernelArg(kernel35,5, sizeof(unsigned int),   &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 10]);
		setKernelArg(kernel35,6, sizeof(unsigned int),   &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 11]);
		setKernelArg(kernel35,7, sizeof(unsigned int),   &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 12]);
		setKernelArg(kernel35,8, sizeof(unsigned int),   &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 13]);
#endif // End of ENABLE_KERNEL35

#ifdef ENABLE_KERNEL36 // Krnl_Prng_BT_ushort_float
		setKernelArg(kernel36,0, sizeof(unsigned int),   &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 14]);
		setKernelArg(kernel36,1, sizeof(unsigned int),   &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 15]);
#endif // End of ENABLE_KERNEL36

#ifdef ENABLE_KERNEL37 // Krnl_PRNG_LS4_float
		setKernelArg(kernel37,0, sizeof(unsigned int),   &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 16]);
#endif // End of ENABLE_KERNEL37

#ifdef ENABLE_KERNEL38 // Krnl_PRNG_LS5_float
		setKernelArg(kernel38,0, sizeof(unsigned int),   &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 17]);
#endif // End of ENABLE_KERNEL38

#ifdef ENABLE_KERNEL41 // Krnl_PRNG_LS6_float
		setKernelArg(kernel41,0, sizeof(unsigned int),   &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 18]);
#endif // End of ENABLE_KERNEL41

#ifdef ENABLE_KERNEL42 // Krnl_PRNG_LS7_float
		setKernelArg(kernel42,0, sizeof(unsigned int),   &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 19]);
#endif // End of ENABLE_KERNEL42

#ifdef ENABLE_KERNEL43 // Krnl_PRNG_LS8_float
		setKernelArg(kernel43,0, sizeof(unsigned int),   &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 20]);
#endif // End of ENABLE_KERNEL43

#ifdef ENABLE_KERNEL44 // Krnl_PRNG_LS9_float
		setKernelArg(kernel44,0, sizeof(unsigned int),   &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 21]);
#endif // End of ENABLE_KERNEL44

		#ifdef ENABLE_KERNEL1
		runKernelTask(command_queue1,kernel1,NULL,NULL);
		#endif // ENABLE_KERNEL1

		#ifdef ENABLE_KERNEL2
		runKernelTask(command_queue2,kernel2,NULL,NULL);
		#endif // ENABLE_KERNEL2

		#ifdef ENABLE_KERNEL3
		runKernelTask(command_queue3,kernel3,NULL,NULL);
		#endif // ENABLE_KERNEL3

		#ifdef ENABLE_KERNEL4
		runKernelTask(command_queue4,kernel4,NULL,NULL);
		#endif // ENABLE_KERNEL4

#if 0
		#ifdef ENABLE_KERNEL5
		runKernelTask(command_queue5,kernel5,NULL,NULL);
		#endif // ENABLE_KERNEL5
#endif

		#ifdef ENABLE_KERNEL6
		runKernelTask(command_queue6,kernel6,NULL,NULL);
		#endif // ENABLE_KERNEL6

		#ifdef ENABLE_KERNEL7
		runKernelTask(command_queue7,kernel7,NULL,NULL);
		#endif // ENABLE_KERNEL7

#if 0
		#ifdef ENABLE_KERNEL8
		runKernelTask(command_queue8,kernel8,NULL,NULL);
		#endif // ENABLE_KERNEL8
#endif

#if 0
		#ifdef ENABLE_KERNEL9
		runKernelTask(command_queue9,kernel9,NULL,NULL);
		#endif // ENABLE_KERNEL9
#endif

		#ifdef ENABLE_KERNEL10
		runKernelTask(command_queue10,kernel10,NULL,NULL);
		#endif // ENABLE_KERNEL10

#if 0
		#ifdef ENABLE_KERNEL11
		runKernelTask(command_queue11,kernel11,NULL,NULL);
		#endif // ENABLE_KERNEL10
#endif

		#ifdef ENABLE_KERNEL12
		runKernelTask(command_queue12,kernel12,NULL,NULL);
		#endif // ENABLE_KERNEL12

#if 0
		#ifdef ENABLE_KERNEL13
		runKernelTask(command_queue13,kernel13,NULL,NULL);
		#endif // ENABLE_KERNEL13
#endif

		#ifdef ENABLE_KERNEL14
		runKernelTask(command_queue14,kernel14,NULL,NULL);
		#endif // ENABLE_KERNEL14

		#ifdef ENABLE_KERNEL15
		runKernelTask(command_queue15,kernel15,NULL,NULL);
		#endif // ENABLE_KERNEL14

#if 0
		#ifdef ENABLE_KERNEL16
		runKernelTask(command_queue16,kernel16,NULL,NULL);
		#endif // ENABLE_KERNEL16
#endif

#if 0
		#ifdef ENABLE_KERNEL17
		runKernelTask(command_queue17,kernel17,NULL,NULL);
		#endif // ENABLE_KERNEL17
#endif

#if 0
		#ifdef ENABLE_KERNEL18
		runKernelTask(command_queue18,kernel18,NULL,NULL);
		#endif // ENABLE_KERNEL18
#endif

#if 0
		#ifdef ENABLE_KERNEL19
		runKernelTask(command_queue19,kernel19,NULL,NULL);
		#endif // ENABLE_KERNEL19
#endif

		#ifdef ENABLE_KERNEL20
		runKernelTask(command_queue20,kernel20,NULL,NULL);
		#endif // ENABLE_KERNEL20

		#ifdef ENABLE_KERNEL21
		runKernelTask(command_queue21,kernel21,NULL,NULL);
		#endif // ENABLE_KERNEL21

#if 0
		#ifdef ENABLE_KERNEL22
		runKernelTask(command_queue22,kernel22,NULL,NULL);
		#endif // ENABLE_KERNEL22
#endif

#if 0
		#ifdef ENABLE_KERNEL23
		runKernelTask(command_queue23,kernel23,NULL,NULL);
		#endif // ENABLE_KERNEL23
#endif

#if 0
		#ifdef ENABLE_KERNEL24
		runKernelTask(command_queue24,kernel24,NULL,NULL);
		#endif // ENABLE_KERNEL24
#endif

#if 0
		#ifdef ENABLE_KERNEL25
		runKernelTask(command_queue25,kernel25,NULL,NULL);
		#endif // ENABLE_KERNEL25
#endif

#if 0
		#ifdef ENABLE_KERNEL26
		runKernelTask(command_queue26,kernel26,NULL,NULL);
		#endif // ENABLE_KERNEL26
#endif

		#ifdef ENABLE_KERNEL27
		runKernelTask(command_queue27,kernel27,NULL,NULL);
		#endif // ENABLE_KERNEL27

#if 0
		#ifdef ENABLE_KERNEL28
		runKernelTask(command_queue28,kernel28,NULL,NULL);
		#endif // ENABLE_KERNEL28
#endif

#if 0
		#ifdef ENABLE_KERNEL29
		runKernelTask(command_queue29,kernel29,NULL,NULL);
		#endif // ENABLE_KERNEL29
#endif

#if 0
		#ifdef ENABLE_KERNEL30
		runKernelTask(command_queue30,kernel30,NULL,NULL);
		#endif // ENABLE_KERNEL30
#endif

#if 0
		#ifdef ENABLE_KERNEL31
		runKernelTask(command_queue31,kernel31,NULL,NULL);
		#endif // ENABLE_KERNEL31
#endif

#if 0
		#ifdef ENABLE_KERNEL32
		runKernelTask(command_queue32,kernel32,NULL,NULL);
		#endif // ENABLE_KERNEL32
#endif

#if 0
		#ifdef ENABLE_KERNEL33
		runKernelTask(command_queue33,kernel33,NULL,NULL);
		#endif // ENABLE_KERNEL33
#endif

#if 0
		#ifdef ENABLE_KERNEL34
		runKernelTask(command_queue34,kernel34,NULL,NULL);
		#endif // ENABLE_KERNEL34
#endif

		#ifdef ENABLE_KERNEL35
		runKernelTask(command_queue35,kernel35,NULL,NULL);
		#endif // ENABLE_KERNEL35

		#ifdef ENABLE_KERNEL36
		runKernelTask(command_queue36,kernel36,NULL,NULL);
		#endif // ENABLE_KERNEL36

		#ifdef ENABLE_KERNEL37
		runKernelTask(command_queue37,kernel37,NULL,NULL);
		#endif // ENABLE_KERNEL37

		#ifdef ENABLE_KERNEL38
		runKernelTask(command_queue38,kernel38,NULL,NULL);
		#endif // ENABLE_KERNEL38

		#ifdef ENABLE_KERNEL39
		runKernelTask(command_queue39,kernel39,NULL,NULL);
		#endif // ENABLE_KERNEL39

		#ifdef ENABLE_KERNEL40
		runKernelTask(command_queue40,kernel40,NULL,NULL);
		#endif // ENABLE_KERNEL40


		#ifdef ENABLE_KERNEL41
		runKernelTask(command_queue41,kernel41,NULL,NULL);
		#endif // ENABLE_KERNEL41

		#ifdef ENABLE_KERNEL42
		runKernelTask(command_queue42,kernel42,NULL,NULL);
		#endif // ENABLE_KERNEL42

		#ifdef ENABLE_KERNEL43
		runKernelTask(command_queue43,kernel43,NULL,NULL);
		#endif // ENABLE_KERNEL43

		#ifdef ENABLE_KERNEL44
		runKernelTask(command_queue44,kernel44,NULL,NULL);
		#endif // ENABLE_KERNEL44

		#ifdef ENABLE_KERNEL45
		runKernelTask(command_queue45,kernel45,NULL,NULL);
		#endif // ENABLE_KERNEL45

		#ifdef ENABLE_KERNEL46
		runKernelTask(command_queue46,kernel46,NULL,NULL);
		#endif // ENABLE_KERNEL46

		#ifdef ENABLE_KERNEL47
		runKernelTask(command_queue47,kernel47,NULL,NULL);
		#endif // ENABLE_KERNEL47

		#ifdef ENABLE_KERNEL48
		runKernelTask(command_queue48,kernel48,NULL,NULL);
		#endif // ENABLE_KERNEL48




		#ifdef ENABLE_KERNEL1 		
		clFinish(command_queue1); 
		#endif

		#ifdef ENABLE_KERNEL2	
		clFinish(command_queue2); 
		#endif

		#ifdef ENABLE_KERNEL3 		
		clFinish(command_queue3); 
		#endif

		#ifdef ENABLE_KERNEL4 		
		clFinish(command_queue4); 
		#endif

#if 0
		#ifdef ENABLE_KERNEL5
		clFinish(command_queue5); 
		#endif
#endif

		#ifdef ENABLE_KERNEL6
		clFinish(command_queue6); 
		#endif

		#ifdef ENABLE_KERNEL7
		clFinish(command_queue7);
		#endif

#if 0
		#ifdef ENABLE_KERNEL8
		clFinish(command_queue8);
		#endif
#endif

#if 0
		#ifdef ENABLE_KERNEL9
		clFinish(command_queue9);
		#endif
#endif

		#ifdef ENABLE_KERNEL10
		clFinish(command_queue10);
		#endif

#if 0
		#ifdef ENABLE_KERNEL11
		clFinish(command_queue11);
		#endif
#endif

		#ifdef ENABLE_KERNEL12
		clFinish(command_queue12);
		#endif

#if 0
		#ifdef ENABLE_KERNEL13
		clFinish(command_queue13);
		#endif
#endif

		#ifdef ENABLE_KERNEL14
		clFinish(command_queue14);
		#endif

		#ifdef ENABLE_KERNEL15
		clFinish(command_queue15);
		#endif

#if 0
		#ifdef ENABLE_KERNEL16
		clFinish(command_queue16);
		#endif
#endif

#if 0
		#ifdef ENABLE_KERNEL17
		clFinish(command_queue17);
		#endif
#endif

#if 0
		#ifdef ENABLE_KERNEL18
		clFinish(command_queue18);
		#endif
#endif

#if 0
		#ifdef ENABLE_KERNEL19
		clFinish(command_queue19);
		#endif
#endif

		#ifdef ENABLE_KERNEL20
		clFinish(command_queue20);
		#endif

		#ifdef ENABLE_KERNEL21
		clFinish(command_queue21);
		#endif

#if 0
		#ifdef ENABLE_KERNEL22
		clFinish(command_queue22);
		#endif
#endif

#if 0
		#ifdef ENABLE_KERNEL23
		clFinish(command_queue23);
		#endif
#endif

#if 0
		#ifdef ENABLE_KERNEL24
		clFinish(command_queue24);
		#endif
#endif

#if 0
		#ifdef ENABLE_KERNEL25
		clFinish(command_queue25);
		#endif
#endif

#if 0
		#ifdef ENABLE_KERNEL26
		clFinish(command_queue26);
		#endif
#endif

		#ifdef ENABLE_KERNEL27
		clFinish(command_queue27);
		#endif

#if 0
		#ifdef ENABLE_KERNEL28
		clFinish(command_queue28);
		#endif
#endif

#if 0
		#ifdef ENABLE_KERNEL29
		clFinish(command_queue29);
		#endif
#endif

#if 0
		#ifdef ENABLE_KERNEL30
		clFinish(command_queue30);
		#endif
#endif

#if 0
		#ifdef ENABLE_KERNEL31
		clFinish(command_queue31);
		#endif
#endif

#if 0
		#ifdef ENABLE_KERNEL32
		clFinish(command_queue32);
		#endif
#endif

#if 0
		#ifdef ENABLE_KERNEL33
		clFinish(command_queue33);
		#endif
#endif

#if 0
		#ifdef ENABLE_KERNEL34
		clFinish(command_queue34);
		#endif
#endif

		#ifdef ENABLE_KERNEL35
		clFinish(command_queue35);
		#endif

		#ifdef ENABLE_KERNEL36
		clFinish(command_queue36);
		#endif

		#ifdef ENABLE_KERNEL37
		clFinish(command_queue37);
		#endif

		#ifdef ENABLE_KERNEL38
		clFinish(command_queue38);
		#endif

		#ifdef ENABLE_KERNEL39
		clFinish(command_queue39);
		#endif

		#ifdef ENABLE_KERNEL40
		clFinish(command_queue40);
		#endif

		#ifdef ENABLE_KERNEL41
		clFinish(command_queue41);
		#endif

		#ifdef ENABLE_KERNEL42
		clFinish(command_queue42);
		#endif

		#ifdef ENABLE_KERNEL43
		clFinish(command_queue43);
		#endif

		#ifdef ENABLE_KERNEL44
		clFinish(command_queue44);
		#endif

		#ifdef ENABLE_KERNEL45
		clFinish(command_queue45);
		#endif

		#ifdef ENABLE_KERNEL46
		clFinish(command_queue46);
		#endif

		#ifdef ENABLE_KERNEL47
		clFinish(command_queue47);
		#endif

		#ifdef ENABLE_KERNEL48
		clFinish(command_queue48);
		#endif

		clock_stop_docking = clock();


#if defined(SINGLE_COPY_POP_ENE)


#else
		/*
		fflush(stdout);
		*/

		//copy results from device
		memcopyBufferObjectFromDevice(command_queue1,array_evals_and_generations_performed,mem_evals_and_generations_performed,2*sizeof(unsigned int));
		mypars->num_of_energy_evals = array_evals_and_generations_performed [0];
		mypars->num_of_generations  = array_evals_and_generations_performed [1];
	
		memcopyBufferObjectFromDevice(command_queue1,cpu_final_populations,mem_dockpars_conformations_current,size_populations);

		memcopyBufferObjectFromDevice(command_queue1,cpu_energies,mem_dockpars_energies_current,size_energies);



		//processing results
		
/*
		// Fix genotypes so map angle is used for genotypes 3,4,5
		// Check what format is used by host regarding the angles
		for (int ent_cnt=0; ent_cnt<mypars->pop_size; ent_cnt++) {
				
			float temp_genotype[ACTUAL_GENOTYPE_LENGTH];
			memcpy(temp_genotype, cpu_final_populations+ent_cnt*ACTUAL_GENOTYPE_LENGTH, ACTUAL_GENOTYPE_LENGTH*sizeof(float));

			for (int gene_cnt=3; gene_cnt<ACTUAL_GENOTYPE_LENGTH; gene_cnt++) {
				
				if (gene_cnt == 4) {
					//temp_genotype[gene_cnt] = map_angle_180(temp_genotype[gene_cnt]);
				}
				else {
					temp_genotype[gene_cnt] = map_angle_360(temp_genotype[gene_cnt]);
				}
			}
			memcpy(cpu_final_populations+ent_cnt*ACTUAL_GENOTYPE_LENGTH, temp_genotype, ACTUAL_GENOTYPE_LENGTH*sizeof(float));
			
		}
*/

/*
		arrange_result(cpu_final_populations+run_cnt*mypars->pop_size*GENOTYPE_LENGTH_IN_GLOBMEM, 
			       cpu_energies+run_cnt*mypars->pop_size, mypars->pop_size);
*/

		arrange_result(cpu_final_populations, cpu_energies, mypars->pop_size);


/*
		make_resfiles(cpu_final_populations+run_cnt*mypars->pop_size*GENOTYPE_LENGTH_IN_GLOBMEM, 
			      cpu_energies+run_cnt*mypars->pop_size, 
			      &myligand_reference,
			      myligand_init, 
			      mypars, 
   			      cpu_evals_of_runs[run_cnt], 
			      generation_cnt, 
			      mygrid, 
			      cpu_floatgrids, 
			      cpu_ref_ori_angles+3*run_cnt, 
			      argc, 
			      argv, 
			      0,
			      run_cnt, 
                              &(cpu_result_ligands [run_cnt]));
*/

		//To write out final_population generated by get_result
		make_resfiles(cpu_final_populations, 
			      cpu_energies, 
			      &myligand_reference,
			      myligand_init, 
			      mypars, 
			      mypars->num_of_energy_evals, 
			      mypars->num_of_generations, 
			      mygrid, 
			      cpu_floatgrids,
			      cpu_ref_ori_angles, 
			      argc, 
			      argv, 
			      0,
			      run_cnt, 
			      &cpu_result_ligands[run_cnt]);


#endif


	} // End of for (run_cnt = 0; run_cnt < mypars->num_of_runs; run_cnt++)


	printf("\n"); 

#if defined(SINGLE_COPY_POP_ENE)

	//copy results from device
	memcopyBufferObjectFromDevice(command_queue1, cpu_evals_of_runs, mem_evals_performed, size_evals_of_runs);
	memcopyBufferObjectFromDevice(command_queue1, cpu_gens_of_runs,  mem_gens_performed,  size_evals_of_runs);

	memcopyBufferObjectFromDevice(command_queue1,cpu_final_populations,mem_dockpars_conformations_current,size_populations);
	memcopyBufferObjectFromDevice(command_queue1,cpu_energies,mem_dockpars_energies_current,size_energies);


	for (unsigned int run_cnt = 0; run_cnt < mypars->num_of_runs; run_cnt++) {

		arrange_result(cpu_final_populations+run_cnt*mypars->pop_size*ACTUAL_GENOTYPE_LENGTH, 
			       cpu_energies+run_cnt*mypars->pop_size, 
			       mypars->pop_size);

		make_resfiles(cpu_final_populations+run_cnt*mypars->pop_size*ACTUAL_GENOTYPE_LENGTH, 
			      cpu_energies+run_cnt*mypars->pop_size, 
			      &myligand_reference,
			      myligand_init, 
			      mypars, 
   			      cpu_evals_of_runs[run_cnt], 
			      cpu_gens_of_runs[run_cnt], /*generation_cnt, */
			      mygrid, 
			      cpu_floatgrids, 
			      cpu_ref_ori_angles+3*run_cnt, 
			      argc, 
			      argv, 
			      0,
			      run_cnt, 
                              &(cpu_result_ligands [run_cnt]));
	} // End of for (run_cnt = 0; run_cnt < mypars->num_of_runs; run_cnt++)

#endif






	



/*
#if defined (DOCK_DEBUG)
	for (int cnt_pop=0;cnt_pop<size_populations/sizeof(float);cnt_pop++)
		printf("total_num_pop: %u, cpu_final_populations[%u]: %f\n",(unsigned int)(size_populations/sizeof(float)),cnt_pop,cpu_final_populations[cnt_pop]);

	for (int cnt_pop=0;cnt_pop<size_energies/sizeof(float);cnt_pop++)
		printf("total_num_energies: %u, cpu_energies[%u]: %f\n",    (unsigned int)(size_energies/sizeof(float)),cnt_pop,cpu_energies[cnt_pop]);
#endif
*/












	clock_stop_program_before_clustering = clock();


	clusanal_gendlg(cpu_result_ligands, 
			mypars->num_of_runs,
			myligand_init, mypars,
   		        mygrid, 
			argc,
			argv,
			ELAPSEDSECS(clock_stop_docking, clock_start_docking)/mypars->num_of_runs,
			ELAPSEDSECS(clock_stop_program_before_clustering, clock_start_program));





	clock_stop_docking = clock();






  	// Free the resources allocated
  	cleanup();

	return 0;
}


//// --------------------------------
//// Altera OpenCL Helper Functions
//// --------------------------------
bool init() {
  cl_int status;

  if(!setCwdToExeDir()) {
    return false;
  }

  // Get the OpenCL platform.
  //platform = findPlatform("Intel(R) FPGA"); // use it from aoc v16.1
  platform = findPlatform("Altera SDK");      // works for harp2, i.e. v16.0 patched
  if(platform == NULL) {
    printf("ERROR: Unable to find Intel(R) FPGA OpenCL platform.\n");
    return false;
  }

  // User-visible output - Platform information
  {
    char char_buffer[STRING_BUFFER_LEN]; 
    printf("Querying platform for info:\n");
    printf("==========================\n");
    clGetPlatformInfo(platform, CL_PLATFORM_NAME, STRING_BUFFER_LEN, char_buffer, NULL);
    printf("%-40s = %s\n", "CL_PLATFORM_NAME", char_buffer);
    clGetPlatformInfo(platform, CL_PLATFORM_VENDOR, STRING_BUFFER_LEN, char_buffer, NULL);
    printf("%-40s = %s\n", "CL_PLATFORM_VENDOR ", char_buffer);
    clGetPlatformInfo(platform, CL_PLATFORM_VERSION, STRING_BUFFER_LEN, char_buffer, NULL);
    printf("%-40s = %s\n\n", "CL_PLATFORM_VERSION ", char_buffer);
  }

  // Query the available OpenCL devices.
  scoped_array<cl_device_id> devices;
  cl_uint num_devices;

  devices.reset(getDevices(platform, CL_DEVICE_TYPE_ALL, &num_devices));

  // We'll just use the first device.
  device = devices[0];

  // Display some device information.
  display_device_info(device);

  // Create the context.
  context = clCreateContext(NULL, 1, &device, &oclContextCallback, NULL, &status);
  checkError(status, "Failed to create context");

  // Create the command queue.
  //queue = clCreateCommandQueue(context, device, CL_QUEUE_PROFILING_ENABLE, &status);
  //command_queue = clCreateCommandQueue(context, device, CL_QUEUE_PROFILING_ENABLE, &status);
  //checkError(status, "Failed to create command queue");

  // Create the program.
/*  
  std::string binary_file = getBoardBinaryFile("docking", device);
*/
  std::string binary_file = getBoardBinaryFile("Krnl_GA", device);
  printf("Using AOCX: %s\n", binary_file.c_str());
  program = createProgramFromBinary(context, binary_file.c_str(), &device, 1);


  // Build the program that was just created.
  status = clBuildProgram(program, 0, NULL, "", NULL, NULL);
  checkError(status, "Failed to build program");


  // Create the kernel - name passed in here must match kernel name in the
  // original CL file, that was compiled into an AOCX file using the AOC tool
#ifdef ENABLE_KERNEL1
  //command_queue1 = clCreateCommandQueue(context, device, CL_QUEUE_PROFILING_ENABLE, &status);
  command_queue1 = clCreateCommandQueue(context, device, 0, &status);
  checkError(status, "Failed to create command queue1");
  kernel1 = clCreateKernel(program, name_k1, &status);
  checkError(status, "Failed to create kernel");
#endif

#ifdef ENABLE_KERNEL2
  command_queue2 = clCreateCommandQueue(context, device, 0, &status);
  checkError(status, "Failed to create command queue2");
  kernel2 = clCreateKernel(program, name_k2, &status);
  checkError(status, "Failed to create kernel");
#endif

#ifdef ENABLE_KERNEL3
  command_queue3 = clCreateCommandQueue(context, device, 0, &status);
  checkError(status, "Failed to create command queue3");
  kernel3 = clCreateKernel(program, name_k3, &status);
  checkError(status, "Failed to create kernel");
#endif

#ifdef ENABLE_KERNEL4
  command_queue4 = clCreateCommandQueue(context, device, 0, &status);
  checkError(status, "Failed to create command queue4");
  kernel4 = clCreateKernel(program, name_k4, &status);
  checkError(status, "Failed to create kernel");
#endif

#if 0
#ifdef ENABLE_KERNEL5
  command_queue5 = clCreateCommandQueue(context, device, 0, &status);
  checkError(status, "Failed to create command queue5");
  kernel5 = clCreateKernel(program, name_k5, &status);
  checkError(status, "Failed to create kernel");
#endif
#endif

#ifdef ENABLE_KERNEL6
  command_queue6 = clCreateCommandQueue(context, device, 0, &status);
  checkError(status, "Failed to create command queue6");
  kernel6 = clCreateKernel(program, name_k6, &status);
  checkError(status, "Failed to create kernel");
#endif

#ifdef ENABLE_KERNEL7
  command_queue7 = clCreateCommandQueue(context, device, 0, &status);
  checkError(status, "Failed to create command queue7");
  kernel7 = clCreateKernel(program, name_k7, &status);
  checkError(status, "Failed to create kernel");
#endif

#if 0
#ifdef ENABLE_KERNEL8
  command_queue8 = clCreateCommandQueue(context, device, 0, &status);
  checkError(status, "Failed to create command queue8");
  kernel8 = clCreateKernel(program, name_k8, &status);
  checkError(status, "Failed to create kernel");
#endif
#endif

#if 0
#ifdef ENABLE_KERNEL9
  command_queue9 = clCreateCommandQueue(context, device, 0, &status);
  checkError(status, "Failed to create command queue9");
  kernel9 = clCreateKernel(program, name_k9, &status);
  checkError(status, "Failed to create kernel");
#endif
#endif

#ifdef ENABLE_KERNEL10
  command_queue10 = clCreateCommandQueue(context, device, 0, &status);
  checkError(status, "Failed to create command queue10");
  kernel10 = clCreateKernel(program, name_k10, &status);
  checkError(status, "Failed to create kernel");
#endif

#if 0
#ifdef ENABLE_KERNEL11
  command_queue11 = clCreateCommandQueue(context, device, 0, &status);
  checkError(status, "Failed to create command queue10");
  kernel11 = clCreateKernel(program, name_k11, &status);
  checkError(status, "Failed to create kernel");
#endif
#endif

#ifdef ENABLE_KERNEL12
  command_queue12 = clCreateCommandQueue(context, device, 0, &status);
  checkError(status, "Failed to create command queue12");
  kernel12 = clCreateKernel(program, name_k12, &status);
  checkError(status, "Failed to create kernel");
#endif

#if 0
#ifdef ENABLE_KERNEL13
  command_queue13 = clCreateCommandQueue(context, device, 0, &status);
  checkError(status, "Failed to create command queue13");
  kernel13 = clCreateKernel(program, name_k13, &status);
  checkError(status, "Failed to create kernel");
#endif
#endif

#ifdef ENABLE_KERNEL14
  command_queue14 = clCreateCommandQueue(context, device, 0, &status);
  checkError(status, "Failed to create command queue14");
  kernel14 = clCreateKernel(program, name_k14, &status);
  checkError(status, "Failed to create kernel");
#endif

#ifdef ENABLE_KERNEL15
  command_queue15 = clCreateCommandQueue(context, device, 0, &status);
  checkError(status, "Failed to create command queue15");
  kernel15 = clCreateKernel(program, name_k15, &status);
  checkError(status, "Failed to create kernel");
#endif

#if 0
#ifdef ENABLE_KERNEL16
  command_queue16 = clCreateCommandQueue(context, device, 0, &status);
  checkError(status, "Failed to create command queue13");
  kernel16 = clCreateKernel(program, name_k16, &status);
  checkError(status, "Failed to create kernel");
#endif
#endif

#if 0
#ifdef ENABLE_KERNEL17
  command_queue17 = clCreateCommandQueue(context, device, 0, &status);
  checkError(status, "Failed to create command queue17");
  kernel17 = clCreateKernel(program, name_k17, &status);
  checkError(status, "Failed to create kernel");
#endif
#endif

#if 0
#ifdef ENABLE_KERNEL18
  command_queue18 = clCreateCommandQueue(context, device, 0, &status);
  checkError(status, "Failed to create command queue18");
  kernel18 = clCreateKernel(program, name_k18, &status);
  checkError(status, "Failed to create kernel");
#endif
#endif

#if 0
#ifdef ENABLE_KERNEL19
  command_queue19 = clCreateCommandQueue(context, device, 0, &status);
  checkError(status, "Failed to create command queue19");
  kernel19 = clCreateKernel(program, name_k19, &status);
  checkError(status, "Failed to create kernel");
#endif
#endif

#ifdef ENABLE_KERNEL20
  command_queue20 = clCreateCommandQueue(context, device, 0, &status);
  checkError(status, "Failed to create command queue20");
  kernel20 = clCreateKernel(program, name_k20, &status);
  checkError(status, "Failed to create kernel");
#endif

#ifdef ENABLE_KERNEL21
  command_queue21 = clCreateCommandQueue(context, device, 0, &status);
  checkError(status, "Failed to create command queue21");
  kernel21 = clCreateKernel(program, name_k21, &status);
  checkError(status, "Failed to create kernel");
#endif

#if 0
#ifdef ENABLE_KERNEL22
  command_queue22 = clCreateCommandQueue(context, device, 0, &status);
  checkError(status, "Failed to create command queue22");
  kernel22 = clCreateKernel(program, name_k22, &status);
  checkError(status, "Failed to create kernel");
#endif
#endif

#if 0
#ifdef ENABLE_KERNEL23
  command_queue23 = clCreateCommandQueue(context, device, 0, &status);
  checkError(status, "Failed to create command queue23");
  kernel23 = clCreateKernel(program, name_k23, &status);
  checkError(status, "Failed to create kernel");
#endif
#endif

#if 0
#ifdef ENABLE_KERNEL24
  command_queue24 = clCreateCommandQueue(context, device, 0, &status);
  checkError(status, "Failed to create command queue24");
  kernel24 = clCreateKernel(program, name_k24, &status);
  checkError(status, "Failed to create kernel");
#endif
#endif

#if 0
#ifdef ENABLE_KERNEL25
  command_queue25 = clCreateCommandQueue(context, device, 0, &status);
  checkError(status, "Failed to create command queue25");
  kernel25 = clCreateKernel(program, name_k25, &status);
  checkError(status, "Failed to create kernel");
#endif
#endif

#if 0
#ifdef ENABLE_KERNEL26
  command_queue26 = clCreateCommandQueue(context, device, 0, &status);
  checkError(status, "Failed to create command queue26");
  kernel26 = clCreateKernel(program, name_k26, &status);
  checkError(status, "Failed to create kernel");
#endif
#endif

#ifdef ENABLE_KERNEL27
  command_queue27 = clCreateCommandQueue(context, device, 0, &status);
  checkError(status, "Failed to create command queue27");
  kernel27 = clCreateKernel(program, name_k27, &status);
  checkError(status, "Failed to create kernel");
#endif

#if 0
#ifdef ENABLE_KERNEL28
  command_queue28 = clCreateCommandQueue(context, device, 0, &status);
  checkError(status, "Failed to create command queue28");
  kernel28 = clCreateKernel(program, name_k28, &status);
  checkError(status, "Failed to create kernel");
#endif
#endif

#if 0
#ifdef ENABLE_KERNEL29
  command_queue29 = clCreateCommandQueue(context, device, 0, &status);
  checkError(status, "Failed to create command queue29");
  kernel29 = clCreateKernel(program, name_k29, &status);
  checkError(status, "Failed to create kernel");
#endif
#endif

#if 0
#ifdef ENABLE_KERNEL30
  command_queue30 = clCreateCommandQueue(context, device, 0, &status);
  checkError(status, "Failed to create command queue30");
  kernel30 = clCreateKernel(program, name_k30, &status);
  checkError(status, "Failed to create kernel");
#endif
#endif

#if 0
#ifdef ENABLE_KERNEL31
  command_queue31 = clCreateCommandQueue(context, device, 0, &status);
  checkError(status, "Failed to create command queue31");
  kernel31 = clCreateKernel(program, name_k31, &status);
  checkError(status, "Failed to create kernel");
#endif
#endif

#if 0
#ifdef ENABLE_KERNEL32
  command_queue32 = clCreateCommandQueue(context, device, 0, &status);
  checkError(status, "Failed to create command queue32");
  kernel32 = clCreateKernel(program, name_k32, &status);
  checkError(status, "Failed to create kernel");
#endif
#endif

#if 0
#ifdef ENABLE_KERNEL33
  command_queue33 = clCreateCommandQueue(context, device, 0, &status);
  checkError(status, "Failed to create command queue33");
  kernel33 = clCreateKernel(program, name_k33, &status);
  checkError(status, "Failed to create kernel");
#endif
#endif

#if 0
#ifdef ENABLE_KERNEL34
  command_queue34 = clCreateCommandQueue(context, device, 0, &status);
  checkError(status, "Failed to create command queue34");
  kernel34 = clCreateKernel(program, name_k34, &status);
  checkError(status, "Failed to create kernel");
#endif
#endif

#ifdef ENABLE_KERNEL35
  command_queue35 = clCreateCommandQueue(context, device, 0, &status);
  checkError(status, "Failed to create command queue26");
  kernel35 = clCreateKernel(program, name_k35, &status);
  checkError(status, "Failed to create kernel");
#endif

#ifdef ENABLE_KERNEL36
  command_queue36 = clCreateCommandQueue(context, device, 0, &status);
  checkError(status, "Failed to create command queue36");
  kernel36 = clCreateKernel(program, name_k36, &status);
  checkError(status, "Failed to create kernel");
#endif

#ifdef ENABLE_KERNEL37
  command_queue37 = clCreateCommandQueue(context, device, 0, &status);
  checkError(status, "Failed to create command queue37");
  kernel37 = clCreateKernel(program, name_k37, &status);
  checkError(status, "Failed to create kernel");
#endif

#ifdef ENABLE_KERNEL38
  command_queue38 = clCreateCommandQueue(context, device, 0, &status);
  checkError(status, "Failed to create command queue38");
  kernel38 = clCreateKernel(program, name_k38, &status);
  checkError(status, "Failed to create kernel");
#endif

#ifdef ENABLE_KERNEL39
  command_queue39 = clCreateCommandQueue(context, device, 0, &status);
  checkError(status, "Failed to create command queue39");
  kernel39 = clCreateKernel(program, name_k39, &status);
  checkError(status, "Failed to create kernel");
#endif

#ifdef ENABLE_KERNEL40
  command_queue40 = clCreateCommandQueue(context, device, 0, &status);
  checkError(status, "Failed to create command queue40");
  kernel40 = clCreateKernel(program, name_k40, &status);
  checkError(status, "Failed to create kernel");
#endif

#ifdef ENABLE_KERNEL41
  command_queue41 = clCreateCommandQueue(context, device, 0, &status);
  checkError(status, "Failed to create command queue41");
  kernel41 = clCreateKernel(program, name_k41, &status);
  checkError(status, "Failed to create kernel");
#endif

#ifdef ENABLE_KERNEL42
  command_queue42 = clCreateCommandQueue(context, device, 0, &status);
  checkError(status, "Failed to create command queue42");
  kernel42 = clCreateKernel(program, name_k42, &status);
  checkError(status, "Failed to create kernel");
#endif

#ifdef ENABLE_KERNEL43
  command_queue43 = clCreateCommandQueue(context, device, 0, &status);
  checkError(status, "Failed to create command queue43");
  kernel43 = clCreateKernel(program, name_k43, &status);
  checkError(status, "Failed to create kernel");
#endif

#ifdef ENABLE_KERNEL44
  command_queue44 = clCreateCommandQueue(context, device, 0, &status);
  checkError(status, "Failed to create command queue44");
  kernel44 = clCreateKernel(program, name_k44, &status);
  checkError(status, "Failed to create kernel");
#endif



#ifdef ENABLE_KERNEL45
  command_queue45 = clCreateCommandQueue(context, device, 0, &status);
  checkError(status, "Failed to create command queue45");
  kernel45 = clCreateKernel(program, name_k45, &status);
  checkError(status, "Failed to create kernel");
#endif

#ifdef ENABLE_KERNEL46
  command_queue46 = clCreateCommandQueue(context, device, 0, &status);
  checkError(status, "Failed to create command queue46");
  kernel46 = clCreateKernel(program, name_k46, &status);
  checkError(status, "Failed to create kernel");
#endif

#ifdef ENABLE_KERNEL47
  command_queue47 = clCreateCommandQueue(context, device, 0, &status);
  checkError(status, "Failed to create command queue47");
  kernel47 = clCreateKernel(program, name_k47, &status);
  checkError(status, "Failed to create kernel");
#endif

#ifdef ENABLE_KERNEL48
  command_queue48 = clCreateCommandQueue(context, device, 0, &status);
  checkError(status, "Failed to create command queue48");
  kernel48 = clCreateKernel(program, name_k48, &status);
  checkError(status, "Failed to create kernel");
#endif

  return true;
}

// Free the resources allocated during initialization
void cleanup() {
#ifdef ENABLE_KERNEL1
  if(kernel1) {clReleaseKernel(kernel1);}
  if(command_queue1) {clReleaseCommandQueue(command_queue1);}
#endif

#ifdef ENABLE_KERNEL2
  if(kernel2) {clReleaseKernel(kernel2);}
  if(command_queue2) {clReleaseCommandQueue(command_queue2);}
#endif

#ifdef ENABLE_KERNEL3
  if(kernel3) {clReleaseKernel(kernel3);}
  if(command_queue3) {clReleaseCommandQueue(command_queue3);}
#endif

#ifdef ENABLE_KERNEL4
  if(kernel4) {clReleaseKernel(kernel4);}
  if(command_queue4) {clReleaseCommandQueue(command_queue4);}
#endif

#if 0
#ifdef ENABLE_KERNEL5
  if(kernel5) {clReleaseKernel(kernel5);}
  if(command_queue5) {clReleaseCommandQueue(command_queue5);}
#endif
#endif

#ifdef ENABLE_KERNEL6
  if(kernel6) {clReleaseKernel(kernel6);}
  if(command_queue6) {clReleaseCommandQueue(command_queue6);}
#endif

#ifdef ENABLE_KERNEL7
  if(kernel7) {clReleaseKernel(kernel7);}
  if(command_queue7) {clReleaseCommandQueue(command_queue7);}
#endif

#if 0
#ifdef ENABLE_KERNEL8
  if(kernel8) {clReleaseKernel(kernel8);}
  if(command_queue8) {clReleaseCommandQueue(command_queue8);}
#endif
#endif

#if 0
#ifdef ENABLE_KERNEL9
  if(kernel9) {clReleaseKernel(kernel9);}
  if(command_queue9) {clReleaseCommandQueue(command_queue9);}
#endif
#endif

#ifdef ENABLE_KERNEL10
  if(kernel10) {clReleaseKernel(kernel10);}
  if(command_queue10) {clReleaseCommandQueue(command_queue10);}
#endif

#if 0
#ifdef ENABLE_KERNEL11
  if(kernel11) {clReleaseKernel(kernel11);}
  if(command_queue11) {clReleaseCommandQueue(command_queue11);}
#endif
#endif

#ifdef ENABLE_KERNEL12
  if(kernel12) {clReleaseKernel(kernel12);}
  if(command_queue12) {clReleaseCommandQueue(command_queue12);}
#endif

#if 0
#ifdef ENABLE_KERNEL13
  if(kernel13) {clReleaseKernel(kernel13);}
  if(command_queue13) {clReleaseCommandQueue(command_queue13);}
#endif
#endif

#ifdef ENABLE_KERNEL14
  if(kernel14) {clReleaseKernel(kernel14);}
  if(command_queue14) {clReleaseCommandQueue(command_queue14);}
#endif

#ifdef ENABLE_KERNEL15
  if(kernel15) {clReleaseKernel(kernel15);}
  if(command_queue15) {clReleaseCommandQueue(command_queue15);}
#endif

#if 0
#ifdef ENABLE_KERNEL16
  if(kernel16) {clReleaseKernel(kernel16);}
  if(command_queue16) {clReleaseCommandQueue(command_queue16);}
#endif
#endif

#if 0
#ifdef ENABLE_KERNEL17
  if(kernel17) {clReleaseKernel(kernel17);}
  if(command_queue17) {clReleaseCommandQueue(command_queue17);}
#endif
#endif

#if 0
#ifdef ENABLE_KERNEL18
  if(kernel18) {clReleaseKernel(kernel18);}
  if(command_queue18) {clReleaseCommandQueue(command_queue18);}
#endif
#endif

#if 0
#ifdef ENABLE_KERNEL19
  if(kernel19) {clReleaseKernel(kernel19);}
  if(command_queue19) {clReleaseCommandQueue(command_queue19);}
#endif
#endif

#ifdef ENABLE_KERNEL20
  if(kernel20) {clReleaseKernel(kernel20);}
  if(command_queue20) {clReleaseCommandQueue(command_queue20);}
#endif

#ifdef ENABLE_KERNEL21
  if(kernel21) {clReleaseKernel(kernel21);}
  if(command_queue21) {clReleaseCommandQueue(command_queue21);}
#endif

#if 0
#ifdef ENABLE_KERNEL22
  if(kernel22) {clReleaseKernel(kernel22);}
  if(command_queue22) {clReleaseCommandQueue(command_queue22);}
#endif
#endif

#if 0
#ifdef ENABLE_KERNEL23
  if(kernel23) {clReleaseKernel(kernel23);}
  if(command_queue23) {clReleaseCommandQueue(command_queue23);}
#endif
#endif

#if 0
#ifdef ENABLE_KERNEL24
  if(kernel24) {clReleaseKernel(kernel24);}
  if(command_queue24) {clReleaseCommandQueue(command_queue24);}
#endif
#endif

#if 0
#ifdef ENABLE_KERNEL25
  if(kernel25) {clReleaseKernel(kernel25);}
  if(command_queue25) {clReleaseCommandQueue(command_queue25);}
#endif
#endif

#if 0
#ifdef ENABLE_KERNEL26
  if(kernel26) {clReleaseKernel(kernel26);}
  if(command_queue26) {clReleaseCommandQueue(command_queue26);}
#endif
#endif

#ifdef ENABLE_KERNEL27
  if(kernel27) {clReleaseKernel(kernel27);}
  if(command_queue27) {clReleaseCommandQueue(command_queue27);}
#endif

#if 0
#ifdef ENABLE_KERNEL28
  if(kernel28) {clReleaseKernel(kernel28);}
  if(command_queue28) {clReleaseCommandQueue(command_queue28);}
#endif
#endif

#if 0
#ifdef ENABLE_KERNEL29
  if(kernel29) {clReleaseKernel(kernel29);}
  if(command_queue29) {clReleaseCommandQueue(command_queue29);}
#endif
#endif

#if 0
#ifdef ENABLE_KERNEL30
  if(kernel30) {clReleaseKernel(kernel30);}
  if(command_queue30) {clReleaseCommandQueue(command_queue30);}
#endif
#endif

#if 0
#ifdef ENABLE_KERNEL31
  if(kernel31) {clReleaseKernel(kernel31);}
  if(command_queue31) {clReleaseCommandQueue(command_queue31);}
#endif
#endif

#if 0
#ifdef ENABLE_KERNEL32
  if(kernel32) {clReleaseKernel(kernel32);}
  if(command_queue32) {clReleaseCommandQueue(command_queue32);}
#endif
#endif

#if 0
#ifdef ENABLE_KERNEL33
  if(kernel33) {clReleaseKernel(kernel33);}
  if(command_queue33) {clReleaseCommandQueue(command_queue33);}
#endif
#endif

#if 0
#ifdef ENABLE_KERNEL34
  if(kernel34) {clReleaseKernel(kernel34);}
  if(command_queue34) {clReleaseCommandQueue(command_queue34);}
#endif
#endif

#ifdef ENABLE_KERNEL35
  if(kernel35) {clReleaseKernel(kernel35);}
  if(command_queue35) {clReleaseCommandQueue(command_queue35);}
#endif

#ifdef ENABLE_KERNEL36
  if(kernel36) {clReleaseKernel(kernel36);}
  if(command_queue36) {clReleaseCommandQueue(command_queue36);}
#endif

#ifdef ENABLE_KERNEL37
  if(kernel37) {clReleaseKernel(kernel37);}
  if(command_queue37) {clReleaseCommandQueue(command_queue37);}
#endif

#ifdef ENABLE_KERNEL38
  if(kernel38) {clReleaseKernel(kernel38);}
  if(command_queue38) {clReleaseCommandQueue(command_queue38);}
#endif

#ifdef ENABLE_KERNEL39
  if(kernel39) {clReleaseKernel(kernel39);}
  if(command_queue39) {clReleaseCommandQueue(command_queue39);}
#endif

#ifdef ENABLE_KERNEL40
  if(kernel40) {clReleaseKernel(kernel40);}
  if(command_queue40) {clReleaseCommandQueue(command_queue40);}
#endif

#ifdef ENABLE_KERNEL41
  if(kernel41) {clReleaseKernel(kernel41);}
  if(command_queue41) {clReleaseCommandQueue(command_queue41);}
#endif

#ifdef ENABLE_KERNEL42
  if(kernel42) {clReleaseKernel(kernel42);}
  if(command_queue42) {clReleaseCommandQueue(command_queue42);}
#endif

#ifdef ENABLE_KERNEL43
  if(kernel43) {clReleaseKernel(kernel43);}
  if(command_queue43) {clReleaseCommandQueue(command_queue43);}
#endif

#ifdef ENABLE_KERNEL44
  if(kernel44) {clReleaseKernel(kernel44);}
  if(command_queue44) {clReleaseCommandQueue(command_queue44);}
#endif

#ifdef ENABLE_KERNEL45
  if(kernel45) {clReleaseKernel(kernel45);}
  if(command_queue45) {clReleaseCommandQueue(command_queue45);}
#endif

#ifdef ENABLE_KERNEL46
  if(kernel46) {clReleaseKernel(kernel46);}
  if(command_queue46) {clReleaseCommandQueue(command_queue46);}
#endif

#ifdef ENABLE_KERNEL47
  if(kernel47) {clReleaseKernel(kernel47);}
  if(command_queue47) {clReleaseCommandQueue(command_queue47);}
#endif

#ifdef ENABLE_KERNEL48
  if(kernel48) {clReleaseKernel(kernel48);}
  if(command_queue48) {clReleaseCommandQueue(command_queue48);}
#endif

  if(program) {clReleaseProgram(program);}
  if(context) {clReleaseContext(context);}

  if(cpu_init_populations) {alignedFree(cpu_init_populations);}
  if(cpu_final_populations){alignedFree(cpu_final_populations);}
  if(cpu_energies)         {alignedFree(cpu_energies);}
  if(cpu_result_ligands)   {alignedFree(cpu_result_ligands);}
  if(cpu_prng_seeds)       {alignedFree(cpu_prng_seeds);}
#if defined(SINGLE_COPY_POP_ENE)
  if(cpu_evals_of_runs)    {alignedFree(cpu_evals_of_runs);}
#endif
  if(cpu_ref_ori_angles)   {alignedFree(cpu_ref_ori_angles);}

//#if defined (FIXED_POINT_INTERE)
#if 0
  if(cpu_fixedpt64grids)   {alignedFree(cpu_fixedpt64grids);}
#endif

#if defined (FIXED_POINT_INTERE)
  if(mem_KerConstStatic_fixpt64_atom_charges_const)	  {clReleaseMemObject(mem_KerConstStatic_fixpt64_atom_charges_const);}
#endif
  if(mem_KerConstStatic_atom_charges_const)	  	  {clReleaseMemObject(mem_KerConstStatic_atom_charges_const);}
  if(mem_KerConstStatic_atom_types_const)	   	  {clReleaseMemObject(mem_KerConstStatic_atom_types_const);}
  if(mem_KerConstStatic_intraE_contributors_const) 	  {clReleaseMemObject(mem_KerConstStatic_intraE_contributors_const);}
  if(mem_KerConstStatic_VWpars_AC_const)	   	  {clReleaseMemObject(mem_KerConstStatic_VWpars_AC_const);}
  if(mem_KerConstStatic_VWpars_BD_const)	   	  {clReleaseMemObject(mem_KerConstStatic_VWpars_BD_const);}
  if(mem_KerConstStatic_dspars_S_const)		   	  {clReleaseMemObject(mem_KerConstStatic_dspars_S_const);}
  if(mem_KerConstStatic_dspars_V_const)		   	  {clReleaseMemObject(mem_KerConstStatic_dspars_V_const);}
  if(mem_KerConstStatic_rotlist_const)		   	  {clReleaseMemObject(mem_KerConstStatic_rotlist_const);}
  if(mem_KerConstStatic_ref_coords_const)		  {clReleaseMemObject(mem_KerConstStatic_ref_coords_const);}
  if(mem_KerConstStatic_rotbonds_moving_vectors_const)    {clReleaseMemObject(mem_KerConstStatic_rotbonds_moving_vectors_const);}
  if(mem_KerConstStatic_rotbonds_unit_vectors_const)	  {clReleaseMemObject(mem_KerConstStatic_rotbonds_unit_vectors_const);}
  if(mem_KerConstStatic_ref_orientation_quats_const)	  {clReleaseMemObject(mem_KerConstStatic_ref_orientation_quats_const);}

  if(mem_dockpars_fgrids) 		  {clReleaseMemObject(mem_dockpars_fgrids);}
#if defined(SEPARATE_FGRID_INTERE)
  if(mem_dockpars_fgrids2) 		  {clReleaseMemObject(mem_dockpars_fgrids2);}
  if(mem_dockpars_fgrids3) 		  {clReleaseMemObject(mem_dockpars_fgrids3);}
#endif

  if(mem_dockpars_conformations_current)  {clReleaseMemObject(mem_dockpars_conformations_current);}
  if(mem_dockpars_energies_current) 	  {clReleaseMemObject(mem_dockpars_energies_current);}

/*
  if(mem_dockpars_prng_states)            {clReleaseMemObject(mem_dockpars_prng_states);}
*/
#if defined(SINGLE_COPY_POP_ENE)
  if(mem_evals_performed) {clReleaseMemObject(mem_evals_performed);}
  if(mem_gens_performed)  {clReleaseMemObject(mem_gens_performed);}
#else
  if(mem_evals_and_generations_performed) {clReleaseMemObject(mem_evals_and_generations_performed);}
#endif
}

// Helper functions to display parameters returned by OpenCL queries
static void device_info_ulong( cl_device_id device, cl_device_info param, const char* name) {
   cl_ulong a;
   clGetDeviceInfo(device, param, sizeof(cl_ulong), &a, NULL);
   printf("%-40s = %lu\n", name, a);
}
static void device_info_uint( cl_device_id device, cl_device_info param, const char* name) {
   cl_uint a;
   clGetDeviceInfo(device, param, sizeof(cl_uint), &a, NULL);
   printf("%-40s = %u\n", name, a);
}
static void device_info_bool( cl_device_id device, cl_device_info param, const char* name) {
   cl_bool a;
   clGetDeviceInfo(device, param, sizeof(cl_bool), &a, NULL);
   printf("%-40s = %s\n", name, (a?"true":"false"));
}
static void device_info_string( cl_device_id device, cl_device_info param, const char* name) {
   char a[STRING_BUFFER_LEN]; 
   clGetDeviceInfo(device, param, STRING_BUFFER_LEN, &a, NULL);
   printf("%-40s = %s\n", name, a);
}

// Query and display OpenCL information on device and runtime environment
static void display_device_info( cl_device_id device ) {

   printf("Querying device for info:\n");
   printf("========================\n");
   device_info_string(device, CL_DEVICE_NAME, "CL_DEVICE_NAME");
   device_info_string(device, CL_DEVICE_VENDOR, "CL_DEVICE_VENDOR");
   device_info_uint(device, CL_DEVICE_VENDOR_ID, "CL_DEVICE_VENDOR_ID");
   device_info_string(device, CL_DEVICE_VERSION, "CL_DEVICE_VERSION");
   device_info_string(device, CL_DRIVER_VERSION, "CL_DRIVER_VERSION");
   device_info_uint(device, CL_DEVICE_ADDRESS_BITS, "CL_DEVICE_ADDRESS_BITS");
   device_info_bool(device, CL_DEVICE_AVAILABLE, "CL_DEVICE_AVAILABLE");
   device_info_bool(device, CL_DEVICE_ENDIAN_LITTLE, "CL_DEVICE_ENDIAN_LITTLE");
   device_info_ulong(device, CL_DEVICE_GLOBAL_MEM_CACHE_SIZE, "CL_DEVICE_GLOBAL_MEM_CACHE_SIZE");
   device_info_ulong(device, CL_DEVICE_GLOBAL_MEM_CACHELINE_SIZE, "CL_DEVICE_GLOBAL_MEM_CACHELINE_SIZE");
   device_info_ulong(device, CL_DEVICE_GLOBAL_MEM_SIZE, "CL_DEVICE_GLOBAL_MEM_SIZE");
   device_info_bool(device, CL_DEVICE_IMAGE_SUPPORT, "CL_DEVICE_IMAGE_SUPPORT");
   device_info_ulong(device, CL_DEVICE_LOCAL_MEM_SIZE, "CL_DEVICE_LOCAL_MEM_SIZE");
   device_info_ulong(device, CL_DEVICE_MAX_CLOCK_FREQUENCY, "CL_DEVICE_MAX_CLOCK_FREQUENCY");
   device_info_ulong(device, CL_DEVICE_MAX_COMPUTE_UNITS, "CL_DEVICE_MAX_COMPUTE_UNITS");
   device_info_ulong(device, CL_DEVICE_MAX_CONSTANT_ARGS, "CL_DEVICE_MAX_CONSTANT_ARGS");
   device_info_ulong(device, CL_DEVICE_MAX_CONSTANT_BUFFER_SIZE, "CL_DEVICE_MAX_CONSTANT_BUFFER_SIZE");
   device_info_uint(device, CL_DEVICE_MAX_WORK_ITEM_DIMENSIONS, "CL_DEVICE_MAX_WORK_ITEM_DIMENSIONS");
   device_info_uint(device, CL_DEVICE_MEM_BASE_ADDR_ALIGN, "CL_DEVICE_MEM_BASE_ADDR_ALIGN");
   device_info_uint(device, CL_DEVICE_MIN_DATA_TYPE_ALIGN_SIZE, "CL_DEVICE_MIN_DATA_TYPE_ALIGN_SIZE");
   device_info_uint(device, CL_DEVICE_PREFERRED_VECTOR_WIDTH_CHAR, "CL_DEVICE_PREFERRED_VECTOR_WIDTH_CHAR");
   device_info_uint(device, CL_DEVICE_PREFERRED_VECTOR_WIDTH_SHORT, "CL_DEVICE_PREFERRED_VECTOR_WIDTH_SHORT");
   device_info_uint(device, CL_DEVICE_PREFERRED_VECTOR_WIDTH_INT, "CL_DEVICE_PREFERRED_VECTOR_WIDTH_INT");
   device_info_uint(device, CL_DEVICE_PREFERRED_VECTOR_WIDTH_LONG, "CL_DEVICE_PREFERRED_VECTOR_WIDTH_LONG");
   device_info_uint(device, CL_DEVICE_PREFERRED_VECTOR_WIDTH_FLOAT, "CL_DEVICE_PREFERRED_VECTOR_WIDTH_FLOAT");
   device_info_uint(device, CL_DEVICE_PREFERRED_VECTOR_WIDTH_DOUBLE, "CL_DEVICE_PREFERRED_VECTOR_WIDTH_DOUBLE");

   {
      cl_command_queue_properties ccp;
      clGetDeviceInfo(device, CL_DEVICE_QUEUE_PROPERTIES, sizeof(cl_command_queue_properties), &ccp, NULL);
      printf("%-40s = %s\n", "Command queue out of order? ", ((ccp & CL_QUEUE_OUT_OF_ORDER_EXEC_MODE_ENABLE)?"true":"false"));
      printf("%-40s = %s\n", "Command queue profiling enabled? ", ((ccp & CL_QUEUE_PROFILING_ENABLE)?"true":"false"));
   }
}
