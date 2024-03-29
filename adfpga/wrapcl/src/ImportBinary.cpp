#include "ImportBinary.h"

int load_file_to_memory(const char *filename, char **result)
{
  size_t size = 0;
  FILE *f = fopen(filename, "rb");
  if (f == NULL)
  {
    *result = NULL;
    return -1; // -1 means file opening fail
  }
  fseek(f, 0, SEEK_END);
  size = ftell(f);
  fseek(f, 0, SEEK_SET);
  *result = (char *)malloc(size+1);
  if (size != fread(*result, sizeof(char), size, f))
  {
    free(*result);
    return -2; // -2 means file reading fail
  }
  fclose(f);
  (*result)[size] = 0;
  return size;
}

int ImportBinary(const char*    kernel_xclbin,
                 const char*    kernel_name,
		 cl_device_id*  device_id,
		 cl_context	context,
		 /*cl_program*	program,*/
                 const char*    options,
		 cl_kernel*	kernel)
{
  cl_int err;

  // Load Binary "*.xclbin" from disk
  char *kernel_binary;
  printf("\nINFO: loading xclbin: %-5s\n", kernel_xclbin);
  printf("INFO: kernel name assigned: %-5s\n",kernel_name);
  int n_i = load_file_to_memory(kernel_xclbin, (char **) &kernel_binary);
  if (n_i < 0) {
	printf("Error: load_file_to_memory() %s\n", kernel_xclbin);
	fflush(stdout);
	return EXIT_FAILURE;
  }
  size_t n = n_i;

  // Create the compute program from offline
  cl_int status;
  cl_program local_program;
  local_program = clCreateProgramWithBinary(context,1,device_id,&n,
                                      (const unsigned char **) &kernel_binary,&status,&err);

  if ((!local_program) || (err!=CL_SUCCESS)){
	printf("Error: clCreateProgramWithBinary() %d\n", err);
	fflush(stdout);
 	return EXIT_FAILURE;
  }

#ifdef PROGRAM_INFO_DISPLAY
  err = getProgramInfo(local_program);
  if (err!=CL_SUCCESS){
	printf("Error: getProgramInfo() %d\n",err);
	fflush(stdout);
	return EXIT_FAILURE;
  }
#endif

  // Build the program executable
  // No Notification routine (no callback function)
  err = clBuildProgram(local_program, 1, device_id, options, NULL, NULL);

  if (err != CL_SUCCESS){
    size_t len;
    char buffer[2048];
    printf("Error: clBuildProgram() %d\n",err);
    clGetProgramBuildInfo(local_program,device_id[0],CL_PROGRAM_BUILD_LOG,sizeof(buffer),buffer,&len);
    printf("%s\n", buffer);
    fflush(stdout);
    return EXIT_FAILURE;
  }


#ifdef PROGRAM_BUILD_INFO_DISPLAY
  err = getprogramBuildInfo(local_program, device_id[0]);
  if (err!=CL_SUCCESS){
	printf("Error: getprogramBuildInfo() %d\n",err);
	fflush(stdout);
 	return EXIT_FAILURE;
  }
#endif

  // Create the compute kernel in the program we wish to run
  cl_kernel local_kernel;
  local_kernel = clCreateKernel(local_program, kernel_name, &err);

  if ((!local_kernel) || (err != CL_SUCCESS)){
	printf("Error: clCreateKernel() %s %d\n",kernel_name,err);
	fflush(stdout);
 	return EXIT_FAILURE;
  }

#ifdef KERNEL_INFO_DISPLAY
  err = getKernelInfo(local_kernel);
  if (err!=CL_SUCCESS){
	printf("Error: getKernelInfo() %d\n",kernel_name,err);
	fflush(stdout);
 	return EXIT_FAILURE;
  }
#endif

#ifdef KERNEL_WORK_GROUP_INFO_DISPLAY
  err = getKernelWorkGroupInfo(local_kernel, device_id[0]);
  if (err!=CL_SUCCESS){
	printf("Error: getKernelWorkGroupInfo() %d\n",kernel_name,err);
	fflush(stdout);
 	return EXIT_FAILURE;
  }
#endif

  /* *program = local_program;*/
  *kernel  = local_kernel;
  return CL_SUCCESS;
}
