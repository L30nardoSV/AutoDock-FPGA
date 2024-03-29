#include "Contexts.h"

int createContext(
		  /*
		  const cl_context_properties* properties,
		  */
		  cl_platform_id 	platform_id,
		  cl_uint 		num_devices,
		  cl_device_id*	 	device_id,
		  /*
		  void (*pfn_notify)(const char* errinfo,
				     const void* private_info,
				     size_t      cb,
			             void*       user_data)
		  void* user_data,
		  */
		  /*
		  cl_int*               errcode_ret,
		  */
		  cl_context* 		context){
  cl_int err;
  cl_context local_context;

  cl_context_properties context_props[] = {CL_CONTEXT_PLATFORM,(cl_context_properties) platform_id, 0};

  //context = clCreateContext(0, 1, device_id, NULL, NULL, &err);
  local_context = clCreateContext(context_props,
				  num_devices,
				  (const cl_device_id*) device_id, NULL, NULL, &err);

  if ((!local_context) || (err != CL_SUCCESS)){
	printf("Error: clCreateContext() %d\n",err);
	fflush(stdout);
	return EXIT_FAILURE;
  }

#ifdef CONTEXT_INFO_DISPLAY
  err = getContextInfo(local_context);
  if (err!=CL_SUCCESS){
	printf("Error: getContextInfo(): %d\n",err);
	fflush(stdout);
        return EXIT_FAILURE;
  }
#endif

  *context = local_context;
  /*
  *errcode = err;
  */
  return CL_SUCCESS;
}

#ifdef CONTEXT_INFO_DISPLAY
int getContextInfo(cl_context context){
  cl_int 		 err;
  cl_uint		 i;

  cl_uint* 		 num_dev_in_context;
  cl_device_id*		 device_ids_context;
  cl_context_properties* properties_context;
  cl_uint*		 ref_count_context;
  size_t sizeParam;

  // ----------------------------------------------------------------------------
  // Query Number of devices in context
  printf("\n-----------------------------------------------------------------------\n");
  err = clGetContextInfo(context,CL_CONTEXT_NUM_DEVICES,0,NULL,&sizeParam);
  if (err != CL_SUCCESS){
	printf("Error: clGetContextInfo() %d\n",err);
	fflush(stdout);
        return EXIT_FAILURE;
  }

  num_dev_in_context = (cl_uint*) malloc(sizeof(cl_uint) * sizeParam);
  err = clGetContextInfo(context,CL_CONTEXT_NUM_DEVICES,sizeParam,num_dev_in_context,NULL);
  if (err != CL_SUCCESS){
	printf("Error: clGetContextInfo() %d\n",err);
	fflush(stdout);
	return EXIT_FAILURE;
  }

  printf("  %-45s: %u \n", "CL_CONTEXT_NUM_DEVICES", *num_dev_in_context);

  // Store num devices
  cl_uint num_dev_tmp = *num_dev_in_context;
  free(num_dev_in_context);

  // ----------------------------------------------------------------------------
  // Query Devices in the context
  err = clGetContextInfo(context,CL_CONTEXT_DEVICES,0,NULL,&sizeParam);
  if (err != CL_SUCCESS){
	printf("Error: clGetContextInfo() %d\n",err);
	fflush(stdout);
  	return EXIT_FAILURE;
  }

  device_ids_context = (cl_device_id*) malloc(sizeof(cl_device_id) * sizeParam);
  err = clGetContextInfo(context,CL_CONTEXT_DEVICES,sizeParam,device_ids_context,NULL);
  if (err != CL_SUCCESS){
	printf("Error: clGetContextInfo() %d\n",err);
	fflush(stdout);
	return EXIT_FAILURE;
  }

  /*
  // Assuming (correctly) that only one device is present in context
  printf("%-30s: %x \n", "Device IDs in context", device_ids_context[0]);
  free(device_ids_context);
  */

  // No assumption
  for(i=0; i<num_dev_tmp; i++){
    printf("  %-45s: %x \n", "CL_CONTEXT_DEVICES", device_ids_context[i]);
  }
  free(device_ids_context);

  // ----------------------------------------------------------------------------
  // Query Properties
  /*
  https://www.khronos.org/registry/cl/specs/opencl-1.0.pdf
  CL_CONTEXT_PROPERTIES
  Return the properties argument specified in clCreateContext or clCreateContextFromType.
  If the properties argument specified in clCreateContext or clCreateContextFromType
  used to create context is not NULL, the implementation must return the values
  specified in the properties argument.
  If the properties argument specified in clCreateContext or clCreateContextFromType
  used to create context is NULL, the implementation may return either a param_value_size_ret
  of 0 i.e. there is no context property value to be returned or can return a context
  property value of 0 (where 0 is used to terminate the context properties list).
  in the memory that param_value points to.
  */

  err = clGetContextInfo(context,CL_CONTEXT_PROPERTIES,0,NULL,&sizeParam);
  if (err != CL_SUCCESS){
	printf("Error: clGetContextInfo() %d\n",err);
	fflush(stdout);
	return EXIT_FAILURE;
  }

  properties_context = (cl_context_properties*) malloc(sizeof(cl_context_properties) * sizeParam);
  err = clGetContextInfo(context,CL_CONTEXT_PROPERTIES,sizeParam,properties_context,NULL);
  if (err != CL_SUCCESS){
	printf("Error: clGetContextInfo() %d\n",err);
	fflush(stdout);
	return EXIT_FAILURE;
  }

  // Assuming that only one property is present in context
  printf("  %-45s: %lu \n", "CL_CONTEXT_PROPERTIES", properties_context[0]);
  free(properties_context);

  // ----------------------------------------------------------------------------
  // Query Context' reference count
  /*
  https://www.khronos.org/registry/cl/specs/opencl-1.0.pdf
  CL_CONTEXT_REFERENCE_COUNT
  The returned value should be considered stale (pasado, viejo).
  It is unsuitable for general use in applications.
  This feature is provided for identifying memory leaks.
  */
  err = clGetContextInfo(context,CL_CONTEXT_REFERENCE_COUNT,0,NULL,&sizeParam);
  if (err != CL_SUCCESS){
	printf("Error: clGetContextInfo() %d\n",err);
	fflush(stdout);
	return EXIT_FAILURE;
  }

  ref_count_context = (cl_uint*) malloc(sizeof(cl_uint) * sizeParam);
  err = clGetContextInfo(context,CL_CONTEXT_REFERENCE_COUNT,sizeParam,ref_count_context,NULL);
  if (err != CL_SUCCESS){
	printf("Error: clGetContextInfo() %d\n",err);
	fflush(stdout);
        return EXIT_FAILURE;
  }

  printf("  %-45s: %u \n", "CL_CONTEXT_REFERENCE_COUNT", *ref_count_context);
  free(ref_count_context);

  return CL_SUCCESS;
}
#endif
