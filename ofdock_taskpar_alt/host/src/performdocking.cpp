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





#ifdef ENABLE_KERNEL8
static cl_command_queue command_queue8 = NULL;
static cl_kernel kernel8  = NULL;
static const char *name_k8 = "Krnl_Prng_BT_ushort";
#endif


#ifdef ENABLE_KERNEL5
static cl_command_queue command_queue5 = NULL;
static cl_kernel kernel5  = NULL;
static const char *name_k5 = "Krnl_Prng_BT_float";
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

#ifdef ENABLE_KERNEL9
static cl_command_queue command_queue9 = NULL;
static cl_kernel kernel9  = NULL;
static const char *name_k9 = "Krnl_Prng_LS_ushort";
#endif

#ifdef ENABLE_KERNEL7
static cl_command_queue command_queue7 = NULL;
static cl_kernel kernel7  = NULL;
static const char *name_k7 = "Krnl_Prng_LS_float";
#endif

#ifdef ENABLE_KERNEL11
static cl_command_queue command_queue11 = NULL;
static cl_kernel kernel11  = NULL;
static const char *name_k11 = "Krnl_Prng_Arbiter";
#endif

#ifdef ENABLE_KERNEL12
static cl_command_queue command_queue12 = NULL;
static cl_kernel kernel12  = NULL;
static const char *name_k12 = "Krnl_LS";
#endif

#ifdef ENABLE_KERNEL13
static cl_command_queue command_queue13 = NULL;
static cl_kernel kernel13  = NULL;
static const char *name_k13 = "Krnl_LS_Arbiter";
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

#ifdef ENABLE_KERNEL16
static cl_command_queue command_queue16 = NULL;
static cl_kernel kernel16  = NULL;
static const char *name_k16 = "Krnl_LS2_Arbiter";
#endif

#ifdef ENABLE_KERNEL17
static cl_command_queue command_queue17 = NULL;
static cl_kernel kernel17  = NULL;
static const char *name_k17 = "Krnl_Conform2";
#endif

#ifdef ENABLE_KERNEL18
static cl_command_queue command_queue18 = NULL;
static cl_kernel kernel18  = NULL;
static const char *name_k18 = "Krnl_InterE2";
#endif

#ifdef ENABLE_KERNEL19
static cl_command_queue command_queue19 = NULL;
static cl_kernel kernel19  = NULL;
static const char *name_k19 = "Krnl_IntraE2";
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

#ifdef ENABLE_KERNEL22
static cl_command_queue command_queue22 = NULL;
static cl_kernel kernel22  = NULL;
static const char *name_k22 = "Krnl_LS3_Arbiter";
#endif

#ifdef ENABLE_KERNEL23
static cl_command_queue command_queue23 = NULL;
static cl_kernel kernel23  = NULL;
static const char *name_k23 = "Krnl_Conf_Arbiter";
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
kernelconstant_dynamic KerConstDynamic;

//// --------------------------------
//// Host memory buffers
//// --------------------------------
float* cpu_init_populations;
float* cpu_final_populations;
float* cpu_energies;
Ligandresult* cpu_result_ligands;
unsigned int* cpu_prng_seeds;
float* cpu_ref_ori_angles;

//// --------------------------------
//// Device memory buffers
//// --------------------------------
// Altera Issue
// Constant data holding struct data
// Created because structs containing array
// are not supported as OpenCL kernel args

/*cl_mem mem_KerConstStatic;*/
cl_mem mem_KerConstStatic_atom_charges_const;
cl_mem mem_KerConstStatic_atom_types_const;
cl_mem mem_KerConstStatic_intraE_contributors_const;
cl_mem mem_KerConstStatic_VWpars_AC_const;
cl_mem mem_KerConstStatic_VWpars_BD_const;
cl_mem mem_KerConstStatic_dspars_S_const;
cl_mem mem_KerConstStatic_dspars_V_const;
cl_mem mem_KerConstStatic_rotlist_const;

/*cl_mem mem_KerConstDynamic;*/
/*
cl_mem mem_KerConstDynamic_ref_coords_x_const;
cl_mem mem_KerConstDynamic_ref_coords_y_const;
cl_mem mem_KerConstDynamic_ref_coords_z_const;
*/
cl_mem mem_KerConstDynamic_ref_coords_const;
cl_mem mem_KerConstDynamic_rotbonds_moving_vectors_const;
cl_mem mem_KerConstDynamic_rotbonds_unit_vectors_const;
	
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
cl_mem mem_dockpars_conformations_current;
cl_mem mem_dockpars_energies_current;
/*
cl_mem mem_dockpars_prng_states;
*/
cl_mem mem_evals_and_generations_performed;

















































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
	size_t size_floatgrids;
	size_t size_populations;
	size_t size_energies;
	size_t size_prng_seeds;

	clock_t clock_start_docking;
	clock_t	clock_stop_docking;
	clock_t clock_stop_program_before_clustering;

	//allocating CPU memory for initial populations
	//size_populations = mypars->pop_size * GENOTYPE_LENGTH_IN_GLOBMEM * sizeof(float);
	size_populations = mypars->pop_size * ACTUAL_GENOTYPE_LENGTH * sizeof(float);
        cpu_init_populations = (float*) alignedMalloc(size_populations);
	memset(cpu_init_populations, 0, size_populations);

	//allocating CPU memory for results
	size_energies = mypars->pop_size * sizeof(float);
	cpu_energies = (float*) alignedMalloc(size_energies);		
	cpu_result_ligands = (Ligandresult*) alignedMalloc(sizeof(Ligandresult)*(mypars->num_of_runs));	
	cpu_final_populations = (float*) alignedMalloc(size_populations);

	//allocating memory in CPU for reference orientation angles
	cpu_ref_ori_angles = (float*) alignedMalloc(3*sizeof(float));

	//generating initial populations and random orientation angles of reference ligand
	//(ligand will be moved to origo and scaled as well)
	myligand_reference = *myligand_init;
	gen_initpop_and_reflig(mypars, cpu_init_populations, cpu_ref_ori_angles, &myligand_reference, mygrid);

	//allocating memory in CPU for pseudorandom number generator seeds and
	//generating them (seed for each thread during GA)
/*
	size_prng_seeds = sizeof(unsigned int);
*/

	size_prng_seeds = 8*sizeof(unsigned int);
	cpu_prng_seeds = (unsigned int*) alignedMalloc(size_prng_seeds);

	genseed(time(NULL));	//initializing seed generator

/*
#if defined (REPRO)
	cpu_prng_seeds[0] = 1u;
#else
	cpu_prng_seeds[0] = genseed(0u);	
#endif
*/
	//srand(time(NULL));

	//preparing the constant data fields for the GPU
	// ----------------------------------------------------------------------
	// The original function does CUDA calls initializing const Kernel data.
	// We create a struct to hold those constants
	// and return them <here> (<here> = where prepare_const_fields_for_gpu() is called),
	// so we can send them to Kernels from <here>, instead of from calcenergy.cpp as originally.
	// ----------------------------------------------------------------------
	//if (prepare_conststatic_fields_for_gpu(&myligand_reference, mypars, cpu_ref_ori_angles, &KerConstStatic) == 1)
	if (prepare_conststatic_fields_for_gpu(&myligand_reference, mypars, &KerConstStatic) == 1)
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






 	//allocating GPU memory for populations, floatgrids,
	//energies, evaluation counters and random number generator states
	size_floatgrids = (sizeof(float)) * (mygrid->num_of_atypes+2) * (mygrid->size_xyz[0]) * (mygrid->size_xyz[1]) * (mygrid->size_xyz[2]);

