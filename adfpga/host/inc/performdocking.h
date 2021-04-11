#ifndef PERFORMDOCKING_H_
#define PERFORMDOCKING_H_

#include <assert.h>
#include <cstring>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#include "processgrid.h"
#include "miscellaneous.h"
#include "getparameters.h"
#include "calcenergy.h"	
#include "processligand.h"
#include "ocl_init.h"

#include "Kernels.h"
#include "BufferObjects.h"

#define ELAPSEDSECS(stop,start) ((float) stop-start)/((float) CLOCKS_PER_SEC)

int docking_with_gpu(const Gridinfo* 	mygrid,
         	     /*const*/ float* 	cpu_floatgrids,
		           Dockpars*	mypars,
		     const Liganddata* 	myligand_init,
		     const int* 	argc,
		     char**		argv,
		           clock_t 	clock_start_program);

double check_progress(int* evals_of_runs,
		      int generation_cnt,
		      int max_num_of_evals,
		      int max_num_of_gens,
		      int num_of_runs);

//// --------------------------------
//// Host constant struct
//// --------------------------------
Dockparameters dockpars;
kernelconstant_static  KerConstStatic;
#if defined(SINGLE_COPY_POP_ENE)

#else
kernelconstant_dynamic KerConstDynamic;
#endif

#endif /* PERFORMDOCKING_H_ */
