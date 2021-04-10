#ifndef COMMON_MACROS_H
#define COMMON_MACROS_H

#include <stdio.h>
#include <stdlib.h>
#include <CL/opencl.h>

#ifdef PRINT_OCL_INFO
	// wrapcl/Platforms.cpp
	#define PLATFORM_ATTRIBUTES_DISPLAY

	// wrapcl/Devices.cpp
	#define DEVICE_ATTRIBUTES_DISPLAY

	// wrapcl/Contexts.cpp
	#define CONTEXT_INFO_DISPLAY

	// wrapcl/CommandQueue.cpp
	#define CMD_QUEUE_INFO_DISPLAY
	#define CMD_QUEUE_PROFILING_ENABLE
	#define CMD_QUEUE_OUTORDER_ENABLE

	// wrapcl/Programs.cpp
	#define PROGRAM_INFO_DISPLAY
	#define PROGRAM_BUILD_INFO_DISPLAY

	// wrapcl/Kernels.cpp
	#define KERNEL_INFO_DISPLAY
	#define KERNEL_WORK_GROUP_INFO_DISPLAY

	// wrapcl/BufferObjects.cpp
	#define BUFFER_OBJECT_INFO_DISPLAY
#endif

#endif // COMMON_MACROS_H