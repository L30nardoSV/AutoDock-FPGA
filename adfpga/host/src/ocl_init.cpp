#include "ocl_init.h"

// OpenCL runtime configuration
cl_platform_id platform = NULL;
cl_device_id device = NULL;
cl_context context = NULL;

// Kernel name, as defined in the CL file
cl_command_queue command_queue_ga = NULL;
cl_kernel kernel_ga = NULL;
const char *name_ga = "Krnl_GA";

cl_command_queue command_queue_pc = NULL;
cl_kernel kernel_pc = NULL;
const char *name_pc = "Krnl_Conform";

cl_command_queue command_queue_ie = NULL;
cl_kernel kernel_ie = NULL;
const char *name_ie = "Krnl_InterE";

cl_command_queue command_queue_ia = NULL;
cl_kernel kernel_ia = NULL;
const char *name_ia = "Krnl_IntraE";

cl_command_queue command_queue_prng_gg_float = NULL;
cl_kernel kernel_prng_gg_float = NULL;
const char *name_prng_gg_float = "Krnl_Prng_GG_float";

cl_command_queue command_queue_prng_ls_float = NULL;
cl_kernel kernel_prng_ls_float = NULL;
const char *name_prng_ls_float = "Krnl_Prng_LS_float";

cl_command_queue command_queue_prng_gg_uchar = NULL;
cl_kernel kernel_prng_gg_uchar = NULL;
const char *name_prng_gg_uchar = "Krnl_Prng_GG_uchar";

cl_command_queue command_queue_ls = NULL;
cl_kernel kernel_ls = NULL;
const char *name_ls = "Krnl_LS";

cl_command_queue command_queue_prng_ls2_float = NULL;
cl_kernel kernel_prng_ls2_float = NULL;
const char *name_prng_ls2_float = "Krnl_Prng_LS2_float";

cl_command_queue command_queue_ls2 = NULL;
cl_kernel kernel_ls2 = NULL;
const char *name_ls2 = "Krnl_LS2";

cl_command_queue command_queue_prng_ls3_float = NULL;
cl_kernel kernel_prng_ls3_float = NULL;
const char *name_prng_ls3_float = "Krnl_Prng_LS3_float";

cl_command_queue command_queue_ls3 = NULL;
cl_kernel kernel_ls3 = NULL;
const char *name_ls3 = "Krnl_LS3";

/*
cl_command_queue command_queue_igl_arb = NULL;
cl_kernel kernel_igl_arb = NULL;
const char *name_igl_arb = "Krnl_IGL_Arbiter";
*/

cl_command_queue command_queue_ls123_ushort = NULL;
cl_kernel kernel_ls123_ushort = NULL;
const char *name_ls123_ushort = "Krnl_Prng_LS123_ushort";

cl_command_queue command_queue_prng_bt_ushort_float = NULL;
cl_kernel kernel_prng_bt_ushort_float = NULL;
const char *name_prng_bt_ushort_float = "Krnl_Prng_BT_ushort_float";

cl_command_queue command_queue_prng_ls4_float = NULL;
cl_kernel kernel_prng_ls4_float = NULL;
const char *name_prng_ls4_float = "Krnl_Prng_LS4_float";

cl_command_queue command_queue_prng_ls5_float = NULL;
cl_kernel kernel_prng_ls5_float = NULL;
const char *name_prng_ls5_float = "Krnl_Prng_LS5_float";

cl_command_queue command_queue_ls4 = NULL;
cl_kernel kernel_ls4 = NULL;
const char *name_ls4 = "Krnl_LS4";

cl_command_queue command_queue_ls5 = NULL;
cl_kernel kernel_ls5 = NULL;
const char *name_ls5 = "Krnl_LS5";

cl_command_queue command_queue_prng_ls6_float = NULL;
cl_kernel kernel_prng_ls6_float = NULL;
const char *name_prng_ls6_float = "Krnl_Prng_LS6_float";

cl_command_queue command_queue_prng_ls7_float = NULL;
cl_kernel kernel_prng_ls7_float = NULL;
const char *name_prng_ls7_float = "Krnl_Prng_LS7_float";

cl_command_queue command_queue_prng_ls8_float = NULL;
cl_kernel kernel_prng_ls8_float = NULL;
const char *name_prng_ls8_float = "Krnl_Prng_LS8_float";

cl_command_queue command_queue_prng_ls9_float = NULL;
cl_kernel kernel_prng_ls9_float = NULL;
const char *name_prng_ls9_float = "Krnl_Prng_LS9_float";

cl_command_queue command_queue_ls6 = NULL;
cl_kernel kernel_ls6 = NULL;
const char *name_ls6 = "Krnl_LS6";

cl_command_queue command_queue_ls7 = NULL;
cl_kernel kernel_ls7 = NULL;
const char *name_ls7 = "Krnl_LS7";

cl_command_queue command_queue_ls8 = NULL;
cl_kernel kernel_ls8 = NULL;
const char *name_ls8 = "Krnl_LS8";

cl_command_queue command_queue_ls9 = NULL;
cl_kernel kernel_ls9 = NULL;
const char *name_ls9 = "Krnl_LS9";

cl_program program = NULL;

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
uint* cpu_prng_seeds;
#if defined(SINGLE_COPY_POP_ENE)
int *cpu_evals_of_runs;
int *cpu_gens_of_runs;
#endif
float* cpu_ref_ori_angles;			  

// Altera OpenCL Helper Functions
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

/*
  command_queue_igl_arb = clCreateCommandQueue(context, device, 0, &status);
  checkError(status, "Failed to create command queue igl_arb");
  kernel_igl_arb = clCreateKernel(program, name_igl_arb, &status);
  checkError(status, "Failed to create kernel igl_arb");
*/

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

  command_queue_ls7 = clCreateCommandQueue(context, device, 0, &status);
  checkError(status, "Failed to create command queue ls7");
  kernel_ls7 = clCreateKernel(program, name_ls7, &status);
  checkError(status, "Failed to create kernel ls7");

  command_queue_ls8 = clCreateCommandQueue(context, device, 0, &status);
  checkError(status, "Failed to create command queue ls8");
  kernel_ls8 = clCreateKernel(program, name_ls8, &status);
  checkError(status, "Failed to create kernel ls8");

  command_queue_ls9 = clCreateCommandQueue(context, device, 0, &status);
  checkError(status, "Failed to create command queue ls9");
  kernel_ls9 = clCreateKernel(program, name_ls9, &status);
  checkError(status, "Failed to create kernel ls9");

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

/*
  if(kernel_igl_arb) {clReleaseKernel(kernel_igl_arb);}
  if(command_queue_igl_arb) {clReleaseCommandQueue(command_queue_igl_arb);}
*/

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

  if(kernel_ls7) {clReleaseKernel(kernel_ls7);}
  if(command_queue_ls7) {clReleaseCommandQueue(command_queue_ls7);}

  if(kernel_ls8) {clReleaseKernel(kernel_ls8);}
  if(command_queue_ls8) {clReleaseCommandQueue(command_queue_ls8);}

  if(kernel_ls9) {clReleaseKernel(kernel_ls9);}
  if(command_queue_ls9) {clReleaseCommandQueue(command_queue_ls9);}

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
