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
kernelconstant KerConst;


//// --------------------------------
//// Host memory buffers
//// --------------------------------
float* cpu_init_populations;
float* cpu_final_populations;
float* cpu_energies;
Ligandresult* cpu_result_ligands;
unsigned int* cpu_prng_seeds;
int*   cpu_evals_of_runs;
float* cpu_ref_ori_angles;

//// --------------------------------
//// Device memory buffers
//// --------------------------------
// Altera Issue
// Constant data holding struct data
// Created because structs containing array
// are not supported as OpenCL kernel args

cl_mem mem_DockparametersConst;	
cl_mem mem_KerConst;	
	
/*								                  // Nr elements	// Nr bytes
cl_mem mem_atom_charges_const;		// float [MAX_NUM_OF_ATOMS];			// 90	 = 90	//360
cl_mem mem_atom_types_const;		// char  [MAX_NUM_OF_ATOMS];			// 90	 = 90	//360
cl_mem mem_intraE_contributors_const;	// char  [3*MAX_INTRAE_CONTRIBUTORS];		// 3*8128=28384 //28384	
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
cl_mem mem_dockpars_conformations_next;
cl_mem mem_dockpars_energies_next;
cl_mem mem_dockpars_prng_states;

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
	size_t size_evals_of_runs;

	int threadsPerBlock;
	int blocksPerGridForEachEntity;
	int blocksPerGridForEachRun;
	int blocksPerGridForEachLSEntity;

	unsigned long run_cnt;	/* int run_cnt; */
	int generation_cnt;
	int i;
	double progress;


	clock_t clock_start_docking;
	clock_t	clock_stop_docking;
	clock_t clock_stop_program_before_clustering;

	//setting number of blocks and threads
	threadsPerBlock = NUM_OF_THREADS_PER_BLOCK;
	blocksPerGridForEachEntity = mypars->pop_size * mypars->num_of_runs;
	blocksPerGridForEachRun = mypars->num_of_runs;

	//allocating CPU memory for initial populations
	size_populations = mypars->num_of_runs * mypars->pop_size * GENOTYPE_LENGTH_IN_GLOBMEM*sizeof(float);
        cpu_init_populations = (float*) alignedMalloc(size_populations);
	memset(cpu_init_populations, 0, size_populations);

	//allocating CPU memory for results
	size_energies = mypars->pop_size * mypars->num_of_runs * sizeof(float);
	cpu_energies = (float*) alignedMalloc(size_energies);
	cpu_result_ligands = (Ligandresult*) alignedMalloc(sizeof(Ligandresult)*(mypars->num_of_runs));	
	cpu_final_populations = (float*) alignedMalloc(size_populations);

	//allocating memory in CPU for reference orientation angles
	cpu_ref_ori_angles = (float*) alignedMalloc(mypars->num_of_runs*3*sizeof(float));

	//generating initial populations and random orientation angles of reference ligand
	//(ligand will be moved to origo and scaled as well)
	myligand_reference = *myligand_init;
	gen_initpop_and_reflig(mypars, cpu_init_populations, cpu_ref_ori_angles, &myligand_reference, mygrid);

	//allocating memory in CPU for pseudorandom number generator seeds and
	//generating them (seed for each thread during GA)
	size_prng_seeds = blocksPerGridForEachEntity * threadsPerBlock * sizeof(unsigned int);
	cpu_prng_seeds = (unsigned int*) alignedMalloc(size_prng_seeds);

	genseed(time(NULL));	//initializing seed generator

	for (i=0; i<blocksPerGridForEachEntity*threadsPerBlock; i++)
#if defined (REPRO)
		cpu_prng_seeds[i] = 1u;
#else
		cpu_prng_seeds[i] = genseed(0u);