/*	mallocBufferObject(context,CL_MEM_READ_ONLY, sizeof(KerConstStatic), 	&mem_KerConstStatic);*/
	mallocBufferObject(context,CL_MEM_READ_ONLY, MAX_NUM_OF_ATOMS*sizeof(float),                    &mem_KerConstStatic_atom_charges_const);
	mallocBufferObject(context,CL_MEM_READ_ONLY, MAX_NUM_OF_ATOMS*sizeof(char),                     &mem_KerConstStatic_atom_types_const);
	mallocBufferObject(context,CL_MEM_READ_ONLY, 3*MAX_INTRAE_CONTRIBUTORS*sizeof(char),            &mem_KerConstStatic_intraE_contributors_const);
	mallocBufferObject(context,CL_MEM_READ_ONLY, MAX_NUM_OF_ATYPES*MAX_NUM_OF_ATYPES*sizeof(float), &mem_KerConstStatic_VWpars_AC_const);
	mallocBufferObject(context,CL_MEM_READ_ONLY, MAX_NUM_OF_ATYPES*MAX_NUM_OF_ATYPES*sizeof(float), &mem_KerConstStatic_VWpars_BD_const);
	mallocBufferObject(context,CL_MEM_READ_ONLY, MAX_NUM_OF_ATYPES*sizeof(float), 			&mem_KerConstStatic_dspars_S_const);
	mallocBufferObject(context,CL_MEM_READ_ONLY, MAX_NUM_OF_ATYPES*sizeof(float), 			&mem_KerConstStatic_dspars_V_const);
	mallocBufferObject(context,CL_MEM_READ_ONLY, MAX_NUM_OF_ROTATIONS*sizeof(int), 			&mem_KerConstStatic_rotlist_const);

/*	mallocBufferObject(context,CL_MEM_READ_ONLY, sizeof(KerConstDynamic), 	&mem_KerConstDynamic);*/
	/*
	mallocBufferObject(context,CL_MEM_READ_ONLY, MAX_NUM_OF_ATOMS*sizeof(float), 		&mem_KerConstDynamic_ref_coords_x_const);
	mallocBufferObject(context,CL_MEM_READ_ONLY, MAX_NUM_OF_ATOMS*sizeof(float), 		&mem_KerConstDynamic_ref_coords_y_const);
	mallocBufferObject(context,CL_MEM_READ_ONLY, MAX_NUM_OF_ATOMS*sizeof(float), 		&mem_KerConstDynamic_ref_coords_z_const);
	*/
	mallocBufferObject(context,CL_MEM_READ_ONLY, MAX_NUM_OF_ATOMS*sizeof(cl_float3), 		&mem_KerConstDynamic_ref_coords_const);

	/*
	mallocBufferObject(context,CL_MEM_READ_ONLY, 3*MAX_NUM_OF_ROTBONDS*sizeof(float), 	&mem_KerConstDynamic_rotbonds_moving_vectors_const);
	mallocBufferObject(context,CL_MEM_READ_ONLY, 3*MAX_NUM_OF_ROTBONDS*sizeof(float), 	&mem_KerConstDynamic_rotbonds_unit_vectors_const);
	*/
	mallocBufferObject(context,CL_MEM_READ_ONLY, MAX_NUM_OF_ROTBONDS*sizeof(cl_float3), 	&mem_KerConstDynamic_rotbonds_moving_vectors_const);
	mallocBufferObject(context,CL_MEM_READ_ONLY, MAX_NUM_OF_ROTBONDS*sizeof(cl_float3), 	&mem_KerConstDynamic_rotbonds_unit_vectors_const);

	mallocBufferObject(context,CL_MEM_READ_ONLY,size_floatgrids,   		&mem_dockpars_fgrids);
	mallocBufferObject(context,CL_MEM_READ_WRITE,size_populations,  	&mem_dockpars_conformations_current);
	mallocBufferObject(context,CL_MEM_READ_WRITE,size_energies,    		&mem_dockpars_energies_current);
/*
	mallocBufferObject(context,CL_MEM_READ_ONLY,size_prng_seeds,  		&mem_dockpars_prng_states);
*/
	mallocBufferObject(context,CL_MEM_WRITE_ONLY,2*sizeof(unsigned int),  	&mem_evals_and_generations_performed);

	unsigned int array_evals_and_generations_performed [2]; // [0]: evals, [1]: generations 

/*	memcopyBufferObjectToDevice(command_queue1,mem_KerConstStatic, 	   	&KerConstStatic,      sizeof(KerConstStatic));*/
	memcopyBufferObjectToDevice(command_queue1,mem_KerConstStatic_atom_charges_const,        &KerConstStatic.atom_charges_const[0],       MAX_NUM_OF_ATOMS*sizeof(float));
	memcopyBufferObjectToDevice(command_queue1,mem_KerConstStatic_atom_types_const,          &KerConstStatic.atom_types_const[0],         MAX_NUM_OF_ATOMS*sizeof(char));
	memcopyBufferObjectToDevice(command_queue1,mem_KerConstStatic_intraE_contributors_const, &KerConstStatic.intraE_contributors_const[0],3*MAX_INTRAE_CONTRIBUTORS*sizeof(char));
	memcopyBufferObjectToDevice(command_queue1,mem_KerConstStatic_VWpars_AC_const,           &KerConstStatic.VWpars_AC_const[0],          MAX_NUM_OF_ATYPES*MAX_NUM_OF_ATYPES*sizeof(float));
	memcopyBufferObjectToDevice(command_queue1,mem_KerConstStatic_VWpars_BD_const,           &KerConstStatic.VWpars_BD_const[0],          MAX_NUM_OF_ATYPES*MAX_NUM_OF_ATYPES*sizeof(float));
	memcopyBufferObjectToDevice(command_queue1,mem_KerConstStatic_dspars_S_const,            &KerConstStatic.dspars_S_const[0], 	  MAX_NUM_OF_ATYPES*sizeof(float));
	memcopyBufferObjectToDevice(command_queue1,mem_KerConstStatic_dspars_V_const,            &KerConstStatic.dspars_V_const[0], 	  MAX_NUM_OF_ATYPES*sizeof(float));
	memcopyBufferObjectToDevice(command_queue1,mem_KerConstStatic_rotlist_const,             &KerConstStatic.rotlist_const[0], 		  MAX_NUM_OF_ROTATIONS*sizeof(int));

	memcopyBufferObjectToDevice(command_queue1,mem_dockpars_fgrids, 	cpu_floatgrids,       size_floatgrids);

	clock_start_docking = clock();

