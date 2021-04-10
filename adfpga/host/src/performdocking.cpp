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
static cl_platform_id platform = NULL;
static cl_device_id device = NULL;
static cl_context context = NULL;

// Kernel name, as defined in the CL file
static cl_command_queue command_queue_ga = NULL;
static cl_kernel kernel_ga = NULL;
static const char *name_ga = "Krnl_GA";

static cl_command_queue command_queue_pc = NULL;
static cl_kernel kernel_pc = NULL;
static const char *name_pc = "Krnl_Conform";

static cl_command_queue command_queue_ie = NULL;
static cl_kernel kernel_ie = NULL;
static const char *name_ie = "Krnl_InterE";

static cl_command_queue command_queue_ia = NULL;
static cl_kernel kernel_ia = NULL;
static const char *name_ia = "Krnl_IntraE";

static cl_command_queue command_queue_prng_gg_float = NULL;
static cl_kernel kernel_prng_gg_float = NULL;
static const char *name_prng_gg_float = "Krnl_Prng_GG_float";

static cl_command_queue command_queue_prng_ls_float = NULL;
static cl_kernel kernel_prng_ls_float = NULL;
static const char *name_prng_ls_float = "Krnl_Prng_LS_float";

static cl_command_queue command_queue_prng_gg_uchar = NULL;
static cl_kernel kernel_prng_gg_uchar = NULL;
static const char *name_prng_gg_uchar = "Krnl_Prng_GG_uchar";

static cl_command_queue command_queue_ls = NULL;
static cl_kernel kernel_ls = NULL;
static const char *name_ls = "Krnl_LS";

static cl_command_queue command_queue_prng_ls2_float = NULL;
static cl_kernel kernel_prng_ls2_float = NULL;
static const char *name_prng_ls2_float = "Krnl_Prng_LS2_float";

static cl_command_queue command_queue_ls2 = NULL;
static cl_kernel kernel_ls2 = NULL;
static const char *name_ls2 = "Krnl_LS2";

static cl_command_queue command_queue_prng_ls3_float = NULL;
static cl_kernel kernel_prng_ls3_float = NULL;
static const char *name_prng_ls3_float = "Krnl_Prng_LS3_float";

static cl_command_queue command_queue_ls3 = NULL;
static cl_kernel kernel_ls3 = NULL;
static const char *name_ls3 = "Krnl_LS3";

static cl_command_queue command_queue_igl_arb = NULL;
static cl_kernel kernel_igl_arb = NULL;
static const char *name_igl_arb = "Krnl_IGL_Arbiter";

static cl_command_queue command_queue_ls123_ushort = NULL;
static cl_kernel kernel_ls123_ushort = NULL;
static const char *name_ls123_ushort = "Krnl_Prng_LS123_ushort";

static cl_command_queue command_queue_prng_bt_ushort_float = NULL;
static cl_kernel kernel_prng_bt_ushort_float = NULL;
static const char *name_prng_bt_ushort_float = "Krnl_Prng_BT_ushort_float";

static cl_command_queue command_queue_prng_ls4_float = NULL;
static cl_kernel kernel_prng_ls4_float = NULL;
static const char *name_prng_ls4_float = "Krnl_Prng_LS4_float";

static cl_command_queue command_queue_prng_ls5_float = NULL;
static cl_kernel kernel_prng_ls5_float = NULL;
static const char *name_prng_ls5_float = "Krnl_Prng_LS5_float";

static cl_command_queue command_queue_ls4 = NULL;
static cl_kernel kernel_ls4 = NULL;
static const char *name_ls4 = "Krnl_LS4";

static cl_command_queue command_queue_ls5 = NULL;
static cl_kernel kernel_ls5 = NULL;
static const char *name_ls5 = "Krnl_LS5";

static cl_command_queue command_queue_prng_ls6_float = NULL;
static cl_kernel kernel_prng_ls6_float = NULL;
static const char *name_prng_ls6_float = "Krnl_Prng_LS6_float";

static cl_command_queue command_queue_prng_ls7_float = NULL;
static cl_kernel kernel_prng_ls7_float = NULL;
static const char *name_prng_ls7_float = "Krnl_Prng_LS7_float";

static cl_command_queue command_queue_prng_ls8_float = NULL;
static cl_kernel kernel_prng_ls8_float = NULL;
static const char *name_prng_ls8_float = "Krnl_Prng_LS8_float";

static cl_command_queue command_queue_prng_ls9_float = NULL;
static cl_kernel kernel_prng_ls9_float = NULL;
static const char *name_prng_ls9_float = "Krnl_Prng_LS9_float";

static cl_command_queue command_queue_ls6 = NULL;
static cl_kernel kernel_ls6 = NULL;
static const char *name_ls6 = "Krnl_LS6";

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

cl_mem mem_KerConstStatic_reqm_const;
cl_mem mem_KerConstStatic_reqm_hbond_const;
cl_mem mem_KerConstStatic_atom1_types_reqm_const;
cl_mem mem_KerConstStatic_atom2_types_reqm_const;

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

	timeval tv_start_docking, tv_stop_docking;

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
	dockpars.smooth = mypars->smooth;

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

        mallocBufferObject(context,CL_MEM_READ_ONLY, ATYPE_NUM*sizeof(float),				&mem_KerConstStatic_reqm_const);
	mallocBufferObject(context,CL_MEM_READ_ONLY, ATYPE_NUM*sizeof(float),				&mem_KerConstStatic_reqm_hbond_const);
  	mallocBufferObject(context,CL_MEM_READ_ONLY, ATYPE_NUM*sizeof(unsigned int),			&mem_KerConstStatic_atom1_types_reqm_const);
  	mallocBufferObject(context,CL_MEM_READ_ONLY, ATYPE_NUM*sizeof(unsigned int),                    &mem_KerConstStatic_atom2_types_reqm_const);

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
	memcopyBufferObjectToDevice(command_queue_ga,mem_KerConstStatic_fixpt64_atom_charges_const,            &KerConstStatic.fixpt64_atom_charges_const[0],            MAX_NUM_OF_ATOMS*sizeof(fixedpt64));
#endif
	memcopyBufferObjectToDevice(command_queue_ga,mem_KerConstStatic_atom_charges_const,            &KerConstStatic.atom_charges_const[0],            MAX_NUM_OF_ATOMS*sizeof(float));

	memcopyBufferObjectToDevice(command_queue_ga,mem_KerConstStatic_atom_types_const,              &KerConstStatic.atom_types_const[0],              MAX_NUM_OF_ATOMS*sizeof(char));