#endif

	//allocating memory in CPU for evaluation counters
	size_evals_of_runs = mypars->num_of_runs*sizeof(int);
	cpu_evals_of_runs = (int*) alignedMalloc(size_evals_of_runs);
	memset(cpu_evals_of_runs, 0, size_evals_of_runs);

	//preparing the constant data fields for the GPU
	// ----------------------------------------------------------------------
	// The original function does CUDA calls initializing const Kernel data.
	// We create a struct to hold those constants
	// and return them <here> (<here> = where prepare_const_fields_for_gpu() is called),
	// so we can send them to Kernels from <here>, instead of from calcenergy.cpp as originally.
	// ----------------------------------------------------------------------
	if (prepare_const_fields_for_gpu(&myligand_reference, mypars, cpu_ref_ori_angles, &KerConst) == 1)
		return 1;

	//preparing parameter struct
	dockpars.num_of_atoms  = ((char)  myligand_reference.num_of_atoms);
	dockpars.num_of_atypes = ((char)  myligand_reference.num_of_atypes);
	dockpars.num_of_intraE_contributors = ((int) myligand_reference.num_of_intraE_contributors);
	dockpars.gridsize_x    = ((char)  mygrid->size_xyz[0]);
	dockpars.gridsize_y    = ((char)  mygrid->size_xyz[1]);
	dockpars.gridsize_z    = ((char)  mygrid->size_xyz[2]);
	dockpars.grid_spacing  = ((float) mygrid->spacing);
	dockpars.rotbondlist_length = ((int) NUM_OF_THREADS_PER_BLOCK*(myligand_reference.num_of_rotcyc));
	dockpars.coeff_elec    = ((float) mypars->coeffs.scaled_AD4_coeff_elec);
	dockpars.coeff_desolv  = ((float) mypars->coeffs.AD4_coeff_desolv);
	dockpars.pop_size      = mypars->pop_size;
	dockpars.num_of_genes  = myligand_reference.num_of_rotbonds + 6;
	dockpars.tournament_rate = mypars->tournament_rate;
	dockpars.crossover_rate  = mypars->crossover_rate;
	dockpars.mutation_rate   = mypars->mutation_rate;
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
	blocksPerGridForEachLSEntity = dockpars.num_of_lsentities*mypars->num_of_runs;


 	//allocating GPU memory for populations, floatgrids,
	//energies, evaluation counters and random number generator states
	size_floatgrids = (sizeof(float)) * (mygrid->num_of_atypes+2) * (mygrid->size_xyz[0]) * (mygrid->size_xyz[1]) * (mygrid->size_xyz[2]);

	mallocBufferObject(context,CL_MEM_READ_ONLY, sizeof(dockpars), &mem_DockparametersConst);
	mallocBufferObject(context,CL_MEM_READ_ONLY, sizeof(KerConst), &mem_KerConst);
	mallocBufferObject(context,CL_MEM_READ_ONLY,size_floatgrids,   &mem_dockpars_fgrids);
	mallocBufferObject(context,CL_MEM_READ_ONLY,size_populations,  &mem_dockpars_conformations_current);
	mallocBufferObject(context,CL_MEM_READ_WRITE,size_energies,    &mem_dockpars_energies_current);
	mallocBufferObject(context,CL_MEM_READ_WRITE,size_populations, &mem_dockpars_conformations_next);
	mallocBufferObject(context,CL_MEM_READ_WRITE,size_energies,    &mem_dockpars_energies_next);
	mallocBufferObject(context,CL_MEM_READ_WRITE,size_prng_seeds,  &mem_dockpars_prng_states);

	memcopyBufferObjectToDevice(command_queue1,mem_DockparametersConst, 		&dockpars,            sizeof(dockpars));
	memcopyBufferObjectToDevice(command_queue1,mem_KerConst, 	   		&KerConst,            sizeof(KerConst));
	memcopyBufferObjectToDevice(command_queue1,mem_dockpars_fgrids, 			cpu_floatgrids,       size_floatgrids);
 	memcopyBufferObjectToDevice(command_queue1,mem_dockpars_conformations_current, 	cpu_init_populations, size_populations);
	memcopyBufferObjectToDevice(command_queue1,mem_dockpars_prng_states,     	cpu_prng_seeds,       size_prng_seeds);

	clock_start_docking = clock();

#ifdef ENABLE_KERNEL1
        setKernelArg(kernel1,0, sizeof(mem_dockpars_fgrids),                    &mem_dockpars_fgrids);
        setKernelArg(kernel1,1, sizeof(mem_dockpars_conformations_current),     &mem_dockpars_conformations_current);
        setKernelArg(kernel1,2, sizeof(mem_dockpars_energies_current),          &mem_dockpars_energies_current);
        setKernelArg(kernel1,3, sizeof(mem_dockpars_conformations_next),        &mem_dockpars_conformations_next);
        setKernelArg(kernel1,4, sizeof(mem_dockpars_energies_next),             &mem_dockpars_energies_next);
        setKernelArg(kernel1,5, sizeof(mem_dockpars_prng_states),               &mem_dockpars_prng_states);
	setKernelArg(kernel1,6, sizeof(cl_mem),                          	&mem_KerConst);
        setKernelArg(kernel1,7, sizeof(cl_mem),                          	&mem_DockparametersConst);
#endif // End of ENABLE_KERNEL1

