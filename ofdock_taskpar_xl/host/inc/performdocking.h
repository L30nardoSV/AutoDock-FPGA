#ifndef PERFORMDOCKING_H_
#define PERFORMDOCKING_H_

#include "ext_headers.h"
#include "processgrid.h"
#include "miscellaneous.h"
#include "processligand.h"
#include "getparameters.h"
#include "calcenergy.h"	
#include "processresult.h"

using std::vector;

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

#endif /* PERFORMDOCKING_H_ */