/*
	memcopyBufferObjectToDevice(command_queue_ga,mem_KerConstStatic_intraE_contributors_const,     &KerConstStatic.intraE_contributors_const[0],     3*MAX_INTRAE_CONTRIBUTORS*sizeof(char));
*/
	memcopyBufferObjectToDevice(command_queue_ga,mem_KerConstStatic_intraE_contributors_const,     &KerConstStatic.intraE_contributors_const[0],     MAX_INTRAE_CONTRIBUTORS*sizeof(cl_char3));

	memcopyBufferObjectToDevice(command_queue_ga,mem_KerConstStatic_reqm_const,         	     &KerConstStatic.reqm_const,           	       ATYPE_NUM*sizeof(float));
  	memcopyBufferObjectToDevice(command_queue_ga,mem_KerConstStatic_reqm_hbond_const,              &KerConstStatic.reqm_hbond_const,                 ATYPE_NUM*sizeof(float));
  	memcopyBufferObjectToDevice(command_queue_ga,mem_KerConstStatic_atom1_types_reqm_const,        &KerConstStatic.atom1_types_reqm_const,           ATYPE_NUM*sizeof(unsigned int));
  	memcopyBufferObjectToDevice(command_queue_ga,mem_KerConstStatic_atom2_types_reqm_const,        &KerConstStatic.atom2_types_reqm_const,           ATYPE_NUM*sizeof(unsigned int));

	memcopyBufferObjectToDevice(command_queue_ga,mem_KerConstStatic_VWpars_AC_const,               &KerConstStatic.VWpars_AC_const[0],               MAX_NUM_OF_ATYPES*MAX_NUM_OF_ATYPES*sizeof(float));
	memcopyBufferObjectToDevice(command_queue_ga,mem_KerConstStatic_VWpars_BD_const,               &KerConstStatic.VWpars_BD_const[0],               MAX_NUM_OF_ATYPES*MAX_NUM_OF_ATYPES*sizeof(float));
	memcopyBufferObjectToDevice(command_queue_ga,mem_KerConstStatic_dspars_S_const,                &KerConstStatic.dspars_S_const[0], 	       MAX_NUM_OF_ATYPES*sizeof(float));
	memcopyBufferObjectToDevice(command_queue_ga,mem_KerConstStatic_dspars_V_const,                &KerConstStatic.dspars_V_const[0], 	       MAX_NUM_OF_ATYPES*sizeof(float));
	#if defined (FIXED_POINT_CONFORM)
	// fixed-point
	memcopyBufferObjectToDevice(command_queue_ga,mem_KerConstStatic_rotlist_const,                 &KerConstStatic.rotlist_const[0], 		       MAX_NUM_OF_ROTATIONS*sizeof(fixedpt));
	memcopyBufferObjectToDevice(command_queue_ga,mem_KerConstStatic_ref_coords_const, 	     &KerConstStatic.ref_coords_const[0],              MAX_NUM_OF_ATOMS*sizeof(cl_int3));
	memcopyBufferObjectToDevice(command_queue_ga,mem_KerConstStatic_rotbonds_moving_vectors_const, &KerConstStatic.rotbonds_moving_vectors_const[0], MAX_NUM_OF_ROTBONDS*sizeof(cl_int3));
	memcopyBufferObjectToDevice(command_queue_ga,mem_KerConstStatic_rotbonds_unit_vectors_const,   &KerConstStatic.rotbonds_unit_vectors_const[0],   MAX_NUM_OF_ROTBONDS*sizeof(cl_int3));
	memcopyBufferObjectToDevice(command_queue_ga,mem_KerConstStatic_ref_orientation_quats_const,   &KerConstStatic.ref_orientation_quats_const[0],   MAX_NUM_OF_RUNS*sizeof(cl_int4));
	#else
	// floating-point (original)
	memcopyBufferObjectToDevice(command_queue_ga,mem_KerConstStatic_rotlist_const,                 &KerConstStatic.rotlist_const[0], 		       MAX_NUM_OF_ROTATIONS*sizeof(int));
	memcopyBufferObjectToDevice(command_queue_ga,mem_KerConstStatic_ref_coords_const, 	     &KerConstStatic.ref_coords_const[0],              MAX_NUM_OF_ATOMS*sizeof(cl_float3));
	memcopyBufferObjectToDevice(command_queue_ga,mem_KerConstStatic_rotbonds_moving_vectors_const, &KerConstStatic.rotbonds_moving_vectors_const[0], MAX_NUM_OF_ROTBONDS*sizeof(cl_float3));
	memcopyBufferObjectToDevice(command_queue_ga,mem_KerConstStatic_rotbonds_unit_vectors_const,   &KerConstStatic.rotbonds_unit_vectors_const[0],   MAX_NUM_OF_ROTBONDS*sizeof(cl_float3));
	memcopyBufferObjectToDevice(command_queue_ga,mem_KerConstStatic_ref_orientation_quats_const,   &KerConstStatic.ref_orientation_quats_const[0],   MAX_NUM_OF_RUNS*sizeof(cl_float4));
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

	memcopyBufferObjectToDevice(command_queue_ga,mem_dockpars_fgrids, 	cpu_fixedpt64grids,       size_fixedpt64grids);
#else
	memcopyBufferObjectToDevice(command_queue_ga,mem_dockpars_fgrids, 	cpu_floatgrids,       size_floatgrids);

	#if defined(SEPARATE_FGRID_INTERE)
	memcopyBufferObjectToDevice(command_queue_ga,mem_dockpars_fgrids2, 	cpu_floatgrids + mygrid->num_of_atypes     * mygrid->size_xyz[0]*mygrid->size_xyz[1]* mygrid->size_xyz[2],       size_floatgrids2);
	memcopyBufferObjectToDevice(command_queue_ga,mem_dockpars_fgrids3, 	cpu_floatgrids + (mygrid->num_of_atypes+1) * mygrid->size_xyz[0]*mygrid->size_xyz[1]* mygrid->size_xyz[2],       size_floatgrids3);
	#endif
#endif

	clock_start_docking = clock();

	// Krnl_GA
	#if defined(SINGLE_COPY_POP_ENE)
    setKernelArg(kernel_ga,0,  sizeof(mem_dockpars_conformations_current),    &mem_dockpars_conformations_current);
    setKernelArg(kernel_ga,1,  sizeof(mem_dockpars_energies_current),         &mem_dockpars_energies_current);
	setKernelArg(kernel_ga,2,  sizeof(mem_evals_performed),   		&mem_evals_performed);
	setKernelArg(kernel_ga,3,  sizeof(mem_gens_performed),    		&mem_gens_performed);
	setKernelArg(kernel_ga,4,  sizeof(unsigned int),                  	&dockpars.pop_size);
	setKernelArg(kernel_ga,5,  sizeof(unsigned int),                 		&dockpars.num_of_energy_evals);
	setKernelArg(kernel_ga,6,  sizeof(unsigned int),                 		&dockpars.num_of_generations);
	setKernelArg(kernel_ga,7,  sizeof(float),                          	&dockpars.tournament_rate);
	setKernelArg(kernel_ga,8,  sizeof(float),                          	&dockpars.mutation_rate);
	setKernelArg(kernel_ga,9,  sizeof(float),                          	&dockpars.abs_max_dmov);
	setKernelArg(kernel_ga,10, sizeof(float),                          	&dockpars.abs_max_dang);
	setKernelArg(kernel_ga,11, sizeof(float),                                 &two_absmaxdmov);
	setKernelArg(kernel_ga,12, sizeof(float),                                 &two_absmaxdang);
	setKernelArg(kernel_ga,13, sizeof(float),                          	&dockpars.crossover_rate);
	setKernelArg(kernel_ga,14, sizeof(unsigned int),                          &dockpars.num_of_lsentities);
	setKernelArg(kernel_ga,15, sizeof(unsigned char),                         &dockpars.num_of_genes);
	//setKernelArg(kernel_ga,16, sizeof(unsigned short),                      run_cnt);
	//setKernelArg(kernel_ga,17, sizeof(unsigned int),                        offset_pop);
	//setKernelArg(kernel_ga,18, sizeof(unsigned int),                        offset_ene);
	#else
    setKernelArg(kernel_ga,0,  sizeof(mem_dockpars_conformations_current),    &mem_dockpars_conformations_current);
    setKernelArg(kernel_ga,1,  sizeof(mem_dockpars_energies_current),         &mem_dockpars_energies_current);
	setKernelArg(kernel_ga,2,  sizeof(mem_evals_and_generations_performed),   &mem_evals_and_generations_performed);
	setKernelArg(kernel_ga,3,  sizeof(unsigned int),                  	&dockpars.pop_size);
	setKernelArg(kernel_ga,4,  sizeof(unsigned int),                 		&dockpars.num_of_energy_evals);
	setKernelArg(kernel_ga,5,  sizeof(unsigned int),                 		&dockpars.num_of_generations);
	setKernelArg(kernel_ga,6,  sizeof(float),                          	&dockpars.tournament_rate);
	setKernelArg(kernel_ga,7,  sizeof(float),                          	&dockpars.mutation_rate);
	setKernelArg(kernel_ga,8,  sizeof(float),                          	&dockpars.abs_max_dmov);
	setKernelArg(kernel_ga,9,  sizeof(float),                          	&dockpars.abs_max_dang);
	setKernelArg(kernel_ga,10, sizeof(float),                                 &two_absmaxdmov);
	setKernelArg(kernel_ga,11, sizeof(float),                                 &two_absmaxdang);
	setKernelArg(kernel_ga,12, sizeof(float),                          	&dockpars.crossover_rate);
	setKernelArg(kernel_ga,13, sizeof(unsigned int),                          &dockpars.num_of_lsentities);
	setKernelArg(kernel_ga,14, sizeof(unsigned char),                         &dockpars.num_of_genes);
	#endif

	// Krnl_PoseCalc
	setKernelArg(kernel_pc,0,  sizeof(mem_KerConstStatic_rotlist_const),      	   &mem_KerConstStatic_rotlist_const);
	setKernelArg(kernel_pc,1,  sizeof(mem_KerConstStatic_ref_coords_const),              &mem_KerConstStatic_ref_coords_const);
	setKernelArg(kernel_pc,2,  sizeof(mem_KerConstStatic_rotbonds_moving_vectors_const), &mem_KerConstStatic_rotbonds_moving_vectors_const);
	setKernelArg(kernel_pc,3,  sizeof(mem_KerConstStatic_rotbonds_unit_vectors_const),   &mem_KerConstStatic_rotbonds_unit_vectors_const);
	setKernelArg(kernel_pc,4,  sizeof(unsigned int),       &dockpars.rotbondlist_length);
	setKernelArg(kernel_pc,5,  sizeof(unsigned char),      &dockpars.num_of_atoms);
	setKernelArg(kernel_pc,6,  sizeof(unsigned char),      &dockpars.num_of_genes);