#ifdef ENABLE_KERNEL1 // Krnl_GA
        setKernelArg(kernel1,0, sizeof(mem_dockpars_conformations_current),     &mem_dockpars_conformations_current);
        setKernelArg(kernel1,1, sizeof(mem_dockpars_energies_current),          &mem_dockpars_energies_current);
	setKernelArg(kernel1,2, sizeof(mem_evals_and_generations_performed),    &mem_evals_and_generations_performed);
	// private args added in the order in which their values are used in kernel
	setKernelArg(kernel1,3,  sizeof(unsigned int),                  	&dockpars.pop_size);
	setKernelArg(kernel1,4,  sizeof(unsigned int),                 		&dockpars.num_of_energy_evals);
	setKernelArg(kernel1,5,  sizeof(unsigned int),                 		&dockpars.num_of_generations);
	setKernelArg(kernel1,6,  sizeof(float),                          	&dockpars.tournament_rate);
	setKernelArg(kernel1,7,  sizeof(float),                          	&dockpars.mutation_rate);
	setKernelArg(kernel1,8, sizeof(float),                          	&dockpars.abs_max_dmov);
	setKernelArg(kernel1,9, sizeof(float),                          	&dockpars.abs_max_dang);
	setKernelArg(kernel1,10, sizeof(float),                          	&dockpars.crossover_rate);
	setKernelArg(kernel1,11, sizeof(unsigned int),                          &dockpars.num_of_lsentities);
	//setKernelArg(kernel1,12, sizeof(unsigned int),                          &dockpars.max_num_of_iters);
	//setKernelArg(kernel1,13, sizeof(float),                          	&dockpars.rho_lower_bound);
	//setKernelArg(kernel1,14, sizeof(float),                          	&dockpars.base_dmov_mul_sqrt3);
	//setKernelArg(kernel1,15, sizeof(unsigned int),                          &dockpars.num_of_genes);
	setKernelArg(kernel1,12, sizeof(unsigned int),                          &dockpars.num_of_genes);
	//setKernelArg(kernel1,16, sizeof(float),                          	&dockpars.base_dang_mul_sqrt3);
	//setKernelArg(kernel1,17, sizeof(unsigned int),                          &dockpars.cons_limit);
#endif // End of ENABLE_KERNEL1

#ifdef ENABLE_KERNEL2 // Krnl_Conform
	setKernelArg(kernel2,0, sizeof(mem_KerConstStatic_rotlist_const),      	&mem_KerConstStatic_rotlist_const);
	setKernelArg(kernel2,1,  sizeof(mem_KerConstDynamic_ref_coords_const), &mem_KerConstDynamic_ref_coords_const);
	setKernelArg(kernel2,2,  sizeof(mem_KerConstDynamic_rotbonds_moving_vectors_const), &mem_KerConstDynamic_rotbonds_moving_vectors_const);
	setKernelArg(kernel2,3,  sizeof(mem_KerConstDynamic_rotbonds_unit_vectors_const),  &mem_KerConstDynamic_rotbonds_unit_vectors_const);

	// private args added in the order in which their values are used in kernel
	setKernelArg(kernel2,4,  sizeof(unsigned int),        &dockpars.rotbondlist_length);
	setKernelArg(kernel2,5,  sizeof(unsigned char),       &dockpars.num_of_atoms);
	setKernelArg(kernel2,6,  sizeof(unsigned int),        &dockpars.num_of_genes);

	setKernelArg(kernel2,7,  sizeof(float),              &KerConstDynamic.ref_orientation_quats_const[0]);
	setKernelArg(kernel2,8,  sizeof(float),              &KerConstDynamic.ref_orientation_quats_const[1]);
	setKernelArg(kernel2,9,  sizeof(float),              &KerConstDynamic.ref_orientation_quats_const[2]);
	setKernelArg(kernel2,10, sizeof(float),              &KerConstDynamic.ref_orientation_quats_const[3]);

#endif // End of ENABLE_KERNEL2


	unsigned char gridsizex_minus1 = dockpars.gridsize_x - 1;
	unsigned char gridsizey_minus1 = dockpars.gridsize_y - 1;
	unsigned char gridsizez_minus1 = dockpars.gridsize_z - 1;


#ifdef ENABLE_KERNEL3 // Krnl_InterE
        setKernelArg(kernel3,0, sizeof(mem_dockpars_fgrids),                    &mem_dockpars_fgrids);
	setKernelArg(kernel3,1, sizeof(mem_KerConstStatic_atom_charges_const),  &mem_KerConstStatic_atom_charges_const);
	setKernelArg(kernel3,2, sizeof(mem_KerConstStatic_atom_types_const),    &mem_KerConstStatic_atom_types_const);

	// private args added in the order in which their values are used in kernel
	setKernelArg(kernel3,3, sizeof(unsigned char),                          &dockpars.g1);
	setKernelArg(kernel3,4, sizeof(unsigned int),                          	&dockpars.g2);
	setKernelArg(kernel3,5, sizeof(unsigned int),                          	&dockpars.g3);
	setKernelArg(kernel3,6, sizeof(unsigned char),                          &dockpars.num_of_atoms);
	setKernelArg(kernel3,7, sizeof(unsigned char),                          &gridsizex_minus1);
	setKernelArg(kernel3,8, sizeof(unsigned char),                          &gridsizey_minus1);
	setKernelArg(kernel3,9, sizeof(unsigned char),                          &gridsizez_minus1);
	setKernelArg(kernel3,10, sizeof(unsigned char),                         &dockpars.num_of_atypes);
#endif // End of ENABLE_KERNEL3

#ifdef ENABLE_KERNEL4 // Krnl_IntraE
	setKernelArg(kernel4,0, sizeof(mem_KerConstStatic_atom_charges_const),        &mem_KerConstStatic_atom_charges_const);
	setKernelArg(kernel4,1, sizeof(mem_KerConstStatic_atom_types_const),          &mem_KerConstStatic_atom_types_const);
	setKernelArg(kernel4,2, sizeof(mem_KerConstStatic_intraE_contributors_const), &mem_KerConstStatic_intraE_contributors_const);
	setKernelArg(kernel4,3, sizeof(mem_KerConstStatic_VWpars_AC_const),    	      &mem_KerConstStatic_VWpars_AC_const);
	setKernelArg(kernel4,4, sizeof(mem_KerConstStatic_VWpars_BD_const),    	      &mem_KerConstStatic_VWpars_BD_const);
	setKernelArg(kernel4,5, sizeof(mem_KerConstStatic_dspars_S_const),     	      &mem_KerConstStatic_dspars_S_const);
	setKernelArg(kernel4,6, sizeof(mem_KerConstStatic_dspars_V_const),     	      &mem_KerConstStatic_dspars_V_const);

	// private args added in the order in which their values are used in kernel
	setKernelArg(kernel4,7,  sizeof(unsigned char),                         &dockpars.num_of_atoms);
	setKernelArg(kernel4,8,  sizeof(unsigned int),                          &dockpars.num_of_intraE_contributors);
	setKernelArg(kernel4,9,  sizeof(float),                          	&dockpars.grid_spacing);
	setKernelArg(kernel4,10, sizeof(unsigned char),                         &dockpars.num_of_atypes);
	setKernelArg(kernel4,11, sizeof(float),                          	&dockpars.coeff_elec);
	setKernelArg(kernel4,12, sizeof(float),                          	&dockpars.qasp);
	setKernelArg(kernel4,13, sizeof(float),                          	&dockpars.coeff_desolv);
