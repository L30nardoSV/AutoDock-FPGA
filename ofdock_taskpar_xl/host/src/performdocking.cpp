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

/*
#include "AOCLUtils/aocl_utils.h"
using namespace aocl_utils;
*/
#define STRING_BUFFER_LEN 1024

#include "xcl2.hpp"
#include <vector>
using std::vector;


// Function prototypes

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

//// --------------------------------
//// Device memory buffers
//// --------------------------------
cl_mem mem_KerConstStatic_InterE_atom_charges_const;
cl_mem mem_KerConstStatic_InterE_atom_types_const;

cl_mem mem_KerConstStatic_IntraE_atom_charges_const;
cl_mem mem_KerConstStatic_IntraE_atom_types_const;

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
cl_mem mem_dockpars_conformations_current;
cl_mem mem_dockpars_energies_current;

cl_mem mem_evals_performed;
cl_mem mem_gens_performed;

#if !defined(SW_EMU)
// IMPORTANT: enable this dummy global argument only for "hw" build.
// Check ../common_xilinx/utility/boards.mk
// https://forums.xilinx.com/t5/SDAccel/ERROR-KernelCheck-83-114-in-sdx-2017-4/td-p/818135
cl_mem mem_dummy;
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
	// The get_xil_devices will return vector of Xilinx Devices 
	std::vector<cl::Device> devices = xcl::get_xil_devices();
	cl::Device device = devices[0];

	//Creating Context and Command Queue for selected Device 
	cl::Context context(device);
    	std::string device_name = device.getInfo<CL_DEVICE_NAME>(); 
	std::cout << "Found Device=" << device_name.c_str() << std::endl;

	#ifdef ENABLE_KRNL_GA
	cl::CommandQueue command_queue_ga			(context, device, CL_QUEUE_PROFILING_ENABLE);
	#endif
	#ifdef ENABLE_KRNL_CONFORM
	cl::CommandQueue command_queue_conform			(context, device, CL_QUEUE_PROFILING_ENABLE);
	#endif
	#ifdef ENABLE_KRNL_INTERE
	cl::CommandQueue command_queue_intere			(context, device, CL_QUEUE_PROFILING_ENABLE);
	#endif
	#ifdef ENABLE_KRNL_INTRAE
	cl::CommandQueue command_queue_intrae			(context, device, CL_QUEUE_PROFILING_ENABLE);
	#endif
	#ifdef ENABLE_KRNL_PRNG_BT_USHORT_FLOAT
	cl::CommandQueue command_queue_prng_bt_ushort_float	(context, device, CL_QUEUE_PROFILING_ENABLE);
	#endif
	#ifdef ENABLE_KRNL_PRNG_GG_UCHAR
	cl::CommandQueue command_queue_prng_gg_uchar		(context, device, CL_QUEUE_PROFILING_ENABLE);
	#endif
	#ifdef ENABLE_KRNL_PRNG_GG_FLOAT
	cl::CommandQueue command_queue_prng_gg_float		(context, device, CL_QUEUE_PROFILING_ENABLE);
	#endif
	#ifdef ENABLE_KRNL_PRNG_LS123_USHORT
	cl::CommandQueue command_queue_prng_ls123_ushort	(context, device, CL_QUEUE_PROFILING_ENABLE);
	#endif
	#ifdef ENABLE_KRNL_PRNG_LS_FLOAT
	cl::CommandQueue command_queue_prng_ls_float		(context, device, CL_QUEUE_PROFILING_ENABLE);
	#endif
	#ifdef ENABLE_KRNL_PRNG_LS2_FLOAT
	cl::CommandQueue command_queue_prng_ls2_float		(context, device, CL_QUEUE_PROFILING_ENABLE);
	#endif
	#ifdef ENABLE_KRNL_PRNG_LS3_FLOAT
	cl::CommandQueue command_queue_prng_ls3_float		(context, device, CL_QUEUE_PROFILING_ENABLE);
	#endif
	#ifdef ENABLE_KRNL_PRNG_LS4_FLOAT
	cl::CommandQueue command_queue_prng_ls4_float		(context, device, CL_QUEUE_PROFILING_ENABLE);
	#endif
	#ifdef ENABLE_KRNL_PRNG_LS5_FLOAT
	cl::CommandQueue command_queue_prng_ls5_float		(context, device, CL_QUEUE_PROFILING_ENABLE);
	#endif
	#ifdef ENABLE_KRNL_PRNG_LS6_FLOAT
	cl::CommandQueue command_queue_prng_ls6_float		(context, device, CL_QUEUE_PROFILING_ENABLE);
	#endif
	#ifdef ENABLE_KRNL_PRNG_LS7_FLOAT
	cl::CommandQueue command_queue_prng_ls7_float		(context, device, CL_QUEUE_PROFILING_ENABLE);
	#endif
	#ifdef ENABLE_KRNL_PRNG_LS8_FLOAT
	cl::CommandQueue command_queue_prng_ls8_float		(context, device, CL_QUEUE_PROFILING_ENABLE);
	#endif
	#ifdef ENABLE_KRNL_PRNG_LS9_FLOAT
	cl::CommandQueue command_queue_prng_ls9_float		(context, device, CL_QUEUE_PROFILING_ENABLE);
	#endif
	#ifdef ENABLE_KRNL_LS
	cl::CommandQueue command_queue_ls			(context, device, CL_QUEUE_PROFILING_ENABLE);
	#endif
	#ifdef ENABLE_KRNL_LS2
	cl::CommandQueue command_queue_ls2			(context, device, CL_QUEUE_PROFILING_ENABLE);
	#endif
	#ifdef ENABLE_KRNL_LS3
	cl::CommandQueue command_queue_ls3			(context, device, CL_QUEUE_PROFILING_ENABLE);
	#endif
	#ifdef ENABLE_KRNL_LS4
	cl::CommandQueue command_queue_ls4			(context, device, CL_QUEUE_PROFILING_ENABLE);
	#endif
	#ifdef ENABLE_KRNL_LS5
	cl::CommandQueue command_queue_ls5			(context, device, CL_QUEUE_PROFILING_ENABLE);
	#endif
	#ifdef ENABLE_KRNL_LS6
	cl::CommandQueue command_queue_ls6			(context, device, CL_QUEUE_PROFILING_ENABLE);
	#endif	
	#ifdef ENABLE_KRNL_LS7
	cl::CommandQueue command_queue_ls7			(context, device, CL_QUEUE_PROFILING_ENABLE);
	#endif
	#ifdef ENABLE_KRNL_LS8
	cl::CommandQueue command_queue_ls8			(context, device, CL_QUEUE_PROFILING_ENABLE);
	#endif
	#ifdef ENABLE_KRNL_LS9
	cl::CommandQueue command_queue_ls9			(context, device, CL_QUEUE_PROFILING_ENABLE);
	#endif
	#ifdef ENABLE_KRNL_IGL_ARBITER
	cl::CommandQueue command_queue_igl_arbiter		(context, device, CL_QUEUE_PROFILING_ENABLE);
	#endif

    	// import_binary() command will find the OpenCL binary file created using the 
    	// xocc compiler load into OpenCL Binary and return as Binaries
    	// OpenCL and it can contain many functions which can be executed on the
   	// device.
    	std::string binaryFile = xcl::find_binary_file(device_name,"Krnl_GA");
    	cl::Program::Binaries bins = xcl::import_binary_file(binaryFile);
    	devices.resize(1);
    	cl::Program program(context, devices, bins);

    	// This call will extract a kernel out of the program we loaded in the
    	// previous line. A kernel is an OpenCL function that is executed on the
    	// FPGA. This function is defined in the device/Krnl_GA.cl file.
	#ifdef ENABLE_KRNL_GA
	cl::Kernel kernel_ga			(program, "Krnl_GA");
	#endif
	#ifdef ENABLE_KRNL_CONFORM
	cl::Kernel kernel_conform		(program, "Krnl_Conform");
	#endif
	#ifdef ENABLE_KRNL_INTERE
	cl::Kernel kernel_intere		(program, "Krnl_InterE");
	#endif
	#ifdef ENABLE_KRNL_INTRAE
	cl::Kernel kernel_intrae		(program, "Krnl_IntraE");
	#endif
	#ifdef ENABLE_KRNL_PRNG_BT_USHORT_FLOAT
	cl::Kernel kernel_prng_bt_ushort_float	(program, "Krnl_Prng_BT_ushort_float");
	#endif
	#ifdef ENABLE_KRNL_PRNG_GG_UCHAR
	cl::Kernel kernel_prng_gg_uchar		(program, "Krnl_Prng_GG_uchar");
	#endif
	#ifdef ENABLE_KRNL_PRNG_GG_FLOAT
	cl::Kernel kernel_prng_gg_float		(program, "Krnl_Prng_GG_float");
	#endif
	#ifdef ENABLE_KRNL_PRNG_LS123_USHORT
	cl::Kernel kernel_prng_ls123_ushort	(program, "Krnl_Prng_LS123_ushort");
	#endif
	#ifdef ENABLE_KRNL_PRNG_LS_FLOAT
	cl::Kernel kernel_prng_ls_float		(program, "Krnl_Prng_LS_float");
	#endif
	#ifdef ENABLE_KRNL_PRNG_LS2_FLOAT
	cl::Kernel kernel_prng_ls2_float	(program, "Krnl_Prng_LS2_float");
	#endif
	#ifdef ENABLE_KRNL_PRNG_LS3_FLOAT
	cl::Kernel kernel_prng_ls3_float	(program, "Krnl_Prng_LS3_float");
	#endif
	#ifdef ENABLE_KRNL_PRNG_LS4_FLOAT
	cl::Kernel kernel_prng_ls4_float	(program, "Krnl_Prng_LS4_float");
	#endif
	#ifdef ENABLE_KRNL_PRNG_LS5_FLOAT
	cl::Kernel kernel_prng_ls5_float	(program, "Krnl_Prng_LS5_float");
	#endif
	#ifdef ENABLE_KRNL_PRNG_LS6_FLOAT
	cl::Kernel kernel_prng_ls6_float	(program, "Krnl_Prng_LS6_float");
	#endif
	#ifdef ENABLE_KRNL_PRNG_LS7_FLOAT
	cl::Kernel kernel_prng_ls7_float	(program, "Krnl_Prng_LS7_float");
	#endif
	#ifdef ENABLE_KRNL_PRNG_LS8_FLOAT
	cl::Kernel kernel_prng_ls8_float	(program, "Krnl_Prng_LS8_float");
	#endif
	#ifdef ENABLE_KRNL_PRNG_LS9_FLOAT
	cl::Kernel kernel_prng_ls9_float	(program, "Krnl_Prng_LS9_float");
	#endif
	#ifdef ENABLE_KRNL_LS
	cl::Kernel kernel_ls			(program, "Krnl_LS");
	#endif
	#ifdef ENABLE_KRNL_LS2
	cl::Kernel kernel_ls2			(program, "Krnl_LS2");
	#endif
	#ifdef ENABLE_KRNL_LS3
	cl::Kernel kernel_ls3			(program, "Krnl_LS3");
	#endif
	#ifdef ENABLE_KRNL_LS4
	cl::Kernel kernel_ls4			(program, "Krnl_LS4");
	#endif
	#ifdef ENABLE_KRNL_LS5
	cl::Kernel kernel_ls5			(program, "Krnl_LS5");
	#endif
	#ifdef ENABLE_KRNL_LS6
	cl::Kernel kernel_ls6			(program, "Krnl_LS6");
	#endif
	#ifdef ENABLE_KRNL_LS7
	cl::Kernel kernel_ls7			(program, "Krnl_LS7");
	#endif
	#ifdef ENABLE_KRNL_LS8
	cl::Kernel kernel_ls8			(program, "Krnl_LS8");
	#endif
	#ifdef ENABLE_KRNL_LS9
	cl::Kernel kernel_ls9			(program, "Krnl_LS9");
	#endif
	#ifdef ENABLE_KRNL_IGL_ARBITER
	cl::Kernel kernel_igl_arbiter		(program, "Krnl_IGL_Arbiter");
	#endif

	clock_t clock_start_docking;
	clock_t	clock_stop_docking;
	clock_t clock_stop_program_before_clustering;

	Liganddata myligand_reference;

 	//allocating GPU memory for floatgrids,
	size_t size_floatgrids_nbytes = (sizeof(float)) * (mygrid->num_of_atypes+2) * (mygrid->size_xyz[0]) * (mygrid->size_xyz[1]) * (mygrid->size_xyz[2]);

	size_t size_populations_nbytes = mypars->num_of_runs * mypars->pop_size * ACTUAL_GENOTYPE_LENGTH * sizeof(float);
	size_t size_populations_nelems = mypars->num_of_runs * mypars->pop_size * ACTUAL_GENOTYPE_LENGTH;

	size_t size_energies_nbytes = mypars->num_of_runs * mypars->pop_size * sizeof(float);
	size_t size_energies_nelems = mypars->num_of_runs * mypars->pop_size;

	//allocating and initializing CPU memory for initial population
	vector<float,aligned_allocator<float>> cpu_init_populations (size_populations_nelems, 0.0f);

	//allocating CPU memory for final population
	vector<float,aligned_allocator<float>> cpu_final_populations (size_populations_nelems);

	//allocating CPU memory for results
	vector<float,aligned_allocator<float>> cpu_energies (size_energies_nelems);

	//allocating CPU memory for resulting ligands
	vector<Ligandresult,aligned_allocator<Ligandresult>> cpu_result_ligands (mypars->num_of_runs);

	//allocating memory in CPU for reference orientation angles
	vector<float,aligned_allocator<float>> cpu_ref_ori_angles (mypars->num_of_runs*3);

	//generating initial populations and random orientation angles of reference ligand
	//(ligand will be moved to origo and scaled as well)
	myligand_reference = *myligand_init;
	gen_initpop_and_reflig(mypars, cpu_init_populations, cpu_ref_ori_angles, &myligand_reference, mygrid);

	//allocating memory in CPU for pseudorandom number generator seeds
	const unsigned int num_of_prng_blocks = 25;
	size_t size_prng_seeds_nelems = num_of_prng_blocks * mypars->num_of_runs;
	vector<unsigned int,aligned_allocator<unsigned int>> cpu_prng_seeds (size_prng_seeds_nelems);
	
	//initializing seed generator
	genseed(time(NULL));	

	//generating seeds (for each thread during GA)
	for (unsigned int i=0; i<size_prng_seeds_nelems; i++) {
		cpu_prng_seeds[i] = genseed(0u);
	}

	size_t size_evals_of_runs_nbytes = mypars->num_of_runs*sizeof(int);
	size_t size_evals_of_runs_nelems = mypars->num_of_runs;

	// allocating memory in CPU for evaluation counters
	vector<int,aligned_allocator<int>> cpu_evals_of_runs (size_evals_of_runs_nelems, 0);
	
	// allocating memory in CPU for generation counters
	vector<int,aligned_allocator<int>> cpu_gens_of_runs (size_evals_of_runs_nelems, 0);

	//preparing the constant data fields for the GPU
	// ----------------------------------------------------------------------
	// The original function does CUDA calls initializing const Kernel data.
	// We create a struct to hold those constants
	// and return them <here> (<here> = where prepare_const_fields_for_gpu() is called),
	// so we can send them to Kernels from <here>, instead of from calcenergy.cpp as originally.
	// ----------------------------------------------------------------------
	if (prepare_conststatic_fields_for_gpu(&myligand_reference, mypars, cpu_ref_ori_angles, &KerConstStatic) == 1)
		return 1;

	//preparing parameter struct
	dockpars.num_of_atoms  			= ((unsigned char) myligand_reference.num_of_atoms);
	dockpars.num_of_atypes 			= ((unsigned char) myligand_reference.num_of_atypes);
	dockpars.num_of_intraE_contributors 	= ((unsigned int) myligand_reference.num_of_intraE_contributors);
	dockpars.gridsize_x    			= ((unsigned char)  mygrid->size_xyz[0]);
	dockpars.gridsize_y    			= ((unsigned char)  mygrid->size_xyz[1]);
	dockpars.gridsize_z    			= ((unsigned char)  mygrid->size_xyz[2]);
	dockpars.g1	       			= dockpars.gridsize_x ;
	dockpars.g2	       			= dockpars.gridsize_x * dockpars.gridsize_y;
	dockpars.g3	       			= dockpars.gridsize_x * dockpars.gridsize_y * dockpars.gridsize_z;
	dockpars.grid_spacing  			= ((float) mygrid->spacing);
	dockpars.rotbondlist_length 		= ((unsigned int) NUM_OF_THREADS_PER_BLOCK*(myligand_reference.num_of_rotcyc));
	dockpars.coeff_elec    			= ((float) mypars->coeffs.scaled_AD4_coeff_elec);
	dockpars.coeff_desolv  			= ((float) mypars->coeffs.AD4_coeff_desolv);

	dockpars.num_of_energy_evals 		= (unsigned int) mypars->num_of_energy_evals;
	dockpars.num_of_generations  		= (unsigned int) mypars->num_of_generations;

	dockpars.pop_size      			= (unsigned int) mypars->pop_size;
	dockpars.num_of_genes  			= (unsigned int)(myligand_reference.num_of_rotbonds + 6);
	dockpars.tournament_rate 		= (mypars->tournament_rate)/100;
	dockpars.crossover_rate  		= (mypars->crossover_rate)/100;
	dockpars.mutation_rate   		= (mypars->mutation_rate)/100;
	dockpars.abs_max_dang    		= mypars->abs_max_dang;
	dockpars.abs_max_dmov    		= mypars->abs_max_dmov;
	dockpars.lsearch_rate    		= mypars->lsearch_rate;
	dockpars.num_of_lsentities 		= (unsigned int) (mypars->lsearch_rate/100.0*mypars->pop_size + 0.5);
	dockpars.rho_lower_bound   		= mypars->rho_lower_bound;
	dockpars.base_dmov_mul_sqrt3 		= mypars->base_dmov_mul_sqrt3;
	dockpars.base_dang_mul_sqrt3 		= mypars->base_dang_mul_sqrt3;
	dockpars.cons_limit        		= (unsigned int) mypars->cons_limit;
	dockpars.max_num_of_iters  		= (unsigned int) mypars->max_num_of_iters;
	dockpars.qasp 				= mypars->qasp;
	dockpars.smooth 			= mypars->smooth;

	// these variables hold multiplications between kernel-constants
	// better calculate them here and then pass them to Krnl_GA
	const float two_absmaxdmov = 2.0 * dockpars.abs_max_dmov;
	const float two_absmaxdang = 2.0 * dockpars.abs_max_dang;

	// these variables hold multiplications between kernel-constants
	// better calculate them here and then pass them to Krnl_InterE and Krnl_InterE2
	const unsigned int mul_tmp2 = dockpars.num_of_atypes * dockpars.g3;
	const unsigned int mul_tmp3 = (dockpars.num_of_atypes + 1) * dockpars.g3;

	// -----------------------------------------------------------------------------------------------------
	// Hardware specific
	// Specifiying exact memory bank from host code
	// Only valid if 4 banks are available (AWS)
	cl_mem_ext_ptr_t d_bank0_ext; // Krnl_GA
	cl_mem_ext_ptr_t d_bank1_ext; // Krnl_Conform
	cl_mem_ext_ptr_t d_bank2_ext; // Krnl_InterE
	cl_mem_ext_ptr_t d_bank3_ext; // Krnl_IntraE

	d_bank0_ext.flags = XCL_MEM_DDR_BANK0;
	d_bank0_ext.obj   = NULL;
	d_bank0_ext.param = 0;

	d_bank1_ext.flags = XCL_MEM_DDR_BANK1;
	d_bank1_ext.obj   = NULL;
	d_bank1_ext.param = 0;

	d_bank2_ext.flags = XCL_MEM_DDR_BANK2;
	d_bank2_ext.obj   = NULL;
	d_bank2_ext.param = 0;

	d_bank3_ext.flags = XCL_MEM_DDR_BANK3;
	d_bank3_ext.obj   = NULL;
	d_bank3_ext.param = 0;

	// Replacing common buffer creation with 
	// a Xilinx-specific where DDR banks can be specified
	mallocBufferObject(context,CL_MEM_READ_WRITE | CL_MEM_EXT_PTR_XILINX,size_populations,  	&d_bank0_ext,	&mem_dockpars_conformations_current);	// GA
	mallocBufferObject(context,CL_MEM_READ_WRITE | CL_MEM_EXT_PTR_XILINX,size_energies,    		&d_bank0_ext,	&mem_dockpars_energies_current);	// GA
	mallocBufferObject(context,CL_MEM_WRITE_ONLY | CL_MEM_EXT_PTR_XILINX,size_evals_of_runs,  	&d_bank0_ext,	&mem_evals_performed);			// GA				
	mallocBufferObject(context,CL_MEM_WRITE_ONLY | CL_MEM_EXT_PTR_XILINX,size_evals_of_runs,  	&d_bank0_ext,	&mem_gens_performed);			// GA

	mallocBufferObject(context,CL_MEM_READ_ONLY | CL_MEM_EXT_PTR_XILINX, MAX_NUM_OF_ROTATIONS*sizeof(int), 			&d_bank0_ext/*&d_bank1_ext*/, &mem_KerConstStatic_rotlist_const);			// Conform
	mallocBufferObject(context,CL_MEM_READ_ONLY | CL_MEM_EXT_PTR_XILINX, MAX_NUM_OF_ATOMS*sizeof(cl_float3), 		&d_bank0_ext/*&d_bank1_ext*/, &mem_KerConstStatic_ref_coords_const); 			// Conform
	mallocBufferObject(context,CL_MEM_READ_ONLY | CL_MEM_EXT_PTR_XILINX, MAX_NUM_OF_ROTBONDS*sizeof(cl_float3), 		&d_bank0_ext/*&d_bank1_ext*/, &mem_KerConstStatic_rotbonds_moving_vectors_const);	// Conform
	mallocBufferObject(context,CL_MEM_READ_ONLY | CL_MEM_EXT_PTR_XILINX, MAX_NUM_OF_ROTBONDS*sizeof(cl_float3), 		&d_bank0_ext/*&d_bank1_ext*/, &mem_KerConstStatic_rotbonds_unit_vectors_const);		// Conform
	mallocBufferObject(context,CL_MEM_READ_ONLY | CL_MEM_EXT_PTR_XILINX, MAX_NUM_OF_RUNS*sizeof(cl_float4),			&d_bank0_ext/*&d_bank1_ext*/, &mem_KerConstStatic_ref_orientation_quats_const);		// Conform

	mallocBufferObject(context,CL_MEM_READ_ONLY | CL_MEM_EXT_PTR_XILINX, MAX_NUM_OF_ATOMS*sizeof(float),                    &d_bank1_ext/*&d_bank2_ext*/, &mem_KerConstStatic_InterE_atom_charges_const);	// InterE
  	mallocBufferObject(context,CL_MEM_READ_ONLY | CL_MEM_EXT_PTR_XILINX, MAX_NUM_OF_ATOMS*sizeof(char),                     &d_bank1_ext/*&d_bank2_ext*/, &mem_KerConstStatic_InterE_atom_types_const);	// InterE
	mallocBufferObject(context,CL_MEM_READ_ONLY | CL_MEM_EXT_PTR_XILINX,size_floatgrids,   		&d_bank1_ext/*&d_bank2_ext*/,	&mem_dockpars_fgrids);	// InterE

	mallocBufferObject(context,CL_MEM_READ_ONLY | CL_MEM_EXT_PTR_XILINX, MAX_NUM_OF_ATOMS*sizeof(float),                    &d_bank1_ext/*&d_bank3_ext*/, &mem_KerConstStatic_IntraE_atom_charges_const);	// IntraE
  	mallocBufferObject(context,CL_MEM_READ_ONLY | CL_MEM_EXT_PTR_XILINX, MAX_NUM_OF_ATOMS*sizeof(char),                     &d_bank1_ext/*&d_bank3_ext*/, &mem_KerConstStatic_IntraE_atom_types_const);	// IntraE
	mallocBufferObject(context,CL_MEM_READ_ONLY | CL_MEM_EXT_PTR_XILINX, MAX_INTRAE_CONTRIBUTORS*sizeof(cl_char3),          &d_bank1_ext/*&d_bank3_ext*/, &mem_KerConstStatic_intraE_contributors_const);	// IntraE
        mallocBufferObject(context,CL_MEM_READ_ONLY | CL_MEM_EXT_PTR_XILINX, ATYPE_NUM*sizeof(float),			        &d_bank1_ext/*&d_bank3_ext*/, &mem_KerConstStatic_reqm_const);			// IntraE
	mallocBufferObject(context,CL_MEM_READ_ONLY | CL_MEM_EXT_PTR_XILINX, ATYPE_NUM*sizeof(float),			        &d_bank1_ext/*&d_bank3_ext*/, &mem_KerConstStatic_reqm_hbond_const);		// IntraE
  	mallocBufferObject(context,CL_MEM_READ_ONLY | CL_MEM_EXT_PTR_XILINX, ATYPE_NUM*sizeof(unsigned int),		        &d_bank1_ext/*&d_bank3_ext*/, &mem_KerConstStatic_atom1_types_reqm_const);	// IntraE
  	mallocBufferObject(context,CL_MEM_READ_ONLY | CL_MEM_EXT_PTR_XILINX, ATYPE_NUM*sizeof(unsigned int),                    &d_bank1_ext/*&d_bank3_ext*/, &mem_KerConstStatic_atom2_types_reqm_const);	// IntraE
	mallocBufferObject(context,CL_MEM_READ_ONLY | CL_MEM_EXT_PTR_XILINX, MAX_NUM_OF_ATYPES*MAX_NUM_OF_ATYPES*sizeof(float), &d_bank1_ext/*&d_bank3_ext*/, &mem_KerConstStatic_VWpars_AC_const);		// IntraE
	mallocBufferObject(context,CL_MEM_READ_ONLY | CL_MEM_EXT_PTR_XILINX, MAX_NUM_OF_ATYPES*MAX_NUM_OF_ATYPES*sizeof(float), &d_bank1_ext/*&d_bank3_ext*/, &mem_KerConstStatic_VWpars_BD_const);		// IntraE
	mallocBufferObject(context,CL_MEM_READ_ONLY | CL_MEM_EXT_PTR_XILINX, MAX_NUM_OF_ATYPES*sizeof(float), 		        &d_bank1_ext/*&d_bank3_ext*/, &mem_KerConstStatic_dspars_S_const);		// IntraE
	mallocBufferObject(context,CL_MEM_READ_ONLY | CL_MEM_EXT_PTR_XILINX, MAX_NUM_OF_ATYPES*sizeof(float), 			&d_bank1_ext/*&d_bank3_ext*/, &mem_KerConstStatic_dspars_V_const);		// IntraE
	// -----------------------------------------------------------------------------------------------------

	memcopyBufferObjectToDevice(command_queue_ga,mem_KerConstStatic_InterE_atom_charges_const,            &KerConstStatic.atom_charges_const[0],            MAX_NUM_OF_ATOMS*sizeof(float));
	memcopyBufferObjectToDevice(command_queue_ga,mem_KerConstStatic_InterE_atom_types_const,              &KerConstStatic.atom_types_const[0],              MAX_NUM_OF_ATOMS*sizeof(char));
	memcopyBufferObjectToDevice(command_queue_ga,mem_KerConstStatic_IntraE_atom_charges_const,            &KerConstStatic.atom_charges_const[0],            MAX_NUM_OF_ATOMS*sizeof(float));
	memcopyBufferObjectToDevice(command_queue_ga,mem_KerConstStatic_IntraE_atom_types_const,              &KerConstStatic.atom_types_const[0],              MAX_NUM_OF_ATOMS*sizeof(char));
	memcopyBufferObjectToDevice(command_queue_ga,mem_KerConstStatic_intraE_contributors_const,     	      &KerConstStatic.intraE_contributors_const[0],     MAX_INTRAE_CONTRIBUTORS*sizeof(cl_char3));

	memcopyBufferObjectToDevice(command_queue_ga,mem_KerConstStatic_reqm_const,         	       &KerConstStatic.reqm_const,           	           ATYPE_NUM*sizeof(float));
  	memcopyBufferObjectToDevice(command_queue_ga,mem_KerConstStatic_reqm_hbond_const,              &KerConstStatic.reqm_hbond_const,                 ATYPE_NUM*sizeof(float));
  	memcopyBufferObjectToDevice(command_queue_ga,mem_KerConstStatic_atom1_types_reqm_const,        &KerConstStatic.atom1_types_reqm_const,           ATYPE_NUM*sizeof(unsigned int));
  	memcopyBufferObjectToDevice(command_queue_ga,mem_KerConstStatic_atom2_types_reqm_const,        &KerConstStatic.atom2_types_reqm_const,           ATYPE_NUM*sizeof(unsigned int));

	memcopyBufferObjectToDevice(command_queue_ga,mem_KerConstStatic_VWpars_AC_const,               &KerConstStatic.VWpars_AC_const[0],               MAX_NUM_OF_ATYPES*MAX_NUM_OF_ATYPES*sizeof(float));
	memcopyBufferObjectToDevice(command_queue_ga,mem_KerConstStatic_VWpars_BD_const,               &KerConstStatic.VWpars_BD_const[0],               MAX_NUM_OF_ATYPES*MAX_NUM_OF_ATYPES*sizeof(float));
	memcopyBufferObjectToDevice(command_queue_ga,mem_KerConstStatic_dspars_S_const,                &KerConstStatic.dspars_S_const[0], 	       MAX_NUM_OF_ATYPES*sizeof(float));
	memcopyBufferObjectToDevice(command_queue_ga,mem_KerConstStatic_dspars_V_const,                &KerConstStatic.dspars_V_const[0], 	       MAX_NUM_OF_ATYPES*sizeof(float));
	memcopyBufferObjectToDevice(command_queue_ga,mem_KerConstStatic_rotlist_const,                 &KerConstStatic.rotlist_const[0], 		       MAX_NUM_OF_ROTATIONS*sizeof(int));
	memcopyBufferObjectToDevice(command_queue_ga,mem_KerConstStatic_ref_coords_const, 	       &KerConstStatic.ref_coords_const[0],              MAX_NUM_OF_ATOMS*sizeof(cl_float3));
	memcopyBufferObjectToDevice(command_queue_ga,mem_KerConstStatic_rotbonds_moving_vectors_const, &KerConstStatic.rotbonds_moving_vectors_const[0], MAX_NUM_OF_ROTBONDS*sizeof(cl_float3));
	memcopyBufferObjectToDevice(command_queue_ga,mem_KerConstStatic_rotbonds_unit_vectors_const,   &KerConstStatic.rotbonds_unit_vectors_const[0],   MAX_NUM_OF_ROTBONDS*sizeof(cl_float3));
	memcopyBufferObjectToDevice(command_queue_ga,mem_KerConstStatic_ref_orientation_quats_const,   &KerConstStatic.ref_orientation_quats_const[0],   MAX_NUM_OF_RUNS*sizeof(cl_float4));
	memcopyBufferObjectToDevice(command_queue_ga,mem_dockpars_fgrids, 	cpu_floatgrids,       size_floatgrids);


	clock_start_docking = clock();

	int narg;
	#ifdef ENABLE_KRNL_GA
	narg = 0;
	kernel_ga.setArg(narg++, mem_dockpars_conformations_current);
	kernel_ga.setArg(narg++, mem_dockpars_energies_current);
	kernel_ga.setArg(narg++, mem_evals_performed);
	kernel_ga.setArg(narg++, mem_gens_performed);
	kernel_ga.setArg(narg++, dockpars.pop_size);
	kernel_ga.setArg(narg++, dockpars.num_of_energy_evals);
	kernel_ga.setArg(narg++, dockpars.num_of_generations);
	kernel_ga.setArg(narg++, dockpars.tournament_rate);
	kernel_ga.setArg(narg++, dockpars.mutation_rate);
	kernel_ga.setArg(narg++, dockpars.abs_max_dmov);
	kernel_ga.setArg(narg++, dockpars.abs_max_dang);
	kernel_ga.setArg(narg++, two_absmaxdmov);
	kernel_ga.setArg(narg++, two_absmaxdang);
	kernel_ga.setArg(narg++, dockpars.crossover_rate);
	kernel_ga.setArg(narg++, dockpars.num_of_lsentities);
	kernel_ga.setArg(narg++, dockpars.num_of_genes);
	#endif

	#ifdef ENABLE_KRNL_CONFORM
	narg = 0;
	kernel_conform.setArg(narg++, mem_KerConstStatic_rotlist_const);
	kernel_conform.setArg(narg++, mem_KerConstStatic_ref_coords_const);
	kernel_conform.setArg(narg++, mem_KerConstStatic_rotbonds_moving_vectors_const);
	kernel_conform.setArg(narg++, mem_KerConstStatic_rotbonds_unit_vectors_const);
	kernel_conform.setArg(narg++, dockpars.rotbondlist_length);
	kernel_conform.setArg(narg++, dockpars.num_of_atoms);
	kernel_conform.setArg(narg++, dockpars.num_of_genes);
	kernel_conform.setArg(narg++, mem_KerConstStatic_ref_orientation_quats_const);
	kernel_conform.setArg(narg++, KerConstDynamic.ref_orientation_quats_const[0]);
	kernel_conform.setArg(narg++, KerConstDynamic.ref_orientation_quats_const[1]);
	kernel_conform.setArg(narg++, KerConstDynamic.ref_orientation_quats_const[2]);
	kernel_conform.setArg(narg++, KerConstDynamic.ref_orientation_quats_const[3]);	
	#endif

	unsigned char gridsizex_minus1 = dockpars.gridsize_x - 1;
	unsigned char gridsizey_minus1 = dockpars.gridsize_y - 1;
	unsigned char gridsizez_minus1 = dockpars.gridsize_z - 1;
	float fgridsizex_minus1 = (float) gridsizex_minus1;
	float fgridsizey_minus1 = (float) gridsizey_minus1;
	float fgridsizez_minus1 = (float) gridsizez_minus1;

	#ifdef ENABLE_KRNL_INTERE
	narg = 0;
	kernel_intere.setArg(narg++, mem_dockpars_fgrids);
	kernel_intere.setArg(narg++, mem_KerConstStatic_InterE_atom_charges_const);
	kernel_intere.setArg(narg++, mem_KerConstStatic_InterE_atom_types_const);
	kernel_intere.setArg(narg++, dockpars.g1);
	kernel_intere.setArg(narg++, dockpars.g2);
	kernel_intere.setArg(narg++, dockpars.g3);
	kernel_intere.setArg(narg++, dockpars.num_of_atoms);
	kernel_intere.setArg(narg++, fgridsizex_minus1);
	kernel_intere.setArg(narg++, fgridsizey_minus1);
	kernel_intere.setArg(narg++, fgridsizez_minus1);
	kernel_intere.setArg(narg++, mul_tmp2);
	kernel_intere.setArg(narg++, mul_tmp3);
	#endif

	#ifdef ENABLE_KRNL_INTRAE
	narg = 0;
	kernel_intrae.setArg(narg++, mem_KerConstStatic_IntraE_atom_charges_const);
	kernel_intrae.setArg(narg++, mem_KerConstStatic_IntraE_atom_types_const);
	kernel_intrae.setArg(narg++, mem_KerConstStatic_intraE_contributors_const);
	kernel_intrae.setArg(narg++, dockpars.smooth);
	kernel_intrae.setArg(narg++, mem_KerConstStatic_reqm_const);
	kernel_intrae.setArg(narg++, mem_KerConstStatic_reqm_hbond_const);
	kernel_intrae.setArg(narg++, mem_KerConstStatic_atom1_types_reqm_const);
	kernel_intrae.setArg(narg++, mem_KerConstStatic_atom2_types_reqm_const);
	kernel_intrae.setArg(narg++, mem_KerConstStatic_VWpars_AC_const);
	kernel_intrae.setArg(narg++, mem_KerConstStatic_VWpars_BD_const);
	kernel_intrae.setArg(narg++, mem_KerConstStatic_dspars_S_const);
	kernel_intrae.setArg(narg++, mem_KerConstStatic_dspars_V_const);
	kernel_intrae.setArg(narg++, dockpars.num_of_atoms);
	kernel_intrae.setArg(narg++, dockpars.num_of_intraE_contributors);
	kernel_intrae.setArg(narg++, dockpars.grid_spacing);
	kernel_intrae.setArg(narg++, dockpars.num_of_atypes);
	kernel_intrae.setArg(narg++, dockpars.coeff_elec);
	kernel_intrae.setArg(narg++, dockpars.qasp);
	kernel_intrae.setArg(narg++, dockpars.coeff_desolv);
	#endif

	#ifdef ENABLE_KRNL_PRNG_BT_USHORT_FLOAT
	setKernelArg(kernel_prng_bt_ushort_float,2, sizeof(unsigned int),  &dockpars.pop_size);

	#if !defined(SW_EMU)
	setKernelArg(kernel_prng_bt_ushort_float,3, sizeof(mem_dummy),   &mem_dummy);
	#endif
	#endif // End of ENABLE_KRNL_PRNG_BT_USHORT_FLOAT

	#ifdef ENABLE_KRNL_PRNG_GG_UCHAR
	setKernelArg(kernel_prng_gg_uchar,1, sizeof(unsigned char),  &dockpars.num_of_genes);

	#if !defined(SW_EMU)
	setKernelArg(kernel_prng_gg_uchar,2, sizeof(mem_dummy),   &mem_dummy);
	#endif
	#endif // End of ENABLE_KRNL_PRNG_GG_UCHAR

	#ifdef ENABLE_KRNL_PRNG_GG_FLOAT
	setKernelArg(kernel_prng_gg_float,1, sizeof(unsigned char),  &dockpars.num_of_genes);

	#if !defined(SW_EMU)
	setKernelArg(kernel_prng_gg_float,2, sizeof(mem_dummy),   &mem_dummy);
	#endif
	#endif // End of ENABLE_KRNL_PRNG_GG_FLOAT

	#ifdef ENABLE_KRNL_PRNG_LS123_USHORT
	setKernelArg(kernel_prng_ls123_ushort,9, sizeof(unsigned int),  &dockpars.pop_size);

	#if !defined(SW_EMU)
	setKernelArg(kernel_prng_ls123_ushort,10, sizeof(mem_dummy),   &mem_dummy);
	#endif
	#endif // End of ENABLE_KRNL_PRNG_LS123_USHORT

	#ifdef ENABLE_KRNL_PRNG_LS_FLOAT
	setKernelArg(kernel_prng_ls_float,1, sizeof(unsigned char),  &dockpars.num_of_genes);

	#if !defined(SW_EMU)
	setKernelArg(kernel_prng_ls_float,2, sizeof(mem_dummy),   &mem_dummy);
	#endif
	#endif // End of ENABLE_KRNL_PRNG_LS_FLOAT

	#ifdef ENABLE_KRNL_PRNG_LS2_FLOAT
	setKernelArg(kernel_prng_ls2_float,1, sizeof(unsigned char),  &dockpars.num_of_genes);

	#if !defined(SW_EMU)
	setKernelArg(kernel_prng_ls2_float,2, sizeof(mem_dummy),   &mem_dummy);
	#endif
	#endif // End of ENABLE_KRNL_PRNG_LS2_FLOAT

	#ifdef ENABLE_KRNL_PRNG_LS3_FLOAT
	setKernelArg(kernel_prng_ls3_float,1, sizeof(unsigned char),  &dockpars.num_of_genes);

	#if !defined(SW_EMU)
	setKernelArg(kernel_prng_ls3_float,2, sizeof(mem_dummy),   &mem_dummy);
	#endif
	#endif // End of ENABLE_KRNL_PRNG_LS3_FLOAT

	#ifdef ENABLE_KRNL_PRNG_LS4_FLOAT
	setKernelArg(kernel_prng_ls4_float,1, sizeof(unsigned char),  &dockpars.num_of_genes);

	#if !defined(SW_EMU)
	setKernelArg(kernel_prng_ls4_float,2, sizeof(mem_dummy),   &mem_dummy);
	#endif
	#endif // End of ENABLE_KRNL_PRNG_LS4_FLOAT

	#ifdef ENABLE_KRNL_PRNG_LS5_FLOAT
	setKernelArg(kernel_prng_ls5_float,1, sizeof(unsigned char),  &dockpars.num_of_genes);

	#if !defined(SW_EMU)
	setKernelArg(kernel_prng_ls5_float,2, sizeof(mem_dummy),   &mem_dummy);
	#endif
	#endif // End of ENABLE_KRNL_PRNG_LS5_FLOAT

	#ifdef ENABLE_KRNL_PRNG_LS6_FLOAT
	setKernelArg(kernel_prng_ls6_float,1, sizeof(unsigned char),  &dockpars.num_of_genes);

	#if !defined(SW_EMU)
	setKernelArg(kernel_prng_ls6_float,2, sizeof(mem_dummy),   &mem_dummy);
	#endif
	#endif // End of ENABLE_KRNL_PRNG_LS6_FLOAT

	#ifdef ENABLE_KRNL_PRNG_LS7_FLOAT
	setKernelArg(kernel_prng_ls7_float,1, sizeof(unsigned char),  &dockpars.num_of_genes);

	#if !defined(SW_EMU)
	setKernelArg(kernel_prng_ls7_float,2, sizeof(mem_dummy),   &mem_dummy);
	#endif
	#endif // End of ENABLE_KRNL_PRNG_LS7_FLOAT

	#ifdef ENABLE_KRNL_PRNG_LS8_FLOAT
	setKernelArg(kernel_prng_ls8_float,1, sizeof(unsigned char),  &dockpars.num_of_genes);

	#if !defined(SW_EMU)
	setKernelArg(kernel_prng_ls8_float,2, sizeof(mem_dummy),   &mem_dummy);
	#endif
	#endif // End of ENABLE_KRNL_PRNG_LS8_FLOAT

	#ifdef ENABLE_KRNL_PRNG_LS9_FLOAT
	setKernelArg(kernel_prng_ls9_float,1, sizeof(unsigned char),  &dockpars.num_of_genes);

	#if !defined(SW_EMU)
	setKernelArg(kernel_prng_ls9_float,2, sizeof(mem_dummy),   &mem_dummy);
	#endif
	#endif // End of ENABLE_KRNL_PRNG_LS9_FLOAT

	unsigned short Host_max_num_of_iters = (unsigned short)dockpars.max_num_of_iters;
	unsigned char  Host_cons_limit       = (unsigned char) dockpars.cons_limit;

	#if !defined(SW_EMU)

	#endif

	#ifdef ENABLE_KRNL_LS
	setKernelArg(kernel_ls,0, sizeof(unsigned short),  	&Host_max_num_of_iters);
	setKernelArg(kernel_ls,1, sizeof(float),  		&dockpars.rho_lower_bound);
	setKernelArg(kernel_ls,2, sizeof(float),  		&dockpars.base_dmov_mul_sqrt3);
	setKernelArg(kernel_ls,3, sizeof(unsigned char), 	&dockpars.num_of_genes);
	setKernelArg(kernel_ls,4, sizeof(float),  		&dockpars.base_dang_mul_sqrt3);
	setKernelArg(kernel_ls,5, sizeof(unsigned char),   	&Host_cons_limit);
	#if !defined(SW_EMU)
	setKernelArg(kernel_ls,6, sizeof(mem_dummy),   		&mem_dummy);
	#endif
	#endif // End of ENABLE_KRNL_LS

	#ifdef ENABLE_KRNL_LS2
	setKernelArg(kernel_ls2,0, sizeof(unsigned short),  	&Host_max_num_of_iters);
	setKernelArg(kernel_ls2,1, sizeof(float),  		&dockpars.rho_lower_bound);
	setKernelArg(kernel_ls2,2, sizeof(float),  		&dockpars.base_dmov_mul_sqrt3);
	setKernelArg(kernel_ls2,3, sizeof(unsigned char), 	&dockpars.num_of_genes);
	setKernelArg(kernel_ls2,4, sizeof(float),  		&dockpars.base_dang_mul_sqrt3);
	setKernelArg(kernel_ls2,5, sizeof(unsigned char),   	&Host_cons_limit);
	#if !defined(SW_EMU)
	setKernelArg(kernel_ls2,6, sizeof(mem_dummy),   	&mem_dummy);
	#endif
	#endif // End of ENABLE_KRNL_LS2

	#ifdef ENABLE_KRNL_LS3
	setKernelArg(kernel_ls3,0, sizeof(unsigned short),  	&Host_max_num_of_iters);
	setKernelArg(kernel_ls3,1, sizeof(float),  		&dockpars.rho_lower_bound);
	setKernelArg(kernel_ls3,2, sizeof(float),  		&dockpars.base_dmov_mul_sqrt3);
	setKernelArg(kernel_ls3,3, sizeof(unsigned char), 	&dockpars.num_of_genes);
	setKernelArg(kernel_ls3,4, sizeof(float),  		&dockpars.base_dang_mul_sqrt3);
	setKernelArg(kernel_ls3,5, sizeof(unsigned char),   	&Host_cons_limit);
	#if !defined(SW_EMU)
	setKernelArg(kernel_ls3,6, sizeof(mem_dummy),   	&mem_dummy);
	#endif
	#endif // End of ENABLE_KRNL_LS3

	#ifdef ENABLE_KRNL_LS4
	setKernelArg(kernel_ls4,0, sizeof(unsigned short),  	&Host_max_num_of_iters);
	setKernelArg(kernel_ls4,1, sizeof(float),  	  	&dockpars.rho_lower_bound);
	setKernelArg(kernel_ls4,2, sizeof(float),  	  	&dockpars.base_dmov_mul_sqrt3);
	setKernelArg(kernel_ls4,3, sizeof(unsigned char),   	&dockpars.num_of_genes);
	setKernelArg(kernel_ls4,4, sizeof(float),  	  	&dockpars.base_dang_mul_sqrt3);
	setKernelArg(kernel_ls4,5, sizeof(unsigned char),   	&Host_cons_limit);
	#if !defined(SW_EMU)
	setKernelArg(kernel_ls4,6, sizeof(mem_dummy),   	&mem_dummy);
	#endif
	#endif // End of ENABLE_KRNL_LS4

	#ifdef ENABLE_KRNL_LS5
	setKernelArg(kernel_ls5,0, sizeof(unsigned short),  	&Host_max_num_of_iters);
	setKernelArg(kernel_ls5,1, sizeof(float),  	  	&dockpars.rho_lower_bound);
	setKernelArg(kernel_ls5,2, sizeof(float),  	  	&dockpars.base_dmov_mul_sqrt3);
	setKernelArg(kernel_ls5,3, sizeof(unsigned char),   	&dockpars.num_of_genes);
	setKernelArg(kernel_ls5,4, sizeof(float),  	  	&dockpars.base_dang_mul_sqrt3);
	setKernelArg(kernel_ls5,5, sizeof(unsigned char),  	&Host_cons_limit);
	#if !defined(SW_EMU)
	setKernelArg(kernel_ls5,6, sizeof(mem_dummy),   	&mem_dummy);
	#endif
	#endif // End of ENABLE_KRNL_LS5

	#ifdef ENABLE_KRNL_LS6
	setKernelArg(kernel_ls6,0, sizeof(unsigned short),  	&Host_max_num_of_iters);
	setKernelArg(kernel_ls6,1, sizeof(float),  	  	&dockpars.rho_lower_bound);
	setKernelArg(kernel_ls6,2, sizeof(float),  	  	&dockpars.base_dmov_mul_sqrt3);
	setKernelArg(kernel_ls6,3, sizeof(unsigned char),   	&dockpars.num_of_genes);
	setKernelArg(kernel_ls6,4, sizeof(float),  	  	&dockpars.base_dang_mul_sqrt3);
	setKernelArg(kernel_ls6,5, sizeof(unsigned char),   	&Host_cons_limit);
	#if !defined(SW_EMU)
	setKernelArg(kernel_ls6,6, sizeof(mem_dummy),   	&mem_dummy);
	#endif
	#endif // End of ENABLE_KRNL_LS6

	#ifdef ENABLE_KRNL_LS7
	setKernelArg(kernel_ls7,0, sizeof(unsigned short),  	&Host_max_num_of_iters);
	setKernelArg(kernel_ls7,1, sizeof(float),  	  	&dockpars.rho_lower_bound);
	setKernelArg(kernel_ls7,2, sizeof(float),  	  	&dockpars.base_dmov_mul_sqrt3);
	setKernelArg(kernel_ls7,3, sizeof(unsigned char),   	&dockpars.num_of_genes);
	setKernelArg(kernel_ls7,4, sizeof(float),  	  	&dockpars.base_dang_mul_sqrt3);
	setKernelArg(kernel_ls7,5, sizeof(unsigned char),   	&Host_cons_limit);
	#if !defined(SW_EMU)
	setKernelArg(kernel_ls7,6, sizeof(mem_dummy),   	&mem_dummy);
	#endif
	#endif // End of ENABLE_KRNL_LS7

	#ifdef ENABLE_KRNL_LS8
	setKernelArg(kernel_ls8,0, sizeof(unsigned short),  	&Host_max_num_of_iters);
	setKernelArg(kernel_ls8,1, sizeof(float),  	  	&dockpars.rho_lower_bound);
	setKernelArg(kernel_ls8,2, sizeof(float),  	  	&dockpars.base_dmov_mul_sqrt3);
	setKernelArg(kernel_ls8,3, sizeof(unsigned char),   	&dockpars.num_of_genes);
	setKernelArg(kernel_ls8,4, sizeof(float),  	  	&dockpars.base_dang_mul_sqrt3);
	setKernelArg(kernel_ls8,5, sizeof(unsigned char),   	&Host_cons_limit);
	#if !defined(SW_EMU)
	setKernelArg(kernel_ls8,6, sizeof(mem_dummy),   	&mem_dummy);
	#endif
	#endif // End of ENABLE_KRNL_LS8

	#ifdef ENABLE_KRNL_LS9
	setKernelArg(kernel_ls9,0, sizeof(unsigned short),  	&Host_max_num_of_iters);
	setKernelArg(kernel_ls9,1, sizeof(float),  	  	&dockpars.rho_lower_bound);
	setKernelArg(kernel_ls9,2, sizeof(float),  	  	&dockpars.base_dmov_mul_sqrt3);
	setKernelArg(kernel_ls9,3, sizeof(unsigned char),   	&dockpars.num_of_genes);
	setKernelArg(kernel_ls9,4, sizeof(float),  	 	&dockpars.base_dang_mul_sqrt3);
	setKernelArg(kernel_ls9,5, sizeof(unsigned char),   	&Host_cons_limit);
	#if !defined(SW_EMU)
	setKernelArg(kernel_ls9,6, sizeof(mem_dummy),   	&mem_dummy);
	#endif
	#endif // End of ENABLE_KRNL_LS9

	#ifdef ENABLE_KRNL_IGL_ARBITER
	#if !defined(SW_EMU)
	setKernelArg(kernel_igl_arbiter,0, sizeof(mem_dummy),   &mem_dummy);
	#endif
	#endif // End of ENABLE_KRNL_IGL_ARBITER

	memcopyBufferObjectToDevice(command_queue_ga,mem_dockpars_conformations_current, 	cpu_init_populations, size_populations);

	printf("Docking runs to be executed: %u\n", mypars->num_of_runs); 
	printf("Execution run: ");

	for (unsigned int run_cnt = 0; run_cnt < mypars->num_of_runs; run_cnt++)
	{
		printf(" %u", run_cnt+1); 
		fflush(stdout);

		#ifdef ENABLE_KRNL_GA
		unsigned int Host_Offset_Pop = run_cnt * dockpars.pop_size * ACTUAL_GENOTYPE_LENGTH;
		unsigned int Host_Offset_Ene = run_cnt * dockpars.pop_size;
		setKernelArg(kernel_ga,16,  sizeof(unsigned short), &run_cnt);
		setKernelArg(kernel_ga,17,  sizeof(unsigned int),   &Host_Offset_Pop);
		setKernelArg(kernel_ga,18,  sizeof(unsigned int),   &Host_Offset_Ene);
		#endif

		#ifdef ENABLE_KRNL_CONFORM
		setKernelArg(kernel_conform,8,  sizeof(unsigned short), &run_cnt);
		#endif // End of ENABLE_KRNL_CONFORM

		#ifdef ENABLE_KRNL_PRNG_BT_USHORT_FLOAT
		setKernelArg(kernel_prng_bt_ushort_float,0, sizeof(unsigned int),   &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 14]);
		setKernelArg(kernel_prng_bt_ushort_float,1, sizeof(unsigned int),   &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 15]);
		#endif // End of ENABLE_KRNL_PRNG_BT_USHORT_FLOAT

		#ifdef ENABLE_KRNL_PRNG_GG_UCHAR
		setKernelArg(kernel_prng_gg_uchar,0, sizeof(unsigned int),   &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 2]);
		#endif // End of ENABLE_KRNL_PRNG_GG_UCHAR

		#ifdef ENABLE_KRNL_PRNG_GG_FLOAT
		setKernelArg(kernel_prng_gg_float,0, sizeof(unsigned int),   &cpu_prng_seeds[num_of_prng_blocks * run_cnt]);
		#endif // End of ENABLE_KRNL_PRNG_GG_FLOAT

		#ifdef ENABLE_KRNL_PRNG_LS123_USHORT
		setKernelArg(kernel_prng_ls123_ushort,0, sizeof(unsigned int),   &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 5]);
		setKernelArg(kernel_prng_ls123_ushort,1, sizeof(unsigned int),   &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 6]);
		setKernelArg(kernel_prng_ls123_ushort,2, sizeof(unsigned int),   &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 7]);
		setKernelArg(kernel_prng_ls123_ushort,3, sizeof(unsigned int),   &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 8]);
		setKernelArg(kernel_prng_ls123_ushort,4, sizeof(unsigned int),   &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 9]);
		setKernelArg(kernel_prng_ls123_ushort,5, sizeof(unsigned int),   &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 10]);
		setKernelArg(kernel_prng_ls123_ushort,6, sizeof(unsigned int),   &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 11]);
		setKernelArg(kernel_prng_ls123_ushort,7, sizeof(unsigned int),   &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 12]);
		setKernelArg(kernel_prng_ls123_ushort,8, sizeof(unsigned int),   &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 13]);
		#endif // End of ENABLE_KRNL_PRNG_LS123_USHORT

		#ifdef ENABLE_KRNL_PRNG_LS_FLOAT
		setKernelArg(kernel_prng_ls_float,0, sizeof(unsigned int),   &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 1]);
		#endif // End of ENABLE_KRNL_PRNG_LS_FLOAT

		#ifdef ENABLE_KRNL_PRNG_LS2_FLOAT
		setKernelArg(kernel_prng_ls2_float,0, sizeof(unsigned int),   &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 3]);
		#endif // End of ENABLE_KRNL_PRNG_LS2_FLOAT

		#ifdef ENABLE_KRNL_PRNG_LS3_FLOAT
		setKernelArg(kernel_prng_ls3_float,0, sizeof(unsigned int),   &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 4]);
		#endif // End of ENABLE_KRNL_PRNG_LS3_FLOAT

		#ifdef ENABLE_KRNL_PRNG_LS4_FLOAT
		setKernelArg(kernel_prng_ls4_float,0, sizeof(unsigned int),   &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 16]);
		#endif // End of ENABLE_KRNL_PRNG_LS4_FLOAT

		#ifdef ENABLE_KRNL_PRNG_LS5_FLOAT
		setKernelArg(kernel_prng_ls5_float,0, sizeof(unsigned int),   &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 17]);
		#endif // End of ENABLE_KRNL_PRNG_LS5_FLOAT

		#ifdef ENABLE_KRNL_PRNG_LS6_FLOAT
		setKernelArg(kernel_prng_ls6_float,0, sizeof(unsigned int),   &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 18]);
		#endif // End of ENABLE_KRNL_PRNG_LS6_FLOAT

		#ifdef ENABLE_KRNL_PRNG_LS7_FLOAT
		setKernelArg(kernel_prng_ls7_float,0, sizeof(unsigned int),   &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 19]);
		#endif // End of ENABLE_KRNL_PRNG_LS7_FLOAT

		#ifdef ENABLE_KRNL_PRNG_LS8_FLOAT
		setKernelArg(kernel_prng_ls8_float,0, sizeof(unsigned int),   &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 20]);
		#endif // End of ENABLE_KRNL_PRNG_LS8_FLOAT

		#ifdef ENABLE_KRNL_PRNG_LS9_FLOAT
		setKernelArg(kernel_prng_ls9_float,0, sizeof(unsigned int),   &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 21]);
		#endif // End of ENABLE_KRNL_PRNG_LS9_FLOAT

		#ifdef ENABLE_KRNL_GA
		command_queue_ga.enqueueTask(kernel_ga);
		#endif
		#ifdef ENABLE_KRNL_CONFORM
		command_queue_conform.enqueueTask(kernel_conform);
		#endif
		#ifdef ENABLE_KRNL_INTERE
		command_queue_intere.enqueueTask(kernel_intere);
		#endif
		#ifdef ENABLE_KRNL_INTRAE
		command_queue_intrae.enqueueTask(kernel_intrae);
		#endif
		#ifdef ENABLE_KRNL_PRNG_BT_USHORT_FLOAT
		command_queue_prng_bt_ushort_float.enqueueTask(kernel_prng_bt_ushort_float);
		#endif
		#ifdef ENABLE_KRNL_PRNG_GG_UCHAR
		command_queue_prng_gg_uchar.enqueueTask(kernel_prng_gg_uchar);
		#endif
		#ifdef ENABLE_KRNL_PRNG_GG_FLOAT
		command_queue_prng_gg_float.enqueueTask(kernel_prng_gg_float);
		#endif
		#ifdef ENABLE_KRNL_PRNG_LS123_USHORT
		command_queue_prng_ls123_ushort.enqueueTask(kernel_prng_ls123_ushort);
		#endif
		#ifdef ENABLE_KRNL_PRNG_LS_FLOAT
		command_queue_prng_ls_float.enqueueTask(kernel_prng_ls_float);
		#endif
		#ifdef ENABLE_KRNL_PRNG_LS2_FLOAT
		command_queue_prng_ls2_float.enqueueTask(kernel_prng_ls2_float);
		#endif
		#ifdef ENABLE_KRNL_PRNG_LS3_FLOAT
		command_queue_prng_ls3_float.enqueueTask(kernel_prng_ls3_float);
		#endif
		#ifdef ENABLE_KRNL_PRNG_LS4_FLOAT
		command_queue_prng_ls4_float.enqueueTask(kernel_prng_ls4_float);
		#endif
		#ifdef ENABLE_KRNL_PRNG_LS5_FLOAT
		command_queue_prng_ls5_float.enqueueTask(kernel_prng_ls5_float);
		#endif
		#ifdef ENABLE_KRNL_PRNG_LS6_FLOAT
		command_queue_prng_ls6_float.enqueueTask(kernel_prng_ls6_float);
		#endif
		#ifdef ENABLE_KRNL_PRNG_LS7_FLOAT
		command_queue_prng_ls7_float.enqueueTask(kernel_prng_ls7_float);
		#endif
		#ifdef ENABLE_KRNL_PRNG_LS8_FLOAT
		command_queue_prng_ls8_float.enqueueTask(kernel_prng_ls8_float);
		#endif
		#ifdef ENABLE_KRNL_PRNG_LS9_FLOAT
		command_queue_prng_ls9_float.enqueueTask(kernel_prng_ls9_float);
		#endif
		#ifdef ENABLE_KRNL_LS
		command_queue_ls.enqueueTask(kernel_ls);
		#endif
		#ifdef ENABLE_KRNL_LS2
		command_queue_ls2.enqueueTask(kernel_ls2);
		#endif
		#ifdef ENABLE_KRNL_LS3
		command_queue_ls3.enqueueTask(kernel_ls3);
		#endif
		#ifdef ENABLE_KRNL_LS4
		command_queue_ls4.enqueueTask(kernel_ls4);
		#endif
		#ifdef ENABLE_KRNL_LS5
		command_queue_ls5.enqueueTask(kernel_ls5);
		#endif
		#ifdef ENABLE_KRNL_LS6
		command_queue_ls6.enqueueTask(kernel_ls6);
		#endif
		#ifdef ENABLE_KRNL_LS7
		command_queue_ls7.enqueueTask(kernel_ls7);
		#endif
		#ifdef ENABLE_KRNL_LS8
		command_queue_ls8.enqueueTask(kernel_ls8);
		#endif
		#ifdef ENABLE_KRNL_LS9
		command_queue_ls9.enqueueTask(kernel_ls9);
		#endif
		#ifdef ENABLE_KRNL_IGL_ARBITER
		command_queue_igl_arbiter.enqueueTask(kernel_igl_arbiter);
		#endif

		#ifdef ENABLE_KRNL_GA	
		command_queue_ga.finish(); 
		#endif
		#ifdef ENABLE_KRNL_CONFORM	
		command_queue_conform.finish(); 
		#endif
		#ifdef ENABLE_KRNL_INTERE	
		command_queue_intere.finish(); 
		#endif
		#ifdef ENABLE_KRNL_INTRAE	
		command_queue_intrae.finish(); 
		#endif
		#ifdef ENABLE_KRNL_PRNG_BT_USHORT_FLOAT
		command_queue_prng_bt_ushort_float.finish();
		#endif
		#ifdef ENABLE_KRNL_PRNG_GG_UCHAR
		command_queue_prng_gg_uchar.finish();
		#endif
		#ifdef ENABLE_KRNL_PRNG_GG_FLOAT
		command_queue_prng_gg_float.finish(); 
		#endif
		#ifdef ENABLE_KRNL_PRNG_LS123_USHORT
		command_queue_prng_ls123_ushort.finish();
		#endif
		#ifdef ENABLE_KRNL_PRNG_LS_FLOAT
		command_queue_prng_ls_float.finish();
		#endif
		#ifdef ENABLE_KRNL_PRNG_LS2_FLOAT
		command_queue_prng_ls2_float.finish();
		#endif
		#ifdef ENABLE_KRNL_PRNG_LS3_FLOAT
		command_queue_prng_ls3_float.finish();
		#endif
		#ifdef ENABLE_KRNL_PRNG_LS4_FLOAT
		command_queue_prng_ls4_float.finish();
		#endif
		#ifdef ENABLE_KRNL_PRNG_LS5_FLOAT
		command_queue_prng_ls5_float.finish();
		#endif
		#ifdef ENABLE_KRNL_PRNG_LS6_FLOAT
		command_queue_prng_ls6_float.finish();
		#endif
		#ifdef ENABLE_KRNL_PRNG_LS7_FLOAT
		command_queue_prng_ls7_float.finish();
		#endif
		#ifdef ENABLE_KRNL_PRNG_LS8_FLOAT
		command_queue_prng_ls8_float.finish();
		#endif
		#ifdef ENABLE_KRNL_PRNG_LS9_FLOAT
		command_queue_prng_ls9_float.finish();
		#endif
		#ifdef ENABLE_KRNL_LS
		command_queue_ls.finish();
		#endif
		#ifdef ENABLE_KRNL_LS2
		command_queue_ls2.finish();
		#endif
		#ifdef ENABLE_KRNL_LS3
		command_queue_ls3.finish();
		#endif
		#ifdef ENABLE_KRNL_LS4
		command_queue_ls4.finish();
		#endif
		#ifdef ENABLE_KRNL_LS5
		command_queue_ls5.finish();
		#endif
		#ifdef ENABLE_KRNL_LS6
		command_queue_ls6.finish();
		#endif
		#ifdef ENABLE_KRNL_LS7
		command_queue_ls7.finish();
		#endif
		#ifdef ENABLE_KRNL_LS8
		command_queue_ls8.finish();
		#endif
		#ifdef ENABLE_KRNL_LS9
		command_queue_ls9.finish();
		#endif
		#ifdef ENABLE_KRNL_IGL_ARBITER
		command_queue_igl_arbiter.finish();
		#endif

		clock_stop_docking = clock();

	} // End of for (run_cnt = 0; run_cnt < mypars->num_of_runs; run_cnt++)


	printf("\n"); 

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