/*
	setKernelArg(kernel_pc,7,  sizeof(unsigned char),      &num_rotbonds);
	setKernelArg(kernel_pc,8,  sizeof(mem_KerConstStatic_ref_orientation_quats_const),   &mem_KerConstStatic_ref_orientation_quats_const);
*/
	setKernelArg(kernel_pc,7,  sizeof(mem_KerConstStatic_ref_orientation_quats_const),   &mem_KerConstStatic_ref_orientation_quats_const);
	#if defined(SINGLE_COPY_POP_ENE)

	#else
		#if defined (FIXED_POINT_CONFORM)
	// fixed-point
	setKernelArg(kernel_pc,8,  sizeof(fixedpt),            &KerConstDynamic.ref_orientation_quats_const[0]);
	setKernelArg(kernel_pc,9,  sizeof(fixedpt),            &KerConstDynamic.ref_orientation_quats_const[1]);
	setKernelArg(kernel_pc,10, sizeof(fixedpt),            &KerConstDynamic.ref_orientation_quats_const[2]);
	setKernelArg(kernel_pc,11, sizeof(fixedpt),            &KerConstDynamic.ref_orientation_quats_const[3]);
		#else
	// floating-point (original)
	setKernelArg(kernel_pc,8,  sizeof(float),              &KerConstDynamic.ref_orientation_quats_const[0]);
	setKernelArg(kernel_pc,9,  sizeof(float),              &KerConstDynamic.ref_orientation_quats_const[1]);
	setKernelArg(kernel_pc,10, sizeof(float),              &KerConstDynamic.ref_orientation_quats_const[2]);
	setKernelArg(kernel_pc,11, sizeof(float),              &KerConstDynamic.ref_orientation_quats_const[3]);
		#endif
	#endif

	unsigned char gridsizex_minus1 = dockpars.gridsize_x - 1;
	unsigned char gridsizey_minus1 = dockpars.gridsize_y - 1;
	unsigned char gridsizez_minus1 = dockpars.gridsize_z - 1;

#if defined (FIXED_POINT_INTERE)

#else
	float fgridsizex_minus1 = (float) gridsizex_minus1;
	float fgridsizey_minus1 = (float) gridsizey_minus1;
	float fgridsizez_minus1 = (float) gridsizez_minus1;

#endif


	// Krnl_InterE
    setKernelArg(kernel_ie,0,  sizeof(mem_dockpars_fgrids),                    &mem_dockpars_fgrids);
	#if defined (FIXED_POINT_INTERE)
	setKernelArg(kernel_ie,1,  sizeof(mem_KerConstStatic_fixpt64_atom_charges_const),  &mem_KerConstStatic_fixpt64_atom_charges_const);
	#else
	setKernelArg(kernel_ie,1,  sizeof(mem_KerConstStatic_atom_charges_const),  &mem_KerConstStatic_atom_charges_const);
	#endif
	setKernelArg(kernel_ie,2,  sizeof(mem_KerConstStatic_atom_types_const),    &mem_KerConstStatic_atom_types_const);
	setKernelArg(kernel_ie,3,  sizeof(unsigned char),                          &dockpars.g1);
	setKernelArg(kernel_ie,4,  sizeof(unsigned int),                           &dockpars.g2);
	setKernelArg(kernel_ie,5,  sizeof(unsigned int),                           &dockpars.g3);
	setKernelArg(kernel_ie,6,  sizeof(unsigned char),                          &dockpars.num_of_atoms);

	#if defined (FIXED_POINT_INTERE)
	setKernelArg(kernel_ie,7,  sizeof(unsigned char),                          &gridsizex_minus1);
	setKernelArg(kernel_ie,8,  sizeof(unsigned char),                          &gridsizey_minus1);
	setKernelArg(kernel_ie,9,  sizeof(unsigned char),                          &gridsizez_minus1);
	#else
	setKernelArg(kernel_ie,7,  sizeof(float),                          	 &fgridsizex_minus1);
	setKernelArg(kernel_ie,8,  sizeof(float),                          	 &fgridsizey_minus1);
	setKernelArg(kernel_ie,9,  sizeof(float),                          	 &fgridsizez_minus1);
	#endif

	#if defined(SEPARATE_FGRID_INTERE)
	setKernelArg(kernel_ie,10, sizeof(mem_dockpars_fgrids2),                   &mem_dockpars_fgrids2);
	setKernelArg(kernel_ie,11, sizeof(mem_dockpars_fgrids3),                   &mem_dockpars_fgrids3);
	#else
	setKernelArg(kernel_ie,10, sizeof(unsigned int),                           &mul_tmp2);
	setKernelArg(kernel_ie,11, sizeof(unsigned int),                           &mul_tmp3);
	#endif

	// Krnl_IntraE
	setKernelArg(kernel_ia,0,  sizeof(mem_KerConstStatic_atom_charges_const),        &mem_KerConstStatic_atom_charges_const);
	setKernelArg(kernel_ia,1,  sizeof(mem_KerConstStatic_atom_types_const),          &mem_KerConstStatic_atom_types_const);
	setKernelArg(kernel_ia,2,  sizeof(mem_KerConstStatic_intraE_contributors_const), &mem_KerConstStatic_intraE_contributors_const);

  	setKernelArg(kernel_ia,3,  sizeof(dockpars.smooth),                              &dockpars.smooth);
  	setKernelArg(kernel_ia,4,  sizeof(mem_KerConstStatic_reqm_const),                &mem_KerConstStatic_reqm_const);
  	setKernelArg(kernel_ia,5,  sizeof(mem_KerConstStatic_reqm_hbond_const),          &mem_KerConstStatic_reqm_hbond_const);
  	setKernelArg(kernel_ia,6,  sizeof(mem_KerConstStatic_atom1_types_reqm_const),    &mem_KerConstStatic_atom1_types_reqm_const);
  	setKernelArg(kernel_ia,7,  sizeof(mem_KerConstStatic_atom2_types_reqm_const),    &mem_KerConstStatic_atom2_types_reqm_const);

	setKernelArg(kernel_ia,8,  sizeof(mem_KerConstStatic_VWpars_AC_const),           &mem_KerConstStatic_VWpars_AC_const);
	setKernelArg(kernel_ia,9,  sizeof(mem_KerConstStatic_VWpars_BD_const),           &mem_KerConstStatic_VWpars_BD_const);
	setKernelArg(kernel_ia,10, sizeof(mem_KerConstStatic_dspars_S_const),            &mem_KerConstStatic_dspars_S_const);
	setKernelArg(kernel_ia,11, sizeof(mem_KerConstStatic_dspars_V_const),            &mem_KerConstStatic_dspars_V_const);

	setKernelArg(kernel_ia,12, sizeof(unsigned char),                    	       &dockpars.num_of_atoms);
	setKernelArg(kernel_ia,13, sizeof(unsigned int),                     	       &dockpars.num_of_intraE_contributors);
	setKernelArg(kernel_ia,14, sizeof(float),                          	       &dockpars.grid_spacing);
	setKernelArg(kernel_ia,15, sizeof(unsigned char),                    	       &dockpars.num_of_atypes);
	setKernelArg(kernel_ia,16, sizeof(float),                          	       &dockpars.coeff_elec);
	setKernelArg(kernel_ia,17, sizeof(float),                          	       &dockpars.qasp);
	setKernelArg(kernel_ia,18, sizeof(float),                          	       &dockpars.coeff_desolv);