#endif // End of ENABLE_KERNEL4

#ifdef ENABLE_KERNEL6 // Krnl_PRNG_GG_float
	setKernelArg(kernel6,1, sizeof(unsigned int),  &dockpars.num_of_genes);
#endif // End of ENABLE_KERNEL6


#ifdef ENABLE_KERNEL7 // Krnl_PRNG_float
	//setKernelArg(kernel7,1, sizeof(unsigned int),  &dockpars.num_of_genes);
#endif // End of ENABLE_KERNEL7

#ifdef ENABLE_KERNEL8 // Krnl_PRNG_ushort
	setKernelArg(kernel8,1, sizeof(unsigned int),  &dockpars.pop_size);
#endif // End of ENABLE_KERNEL8

#ifdef ENABLE_KERNEL9 // Krnl_PRNG_LS_ushort
	setKernelArg(kernel9,1, sizeof(unsigned int),  &dockpars.pop_size);
	setKernelArg(kernel9,2, sizeof(unsigned int),  &dockpars.num_of_lsentities);
#endif // End of ENABLE_KERNEL9

#ifdef ENABLE_KERNEL10 // Krnl_PRNG_uchar
	setKernelArg(kernel10,1, sizeof(unsigned int),  &dockpars.num_of_genes);
#endif // End of ENABLE_KERNEL10

// Kernel 11 has no args

#ifdef ENABLE_KERNEL12 // Krnl_LS
	setKernelArg(kernel12,0, sizeof(unsigned int),  &dockpars.max_num_of_iters);
	setKernelArg(kernel12,1, sizeof(float),  	&dockpars.rho_lower_bound);
	setKernelArg(kernel12,2, sizeof(float),  	&dockpars.base_dmov_mul_sqrt3);
	setKernelArg(kernel12,3, sizeof(unsigned int),  &dockpars.num_of_genes);
	setKernelArg(kernel12,4, sizeof(float),  	&dockpars.base_dang_mul_sqrt3);
	setKernelArg(kernel12,5, sizeof(unsigned int),  &dockpars.cons_limit);
#endif // End of ENABLE_KERNEL12

#ifdef ENABLE_KERNEL13 // Krnl_LS_Arbiter
	setKernelArg(kernel13,0, sizeof(unsigned int),  &dockpars.num_of_genes);
#endif // End of ENABLE_KERNEL12

#ifdef ENABLE_KERNEL15 // Krnl_LS2
	setKernelArg(kernel15,0, sizeof(unsigned int),  &dockpars.max_num_of_iters);
	setKernelArg(kernel15,1, sizeof(float),  	&dockpars.rho_lower_bound);
	setKernelArg(kernel15,2, sizeof(float),  	&dockpars.base_dmov_mul_sqrt3);
	setKernelArg(kernel15,3, sizeof(unsigned int),  &dockpars.num_of_genes);
	setKernelArg(kernel15,4, sizeof(float),  	&dockpars.base_dang_mul_sqrt3);
	setKernelArg(kernel15,5, sizeof(unsigned int),  &dockpars.cons_limit);
#endif // End of ENABLE_KERNEL15

#ifdef ENABLE_KERNEL16 // Krnl_LS2_Arbiter
	setKernelArg(kernel16,0, sizeof(unsigned int),  &dockpars.num_of_genes);
#endif // End of ENABLE_KERNEL12

#ifdef ENABLE_KERNEL17 // Krnl_Conform2
	setKernelArg(kernel17,0,  sizeof(mem_KerConstStatic_rotlist_const),     &mem_KerConstStatic_rotlist_const);
	setKernelArg(kernel17,1,  sizeof(mem_KerConstDynamic_ref_coords_const), &mem_KerConstDynamic_ref_coords_const);
	setKernelArg(kernel17,2,  sizeof(mem_KerConstDynamic_rotbonds_moving_vectors_const), &mem_KerConstDynamic_rotbonds_moving_vectors_const);
	setKernelArg(kernel17,3,  sizeof(mem_KerConstDynamic_rotbonds_unit_vectors_const),  &mem_KerConstDynamic_rotbonds_unit_vectors_const);

	// private args added in the order in which their values are used in kernel
	setKernelArg(kernel17,4,  sizeof(unsigned int),        &dockpars.rotbondlist_length);
	setKernelArg(kernel17,5,  sizeof(unsigned char),       &dockpars.num_of_atoms);
	setKernelArg(kernel17,6,  sizeof(unsigned int),        &dockpars.num_of_genes);

	setKernelArg(kernel17,7,  sizeof(float),              &KerConstDynamic.ref_orientation_quats_const[0]);
	setKernelArg(kernel17,8,  sizeof(float),              &KerConstDynamic.ref_orientation_quats_const[1]);
	setKernelArg(kernel17,9,  sizeof(float),              &KerConstDynamic.ref_orientation_quats_const[2]);
	setKernelArg(kernel17,10, sizeof(float),              &KerConstDynamic.ref_orientation_quats_const[3]);

#endif // End of ENABLE_KERNEL2


#ifdef ENABLE_KERNEL18 // Krnl_InterE2
        setKernelArg(kernel18,0, sizeof(mem_dockpars_fgrids),                    &mem_dockpars_fgrids);
	setKernelArg(kernel18,1, sizeof(mem_KerConstStatic_atom_charges_const),  &mem_KerConstStatic_atom_charges_const);
	setKernelArg(kernel18,2, sizeof(mem_KerConstStatic_atom_types_const),    &mem_KerConstStatic_atom_types_const);

	// private args added in the order in which their values are used in kernel
	setKernelArg(kernel18,3, sizeof(unsigned char),                          &dockpars.g1);
	setKernelArg(kernel18,4, sizeof(unsigned int),                           &dockpars.g2);
	setKernelArg(kernel18,5, sizeof(unsigned int),                           &dockpars.g3);
	setKernelArg(kernel18,6, sizeof(unsigned char),                          &dockpars.num_of_atoms);
	setKernelArg(kernel18,7, sizeof(unsigned char),                          &gridsizex_minus1);
	setKernelArg(kernel18,8, sizeof(unsigned char),                          &gridsizey_minus1);
	setKernelArg(kernel18,9, sizeof(unsigned char),                          &gridsizez_minus1);
	setKernelArg(kernel18,10, sizeof(unsigned char),                         &dockpars.num_of_atypes);
#endif // End of ENABLE_KERNEL18

