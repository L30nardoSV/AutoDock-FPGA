/*
 * (C) 2013. Evopro Innovation Kft.
 *
 * calcenergy.h
 *
 *  Created on: 2010.04.20.
 *      Author: pechan.imre
 */

#ifndef CALCENERGY_H_
#define CALCENERGY_H_

#include <math.h>
#include <stdio.h>

#include "defines.h"
#include "miscellaneous.h"
#include "processligand.h"
#include "getparameters.h"

// This struct is passed to the GPU global functions (OpenCL kernels) as input.
// Its members are parameters related to the ligand, the grid
// and the genetic algorithm, or they are pointers of GPU (ADM FPGA) memory areas
// used for storing different data such as the current
// and the next population genotypes and energies, the grids,
// the evaluation counters and the random number generator states.
typedef struct
{
	char  	 	num_of_atoms;
	char   		num_of_atypes;
	int    		num_of_intraE_contributors;
	char   		gridsize_x;
	char   		gridsize_y;
	char   		gridsize_z;
	float  		grid_spacing;
/*
	float* 		fgrids;
*/
	int    		rotbondlist_length;
	float  		coeff_elec;
	float  		coeff_desolv;
/*
	float* 		conformations_current;
	float* 		energies_current;
	float* 		conformations_next;
	float* 		energies_next;
	int*   		evals_of_new_entities;
	unsigned int* 	prng_states;
*/
	// L30nardoSV added
	unsigned int num_of_energy_evals;
	unsigned int num_of_generations;

	int    		pop_size;
	int    		num_of_genes;
	float  		tournament_rate;
	float  		crossover_rate;
	float  		mutation_rate;
	float  		abs_max_dmov;
	float  		abs_max_dang;
	float  		lsearch_rate;
	unsigned int 	num_of_lsentities;
	float  		rho_lower_bound;
	float  		base_dmov_mul_sqrt3;
	float  		base_dang_mul_sqrt3;
	unsigned int 	cons_limit;
	unsigned int 	max_num_of_iters;
	float  		qasp;
} Dockparameters;

// ----------------------------------------------------------------------
// L30nardoSV modified
// The original function does CUDA calls initializing const kernel data.
// We create a struct to hold those constants and return them <here>
// (<here> = where prepare_const_fields_for_gpu() was called),
// so we can send them to kernels from <here>, instead of from calcenergy.cpp
// as originally.
// ----------------------------------------------------------------------

// Constant struct
typedef struct
{
       float atom_charges_const[MAX_NUM_OF_ATOMS];
       char  atom_types_const  [MAX_NUM_OF_ATOMS];
       char  intraE_contributors_const[3*MAX_INTRAE_CONTRIBUTORS];
       float VWpars_AC_const   [MAX_NUM_OF_ATYPES*MAX_NUM_OF_ATYPES];
       float VWpars_BD_const   [MAX_NUM_OF_ATYPES*MAX_NUM_OF_ATYPES];
       float dspars_S_const    [MAX_NUM_OF_ATYPES];
       float dspars_V_const    [MAX_NUM_OF_ATYPES];
       int   rotlist_const     [MAX_NUM_OF_ROTATIONS];
       float ref_coords_x_const[MAX_NUM_OF_ATOMS];
       float ref_coords_y_const[MAX_NUM_OF_ATOMS];
       float ref_coords_z_const[MAX_NUM_OF_ATOMS];
       float rotbonds_moving_vectors_const[3*MAX_NUM_OF_ROTBONDS];
       float rotbonds_unit_vectors_const  [3*MAX_NUM_OF_ROTBONDS];
       float ref_orientation_quats_const  [4*MAX_NUM_OF_RUNS];
} kernelconstant;

int prepare_const_fields_for_gpu(Liganddata* 	 myligand_reference,
				 Dockpars*   	 mypars,
				 float*      	 cpu_ref_ori_angles,
				 kernelconstant* KerConst);

void make_reqrot_ordering(char number_of_req_rotations[MAX_NUM_OF_ATOMS],
			  char atom_id_of_numrots[MAX_NUM_OF_ATOMS],
		          int  num_of_atoms);

int gen_rotlist(Liganddata* myligand,
		int         rotlist[MAX_NUM_OF_ROTATIONS]);

#endif /* CALCENERGY_H_ */