/*
	setKernelArg(kernel_ia,14, sizeof(unsigned int),                     	&square_num_of_atypes);
*/

	// Krnl_PRNG_GG_float
	setKernelArg(kernel_prng_gg_float,1, sizeof(unsigned char),  &dockpars.num_of_genes);

	// Krnl_PRNG_float
	setKernelArg(kernel_prng_ls_float,1, sizeof(unsigned char),  &dockpars.num_of_genes);

	// Krnl_PRNG_uchar
	setKernelArg(kernel_prng_gg_uchar,1, sizeof(unsigned char),  &dockpars.num_of_genes);

// Kernel 11 has no args

#if defined (FIXED_POINT_LS1) || defined (FIXED_POINT_LS2) || defined (FIXED_POINT_LS3) || defined (FIXED_POINT_LS4) || defined (FIXED_POINT_LS5) || defined (FIXED_POINT_LS6) || defined (FIXED_POINT_LS7) || defined (FIXED_POINT_LS8) || defined (FIXED_POINT_LS9)
fixedpt fixpt_base_dmov_mul_sqrt3 = fixedpt_fromfloat(dockpars.base_dmov_mul_sqrt3);
fixedpt fixpt_base_dang_mul_sqrt3 = fixedpt_fromfloat(dockpars.base_dang_mul_sqrt3);
fixedpt fixpt_rho_lower_bound = fixedpt_fromfloat(dockpars.rho_lower_bound);
#endif

unsigned short Host_max_num_of_iters = (unsigned short)dockpars.max_num_of_iters;
unsigned char  Host_cons_limit       = (unsigned char) dockpars.cons_limit;

// Krnl_LS
	//setKernelArg(kernel_ls,0, sizeof(unsigned int),  &dockpars.max_num_of_iters);
	setKernelArg(kernel_ls,0, sizeof(unsigned short),  &Host_max_num_of_iters);

	#if defined (FIXED_POINT_LS1)
	setKernelArg(kernel_ls,1, sizeof(fixedpt),  	&fixpt_rho_lower_bound);
	setKernelArg(kernel_ls,2, sizeof(fixedpt),  	&fixpt_base_dmov_mul_sqrt3);
	#else
	setKernelArg(kernel_ls,1, sizeof(float),  	&dockpars.rho_lower_bound);
	setKernelArg(kernel_ls,2, sizeof(float),  	&dockpars.base_dmov_mul_sqrt3);
	#endif
	setKernelArg(kernel_ls,3, sizeof(unsigned char), &dockpars.num_of_genes);
	#if defined (FIXED_POINT_LS1)
	setKernelArg(kernel_ls,4, sizeof(fixedpt),  	&fixpt_base_dang_mul_sqrt3);
	#else
	setKernelArg(kernel_ls,4, sizeof(float),  	&dockpars.base_dang_mul_sqrt3);
	#endif

	//setKernelArg(kernel_ls,5, sizeof(unsigned int),  &dockpars.cons_limit);
	setKernelArg(kernel_ls,5, sizeof(unsigned char),   &Host_cons_limit);

	setKernelArg(kernel_prng_ls2_float,1, sizeof(unsigned char),  &dockpars.num_of_genes);

	// Krnl_LS2
	//setKernelArg(kernel_ls2,0, sizeof(unsigned int),  &dockpars.max_num_of_iters);
	setKernelArg(kernel_ls2,0, sizeof(unsigned short),  &Host_max_num_of_iters);
	#if defined (FIXED_POINT_LS2)
	setKernelArg(kernel_ls2,1, sizeof(fixedpt),  	&fixpt_rho_lower_bound);
	setKernelArg(kernel_ls2,2, sizeof(fixedpt),  	&fixpt_base_dmov_mul_sqrt3);
	#else
	setKernelArg(kernel_ls2,1, sizeof(float),  	&dockpars.rho_lower_bound);
	setKernelArg(kernel_ls2,2, sizeof(float),  	&dockpars.base_dmov_mul_sqrt3);
	#endif
	setKernelArg(kernel_ls2,3, sizeof(unsigned char), &dockpars.num_of_genes);
	#if defined (FIXED_POINT_LS2)
	setKernelArg(kernel_ls2,4, sizeof(fixedpt),  	&fixpt_base_dang_mul_sqrt3);
	#else
	setKernelArg(kernel_ls2,4, sizeof(float),  	&dockpars.base_dang_mul_sqrt3);
	#endif
	//setKernelArg(kernel_ls2,5, sizeof(unsigned int),  &dockpars.cons_limit);
	setKernelArg(kernel_ls2,5, sizeof(unsigned char),   &Host_cons_limit);

	setKernelArg(kernel_prng_ls3_float,1, sizeof(unsigned char),  &dockpars.num_of_genes);

	// Krnl_LS3
	//setKernelArg(kernel_ls3,0, sizeof(unsigned int),  &dockpars.max_num_of_iters);
	setKernelArg(kernel_ls3,0, sizeof(unsigned short),  &Host_max_num_of_iters);
	#if defined (FIXED_POINT_LS3)
	setKernelArg(kernel_ls3,1, sizeof(fixedpt),  	&fixpt_rho_lower_bound);
	setKernelArg(kernel_ls3,2, sizeof(fixedpt),  	&fixpt_base_dmov_mul_sqrt3);
	#else
	setKernelArg(kernel_ls3,1, sizeof(float),  	&dockpars.rho_lower_bound);
	setKernelArg(kernel_ls3,2, sizeof(float),  	&dockpars.base_dmov_mul_sqrt3);
	#endif
	setKernelArg(kernel_ls3,3, sizeof(unsigned char), &dockpars.num_of_genes);
	#if defined (FIXED_POINT_LS3)
	setKernelArg(kernel_ls3,4, sizeof(fixedpt),  	&fixpt_base_dang_mul_sqrt3);
	#else
	setKernelArg(kernel_ls3,4, sizeof(float),  	&dockpars.base_dang_mul_sqrt3);
	#endif

	//setKernelArg(kernel_ls3,5, sizeof(unsigned int),  &dockpars.cons_limit);
	setKernelArg(kernel_ls3,5, sizeof(unsigned char),   &Host_cons_limit);
	