// Free the resources allocated during initialization
void cleanup() {
#ifdef ENABLE_KRNL_GA
  if(kernel_ga) {clReleaseKernel(kernel_ga);}
  if(command_queue_ga) {clReleaseCommandQueue(command_queue_ga);}
#endif

#ifdef ENABLE_KRNL_CONFORM
  if(kernel_conform) {clReleaseKernel(kernel_conform);}
  if(command_queue_conform) {clReleaseCommandQueue(command_queue_conform);}
#endif

#ifdef ENABLE_KRNL_INTERE
  if(kernel_intere) {clReleaseKernel(kernel_intere);}
  if(command_queue_intere) {clReleaseCommandQueue(command_queue_intere);}
#endif

#ifdef ENABLE_KRNL_INTRAE
  if(kernel_intrae) {clReleaseKernel(kernel_intrae);}
  if(command_queue_intrae) {clReleaseCommandQueue(command_queue_intrae);}
#endif

#ifdef ENABLE_KRNL_PRNG_BT_USHORT_FLOAT
  if(kernel_prng_bt_ushort_float) {clReleaseKernel(kernel_prng_bt_ushort_float);}
  if(command_queue_prng_bt_ushort_float) {clReleaseCommandQueue(command_queue_prng_bt_ushort_float);}
#endif

#ifdef ENABLE_KRNL_PRNG_GG_UCHAR
  if(kernel_prng_gg_uchar) {clReleaseKernel(kernel_prng_gg_uchar);}
  if(command_queue_prng_gg_uchar) {clReleaseCommandQueue(command_queue_prng_gg_uchar);}
#endif

#ifdef ENABLE_KRNL_PRNG_GG_FLOAT
  if(kernel_prng_gg_float) {clReleaseKernel(kernel_prng_gg_float);}
  if(command_queue_prng_gg_float) {clReleaseCommandQueue(command_queue_prng_gg_float);}
#endif

#ifdef ENABLE_KRNL_PRNG_LS123_USHORT
  if(kernel_prng_ls123_ushort) {clReleaseKernel(kernel_prng_ls123_ushort);}
  if(command_queue_prng_ls123_ushort) {clReleaseCommandQueue(command_queue_prng_ls123_ushort);}
#endif

#ifdef ENABLE_KRNL_PRNG_LS_FLOAT
  if(kernel_prng_ls_float) {clReleaseKernel(kernel_prng_ls_float);}
  if(command_queue_prng_ls_float) {clReleaseCommandQueue(command_queue_prng_ls_float);}
#endif

#ifdef ENABLE_KRNL_PRNG_LS2_FLOAT
  if(kernel_prng_ls2_float) {clReleaseKernel(kernel_prng_ls2_float);}
  if(command_queue_prng_ls2_float) {clReleaseCommandQueue(command_queue_prng_ls2_float);}
#endif

#ifdef ENABLE_KRNL_PRNG_LS3_FLOAT
  if(kernel_prng_ls3_float) {clReleaseKernel(kernel_prng_ls3_float);}
  if(command_queue_prng_ls3_float) {clReleaseCommandQueue(command_queue_prng_ls3_float);}
#endif

#ifdef ENABLE_KRNL_PRNG_LS4_FLOAT
  if(kernel_prng_ls4_float) {clReleaseKernel(kernel_prng_ls4_float);}
  if(command_queue_prng_ls4_float) {clReleaseCommandQueue(command_queue_prng_ls4_float);}
#endif

#ifdef ENABLE_KRNL_PRNG_LS5_FLOAT
  if(kernel_prng_ls5_float) {clReleaseKernel(kernel_prng_ls5_float);}
  if(command_queue_prng_ls5_float) {clReleaseCommandQueue(command_queue_prng_ls5_float);}
#endif

#ifdef ENABLE_KRNL_PRNG_LS6_FLOAT
  if(kernel_prng_ls6_float) {clReleaseKernel(kernel_prng_ls6_float);}
  if(command_queue_prng_ls6_float) {clReleaseCommandQueue(command_queue_prng_ls6_float);}
#endif

#ifdef ENABLE_KRNL_PRNG_LS7_FLOAT
  if(kernel_prng_ls7_float) {clReleaseKernel(kernel_prng_ls7_float);}
  if(command_queue_prng_ls7_float) {clReleaseCommandQueue(command_queue_prng_ls7_float);}
#endif

#ifdef ENABLE_KRNL_PRNG_LS8_FLOAT
  if(kernel_prng_ls8_float) {clReleaseKernel(kernel_prng_ls8_float);}
  if(command_queue_prng_ls8_float) {clReleaseCommandQueue(command_queue_prng_ls8_float);}
#endif

#ifdef ENABLE_KRNL_PRNG_LS9_FLOAT
  if(kernel_prng_ls9_float) {clReleaseKernel(kernel_prng_ls9_float);}
  if(command_queue_prng_ls9_float) {clReleaseCommandQueue(command_queue_prng_ls9_float);}
#endif

#ifdef ENABLE_KRNL_LS
  if(kernel_ls) {clReleaseKernel(kernel_ls);}
  if(command_queue_ls) {clReleaseCommandQueue(command_queue_ls);}
#endif

#ifdef ENABLE_KRNL_LS2
  if(kernel_ls2) {clReleaseKernel(kernel_ls2);}
  if(command_queue_ls2) {clReleaseCommandQueue(command_queue_ls2);}
#endif

#ifdef ENABLE_KRNL_LS3
  if(kernel_ls3) {clReleaseKernel(kernel_ls3);}
  if(command_queue_ls3) {clReleaseCommandQueue(command_queue_ls3);}
#endif

#ifdef ENABLE_KRNL_LS4
  if(kernel_ls4) {clReleaseKernel(kernel_ls4);}
  if(command_queue_ls4) {clReleaseCommandQueue(command_queue_ls4);}
#endif

#ifdef ENABLE_KRNL_LS5
  if(kernel_ls5) {clReleaseKernel(kernel_ls5);}
  if(command_queue_ls5) {clReleaseCommandQueue(command_queue_ls5);}
#endif

#ifdef ENABLE_KRNL_LS6
  if(kernel_ls6) {clReleaseKernel(kernel_ls6);}
  if(command_queue_ls6) {clReleaseCommandQueue(command_queue_ls6);}
#endif

#ifdef ENABLE_KRNL_LS7
  if(kernel_ls7) {clReleaseKernel(kernel_ls7);}
  if(command_queue_ls7) {clReleaseCommandQueue(command_queue_ls7);}
#endif

#ifdef ENABLE_KRNL_LS8
  if(kernel_ls8) {clReleaseKernel(kernel_ls8);}
  if(command_queue_ls8) {clReleaseCommandQueue(command_queue_ls8);}
#endif

#ifdef ENABLE_KRNL_LS9
  if(kernel_ls9) {clReleaseKernel(kernel_ls9);}
  if(command_queue_ls9) {clReleaseCommandQueue(command_queue_ls9);}
#endif

#ifdef ENABLE_KRNL_IGL_ARBITER
  if(kernel_igl_arbiter) {clReleaseKernel(kernel_igl_arbiter);}
  if(command_queue_igl_arbiter) {clReleaseCommandQueue(command_queue_igl_arbiter);}
#endif

#if 0
  if(command_queue) {clReleaseCommandQueue(command_queue);}
#endif

  if(program) {clReleaseProgram(program);}
  if(context) {clReleaseContext(context);}

  if(cpu_init_populations) {free(cpu_init_populations);}
  if(cpu_final_populations){free(cpu_final_populations);}
  if(cpu_energies)         {free(cpu_energies);}
  if(cpu_result_ligands)   {free(cpu_result_ligands);}
  if(cpu_prng_seeds)       {free(cpu_prng_seeds);}
  if(cpu_evals_of_runs)    {free(cpu_evals_of_runs);}


  if(mem_KerConstStatic_InterE_atom_charges_const)	  	  {clReleaseMemObject(mem_KerConstStatic_InterE_atom_charges_const);}
  if(mem_KerConstStatic_InterE_atom_types_const)	   	  {clReleaseMemObject(mem_KerConstStatic_InterE_atom_types_const);}

  if(mem_KerConstStatic_IntraE_atom_charges_const)	  	  {clReleaseMemObject(mem_KerConstStatic_IntraE_atom_charges_const);}
  if(mem_KerConstStatic_IntraE_atom_types_const)	   	  {clReleaseMemObject(mem_KerConstStatic_IntraE_atom_types_const);}

  if(mem_KerConstStatic_intraE_contributors_const) 	  {clReleaseMemObject(mem_KerConstStatic_intraE_contributors_const);}

  if(mem_KerConstStatic_reqm_const) 	  		  {clReleaseMemObject(mem_KerConstStatic_reqm_const);}
  if(mem_KerConstStatic_reqm_hbond_const) 	  	  {clReleaseMemObject(mem_KerConstStatic_reqm_hbond_const);}
  if(mem_KerConstStatic_atom1_types_reqm_const) 	  {clReleaseMemObject(mem_KerConstStatic_atom1_types_reqm_const);}
  if(mem_KerConstStatic_atom2_types_reqm_const)	  	  {clReleaseMemObject(mem_KerConstStatic_atom2_types_reqm_const);}

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
  if(mem_dockpars_conformations_current)  {clReleaseMemObject(mem_dockpars_conformations_current);}
  if(mem_dockpars_energies_current) 	  {clReleaseMemObject(mem_dockpars_energies_current);}

  if(mem_evals_performed) {clReleaseMemObject(mem_evals_performed);}
  if(mem_gens_performed)  {clReleaseMemObject(mem_gens_performed);}
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
