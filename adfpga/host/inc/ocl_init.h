#ifndef OCL_INIT_H_
#define OCL_INIT_H_

#include "processresult.h"
#include "CL/opencl.h"
#include "AOCLUtils/aocl_utils.h"

#include "Kernels.h"
#include "BufferObjects.h"

using namespace aocl_utils;

#define STRING_BUFFER_LEN 1024

// Function prototypes
bool init();
void cleanup();
static void device_info_ulong( cl_device_id device, cl_device_info param, const char* name);
static void device_info_uint ( cl_device_id device, cl_device_info param, const char* name);
static void device_info_bool ( cl_device_id device, cl_device_info param, const char* name);
static void device_info_string( cl_device_id device, cl_device_info param, const char* name);
static void display_device_info( cl_device_id device );

#endif /* OCL_INIT_H_ */