/*	
	setKernelArg(kernel_igl_arb,0, sizeof(unsigned char),  &dockpars.num_of_genes);
*/

	setKernelArg(kernel_ls123_ushort,9, sizeof(unsigned int),  &dockpars.pop_size);

	setKernelArg(kernel_prng_bt_ushort_float,2, sizeof(unsigned int),  &dockpars.pop_size);

	setKernelArg(kernel_prng_ls4_float,1, sizeof(unsigned char),  &dockpars.num_of_genes);

	setKernelArg(kernel_prng_ls5_float,1, sizeof(unsigned char),  &dockpars.num_of_genes);

	setKernelArg(kernel_ls4,0, sizeof(unsigned short),  &Host_max_num_of_iters);
	#if defined (FIXED_POINT_LS4)
	setKernelArg(kernel_ls4,1, sizeof(fixedpt),  	  &fixpt_rho_lower_bound);
	setKernelArg(kernel_ls4,2, sizeof(fixedpt),  	  &fixpt_base_dmov_mul_sqrt3);
	#else
	setKernelArg(kernel_ls4,1, sizeof(float),  	  &dockpars.rho_lower_bound);
	setKernelArg(kernel_ls4,2, sizeof(float),  	  &dockpars.base_dmov_mul_sqrt3);
	#endif
	setKernelArg(kernel_ls4,3, sizeof(unsigned char),   &dockpars.num_of_genes);
	#if defined (FIXED_POINT_LS4)
	setKernelArg(kernel_ls4,4, sizeof(fixedpt),  	  &fixpt_base_dang_mul_sqrt3);
	#else
	setKernelArg(kernel_ls4,4, sizeof(float),  	  &dockpars.base_dang_mul_sqrt3);
	#endif
	setKernelArg(kernel_ls4,5, sizeof(unsigned char),   &Host_cons_limit);

	setKernelArg(kernel_ls5,0, sizeof(unsigned short),  &Host_max_num_of_iters);
	#if defined (FIXED_POINT_LS4)
	setKernelArg(kernel_ls5,1, sizeof(fixedpt),  	  &fixpt_rho_lower_bound);
	setKernelArg(kernel_ls5,2, sizeof(fixedpt),  	  &fixpt_base_dmov_mul_sqrt3);
	#else
	setKernelArg(kernel_ls5,1, sizeof(float),  	  &dockpars.rho_lower_bound);
	setKernelArg(kernel_ls5,2, sizeof(float),  	  &dockpars.base_dmov_mul_sqrt3);
	#endif
	setKernelArg(kernel_ls5,3, sizeof(unsigned char),   &dockpars.num_of_genes);
	#if defined (FIXED_POINT_LS4)
	setKernelArg(kernel_ls5,4, sizeof(fixedpt),  	  &fixpt_base_dang_mul_sqrt3);
	#else
	setKernelArg(kernel_ls5,4, sizeof(float),  	  &dockpars.base_dang_mul_sqrt3);
	#endif
	setKernelArg(kernel_ls5,5, sizeof(unsigned char),   &Host_cons_limit);

	setKernelArg(kernel_prng_ls6_float,1, sizeof(unsigned char),  &dockpars.num_of_genes);
	setKernelArg(kernel_prng_ls7_float,1, sizeof(unsigned char),  &dockpars.num_of_genes);
	setKernelArg(kernel_prng_ls8_float,1, sizeof(unsigned char),  &dockpars.num_of_genes);
	setKernelArg(kernel_prng_ls9_float,1, sizeof(unsigned char),  &dockpars.num_of_genes);

	setKernelArg(kernel_ls6,0, sizeof(unsigned short),  &Host_max_num_of_iters);
	#if defined (FIXED_POINT_LS6)
	setKernelArg(kernel_ls6,1, sizeof(fixedpt),  	  &fixpt_rho_lower_bound);
	setKernelArg(kernel_ls6,2, sizeof(fixedpt),  	  &fixpt_base_dmov_mul_sqrt3);
	#else
	setKernelArg(kernel_ls6,1, sizeof(float),  	  &dockpars.rho_lower_bound);
	setKernelArg(kernel_ls6,2, sizeof(float),  	  &dockpars.base_dmov_mul_sqrt3);
	#endif
	setKernelArg(kernel_ls6,3, sizeof(unsigned char),   &dockpars.num_of_genes);
	#if defined (FIXED_POINT_LS6)
	setKernelArg(kernel_ls6,4, sizeof(fixedpt),  	  &fixpt_base_dang_mul_sqrt3);
	#else
	setKernelArg(kernel_ls6,4, sizeof(float),  	  &dockpars.base_dang_mul_sqrt3);
	#endif
	setKernelArg(kernel_ls6,5, sizeof(unsigned char),   &Host_cons_limit);

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
	memcopyBufferObjectToDevice(command_queue_ga,mem_dockpars_conformations_current, 	cpu_init_populations, size_populations);
