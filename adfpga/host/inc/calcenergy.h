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
	uchar  	num_of_atoms;
	uchar   num_of_atypes;
	uint    num_of_intraE_contributors;
	uchar   gridsize_x;
	uchar   gridsize_y;
	uchar   gridsize_z;
	uchar	g1;
	uint	g2;
	uint 	g3;
	float	grid_spacing;

	uint	rotbondlist_length;
	float	coeff_elec;
	float	coeff_desolv;
/*
	float* 		conformations_current;
	float* 		energies_current;
	float* 		conformations_next;
	float* 		energies_next;
	int*   		evals_of_new_entities;
	uint* 	prng_states;
*/
	uint num_of_energy_evals;
	uint num_of_generations;

	uint    pop_size;
	uint   	num_of_genes;
	float  		tournament_rate;
	float  		crossover_rate;
	float  		mutation_rate;
	float  		abs_max_dmov;
	float  		abs_max_dang;
	float  		lsearch_rate;

	float 		smooth;

	uint 	num_of_lsentities;
	float  		rho_lower_bound;
	float  		base_dmov_mul_sqrt3;
	float  		base_dang_mul_sqrt3;
	uint 	cons_limit;
	uint 	max_num_of_iters;
	float  		qasp;
} Dockparameters;

// ----------------------------------------------------------------------
// Modified
// The original function does CUDA calls initializing const kernel data.
// We create a struct to hold those constants and return them <here>
// (<here> = where prepare_const_fields_for_gpu() was called),
// so we can send them to kernels from <here>, instead of from calcenergy.cpp
// as originally.
// ----------------------------------------------------------------------

// Constant struct
/*
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
       //float ref_orientation_quats_const  [4*MAX_NUM_OF_RUNS];
       float ref_orientation_quats_const  [4];
} kernelconstant;
*/

#include "CL/opencl.h"

#if defined (FIXED_POINT_CONFORM) || defined (FIXED_POINT_LS)
#include "defines_fixedpt.h"
#endif

#if defined (FIXED_POINT_INTERE) || (FIXED_POINT_INTRAE)
#include "defines_fixedpt_64.h"
#endif

// As struct members are used as host buffers
// they are aligned to multiples of 64 bytes (power of 2).
// This solves aligment problem

