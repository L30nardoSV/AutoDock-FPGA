#ifndef PROGRAMS_H
#define PROGRAMS_H

  #include "commonMacros.h"

/*

*/
  int getProgramInfo(cl_program program);

/*

*/
  int getprogramBuildInfo(cl_program   program,
			  cl_device_id device);

#endif /* PROGRAMS_H */