#endif

	printf("Docking runs to be executed: %u\n", mypars->num_of_runs); 
	printf("Execution run: \n");

	for (unsigned int run_cnt = 0; run_cnt < mypars->num_of_runs; run_cnt++)
	{
		printf(" %u", run_cnt + 1);
		if ((run_cnt + 1) % 10 == 0) { printf("\n"); } // Next line if nrun is multiple of 10
		fflush(stdout);

#if defined(SINGLE_COPY_POP_ENE)

#else
		myligand_reference = *myligand_init;
		gen_initpop_and_reflig(mypars, cpu_init_populations, cpu_ref_ori_angles, &myligand_reference, mygrid);

		if (prepare_constdynamic_fields_for_gpu(&myligand_reference, mypars, cpu_ref_ori_angles, &KerConstDynamic) == 1)
			return 1;

 		memcopyBufferObjectToDevice(command_queue_ga,mem_dockpars_conformations_current, 	cpu_init_populations, size_populations);
#endif

#if defined(SINGLE_COPY_POP_ENE)
		unsigned int Host_Offset_Pop = run_cnt * dockpars.pop_size * ACTUAL_GENOTYPE_LENGTH;
		unsigned int Host_Offset_Ene = run_cnt * dockpars.pop_size;
		setKernelArg(kernel_ga,16,  sizeof(unsigned short), &run_cnt);
		setKernelArg(kernel_ga,17,  sizeof(unsigned int),   &Host_Offset_Pop);
		setKernelArg(kernel_ga,18,  sizeof(unsigned int),   &Host_Offset_Ene);
#endif

	// Krnl_PoseCalc
	/*
	#if defined(SINGLE_COPY_POP_ENE)
		#if defined (FIXED_POINT_CONFORM)
		setKernelArg(kernel_pc,8,  sizeof(fixedpt),        &KerConstStatic.ref_orientation_quats_const[4*run_cnt]);
		setKernelArg(kernel_pc,9,  sizeof(fixedpt),        &KerConstStatic.ref_orientation_quats_const[4*run_cnt + 1]);	
		setKernelArg(kernel_pc,10, sizeof(fixedpt),        &KerConstStatic.ref_orientation_quats_const[4*run_cnt + 2]);	
		setKernelArg(kernel_pc,11, sizeof(fixedpt),        &KerConstStatic.ref_orientation_quats_const[4*run_cnt + 3]);
		#else
		setKernelArg(kernel_pc,8,  sizeof(float),          &KerConstStatic.ref_orientation_quats_const[4*run_cnt]);
		setKernelArg(kernel_pc,9,  sizeof(float),          &KerConstStatic.ref_orientation_quats_const[4*run_cnt + 1]);	
		setKernelArg(kernel_pc,10, sizeof(float),          &KerConstStatic.ref_orientation_quats_const[4*run_cnt + 2]);	
		setKernelArg(kernel_pc,11, sizeof(float),          &KerConstStatic.ref_orientation_quats_const[4*run_cnt + 3]);
		#endif
	#else
		#if defined (FIXED_POINT_CONFORM)
		setKernelArg(kernel_pc,8,  sizeof(fixedpt),        &KerConstDynamic.ref_orientation_quats_const[0]);
		setKernelArg(kernel_pc,9,  sizeof(fixedpt),        &KerConstDynamic.ref_orientation_quats_const[1]);	
		setKernelArg(kernel_pc,10, sizeof(fixedpt),        &KerConstDynamic.ref_orientation_quats_const[2]);	
		setKernelArg(kernel_pc,11, sizeof(fixedpt),        &KerConstDynamic.ref_orientation_quats_const[3]);
		#else
		setKernelArg(kernel_pc,8,  sizeof(float),          &KerConstDynamic.ref_orientation_quats_const[0]);
		setKernelArg(kernel_pc,9,  sizeof(float),          &KerConstDynamic.ref_orientation_quats_const[1]);	
		setKernelArg(kernel_pc,10, sizeof(float),          &KerConstDynamic.ref_orientation_quats_const[2]);	
		setKernelArg(kernel_pc,11, sizeof(float),          &KerConstDynamic.ref_orientation_quats_const[3]);
		#endif
	#endif
	*/
	/*
	setKernelArg(kernel_pc,9,  sizeof(unsigned short), &run_cnt);
	*/
	setKernelArg(kernel_pc,8,  sizeof(unsigned short), &run_cnt);

	setKernelArg(kernel_prng_gg_float,0, sizeof(unsigned int), &cpu_prng_seeds[num_of_prng_blocks * run_cnt]);
	setKernelArg(kernel_prng_ls_float,0, sizeof(unsigned int), &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 1]);
	setKernelArg(kernel_prng_gg_uchar,0, sizeof(unsigned int), &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 2]);

	setKernelArg(kernel_prng_ls2_float,0, sizeof(unsigned int),   &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 3]);
	setKernelArg(kernel_prng_ls3_float,0, sizeof(unsigned int),   &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 4]);

	setKernelArg(kernel_ls123_ushort,0, sizeof(unsigned int),   &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 5]);
	setKernelArg(kernel_ls123_ushort,1, sizeof(unsigned int),   &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 6]);
	setKernelArg(kernel_ls123_ushort,2, sizeof(unsigned int),   &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 7]);
	setKernelArg(kernel_ls123_ushort,3, sizeof(unsigned int),   &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 8]);
	setKernelArg(kernel_ls123_ushort,4, sizeof(unsigned int),   &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 9]);
	setKernelArg(kernel_ls123_ushort,5, sizeof(unsigned int),   &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 10]);
	setKernelArg(kernel_ls123_ushort,6, sizeof(unsigned int),   &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 11]);
	setKernelArg(kernel_ls123_ushort,7, sizeof(unsigned int),   &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 12]);
	setKernelArg(kernel_ls123_ushort,8, sizeof(unsigned int),   &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 13]);

	setKernelArg(kernel_prng_bt_ushort_float,0, sizeof(unsigned int),   &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 14]);
	setKernelArg(kernel_prng_bt_ushort_float,1, sizeof(unsigned int),   &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 15]);
	setKernelArg(kernel_prng_ls4_float,0, sizeof(unsigned int),   &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 16]);
	setKernelArg(kernel_prng_ls5_float,0, sizeof(unsigned int),   &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 17]);

	setKernelArg(kernel_prng_ls6_float,0, sizeof(unsigned int),   &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 18]);
	setKernelArg(kernel_prng_ls7_float,0, sizeof(unsigned int),   &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 19]);
	setKernelArg(kernel_prng_ls8_float,0, sizeof(unsigned int),   &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 20]);
	setKernelArg(kernel_prng_ls9_float,0, sizeof(unsigned int),   &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 21]);

		runKernelTask(command_queue_ga,kernel_ga,NULL,NULL);
		runKernelTask(command_queue_pc,kernel_pc,NULL,NULL);
		runKernelTask(command_queue_ie,kernel_ie,NULL,NULL);
		runKernelTask(command_queue_ia,kernel_ia,NULL,NULL);
		runKernelTask(command_queue_prng_gg_float,kernel_prng_gg_float,NULL,NULL);
		runKernelTask(command_queue_prng_ls_float,kernel_prng_ls_float,NULL,NULL);
		runKernelTask(command_queue_prng_gg_uchar,kernel_prng_gg_uchar,NULL,NULL);
		runKernelTask(command_queue_ls,kernel_ls,NULL,NULL);
		runKernelTask(command_queue_prng_ls2_float,kernel_prng_ls2_float,NULL,NULL);
		runKernelTask(command_queue_ls2,kernel_ls2,NULL,NULL);
		runKernelTask(command_queue_prng_ls3_float,kernel_prng_ls3_float,NULL,NULL);
		runKernelTask(command_queue_ls3,kernel_ls3,NULL,NULL);
		runKernelTask(command_queue_igl_arb,kernel_igl_arb,NULL,NULL);
		runKernelTask(command_queue_ls123_ushort,kernel_ls123_ushort,NULL,NULL);
		runKernelTask(command_queue_prng_bt_ushort_float,kernel_prng_bt_ushort_float,NULL,NULL);
		runKernelTask(command_queue_prng_ls4_float,kernel_prng_ls4_float,NULL,NULL);
		runKernelTask(command_queue_prng_ls5_float,kernel_prng_ls5_float,NULL,NULL);
		runKernelTask(command_queue_ls4,kernel_ls4,NULL,NULL);
		runKernelTask(command_queue_ls5,kernel_ls5,NULL,NULL);
		runKernelTask(command_queue_prng_ls6_float,kernel_prng_ls6_float,NULL,NULL);
		runKernelTask(command_queue_prng_ls7_float,kernel_prng_ls7_float,NULL,NULL);
		runKernelTask(command_queue_prng_ls8_float,kernel_prng_ls8_float,NULL,NULL);
		runKernelTask(command_queue_prng_ls9_float,kernel_prng_ls9_float,NULL,NULL);
		runKernelTask(command_queue_ls6,kernel_ls6,NULL,NULL);

		#ifdef ENABLE_KERNEL46
		runKernelTask(command_queue46,kernel46,NULL,NULL);
		#endif // ENABLE_KERNEL46

		#ifdef ENABLE_KERNEL47
		runKernelTask(command_queue47,kernel47,NULL,NULL);
		#endif // ENABLE_KERNEL47

		#ifdef ENABLE_KERNEL48
		runKernelTask(command_queue48,kernel48,NULL,NULL);
		#endif // ENABLE_KERNEL48


		clFinish(command_queue_ga); 
		clFinish(command_queue_pc); 
		clFinish(command_queue_ie); 
		clFinish(command_queue_ia); 
		clFinish(command_queue_prng_gg_float); 
		clFinish(command_queue_prng_ls_float);
		clFinish(command_queue_prng_gg_uchar);
		clFinish(command_queue_ls);
		clFinish(command_queue_prng_ls2_float);
		clFinish(command_queue_ls2);
		clFinish(command_queue_prng_ls3_float);
		clFinish(command_queue_ls3);
		clFinish(command_queue_igl_arb);
		clFinish(command_queue_ls123_ushort);
		clFinish(command_queue_prng_bt_ushort_float);
		clFinish(command_queue_prng_ls4_float);
		clFinish(command_queue_prng_ls5_float);
		clFinish(command_queue_ls4);
		clFinish(command_queue_ls5);
		clFinish(command_queue_prng_ls6_float);
		clFinish(command_queue_prng_ls7_float);
		clFinish(command_queue_prng_ls8_float);
		clFinish(command_queue_prng_ls9_float);
		clFinish(command_queue_ls6);

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
		memcopyBufferObjectFromDevice(command_queue_ga,array_evals_and_generations_performed,mem_evals_and_generations_performed,2*sizeof(unsigned int));
		mypars->num_of_energy_evals = array_evals_and_generations_performed [0];
		mypars->num_of_generations  = array_evals_and_generations_performed [1];
	
		memcopyBufferObjectFromDevice(command_queue_ga,cpu_final_populations,mem_dockpars_conformations_current,size_populations);

		memcopyBufferObjectFromDevice(command_queue_ga,cpu_energies,mem_dockpars_energies_current,size_energies);



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
	memcopyBufferObjectFromDevice(command_queue_ga, cpu_evals_of_runs, mem_evals_performed, size_evals_of_runs);
	memcopyBufferObjectFromDevice(command_queue_ga, cpu_gens_of_runs,  mem_gens_performed,  size_evals_of_runs);

	memcopyBufferObjectFromDevice(command_queue_ga,cpu_final_populations,mem_dockpars_conformations_current,size_populations);
	memcopyBufferObjectFromDevice(command_queue_ga,cpu_energies,mem_dockpars_energies_current,size_energies);


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
  platform = findPlatform("Intel(R) FPGA"); // use it from aoc v16.1
  if(platform == NULL) {
    printf("ERROR: Unable to find Intel(R) FPGA OpenCL platform.\n");
    return false;
  }

  // User-visible output - Platform information
  {
#ifdef PRINT_OCLINFO
	char char_buffer[STRING_BUFFER_LEN];
	printf("\n========================\n");
    printf("Querying platform for info:\n");
    printf("==========================\n");
    clGetPlatformInfo(platform, CL_PLATFORM_NAME, STRING_BUFFER_LEN, char_buffer, NULL);
    printf("%-40s = %s\n", "CL_PLATFORM_NAME", char_buffer);
    clGetPlatformInfo(platform, CL_PLATFORM_VENDOR, STRING_BUFFER_LEN, char_buffer, NULL);
    printf("%-40s = %s\n", "CL_PLATFORM_VENDOR ", char_buffer);
    clGetPlatformInfo(platform, CL_PLATFORM_VERSION, STRING_BUFFER_LEN, char_buffer, NULL);
    printf("%-40s = %s\n\n", "CL_PLATFORM_VERSION ", char_buffer);
#endif
  }

  // Query the available OpenCL devices.
  scoped_array<cl_device_id> devices;
  cl_uint num_devices;

  devices.reset(getDevices(platform, CL_DEVICE_TYPE_ALL, &num_devices));

  // We'll just use the first device.
  device = devices[0];

  // Display some device information.