typedef struct
{
	#if defined (FIXED_POINT_INTERE)
       	fixedpt64 fixpt64_atom_charges_const[MAX_NUM_OF_ATOMS]        __attribute__ ((aligned (1024)));
	#endif
       	float atom_charges_const[MAX_NUM_OF_ATOMS]                    __attribute__ ((aligned (512)));

       	char  atom_types_const  [MAX_NUM_OF_ATOMS]                    __attribute__ ((aligned (128)));

/*
       	char  intraE_contributors_const[3*MAX_INTRAE_CONTRIBUTORS]    __attribute__ ((aligned (32768)));
*/
	cl_char3  intraE_contributors_const[MAX_INTRAE_CONTRIBUTORS]    __attribute__ ((aligned (32768)));

        float reqm_const [ATYPE_NUM]				      __attribute__ ((aligned (64)));
        float reqm_hbond_const [ATYPE_NUM]			      __attribute__ ((aligned (64)));
        uint  atom1_types_reqm_const [ATYPE_NUM]	      __attribute__ ((aligned (64)));
        uint  atom2_types_reqm_const [ATYPE_NUM]	      __attribute__ ((aligned (64)));

       	float VWpars_AC_const   [MAX_NUM_OF_ATYPES*MAX_NUM_OF_ATYPES] __attribute__ ((aligned (1024)));
       	float VWpars_BD_const   [MAX_NUM_OF_ATYPES*MAX_NUM_OF_ATYPES] __attribute__ ((aligned (1024)));
      	float dspars_S_const    [MAX_NUM_OF_ATYPES]                   __attribute__ ((aligned (64)));
       	float dspars_V_const    [MAX_NUM_OF_ATYPES]                   __attribute__ ((aligned (64)));
       	int   rotlist_const     [MAX_NUM_OF_ROTATIONS]                __attribute__ ((aligned (4096)));

	#if defined (FIXED_POINT_CONFORM)
	// fixed-point
       	cl_int3 ref_coords_const[MAX_NUM_OF_ATOMS]                   __attribute__ ((aligned (2048)));
       	cl_int3 rotbonds_moving_vectors_const[MAX_NUM_OF_ROTBONDS]   __attribute__ ((aligned (512)));
       	cl_int3 rotbonds_unit_vectors_const  [MAX_NUM_OF_ROTBONDS]   __attribute__ ((aligned (512)));
	#else
 	// floating-point (original)
      	cl_float3 ref_coords_const[MAX_NUM_OF_ATOMS]                 __attribute__ ((aligned (2048)));
       	cl_float3 rotbonds_moving_vectors_const[MAX_NUM_OF_ROTBONDS] __attribute__ ((aligned (512)));
       	cl_float3 rotbonds_unit_vectors_const  [MAX_NUM_OF_ROTBONDS] __attribute__ ((aligned (512)));
	#endif

#if defined(SINGLE_COPY_POP_ENE)
	#if defined (FIXED_POINT_CONFORM)
	// fixed-point
      	//fixedpt   ref_orientation_quats_const  [4*MAX_NUM_OF_RUNS] __attribute__ ((aligned (512)));
	cl_int4    ref_orientation_quats_const  [MAX_NUM_OF_RUNS] __attribute__ ((aligned (512)));
	#else
	// floating-point (original)
       	//float     ref_orientation_quats_const  [4*MAX_NUM_OF_RUNS] __attribute__ ((aligned (512)));
	cl_float4  ref_orientation_quats_const  [MAX_NUM_OF_RUNS] __attribute__ ((aligned (512)));
	#endif
#endif
} kernelconstant_static;

// As struct members are used as host buffers
// they are aligned to multiples of 64 bytes (power of 2).
// This is added for the sake of completion
// cl_float3 is made of 4 floats, its size is 16 bytes

#if defined(SINGLE_COPY_POP_ENE)

#else
typedef struct
{
	#if defined (FIXED_POINT_CONFORM)
	// fixed-point
      	fixedpt   ref_orientation_quats_const  [4] __attribute__ ((aligned (64)));
	#else
	// floating-point (original)
       	float     ref_orientation_quats_const  [4] __attribute__ ((aligned (64)));
	#endif
} kernelconstant_dynamic;
#endif


/*
int prepare_const_fields_for_gpu(Liganddata* 	 myligand_reference,
				 Dockpars*   	 mypars,
				 float*      	 cpu_ref_ori_angles,
				 kernelconstant* KerConst);
*/
int prepare_conststatic_fields_for_gpu(Liganddata* 	       myligand_reference,
				 	Dockpars*   	       mypars,
					#if defined(SINGLE_COPY_POP_ENE)
				 	float*      	       cpu_ref_ori_angles,
					#endif
				 	kernelconstant_static* KerConstStatic);

#if defined(SINGLE_COPY_POP_ENE)

#else
int prepare_constdynamic_fields_for_gpu(Liganddata* 	 	myligand_reference,
				 	Dockpars*   	 	mypars,
				 	float*      	 	cpu_ref_ori_angles,
				 	kernelconstant_dynamic* KerConstDynamic);
#endif

void make_reqrot_ordering(char number_of_req_rotations[MAX_NUM_OF_ATOMS],
			  char atom_id_of_numrots[MAX_NUM_OF_ATOMS],
		          int  num_of_atoms);

int gen_rotlist(Liganddata* myligand,
		int         rotlist[MAX_NUM_OF_ROTATIONS]);

#endif /* CALCENERGY_H_ */






