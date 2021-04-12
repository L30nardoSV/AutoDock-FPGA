#ifndef DEFINES_H_
#define DEFINES_H_

// ------------------------------------
// Different OpenCL work-group sizes
// ------------------------------------
#define NUM_OF_THREADS_PER_BLOCK 1

// -----------------------------------------------------------------------------
// Docking constants
// -----------------------------------------------------------------------------
#define RLIST_ATOMID_MASK    0x000000FF
#define RLIST_RBONDID_MASK   0x0000FF00
#define RLIST_RBONDID_SHIFT  8
#define RLIST_FIRSTROT_MASK  0x00010000
#define RLIST_GENROT_MASK    0x00020000
#define RLIST_DUMMY_MASK     0x00040000
#define DEG_TO_RAD 	     	 0.0174533f

//#define COEFF_VDW 0.1662f
//#define COEFF_HB 0.1209f
//#define COEFF_ELEC 46.6881f
//#define COEFF_DESOLV 0.1322f
//#define QASP_AD 0.01097f
//#define QASP_DS 0.00679f

#define MAX_NUM_OF_ATOMS		90
#define MAX_NUM_OF_ATYPES		14
#define MAX_INTRAE_CONTRIBUTORS 8128
#define MAX_NUM_OF_ROTATIONS 	4096
#define MAX_NUM_OF_ROTBONDS 	32
//#define MAX_POPSIZE 		2048
#define MAX_POPSIZE 		256
#define MAX_NUM_OF_RUNS 	100

// Must be bigger than MAX_NUM_OF_ROTBONDS+6
#define GENOTYPE_LENGTH_IN_GLOBMEM 64
#define ACTUAL_GENOTYPE_LENGTH	(MAX_NUM_OF_ROTBONDS+6)

#define LS_EXP_FACTOR 	2.0f
#define LS_CONT_FACTOR 	0.5f

// Mask for genotypes
#define MASK_GENOTYPE 0x3F

//macro for a%b where b=2^N
//#define MOD2N(a, b) (a&(b-1))

// gcc linear congruential generator constants
#define RAND_A 		1103515245u
#define RAND_C 		12345u
// WARNING: it is supposed that unsigned int is 32 bit long
#define MAX_UINT 	4294967296.0f

// Original macro for capturing grid values
#define GETGRIDVALUE(mempoi,gridsize_x,gridsize_y,gridsize_z,t,z,y,x) \
	*(mempoi + gridsize_x*(y + gridsize_y*(z + gridsize_z*t)) + x)

// Updated macro for trilinear interpolation
#define TRILININTERPOL(cube, weights) \
	(cube[0][0][0]*weights[0][0][0] +cube[1][0][0]*weights[1][0][0] + \
	 cube[0][1][0]*weights[0][1][0] +cube[1][1][0]*weights[1][1][0] + \
	 cube[0][0][1]*weights[0][0][1] +cube[1][0][1]*weights[1][0][1] + \
	 cube[0][1][1]*weights[0][1][1] +cube[1][1][1]*weights[1][1][1])

#endif /* DEFINES_H_ */
