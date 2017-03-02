/*
 * (C) 2013. Evopro Innovation Kft.
 *
 * performdocking.h
 *
 *  Created on: 2009.05.25.
 *      Author: pechan.imre
 */

#ifndef EXECDOCK_H_
#define EXECDOCK_H_

#include <stdio.h>
#include <string.h>

#include "defines.h"
#include "getparameters.h"
#include "processligand.h"
#include "processgrid.h"
#include "miscallenous.h"
#include "processresult.h"
#include "searchoptimum.h"

#include <CL/opencl.h> 
//#include "commonMacros.h" 
//#include "listAttributes.h" 
//#include "Platforms.h" 
//#include "Devices.h" 
//#include "Contexts.h" 
//#include "CommandQueues.h" 
//#include "Programs.h" 
#include "Kernels.h" 
//#include "ImportBinary.h" 
//#include "ImportSource.h" 
#include "BufferObjects.h"

/*
int docking_with_cpu(const Gridinfo* mygrid, const double* floatgrids, Dockpars* mypars, const Liganddata* myligand_init,
					 const int* argc, char** argv, double* fpga_exectime_sum, Ligandresult* result_ligands);
*/

int docking_with_cpu(const Gridinfo* mygrid, 		     
		     const float* floatgrids, 		     
		     Dockpars* mypars, 		     
		     const Liganddata* myligand_init, 		     
		     const int* argc, 		     
		     char** argv, 		     
		     double* fpga_exectime_sum, 		     
		     Ligandresult* result_ligands);

#endif /* EXECDOCK_H_ */