#ifdef ENABLE_KERNEL19 // Krnl_IntraE2
	setKernelArg(kernel19,0, sizeof(mem_KerConstStatic_atom_charges_const),        &mem_KerConstStatic_atom_charges_const);
	setKernelArg(kernel19,1, sizeof(mem_KerConstStatic_atom_types_const),          &mem_KerConstStatic_atom_types_const);
	setKernelArg(kernel19,2, sizeof(mem_KerConstStatic_intraE_contributors_const), &mem_KerConstStatic_intraE_contributors_const);
	setKernelArg(kernel19,3, sizeof(mem_KerConstStatic_VWpars_AC_const),          &mem_KerConstStatic_VWpars_AC_const);
	setKernelArg(kernel19,4, sizeof(mem_KerConstStatic_VWpars_BD_const),          &mem_KerConstStatic_VWpars_BD_const);
	setKernelArg(kernel19,5, sizeof(mem_KerConstStatic_dspars_S_const),           &mem_KerConstStatic_dspars_S_const);
	setKernelArg(kernel19,6, sizeof(mem_KerConstStatic_dspars_V_const),           &mem_KerConstStatic_dspars_V_const);

	// private args added in the order in which their values are used in kernel
	setKernelArg(kernel19,7,  sizeof(unsigned char),                         &dockpars.num_of_atoms);
	setKernelArg(kernel19,8,  sizeof(unsigned int),                          &dockpars.num_of_intraE_contributors);
	setKernelArg(kernel19,9,  sizeof(float),                          	&dockpars.grid_spacing);
	setKernelArg(kernel19,10, sizeof(unsigned char),                         &dockpars.num_of_atypes);
	setKernelArg(kernel19,11, sizeof(float),                          	&dockpars.coeff_elec);
	setKernelArg(kernel19,12, sizeof(float),                          	&dockpars.qasp);
	setKernelArg(kernel19,13, sizeof(float),                          	&dockpars.coeff_desolv);
#endif // End of ENABLE_KERNEL19

#ifdef ENABLE_KERNEL21 // Krnl_LS3
	setKernelArg(kernel21,0, sizeof(unsigned int),  &dockpars.max_num_of_iters);
	setKernelArg(kernel21,1, sizeof(float),  	&dockpars.rho_lower_bound);
	setKernelArg(kernel21,2, sizeof(float),  	&dockpars.base_dmov_mul_sqrt3);
	setKernelArg(kernel21,3, sizeof(unsigned int),  &dockpars.num_of_genes);
	setKernelArg(kernel21,4, sizeof(float),  	&dockpars.base_dang_mul_sqrt3);
	setKernelArg(kernel21,5, sizeof(unsigned int),  &dockpars.cons_limit);
#endif // End of ENABLE_KERNEL21

#ifdef ENABLE_KERNEL22 // Krnl_LS3_Arbiter
	setKernelArg(kernel22,0, sizeof(unsigned int),  &dockpars.num_of_genes);
#endif // End of ENABLE_KERNEL22

#ifdef ENABLE_KERNEL23 // Krnl_Conf_Arbiter
	setKernelArg(kernel23,0, sizeof(unsigned int),  &dockpars.num_of_genes);