#ifdef ENABLE_KERNEL2
        setKernelArg(kernel2,0, sizeof(mem_dockpars_fgrids),                    &mem_dockpars_fgrids);
        setKernelArg(kernel2,1, sizeof(mem_dockpars_conformations_current),     &mem_dockpars_conformations_current);
        setKernelArg(kernel2,2, sizeof(mem_dockpars_energies_current),          &mem_dockpars_energies_current);
        setKernelArg(kernel2,3, sizeof(mem_dockpars_conformations_next),        &mem_dockpars_conformations_next);
        setKernelArg(kernel2,4, sizeof(mem_dockpars_energies_next),             &mem_dockpars_energies_next);
        setKernelArg(kernel2,5, sizeof(mem_dockpars_prng_states),               &mem_dockpars_prng_states);
	setKernelArg(kernel2,6, sizeof(cl_mem),                          	&mem_KerConst);
        setKernelArg(kernel2,7, sizeof(cl_mem),                          	&mem_DockparametersConst);
#endif // End of ENABLE_KERNEL2

#ifdef ENABLE_KERNEL4
        setKernelArg(kernel4,0, sizeof(mem_dockpars_fgrids),                    &mem_dockpars_fgrids);
        setKernelArg(kernel4,1, sizeof(mem_dockpars_conformations_current),     &mem_dockpars_conformations_current);
        setKernelArg(kernel4,2, sizeof(mem_dockpars_energies_current),          &mem_dockpars_energies_current);
        setKernelArg(kernel4,3, sizeof(mem_dockpars_conformations_next),        &mem_dockpars_conformations_next);
        setKernelArg(kernel4,4, sizeof(mem_dockpars_energies_next),             &mem_dockpars_energies_next);
        setKernelArg(kernel4,5, sizeof(mem_dockpars_prng_states),               &mem_dockpars_prng_states);
	setKernelArg(kernel4,6, sizeof(cl_mem),                          	&mem_KerConst);
        setKernelArg(kernel4,7, sizeof(cl_mem),                          	&mem_DockparametersConst);
#endif // End of ENABLE_KERNEL4

#ifdef ENABLE_KERNEL3
        setKernelArg(kernel3,0, sizeof(mem_dockpars_fgrids),                    &mem_dockpars_fgrids);
        setKernelArg(kernel3,1, sizeof(mem_dockpars_conformations_current),     &mem_dockpars_conformations_current);
        setKernelArg(kernel3,2, sizeof(mem_dockpars_energies_current),          &mem_dockpars_energies_current);
        setKernelArg(kernel3,3, sizeof(mem_dockpars_conformations_next),        &mem_dockpars_conformations_next);
        setKernelArg(kernel3,4, sizeof(mem_dockpars_energies_next),             &mem_dockpars_energies_next);
        setKernelArg(kernel3,5, sizeof(mem_dockpars_prng_states),               &mem_dockpars_prng_states);
	setKernelArg(kernel3,6, sizeof(cl_mem),                          	&mem_KerConst);
        setKernelArg(kernel3,7, sizeof(cl_mem),                          	&mem_DockparametersConst);
#endif // End of ENABLE_KERNEL3






	generation_cnt = 1;




	for (run_cnt = 0; run_cnt < mypars->num_of_runs; run_cnt++)
	{

		printf("Run %d started...     \n", run_cnt+1); 		
		fflush(stdout);

#ifdef ENABLE_KERNEL1
	runKernelTask(command_queue1,kernel1,NULL,NULL);
#endif // ENABLE_KERNEL1

#ifdef ENABLE_KERNEL2
	runKernelTask(command_queue2,kernel2,NULL,NULL);
#endif // ENABLE_KERNEL2

#ifdef ENABLE_KERNEL4
	runKernelTask(command_queue4,kernel4,NULL,NULL);
#endif // ENABLE_KERNEL4

#ifdef ENABLE_KERNEL3
	runKernelTask(command_queue3,kernel3,NULL,NULL);
#endif // ENABLE_KERNEL3


		generation_cnt++;

#ifdef ENABLE_KERNEL1 		
	clFinish(command_queue1); 
#endif

#ifdef ENABLE_KERNEL2	
	clFinish(command_queue2); 
#endif

#ifdef ENABLE_KERNEL4 		
	clFinish(command_queue4); 
#endif

#ifdef ENABLE_KERNEL3 		
	clFinish(command_queue3); 
#endif


	} // End of while-loop















	clock_stop_docking = clock();



	printf("\n\n");

	// ===============================================================================
	// L30nardoSV modified
	// http://www.cc.gatech.edu/~vetter/keeneland/tutorial-2012-02-20/08-opencl.pdf
	// ===============================================================================

	//processing results






	//cudaMemcpy(cpu_final_populations, dockpars.conformations_current, size_populations, cudaMemcpyDeviceToHost);
	memcopyBufferObjectFromDevice(command_queue1,cpu_final_populations,mem_dockpars_conformations_current,size_populations);

	//cudaMemcpy(cpu_energies, dockpars.energies_current, size_energies, cudaMemcpyDeviceToHost);
	memcopyBufferObjectFromDevice(command_queue1,cpu_energies,mem_dockpars_energies_current,size_energies);












