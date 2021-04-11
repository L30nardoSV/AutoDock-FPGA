#ifndef OCL_INIT_H_
#define OCL_INIT_H_

#include "processresult.h"
#include "CL/opencl.h"
#include "AOCLUtils/aocl_utils.h"

#include "Kernels.h"
#include "BufferObjects.h"

using namespace aocl_utils;

#define STRING_BUFFER_LEN 1024

// OpenCL runtime configuration
extern cl_platform_id platform;
extern cl_device_id device;
extern cl_context context;

// Kernel name, as defined in the CL file
extern cl_command_queue command_queue_ga;
extern cl_kernel kernel_ga;
extern const char *name_ga;

extern cl_command_queue command_queue_pc;
extern cl_kernel kernel_pc;
extern const char *name_pc;

extern cl_command_queue command_queue_ie;
extern cl_kernel kernel_ie;
extern const char *name_ie;

extern cl_command_queue command_queue_ia;
extern cl_kernel kernel_ia;
extern const char *name_ia;

extern cl_command_queue command_queue_prng_gg_float;
extern cl_kernel kernel_prng_gg_float;
extern const char *name_prng_gg_float;

extern cl_command_queue command_queue_prng_ls_float;
extern cl_kernel kernel_prng_ls_float;
extern const char *name_prng_ls_float;

extern cl_command_queue command_queue_prng_gg_uchar;
extern cl_kernel kernel_prng_gg_uchar;
extern const char *name_prng_gg_uchar;

extern cl_command_queue command_queue_ls;
extern cl_kernel kernel_ls;
extern const char *name_ls;

extern cl_command_queue command_queue_prng_ls2_float;
extern cl_kernel kernel_prng_ls2_float;
extern const char *name_prng_ls2_float;

extern cl_command_queue command_queue_ls2;
extern cl_kernel kernel_ls2;
extern const char *name_ls2;

extern cl_command_queue command_queue_prng_ls3_float;
extern cl_kernel kernel_prng_ls3_float;
extern const char *name_prng_ls3_float;

extern cl_command_queue command_queue_ls3;
extern cl_kernel kernel_ls3;
extern const char *name_ls3;

extern cl_command_queue command_queue_igl_arb;
extern cl_kernel kernel_igl_arb;
extern const char *name_igl_arb;

extern cl_command_queue command_queue_ls123_ushort ;
extern cl_kernel kernel_ls123_ushort;
extern const char *name_ls123_ushort;

extern cl_command_queue command_queue_prng_bt_ushort_float;
extern cl_kernel kernel_prng_bt_ushort_float;
extern const char *name_prng_bt_ushort_float;

extern cl_command_queue command_queue_prng_ls4_float;
extern cl_kernel kernel_prng_ls4_float;
extern const char *name_prng_ls4_float;

extern cl_command_queue command_queue_prng_ls5_float;
extern cl_kernel kernel_prng_ls5_float;
extern const char *name_prng_ls5_float;

extern cl_command_queue command_queue_ls4;
extern cl_kernel kernel_ls4;
extern const char *name_ls4;

extern cl_command_queue command_queue_ls5;
extern cl_kernel kernel_ls5;
extern const char *name_ls5;

extern cl_command_queue command_queue_prng_ls6_float;
extern cl_kernel kernel_prng_ls6_float;
extern const char *name_prng_ls6_float;

extern cl_command_queue command_queue_prng_ls7_float;
extern cl_kernel kernel_prng_ls7_float;
extern const char *name_prng_ls7_float;

extern cl_command_queue command_queue_prng_ls8_float;
extern cl_kernel kernel_prng_ls8_float;
extern const char *name_prng_ls8_float;

extern cl_command_queue command_queue_prng_ls9_float;
extern cl_kernel kernel_prng_ls9_float;
extern const char *name_prng_ls9_float;

extern cl_command_queue command_queue_ls6;
extern cl_kernel kernel_ls6;
extern const char *name_ls6;

extern cl_command_queue command_queue_ls7;
extern cl_kernel kernel_ls7;
extern const char *name_ls7;

extern cl_command_queue command_queue_ls8;
extern cl_kernel kernel_ls8;
extern const char *name_ls8;

extern cl_command_queue command_queue_ls9;
extern cl_kernel kernel_ls9;
extern const char *name_ls9;

extern cl_program program;

// Altera Issue
// Constant data holding struct data
// Created because structs containing array
// are not supported as OpenCL kernel args

#if defined (FIXED_POINT_INTERE)
extern cl_mem mem_KerConstStatic_fixpt64_atom_charges_const;
#endif
extern cl_mem mem_KerConstStatic_atom_charges_const;
extern cl_mem mem_KerConstStatic_atom_types_const;
extern cl_mem mem_KerConstStatic_intraE_contributors_const;

extern cl_mem mem_KerConstStatic_reqm_const;
extern cl_mem mem_KerConstStatic_reqm_hbond_const;
extern cl_mem mem_KerConstStatic_atom1_types_reqm_const;
extern cl_mem mem_KerConstStatic_atom2_types_reqm_const;

extern cl_mem mem_KerConstStatic_VWpars_AC_const;
extern cl_mem mem_KerConstStatic_VWpars_BD_const;
extern cl_mem mem_KerConstStatic_dspars_S_const;
extern cl_mem mem_KerConstStatic_dspars_V_const;
extern cl_mem mem_KerConstStatic_rotlist_const;
extern cl_mem mem_KerConstStatic_ref_coords_const;
extern cl_mem mem_KerConstStatic_rotbonds_moving_vectors_const;
extern cl_mem mem_KerConstStatic_rotbonds_unit_vectors_const;
extern cl_mem mem_KerConstStatic_ref_orientation_quats_const;

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

extern cl_mem mem_dockpars_fgrids;

#if defined(SEPARATE_FGRID_INTERE)
extern cl_mem mem_dockpars_fgrids2;
extern cl_mem mem_dockpars_fgrids3;
#endif

extern cl_mem mem_dockpars_conformations_current;
extern cl_mem mem_dockpars_energies_current;
/*
cl_mem mem_dockpars_prng_states;
*/

#if defined(SINGLE_COPY_POP_ENE)
extern cl_mem mem_evals_performed;
extern cl_mem mem_gens_performed;
#else
extern cl_mem mem_evals_and_generations_performed;
#endif

//#if defined (FIXED_POINT_INTERE)
#if 0
//#include "defines_fixedpt_64.h"
extern fixedpt64* cpu_fixedpt64grids;
#endif

// Host memory buffers
extern float* cpu_init_populations;
extern float* cpu_final_populations;
extern float* cpu_energies;
extern Ligandresult* cpu_result_ligands;
extern unsigned int* cpu_prng_seeds;
#if defined(SINGLE_COPY_POP_ENE)
extern int *cpu_evals_of_runs;
extern int *cpu_gens_of_runs;
#endif
extern float* cpu_ref_ori_angles;		

// Function prototypes
bool init();
void cleanup();
static void device_info_ulong( cl_device_id device, cl_device_info param, const char* name);
static void device_info_uint ( cl_device_id device, cl_device_info param, const char* name);
static void device_info_bool ( cl_device_id device, cl_device_info param, const char* name);
static void device_info_string( cl_device_id device, cl_device_info param, const char* name);
static void display_device_info( cl_device_id device );

#endif /* OCL_INIT_H_ */