#ifdef PRINT_OCLINFO
  display_device_info(device);
#endif

  // Create the context.
  context = clCreateContext(NULL, 1, &device, &oclContextCallback, NULL, &status);
  checkError(status, "Failed to create context");

  // Create the program.
  std::string binary_file = getBoardBinaryFile("Krnl_GA", device);
  printf("Using AOCX: %s\n", binary_file.c_str());
  program = createProgramFromBinary(context, binary_file.c_str(), &device, 1);

  // Build the program that was just created.
  status = clBuildProgram(program, 0, NULL, "", NULL, NULL);
  checkError(status, "Failed to build program");

  // Create the command queue and kernel

  //command_queue_ga = clCreateCommandQueue(context, device, CL_QUEUE_PROFILING_ENABLE, &status);
  command_queue_ga = clCreateCommandQueue(context, device, 0, &status);
  checkError(status, "Failed to create command queue ga");
  kernel_ga = clCreateKernel(program, name_ga, &status);
  checkError(status, "Failed to create kernel ga");

  command_queue_pc = clCreateCommandQueue(context, device, 0, &status);
  checkError(status, "Failed to create command queue pc");
  kernel_pc = clCreateKernel(program, name_pc, &status);
  checkError(status, "Failed to create kernel pc");

  command_queue_ie = clCreateCommandQueue(context, device, 0, &status);
  checkError(status, "Failed to create command queue ie");
  kernel_ie = clCreateKernel(program, name_ie, &status);
  checkError(status, "Failed to create kernel ie");

  command_queue_ia = clCreateCommandQueue(context, device, 0, &status);
  checkError(status, "Failed to create command queue ia");
  kernel_ia = clCreateKernel(program, name_ia, &status);
  checkError(status, "Failed to create kernel ia");

  command_queue_prng_gg_float = clCreateCommandQueue(context, device, 0, &status);
  checkError(status, "Failed to create command queue prng_gg_float");
  kernel_prng_gg_float = clCreateKernel(program, name_prng_gg_float, &status);
  checkError(status, "Failed to create kernel prng_gg_float");

  command_queue_prng_ls_float = clCreateCommandQueue(context, device, 0, &status);
  checkError(status, "Failed to create command queue prng_ls_float");
  kernel_prng_ls_float = clCreateKernel(program, name_prng_ls_float, &status);
  checkError(status, "Failed to create kernel prng_ls_float");

  command_queue_prng_gg_uchar = clCreateCommandQueue(context, device, 0, &status);
  checkError(status, "Failed to create command queue prng_gg_uchar");
  kernel_prng_gg_uchar = clCreateKernel(program, name_prng_gg_uchar, &status);
  checkError(status, "Failed to create kernel prng_gg_uchar");

  command_queue_ls = clCreateCommandQueue(context, device, 0, &status);
  checkError(status, "Failed to create command queue ls");
  kernel_ls = clCreateKernel(program, name_ls, &status);
  checkError(status, "Failed to create kernel ls");

  command_queue_prng_ls2_float = clCreateCommandQueue(context, device, 0, &status);
  checkError(status, "Failed to create command queue prng_ls2_float");
  kernel_prng_ls2_float = clCreateKernel(program, name_prng_ls2_float, &status);
  checkError(status, "Failed to create kernel prng_ls2_float");

  command_queue_ls2 = clCreateCommandQueue(context, device, 0, &status);
  checkError(status, "Failed to create command queue ls2");
  kernel_ls2 = clCreateKernel(program, name_ls2, &status);
  checkError(status, "Failed to create kernel ls2");

  command_queue_prng_ls3_float = clCreateCommandQueue(context, device, 0, &status);
  checkError(status, "Failed to create command queue prng_ls3_float");
  kernel_prng_ls3_float = clCreateKernel(program, name_prng_ls3_float, &status);
  checkError(status, "Failed to create kernel prng_ls3_float");

  command_queue_ls3 = clCreateCommandQueue(context, device, 0, &status);
  checkError(status, "Failed to create command queue ls3");
  kernel_ls3 = clCreateKernel(program, name_ls3, &status);
  checkError(status, "Failed to create kernel ls3");

  command_queue_igl_arb = clCreateCommandQueue(context, device, 0, &status);
  checkError(status, "Failed to create command queue igl_arb");
  kernel_igl_arb = clCreateKernel(program, name_igl_arb, &status);
  checkError(status, "Failed to create kernel igl_arb");

  command_queue_ls123_ushort = clCreateCommandQueue(context, device, 0, &status);
  checkError(status, "Failed to create command queue ls123_ushort");
  kernel_ls123_ushort = clCreateKernel(program, name_ls123_ushort, &status);
  checkError(status, "Failed to create kernel ls123_ushort");

  command_queue_prng_bt_ushort_float = clCreateCommandQueue(context, device, 0, &status);
  checkError(status, "Failed to create command queue prng_bt_ushort_float");
  kernel_prng_bt_ushort_float = clCreateKernel(program, name_prng_bt_ushort_float, &status);
  checkError(status, "Failed to create kernel prng_bt_ushort_float");

  command_queue_prng_ls4_float = clCreateCommandQueue(context, device, 0, &status);
  checkError(status, "Failed to create command queue prng_ls4_float");
  kernel_prng_ls4_float = clCreateKernel(program, name_prng_ls4_float, &status);
  checkError(status, "Failed to create kernel prng_ls4_float");

  command_queue_prng_ls5_float = clCreateCommandQueue(context, device, 0, &status);
  checkError(status, "Failed to create command queue prng_ls5_float");
  kernel_prng_ls5_float = clCreateKernel(program, name_prng_ls5_float, &status);
  checkError(status, "Failed to create kernel prng_ls5_float");

  command_queue_ls4 = clCreateCommandQueue(context, device, 0, &status);
  checkError(status, "Failed to create command queue ls4");
  kernel_ls4 = clCreateKernel(program, name_ls4, &status);
  checkError(status, "Failed to create kernel ls4");

  command_queue_ls5 = clCreateCommandQueue(context, device, 0, &status);
  checkError(status, "Failed to create command queue ls5");
  kernel_ls5 = clCreateKernel(program, name_ls5, &status);
  checkError(status, "Failed to create kernel ls5");

  command_queue_prng_ls6_float = clCreateCommandQueue(context, device, 0, &status);
  checkError(status, "Failed to create command queue prng_ls6_float");
  kernel_prng_ls6_float = clCreateKernel(program, name_prng_ls6_float, &status);
  checkError(status, "Failed to create kernel prng_ls6_float");

  command_queue_prng_ls7_float = clCreateCommandQueue(context, device, 0, &status);
  checkError(status, "Failed to create command queue prng_ls7_float");
  kernel_prng_ls7_float = clCreateKernel(program, name_prng_ls7_float, &status);
  checkError(status, "Failed to create kernel prng_ls7_float");

  command_queue_prng_ls8_float = clCreateCommandQueue(context, device, 0, &status);
  checkError(status, "Failed to create command queue prng_ls8_float");
  kernel_prng_ls8_float = clCreateKernel(program, name_prng_ls8_float, &status);
  checkError(status, "Failed to create kernel prng_ls8_float");

  command_queue_prng_ls9_float = clCreateCommandQueue(context, device, 0, &status);
  checkError(status, "Failed to create command queue prng_ls9_float");
  kernel_prng_ls9_float = clCreateKernel(program, name_prng_ls9_float, &status);
  checkError(status, "Failed to create kernel prng_ls9_float");

  command_queue_ls6 = clCreateCommandQueue(context, device, 0, &status);
  checkError(status, "Failed to create command queue ls6");
  kernel_ls6 = clCreateKernel(program, name_ls6, &status);
  checkError(status, "Failed to create kernel ls6");

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
  if(kernel_ga) {clReleaseKernel(kernel_ga);}
  if(command_queue_ga) {clReleaseCommandQueue(command_queue_ga);}

  if(kernel_pc) {clReleaseKernel(kernel_pc);}
  if(command_queue_pc) {clReleaseCommandQueue(command_queue_pc);}

  if(kernel_ie) {clReleaseKernel(kernel_ie);}
  if(command_queue_ie) {clReleaseCommandQueue(command_queue_ie);}

  if(kernel_ia) {clReleaseKernel(kernel_ia);}
  if(command_queue_ia) {clReleaseCommandQueue(command_queue_ia);}

  if(kernel_prng_gg_float) {clReleaseKernel(kernel_prng_gg_float);}
  if(command_queue_prng_gg_float) {clReleaseCommandQueue(command_queue_prng_gg_float);}

  if(kernel_prng_ls_float) {clReleaseKernel(kernel_prng_ls_float);}
  if(command_queue_prng_ls_float) {clReleaseCommandQueue(command_queue_prng_ls_float);}

  if(kernel_prng_gg_uchar) {clReleaseKernel(kernel_prng_gg_uchar);}
  if(command_queue_prng_gg_uchar) {clReleaseCommandQueue(command_queue_prng_gg_uchar);}

  if(kernel_ls) {clReleaseKernel(kernel_ls);}
  if(command_queue_ls) {clReleaseCommandQueue(command_queue_ls);}

  if(kernel_prng_ls2_float) {clReleaseKernel(kernel_prng_ls2_float);}
  if(command_queue_prng_ls2_float) {clReleaseCommandQueue(command_queue_prng_ls2_float);}

  if(kernel_ls2) {clReleaseKernel(kernel_ls2);}
  if(command_queue_ls2) {clReleaseCommandQueue(command_queue_ls2);}

  if(kernel_prng_ls3_float) {clReleaseKernel(kernel_prng_ls3_float);}
  if(command_queue_prng_ls3_float) {clReleaseCommandQueue(command_queue_prng_ls3_float);}

  if(kernel_ls3) {clReleaseKernel(kernel_ls3);}
  if(command_queue_ls3) {clReleaseCommandQueue(command_queue_ls3);}

  if(kernel_igl_arb) {clReleaseKernel(kernel_igl_arb);}
  if(command_queue_igl_arb) {clReleaseCommandQueue(command_queue_igl_arb);}

  if(kernel_ls123_ushort) {clReleaseKernel(kernel_ls123_ushort);}
  if(command_queue_ls123_ushort) {clReleaseCommandQueue(command_queue_ls123_ushort);}

  if(kernel_prng_bt_ushort_float) {clReleaseKernel(kernel_prng_bt_ushort_float);}
  if(command_queue_prng_bt_ushort_float) {clReleaseCommandQueue(command_queue_prng_bt_ushort_float);}

  if(kernel_prng_ls4_float) {clReleaseKernel(kernel_prng_ls4_float);}
  if(command_queue_prng_ls4_float) {clReleaseCommandQueue(command_queue_prng_ls4_float);}

  if(kernel_prng_ls5_float) {clReleaseKernel(kernel_prng_ls5_float);}
  if(command_queue_prng_ls5_float) {clReleaseCommandQueue(command_queue_prng_ls5_float);}

  if(kernel_ls4) {clReleaseKernel(kernel_ls4);}
  if(command_queue_ls4) {clReleaseCommandQueue(command_queue_ls4);}

  if(kernel_ls5) {clReleaseKernel(kernel_ls5);}
  if(command_queue_ls5) {clReleaseCommandQueue(command_queue_ls5);}

  if(kernel_prng_ls6_float) {clReleaseKernel(kernel_prng_ls6_float);}
  if(command_queue_prng_ls6_float) {clReleaseCommandQueue(command_queue_prng_ls6_float);}

  if(kernel_prng_ls7_float) {clReleaseKernel(kernel_prng_ls7_float);}
  if(command_queue_prng_ls7_float) {clReleaseCommandQueue(command_queue_prng_ls7_float);}

  if(kernel_prng_ls8_float) {clReleaseKernel(kernel_prng_ls8_float);}
  if(command_queue_prng_ls8_float) {clReleaseCommandQueue(command_queue_prng_ls8_float);}

  if(kernel_prng_ls9_float) {clReleaseKernel(kernel_prng_ls9_float);}
  if(command_queue_prng_ls9_float) {clReleaseCommandQueue(command_queue_prng_ls9_float);}

  if(kernel_ls6) {clReleaseKernel(kernel_ls6);}
  if(command_queue_ls6) {clReleaseCommandQueue(command_queue_ls6);}

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
  if(mem_KerConstStatic_fixpt64_atom_charges_const)	{
	clReleaseMemObject(mem_KerConstStatic_fixpt64_atom_charges_const);}
