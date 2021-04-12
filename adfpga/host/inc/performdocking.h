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

#define ELAPSEDSECS(stop,start) ((float) stop-start)/((float) CLOCKS_PER_SEC)

int docking_with_fpga (
	const Gridinfo* mygrid,
    /*const*/ float* cpu_floatgrids,
	Dockpars* mypars,
	const Liganddata* myligand_init,
	const int* argc,
	char** argv,
	clock_t clock_start_program
);

#endif /* PERFORMDOCKING_H_ */
