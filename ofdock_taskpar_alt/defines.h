#ifndef DEFINES_H_
#define DEFINES_H_

// calc_ddd_Mehler_Solmajer()
#define LAMBDA    0.003627f
#define EPSILON0  78.4f
#define A         -8.5525f
#define B	  (EPSILON0 - A)
#define RK	  7.7839f
#define LAMBDA_B  (-LAMBDA * B)
#define SIGMA     3.6f


// The entire defines. h definition set is copied here
// We don't need to include it anymore
#define CPU_MAX_POP_SIZE 256//2048
#define HIGHEST_ENERGY 137438953472.0

#define GRID_MX_SIZE_XYZ 100
// taken from calcenergy_basic (ofdock also gdock)
// gcc linear congruential generator constants
#define RAND_A 		1103515245u
#define RAND_C 		12345u

// myrand() 
// WARNING: it is supposed that unsigned int is 32 bit long
#define MAX_UINT 	4294967296.0f

// change_conform() and rotate_custom()
#define NEG_M_PI -3.141593f
#define POS_M_PI 3.141593f
#define DOBLE_PI 6.283186f
#define DEG_TO_RAD 0.0174533f
#define DEG_TO_RAD_DIV_2 0.008727f

// interE() outofgrid_tolerance
#define OUTOFGRID_TOLERANCE 0.0f


// intraE() distance cutoff
//#define DCUTOFF 8.0f

// perform_LS()
#define EXPANSION_FACTOR    2.0f
#define CONTRACTION_FACTOR  0.5f

// On-Chip memory
#define MAX_NUM_OF_ATYPES 	 14
#define MAX_NUM_OF_ATOMS 	 256
#define MAX_INTRAE_CONTRIBUTORS  8128
//#define MAX_NUM_OF_ROTATIONS 	 4096
#define MAX_NUM_OF_ROTBONDS 	 32
//#define MAX_POPSIZE 		 2048
//#define MAX_NUM_OF_RUNS 	 100

// Must be bigger than MAX_NUM_OF_ROTBONDS+6
//#define GENOTYPE_LENGTH_IN_GLOBMEM 64
//#define ACTUAL_GENOTYPE_LENGTH	(MAX_NUM_OF_ROTBONDS+6)


// taken from processgrid.h 
//#define getvalue_4Darr(mempoi, grinf, t, z, y, x) *(mempoi+(grinf).size_x*(y+(grinf).size_y*(z+(grinf).size_z*t))+x)



// taken from miscallenous.h
#define trilin_interpol(cube, weights) (cube[0][0][0]*weights[0][0][0] + cube[1][0][0]*weights[1][0][0] + \
					cube[0][1][0]*weights[0][1][0] + cube[1][1][0]*weights[1][1][0] + \
					cube[0][0][1]*weights[0][0][1] + cube[1][0][1]*weights[1][0][1] + \
					cube[0][1][1]*weights[0][1][1] + cube[1][1][1]*weights[1][1][1])


//Struct which describes a quaternion
typedef struct
{
	float q; 
	float x; 
	float y; 
	float z;
} KernelQuaternion;

typedef struct 
{	
	unsigned int  num_of_energy_evals;
	unsigned int  num_of_generations;
	float 	      dmov_mask;
	float         dang_mask;
	float         mutation_rate;
	float         crossover_rate;
	float         lsearch_rate;
	float         tournament_rate;
	float         rho_lower_bound;
	float         base_dmov_mul_sqrt3;
	float         base_dang_mul_sqrt3;
        unsigned int  cons_limit;
        unsigned int  max_num_of_iters;
	unsigned int  pop_size;
	unsigned int  num_of_entity_for_ls;
} Dockingconstant;

typedef struct
{
	unsigned char num_of_atoms;
	unsigned int  num_of_rotbonds;
	unsigned int  num_of_intraE_contributors;
} Ligandconstant;

typedef struct
{
	unsigned char size_x;
	unsigned char size_y;
	unsigned char size_z;
	unsigned char  g1;
	unsigned int  g2;
	unsigned int  g3;
	float         spacing;
	unsigned char num_of_atypes;
} Gridconstant;

#endif /* DEFINES_H_ */