#endif
  if(mem_KerConstStatic_atom_charges_const)	{
	clReleaseMemObject(mem_KerConstStatic_atom_charges_const);}
  if(mem_KerConstStatic_atom_types_const) {
	clReleaseMemObject(mem_KerConstStatic_atom_types_const);}
  if(mem_KerConstStatic_intraE_contributors_const) {
	clReleaseMemObject(mem_KerConstStatic_intraE_contributors_const);}

  if(mem_KerConstStatic_reqm_const) {
	clReleaseMemObject(mem_KerConstStatic_reqm_const);}
  if(mem_KerConstStatic_reqm_hbond_const) {
	clReleaseMemObject(mem_KerConstStatic_reqm_hbond_const);}
  if(mem_KerConstStatic_atom1_types_reqm_const) {
	clReleaseMemObject(mem_KerConstStatic_atom1_types_reqm_const);}
  if(mem_KerConstStatic_atom2_types_reqm_const) {
	clReleaseMemObject(mem_KerConstStatic_atom2_types_reqm_const);}

  if(mem_KerConstStatic_VWpars_AC_const) {
	clReleaseMemObject(mem_KerConstStatic_VWpars_AC_const);}
  if(mem_KerConstStatic_VWpars_BD_const) {
	clReleaseMemObject(mem_KerConstStatic_VWpars_BD_const);}
  if(mem_KerConstStatic_dspars_S_const) {
	clReleaseMemObject(mem_KerConstStatic_dspars_S_const);}
  if(mem_KerConstStatic_dspars_V_const) {
	clReleaseMemObject(mem_KerConstStatic_dspars_V_const);}
  if(mem_KerConstStatic_rotlist_const) {
	clReleaseMemObject(mem_KerConstStatic_rotlist_const);}
  if(mem_KerConstStatic_ref_coords_const) {
	clReleaseMemObject(mem_KerConstStatic_ref_coords_const);}
  if(mem_KerConstStatic_rotbonds_moving_vectors_const) {
	clReleaseMemObject(mem_KerConstStatic_rotbonds_moving_vectors_const);}
  if(mem_KerConstStatic_rotbonds_unit_vectors_const) {
	clReleaseMemObject(mem_KerConstStatic_rotbonds_unit_vectors_const);}
  if(mem_KerConstStatic_ref_orientation_quats_const) {
	clReleaseMemObject(mem_KerConstStatic_ref_orientation_quats_const);}

  if(mem_dockpars_fgrids) {
	clReleaseMemObject(mem_dockpars_fgrids);}
#if defined(SEPARATE_FGRID_INTERE)
  if(mem_dockpars_fgrids2) {
	clReleaseMemObject(mem_dockpars_fgrids2);}
  if(mem_dockpars_fgrids3) {
	clReleaseMemObject(mem_dockpars_fgrids3);}
#endif

  if(mem_dockpars_conformations_current) {
	clReleaseMemObject(mem_dockpars_conformations_current);}
  if(mem_dockpars_energies_current) {
	clReleaseMemObject(mem_dockpars_energies_current);}

/*
  if(mem_dockpars_prng_states)            {clReleaseMemObject(mem_dockpars_prng_states);}
*/
#if defined(SINGLE_COPY_POP_ENE)
  if(mem_evals_performed) {
	clReleaseMemObject(mem_evals_performed);}
  if(mem_gens_performed) {
	clReleaseMemObject(mem_gens_performed);}
#else
  if(mem_evals_and_generations_performed) {
	clReleaseMemObject(mem_evals_and_generations_performed);}
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

   printf("\n========================\n");
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