#if defined (DOCK_DEBUG)
	for (int cnt_pop=0;cnt_pop<size_populations/sizeof(float);cnt_pop++)
		printf("total_num_pop: %u, cpu_final_populations[%u]: %f\n",(unsigned int)(size_populations/sizeof(float)),cnt_pop,cpu_final_populations[cnt_pop]);

	for (int cnt_pop=0;cnt_pop<size_energies/sizeof(float);cnt_pop++)
		printf("total_num_energies: %u, cpu_energies[%u]: %f\n",    (unsigned int)(size_energies/sizeof(float)),cnt_pop,cpu_energies[cnt_pop]);
#endif

	// ===============================================================================


	for (run_cnt=0; run_cnt < mypars->num_of_runs; run_cnt++)
	{
		arrange_result(cpu_final_populations+run_cnt*mypars->pop_size*GENOTYPE_LENGTH_IN_GLOBMEM, cpu_energies+run_cnt*mypars->pop_size, mypars->pop_size);

		make_resfiles(cpu_final_populations+run_cnt*mypars->pop_size*GENOTYPE_LENGTH_IN_GLOBMEM, cpu_energies+run_cnt*mypars->pop_size, &myligand_reference,
					  myligand_init, mypars, cpu_evals_of_runs[run_cnt], generation_cnt, mygrid, cpu_floatgrids, cpu_ref_ori_angles+3*run_cnt, argc, argv, /*1*/0,
					  run_cnt, &(cpu_result_ligands [run_cnt]));

	}

	clock_stop_program_before_clustering = clock();
	clusanal_gendlg(cpu_result_ligands, mypars->num_of_runs, myligand_init, mypars,
					 mygrid, argc, argv, ELAPSEDSECS(clock_stop_docking, clock_start_docking)/mypars->num_of_runs,
					 ELAPSEDSECS(clock_stop_program_before_clustering, clock_start_program));

        // ------------------------
        // Correct time measurement
	//printf("Average run time of one run: %.3f sec\n", ELAPSEDSECS(clock_stop_docking, clock_start_docking)/mypars->num_of_runs);
	// ------------------------

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
  platform = findPlatform("Intel(R) FPGA");
  //platform = findPlatform("Altera SDK");
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

#ifdef ENABLE_KERNEL4
  command_queue4 = clCreateCommandQueue(context, device, CL_QUEUE_PROFILING_ENABLE, &status);
  checkError(status, "Failed to create command queue4");
  kernel4 = clCreateKernel(program, name_k4, &status);
  checkError(status, "Failed to create kernel");
#endif

#ifdef ENABLE_KERNEL3
  command_queue3 = clCreateCommandQueue(context, device, CL_QUEUE_PROFILING_ENABLE, &status);
  checkError(status, "Failed to create command queue3");
  kernel3 = clCreateKernel(program, name_k3, &status);
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

  if(program) {clReleaseProgram(program);}
  //if(command_queue) {clReleaseCommandQueue(command_queue);}
  if(context) {clReleaseContext(context);}

  if(cpu_init_populations) {alignedFree(cpu_init_populations);}
  if(cpu_final_populations){alignedFree(cpu_final_populations);}
  if(cpu_energies)         {alignedFree(cpu_energies);}
  if(cpu_result_ligands)   {alignedFree(cpu_result_ligands);}
  if(cpu_prng_seeds)       {alignedFree(cpu_prng_seeds);}
  if(cpu_evals_of_runs)    {alignedFree(cpu_evals_of_runs);}
  if(cpu_ref_ori_angles)   {alignedFree(cpu_ref_ori_angles);}

  if(mem_DockparametersConst)		{clReleaseMemObject(mem_DockparametersConst);}
  if(mem_KerConst)			{clReleaseMemObject(mem_KerConst);}
  if(mem_dockpars_fgrids) 		{clReleaseMemObject(mem_dockpars_fgrids);}
  if(mem_dockpars_conformations_current){clReleaseMemObject(mem_dockpars_conformations_current);}
  if(mem_dockpars_energies_current) 	{clReleaseMemObject(mem_dockpars_energies_current);}
  if(mem_dockpars_conformations_next)   {clReleaseMemObject(mem_dockpars_conformations_next);}
  if(mem_dockpars_energies_next)        {clReleaseMemObject(mem_dockpars_energies_next);}
  if(mem_dockpars_prng_states)          {clReleaseMemObject(mem_dockpars_prng_states);}
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

