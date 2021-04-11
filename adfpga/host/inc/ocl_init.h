#ifndef OCL_INIT_H_
#define OCL_INIT_H_

#include "processresult.h"
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

static cl_command_queue command_queue_ls7 = NULL;
static cl_kernel kernel_ls7 = NULL;
static const char *name_ls7 = "Krnl_LS7";

static cl_command_queue command_queue_ls8 = NULL;
static cl_kernel kernel_ls8 = NULL;
static const char *name_ls8 = "Krnl_LS8";

static cl_command_queue command_queue_ls9 = NULL;
static cl_kernel kernel_ls9 = NULL;
static const char *name_ls9 = "Krnl_LS9";

static cl_program program = NULL;

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


// Host memory buffers
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


// Function prototypes
bool init();
void cleanup();
static void device_info_ulong( cl_device_id device, cl_device_info param, const char* name);
static void device_info_uint ( cl_device_id device, cl_device_info param, const char* name);
static void device_info_bool ( cl_device_id device, cl_device_info param, const char* name);
static void device_info_string( cl_device_id device, cl_device_info param, const char* name);
static void display_device_info( cl_device_id device );

#endif /* OCL_INIT_H_ */