#endif // End of ENABLE_KERNEL23

	for (unsigned int run_cnt = 0; run_cnt < mypars->num_of_runs; run_cnt++)
	{

		printf("Run %u started ...     \n", run_cnt+1); fflush(stdout);



		myligand_reference = *myligand_init;
		gen_initpop_and_reflig(mypars, cpu_init_populations, cpu_ref_ori_angles, &myligand_reference, mygrid);

		if (prepare_constdynamic_fields_for_gpu(&myligand_reference, mypars, cpu_ref_ori_angles, &KerConstDynamic) == 1)
			return 1;

		#if defined (REPRO)
			cpu_prng_seeds[0] = 1u;
		#else

			cpu_prng_seeds[0] = genseed(0u);
			cpu_prng_seeds[1] = genseed(0u);
			cpu_prng_seeds[2] = genseed(0u);
			cpu_prng_seeds[3] = genseed(0u);
			cpu_prng_seeds[4] = genseed(0u);
			cpu_prng_seeds[5] = genseed(0u);
			cpu_prng_seeds[6] = genseed(0u);
			cpu_prng_seeds[7] = genseed(0u);
		#endif


		memcopyBufferObjectToDevice(command_queue1,mem_KerConstDynamic_ref_coords_const, 	      	&KerConstDynamic.ref_coords_const[0],            MAX_NUM_OF_ATOMS*sizeof(cl_float3));


		memcopyBufferObjectToDevice(command_queue1,mem_KerConstDynamic_rotbonds_moving_vectors_const, &KerConstDynamic.rotbonds_moving_vectors_const[0], MAX_NUM_OF_ROTBONDS*sizeof(cl_float3));
		memcopyBufferObjectToDevice(command_queue1,mem_KerConstDynamic_rotbonds_unit_vectors_const,   &KerConstDynamic.rotbonds_unit_vectors_const[0],   MAX_NUM_OF_ROTBONDS*sizeof(cl_float3));

 		memcopyBufferObjectToDevice(command_queue1,mem_dockpars_conformations_current, 	cpu_init_populations, size_populations);

#ifdef ENABLE_KERNEL2 // Krnl_Conform
		setKernelArg(kernel2,7,  sizeof(float),          &KerConstDynamic.ref_orientation_quats_const[0]);
		setKernelArg(kernel2,8,  sizeof(float),          &KerConstDynamic.ref_orientation_quats_const[1]);	
		setKernelArg(kernel2,9,  sizeof(float),          &KerConstDynamic.ref_orientation_quats_const[2]);	
		setKernelArg(kernel2,10, sizeof(float),          &KerConstDynamic.ref_orientation_quats_const[3]);
#endif // End of ENABLE_KERNEL2


#ifdef ENABLE_KERNEL5 // Krnl_PRNG_BT_float
		setKernelArg(kernel5,0, sizeof(unsigned int),  &cpu_prng_seeds[0]);
#endif // End of ENABLE_KERNEL5

#ifdef ENABLE_KERNEL6 // Krnl_PRNG_GG_float
		setKernelArg(kernel6,0, sizeof(unsigned int),   &cpu_prng_seeds[1]);
#endif // End of ENABLE_KERNEL6


#ifdef ENABLE_KERNEL7 // Krnl_PRNG_float
		setKernelArg(kernel7,0, sizeof(unsigned int),   &cpu_prng_seeds[2]);
#endif // End of ENABLE_KERNEL7

#ifdef ENABLE_KERNEL8 // Krnl_PRNG_ushort
		setKernelArg(kernel8,0, sizeof(unsigned int),   &cpu_prng_seeds[3]);
#endif // End of ENABLE_KERNEL8

#ifdef ENABLE_KERNEL9 // Krnl_PRNG_LS_ushort
		setKernelArg(kernel9,0, sizeof(unsigned int),   &cpu_prng_seeds[4]);
#endif // End of ENABLE_KERNEL9

#ifdef ENABLE_KERNEL10 // Krnl_PRNG_uchar
		setKernelArg(kernel10,0, sizeof(unsigned int),   &cpu_prng_seeds[5]);
#endif // End of ENABLE_KERNEL10

#ifdef ENABLE_KERNEL14 // Krnl_PRNG_LS2_float
		setKernelArg(kernel14,0, sizeof(unsigned int),   &cpu_prng_seeds[6]);
#endif // End of ENABLE_KERNEL7

#ifdef ENABLE_KERNEL17 // Krnl_Conform2
		setKernelArg(kernel17,7,  sizeof(float),          &KerConstDynamic.ref_orientation_quats_const[0]);
		setKernelArg(kernel17,8,  sizeof(float),          &KerConstDynamic.ref_orientation_quats_const[1]);	
		setKernelArg(kernel17,9,  sizeof(float),          &KerConstDynamic.ref_orientation_quats_const[2]);	
		setKernelArg(kernel17,10, sizeof(float),          &KerConstDynamic.ref_orientation_quats_const[3]);
#endif // End of ENABLE_KERNEL2


#ifdef ENABLE_KERNEL20 // Krnl_PRNG_LS3_float
		setKernelArg(kernel20,0, sizeof(unsigned int),   &cpu_prng_seeds[7]);
#endif // End of ENABLE_KERNEL20



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

		#ifdef ENABLE_KERNEL5
		runKernelTask(command_queue5,kernel5,NULL,NULL);
		#endif // ENABLE_KERNEL5

		#ifdef ENABLE_KERNEL6
		runKernelTask(command_queue6,kernel6,NULL,NULL);
		#endif // ENABLE_KERNEL6

		#ifdef ENABLE_KERNEL7
		runKernelTask(command_queue7,kernel7,NULL,NULL);
		#endif // ENABLE_KERNEL7

		#ifdef ENABLE_KERNEL8
		runKernelTask(command_queue8,kernel8,NULL,NULL);
		#endif // ENABLE_KERNEL8

		#ifdef ENABLE_KERNEL9
		runKernelTask(command_queue9,kernel9,NULL,NULL);
		#endif // ENABLE_KERNEL9

		#ifdef ENABLE_KERNEL10
		runKernelTask(command_queue10,kernel10,NULL,NULL);
		#endif // ENABLE_KERNEL10

		#ifdef ENABLE_KERNEL11
		runKernelTask(command_queue11,kernel11,NULL,NULL);
		#endif // ENABLE_KERNEL10

		#ifdef ENABLE_KERNEL12
		runKernelTask(command_queue12,kernel12,NULL,NULL);
		#endif // ENABLE_KERNEL12

		#ifdef ENABLE_KERNEL13
		runKernelTask(command_queue13,kernel13,NULL,NULL);
		#endif // ENABLE_KERNEL13

		#ifdef ENABLE_KERNEL14
		runKernelTask(command_queue14,kernel14,NULL,NULL);
		#endif // ENABLE_KERNEL14

		#ifdef ENABLE_KERNEL15
		runKernelTask(command_queue15,kernel15,NULL,NULL);
		#endif // ENABLE_KERNEL14

		#ifdef ENABLE_KERNEL16
		runKernelTask(command_queue16,kernel16,NULL,NULL);
		#endif // ENABLE_KERNEL16

		#ifdef ENABLE_KERNEL17
		runKernelTask(command_queue17,kernel17,NULL,NULL);
		#endif // ENABLE_KERNEL17

		#ifdef ENABLE_KERNEL18
		runKernelTask(command_queue18,kernel18,NULL,NULL);
		#endif // ENABLE_KERNEL18

		#ifdef ENABLE_KERNEL19
		runKernelTask(command_queue19,kernel19,NULL,NULL);
		#endif // ENABLE_KERNEL19

		#ifdef ENABLE_KERNEL20
		runKernelTask(command_queue20,kernel20,NULL,NULL);
		#endif // ENABLE_KERNEL19

		#ifdef ENABLE_KERNEL21
		runKernelTask(command_queue21,kernel21,NULL,NULL);
		#endif // ENABLE_KERNEL21

		#ifdef ENABLE_KERNEL22
		runKernelTask(command_queue22,kernel22,NULL,NULL);
		#endif // ENABLE_KERNEL22

		#ifdef ENABLE_KERNEL23
		runKernelTask(command_queue23,kernel23,NULL,NULL);
		#endif // ENABLE_KERNEL23



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

		#ifdef ENABLE_KERNEL5
		clFinish(command_queue5); 
		#endif

		#ifdef ENABLE_KERNEL6
		clFinish(command_queue6); 
		#endif

		#ifdef ENABLE_KERNEL7
		clFinish(command_queue7);
		#endif

		#ifdef ENABLE_KERNEL8
		clFinish(command_queue8);
		#endif

		#ifdef ENABLE_KERNEL9
		clFinish(command_queue9);
		#endif

		#ifdef ENABLE_KERNEL10
		clFinish(command_queue10);
		#endif

		#ifdef ENABLE_KERNEL11
		clFinish(command_queue11);
		#endif

		#ifdef ENABLE_KERNEL12
		clFinish(command_queue12);
		#endif

		#ifdef ENABLE_KERNEL13
		clFinish(command_queue13);
		#endif

		#ifdef ENABLE_KERNEL14
		clFinish(command_queue14);
		#endif

		#ifdef ENABLE_KERNEL15
		clFinish(command_queue15);
		#endif

		#ifdef ENABLE_KERNEL16
		clFinish(command_queue16);
		#endif

		#ifdef ENABLE_KERNEL17
		clFinish(command_queue17);
		#endif

		#ifdef ENABLE_KERNEL18
		clFinish(command_queue18);
		#endif

		#ifdef ENABLE_KERNEL19
		clFinish(command_queue19);
		#endif

		#ifdef ENABLE_KERNEL20
		clFinish(command_queue20);
		#endif

		#ifdef ENABLE_KERNEL21
		clFinish(command_queue21);
		#endif

		#ifdef ENABLE_KERNEL22
		clFinish(command_queue22);
		#endif

		#ifdef ENABLE_KERNEL23
		clFinish(command_queue23);
		#endif

		clock_stop_docking = clock();




		fflush(stdout);


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





	} // End of for (run_cnt = 0; run_cnt < mypars->num_of_runs; run_cnt++)










	



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
  std::string binary_file = getBoardBinaryFile("docking", device);
  printf("Using AOCX: %s\n", binary_file.c_str());
  program = createProgramFromBinary(context, binary_file.c_str(), &device, 1);


  // Build the program that was just created.

  status = clBuildProgram(program, 0, NULL, "", NULL, NULL);
  checkError(status, "Failed to build program");


  // Create the kernel - name passed in here must match kernel name in the
  // original CL file, that was compiled into an AOCX file using the AOC tool
#ifdef ENABLE_KERNEL1
  command_queue1 = clCreateCommandQueue(context, device, CL_QUEUE_PROFILING_ENABLE, &status);
  checkError(status, "Failed to create command queue1");
  kernel1 = clCreateKernel(program, name_k1, &status);
  checkError(status, "Failed to create kernel");
#endif

#ifdef ENABLE_KERNEL2
  command_queue2 = clCreateCommandQueue(context, device, CL_QUEUE_PROFILING_ENABLE, &status);
  checkError(status, "Failed to create command queue2");
  kernel2 = clCreateKernel(program, name_k2, &status);
  checkError(status, "Failed to create kernel");
#endif

#ifdef ENABLE_KERNEL3
  command_queue3 = clCreateCommandQueue(context, device, CL_QUEUE_PROFILING_ENABLE, &status);
  checkError(status, "Failed to create command queue3");
  kernel3 = clCreateKernel(program, name_k3, &status);
  checkError(status, "Failed to create kernel");
#endif

#ifdef ENABLE_KERNEL4
  command_queue4 = clCreateCommandQueue(context, device, CL_QUEUE_PROFILING_ENABLE, &status);
  checkError(status, "Failed to create command queue4");
  kernel4 = clCreateKernel(program, name_k4, &status);
  checkError(status, "Failed to create kernel");
#endif



#ifdef ENABLE_KERNEL5
  command_queue5 = clCreateCommandQueue(context, device, CL_QUEUE_PROFILING_ENABLE, &status);
  checkError(status, "Failed to create command queue5");
  kernel5 = clCreateKernel(program, name_k5, &status);
  checkError(status, "Failed to create kernel");
#endif

#ifdef ENABLE_KERNEL6
  command_queue6 = clCreateCommandQueue(context, device, CL_QUEUE_PROFILING_ENABLE, &status);
  checkError(status, "Failed to create command queue6");
  kernel6 = clCreateKernel(program, name_k6, &status);
  checkError(status, "Failed to create kernel");
#endif

#ifdef ENABLE_KERNEL7
  command_queue7 = clCreateCommandQueue(context, device, CL_QUEUE_PROFILING_ENABLE, &status);
  checkError(status, "Failed to create command queue7");
  kernel7 = clCreateKernel(program, name_k7, &status);
  checkError(status, "Failed to create kernel");
#endif

#ifdef ENABLE_KERNEL8
  command_queue8 = clCreateCommandQueue(context, device, CL_QUEUE_PROFILING_ENABLE, &status);
  checkError(status, "Failed to create command queue8");
  kernel8 = clCreateKernel(program, name_k8, &status);
  checkError(status, "Failed to create kernel");
#endif

#ifdef ENABLE_KERNEL9
  command_queue9 = clCreateCommandQueue(context, device, CL_QUEUE_PROFILING_ENABLE, &status);
  checkError(status, "Failed to create command queue9");
  kernel9 = clCreateKernel(program, name_k9, &status);
  checkError(status, "Failed to create kernel");
#endif

#ifdef ENABLE_KERNEL10
  command_queue10 = clCreateCommandQueue(context, device, CL_QUEUE_PROFILING_ENABLE, &status);
  checkError(status, "Failed to create command queue10");
  kernel10 = clCreateKernel(program, name_k10, &status);
  checkError(status, "Failed to create kernel");
#endif

#ifdef ENABLE_KERNEL11
  command_queue11 = clCreateCommandQueue(context, device, CL_QUEUE_PROFILING_ENABLE, &status);
  checkError(status, "Failed to create command queue10");
  kernel11 = clCreateKernel(program, name_k11, &status);
  checkError(status, "Failed to create kernel");
#endif

#ifdef ENABLE_KERNEL12
  command_queue12 = clCreateCommandQueue(context, device, CL_QUEUE_PROFILING_ENABLE, &status);
  checkError(status, "Failed to create command queue12");
  kernel12 = clCreateKernel(program, name_k12, &status);
  checkError(status, "Failed to create kernel");
#endif

#ifdef ENABLE_KERNEL13
  command_queue13 = clCreateCommandQueue(context, device, CL_QUEUE_PROFILING_ENABLE, &status);
  checkError(status, "Failed to create command queue13");
  kernel13 = clCreateKernel(program, name_k13, &status);
  checkError(status, "Failed to create kernel");
#endif

#ifdef ENABLE_KERNEL14
  command_queue14 = clCreateCommandQueue(context, device, CL_QUEUE_PROFILING_ENABLE, &status);
  checkError(status, "Failed to create command queue14");
  kernel14 = clCreateKernel(program, name_k14, &status);
  checkError(status, "Failed to create kernel");
#endif

#ifdef ENABLE_KERNEL15
  command_queue15 = clCreateCommandQueue(context, device, CL_QUEUE_PROFILING_ENABLE, &status);
  checkError(status, "Failed to create command queue15");
  kernel15 = clCreateKernel(program, name_k15, &status);
  checkError(status, "Failed to create kernel");
#endif

#ifdef ENABLE_KERNEL16
  command_queue16 = clCreateCommandQueue(context, device, CL_QUEUE_PROFILING_ENABLE, &status);
  checkError(status, "Failed to create command queue13");
  kernel16 = clCreateKernel(program, name_k16, &status);
  checkError(status, "Failed to create kernel");
#endif

#ifdef ENABLE_KERNEL17
  command_queue17 = clCreateCommandQueue(context, device, CL_QUEUE_PROFILING_ENABLE, &status);
  checkError(status, "Failed to create command queue17");
  kernel17 = clCreateKernel(program, name_k17, &status);
  checkError(status, "Failed to create kernel");
#endif

#ifdef ENABLE_KERNEL18
  command_queue18 = clCreateCommandQueue(context, device, CL_QUEUE_PROFILING_ENABLE, &status);
  checkError(status, "Failed to create command queue18");
  kernel18 = clCreateKernel(program, name_k18, &status);
  checkError(status, "Failed to create kernel");
#endif

#ifdef ENABLE_KERNEL19
  command_queue19 = clCreateCommandQueue(context, device, CL_QUEUE_PROFILING_ENABLE, &status);
  checkError(status, "Failed to create command queue19");
  kernel19 = clCreateKernel(program, name_k19, &status);
  checkError(status, "Failed to create kernel");
#endif

#ifdef ENABLE_KERNEL20
  command_queue20 = clCreateCommandQueue(context, device, CL_QUEUE_PROFILING_ENABLE, &status);
  checkError(status, "Failed to create command queue20");
  kernel20 = clCreateKernel(program, name_k20, &status);
  checkError(status, "Failed to create kernel");
#endif

#ifdef ENABLE_KERNEL21
  command_queue21 = clCreateCommandQueue(context, device, CL_QUEUE_PROFILING_ENABLE, &status);
  checkError(status, "Failed to create command queue21");
  kernel21 = clCreateKernel(program, name_k21, &status);
  checkError(status, "Failed to create kernel");
#endif

#ifdef ENABLE_KERNEL22
  command_queue22 = clCreateCommandQueue(context, device, CL_QUEUE_PROFILING_ENABLE, &status);
  checkError(status, "Failed to create command queue22");
  kernel22 = clCreateKernel(program, name_k22, &status);
  checkError(status, "Failed to create kernel");
#endif

#ifdef ENABLE_KERNEL23
  command_queue23 = clCreateCommandQueue(context, device, CL_QUEUE_PROFILING_ENABLE, &status);
  checkError(status, "Failed to create command queue23");
  kernel23 = clCreateKernel(program, name_k23, &status);
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

#ifdef ENABLE_KERNEL5
  if(kernel5) {clReleaseKernel(kernel5);}
  if(command_queue5) {clReleaseCommandQueue(command_queue5);}
#endif

#ifdef ENABLE_KERNEL6
  if(kernel6) {clReleaseKernel(kernel6);}
  if(command_queue6) {clReleaseCommandQueue(command_queue6);}
#endif

#ifdef ENABLE_KERNEL7
  if(kernel7) {clReleaseKernel(kernel7);}
  if(command_queue7) {clReleaseCommandQueue(command_queue7);}
#endif

#ifdef ENABLE_KERNEL8
  if(kernel8) {clReleaseKernel(kernel8);}
  if(command_queue8) {clReleaseCommandQueue(command_queue8);}
#endif

#ifdef ENABLE_KERNEL9
  if(kernel9) {clReleaseKernel(kernel9);}
  if(command_queue9) {clReleaseCommandQueue(command_queue9);}
#endif

#ifdef ENABLE_KERNEL10
  if(kernel10) {clReleaseKernel(kernel10);}
  if(command_queue10) {clReleaseCommandQueue(command_queue10);}
#endif

#ifdef ENABLE_KERNEL11
  if(kernel11) {clReleaseKernel(kernel11);}
  if(command_queue11) {clReleaseCommandQueue(command_queue11);}
#endif

#ifdef ENABLE_KERNEL12
  if(kernel12) {clReleaseKernel(kernel12);}
  if(command_queue12) {clReleaseCommandQueue(command_queue12);}
#endif

#ifdef ENABLE_KERNEL13
  if(kernel13) {clReleaseKernel(kernel13);}
  if(command_queue13) {clReleaseCommandQueue(command_queue13);}
#endif

#ifdef ENABLE_KERNEL14
  if(kernel14) {clReleaseKernel(kernel14);}
  if(command_queue14) {clReleaseCommandQueue(command_queue14);}
#endif

#ifdef ENABLE_KERNEL15
  if(kernel15) {clReleaseKernel(kernel15);}
  if(command_queue15) {clReleaseCommandQueue(command_queue15);}
#endif

#ifdef ENABLE_KERNEL16
  if(kernel16) {clReleaseKernel(kernel16);}
  if(command_queue16) {clReleaseCommandQueue(command_queue16);}
#endif

#ifdef ENABLE_KERNEL17
  if(kernel17) {clReleaseKernel(kernel17);}
  if(command_queue17) {clReleaseCommandQueue(command_queue17);}
#endif

#ifdef ENABLE_KERNEL18
  if(kernel18) {clReleaseKernel(kernel18);}
  if(command_queue18) {clReleaseCommandQueue(command_queue18);}
#endif

#ifdef ENABLE_KERNEL19
  if(kernel19) {clReleaseKernel(kernel19);}
  if(command_queue19) {clReleaseCommandQueue(command_queue19);}
#endif

#ifdef ENABLE_KERNEL20
  if(kernel20) {clReleaseKernel(kernel20);}
  if(command_queue20) {clReleaseCommandQueue(command_queue20);}
#endif

#ifdef ENABLE_KERNEL21
  if(kernel21) {clReleaseKernel(kernel21);}
  if(command_queue21) {clReleaseCommandQueue(command_queue21);}
#endif

#ifdef ENABLE_KERNEL22
  if(kernel22) {clReleaseKernel(kernel22);}
  if(command_queue22) {clReleaseCommandQueue(command_queue22);}
#endif

#ifdef ENABLE_KERNEL23
  if(kernel23) {clReleaseKernel(kernel23);}
  if(command_queue23) {clReleaseCommandQueue(command_queue23);}
#endif

  if(program) {clReleaseProgram(program);}
  //if(command_queue) {clReleaseCommandQueue(command_queue);}
  if(context) {clReleaseContext(context);}

  if(cpu_init_populations) {alignedFree(cpu_init_populations);}
  if(cpu_final_populations){alignedFree(cpu_final_populations);}
  if(cpu_energies)         {alignedFree(cpu_energies);}
  if(cpu_result_ligands)   {alignedFree(cpu_result_ligands);}
  if(cpu_prng_seeds)       {alignedFree(cpu_prng_seeds);}
  if(cpu_ref_ori_angles)   {alignedFree(cpu_ref_ori_angles);}

/*if(mem_KerConstStatic)		  {clReleaseMemObject(mem_KerConstStatic);}*/  
  if(mem_KerConstStatic_atom_charges_const)	   {clReleaseMemObject(mem_KerConstStatic_atom_charges_const);}
  if(mem_KerConstStatic_atom_types_const)	   {clReleaseMemObject(mem_KerConstStatic_atom_types_const);}
  if(mem_KerConstStatic_intraE_contributors_const) {clReleaseMemObject(mem_KerConstStatic_intraE_contributors_const);}
  if(mem_KerConstStatic_VWpars_AC_const)	   {clReleaseMemObject(mem_KerConstStatic_VWpars_AC_const);}
  if(mem_KerConstStatic_VWpars_BD_const)	   {clReleaseMemObject(mem_KerConstStatic_VWpars_BD_const);}
  if(mem_KerConstStatic_dspars_S_const)		   {clReleaseMemObject(mem_KerConstStatic_dspars_S_const);}
  if(mem_KerConstStatic_dspars_V_const)		   {clReleaseMemObject(mem_KerConstStatic_dspars_V_const);}
  if(mem_KerConstStatic_rotlist_const)		   {clReleaseMemObject(mem_KerConstStatic_rotlist_const);}

/*if(mem_KerConstDynamic)		  {clReleaseMemObject(mem_KerConstDynamic);}*/
  /*
  if(mem_KerConstDynamic_ref_coords_x_const)		  {clReleaseMemObject(mem_KerConstDynamic_ref_coords_x_const);}
  if(mem_KerConstDynamic_ref_coords_y_const)		  {clReleaseMemObject(mem_KerConstDynamic_ref_coords_y_const);}
  if(mem_KerConstDynamic_ref_coords_z_const)		  {clReleaseMemObject(mem_KerConstDynamic_ref_coords_z_const);}
  */
  if(mem_KerConstDynamic_ref_coords_const)		  {clReleaseMemObject(mem_KerConstDynamic_ref_coords_const);}

  if(mem_KerConstDynamic_rotbonds_moving_vectors_const)   {clReleaseMemObject(mem_KerConstDynamic_rotbonds_moving_vectors_const);}
  if(mem_KerConstDynamic_rotbonds_unit_vectors_const)	  {clReleaseMemObject(mem_KerConstDynamic_rotbonds_unit_vectors_const);}

  if(mem_dockpars_fgrids) 		  {clReleaseMemObject(mem_dockpars_fgrids);}
  if(mem_dockpars_conformations_current)  {clReleaseMemObject(mem_dockpars_conformations_current);}
  if(mem_dockpars_energies_current) 	  {clReleaseMemObject(mem_dockpars_energies_current);}

/*
  if(mem_dockpars_prng_states)            {clReleaseMemObject(mem_dockpars_prng_states);}
*/
  if(mem_evals_and_generations_performed) {clReleaseMemObject(mem_evals_and_generations_performed);}
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
