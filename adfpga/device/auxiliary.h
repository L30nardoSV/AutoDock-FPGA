// Enable the Intel channels extension
// Programming Guide v17.1 / 5.4.5
#pragma OPENCL EXTENSION cl_intel_channels : enable

//IC:  initial calculation of energy of populations
//GG:  genetic generation 
//LS:  local search
//OFF: turn off 

#include "../defines.h"

#include "ihc_apint.h"

#define CHAN_DEPTH_ATOMXYZ   (MAX_NUM_OF_ATOMS/2)
#define CHAN_DEPTH_GENOTYPE  ACTUAL_GENOTYPE_LENGTH

#define LS_REPLICATION_FACTOR 9

// Send active signal to IGL_Arbiter
channel bool    chan_GA2IGL_IC_active;
channel bool    chan_GA2IGL_GG_active;

typedef struct ch_geno {
	float array [ACTUAL_GENOTYPE_LENGTH];
} ch_geno_t;

// Send genotypes from producers (IC, GG, LSs) to Conform
//channel float  	chan_IC2Conf_genotype          			__attribute__((depth(CHAN_DEPTH_GENOTYPE)));
//channel float  	chan_GG2Conf_genotype          			__attribute__((depth(CHAN_DEPTH_GENOTYPE)));
//channel float  	chan_LS2Conf_genotype[LS_REPLICATION_FACTOR]    __attribute__((depth(CHAN_DEPTH_GENOTYPE)));

channel ch_geno_t chan_IC2Conf_genotype __attribute__((depth(2)));
channel ch_geno_t chan_GG2Conf_genotype __attribute__((depth(2)));
channel ch_geno_t chan_LS2Conf_genotype[LS_REPLICATION_FACTOR] __attribute__((depth(2)));

// Send ligand-atom positions from Conform to InterE & IntraE
channel float8  chan_Conf2Intere_xyz           __attribute__((depth(CHAN_DEPTH_ATOMXYZ)));
channel char  	chan_Conf2Intere_actmode;

channel float8	chan_Conf2Intrae_xyz           __attribute__((depth(CHAN_DEPTH_ATOMXYZ)));
channel char  	chan_Conf2Intrae_actmode;

// Send energy values from InterE & IntraE to genotype-senders (IC, GG, LSs)
channel float 	chan_Intere2StoreIC_intere     				__attribute__((depth(2)));
channel float 	chan_Intere2StoreGG_intere     				__attribute__((depth(2)));
channel float 	chan_Intere2StoreLS_intere[LS_REPLICATION_FACTOR]  	__attribute__((depth(2)));

channel float 	chan_Intrae2StoreIC_intrae     				__attribute__((depth(2)));
channel float 	chan_Intrae2StoreGG_intrae     				__attribute__((depth(2)));
channel float 	chan_Intrae2StoreLS_intrae[LS_REPLICATION_FACTOR]  	__attribute__((depth(2)));

// Send PRNG outputs from generators to consumers
channel float8   chan_PRNG2GA_BT_ushort_float_prng;
channel uchar2   chan_PRNG2GA_GG_uchar_prng;
channel float    chan_PRNG2GA_GG_float_prng     __attribute__((depth(CHAN_DEPTH_GENOTYPE)));
channel ushort16 chan_PRNG2GA_LS123_ushort_prng;
channel float    chan_PRNG2LS_float_prng[LS_REPLICATION_FACTOR]		__attribute__((depth(CHAN_DEPTH_GENOTYPE)));

// Turn-off signals to PRNG generators
channel bool 	chan_GA2PRNG_BT_ushort_float_off;
channel bool    chan_GA2PRNG_GG_uchar_off;
channel bool    chan_GA2PRNG_GG_float_off;
channel bool    chan_GA2PRNG_LS123_ushort_off;
channel bool    chan_GA2PRNG_LS_float_off[LS_REPLICATION_FACTOR];

// Send energy values and genotypes to LSs
channel float   chan_GA2LS_energy[LS_REPLICATION_FACTOR];
channel float  	chan_GA2LS_genotype[LS_REPLICATION_FACTOR]        __attribute__((depth(CHAN_DEPTH_GENOTYPE)));

// Send LS status from LSs to IGL_Arbiter
channel bool    chan_LS2Arbiter_end[LS_REPLICATION_FACTOR];

// Get LS-eval-count, new energy, new genotype from LSs
channel float2  chan_LS2GA_evalenergy[LS_REPLICATION_FACTOR]      __attribute__((depth(2)));
channel float  	chan_LS2GA_genotype[LS_REPLICATION_FACTOR]        __attribute__((depth(CHAN_DEPTH_GENOTYPE)));

// Turn-off signals to LSs
channel bool    chan_GA2LS_Off_active[LS_REPLICATION_FACTOR];

// Send genotype-producer-channel selector and genotype 
// from IGL_Arbiter to Conform
channel char   chan_IGL2Conform_actmode	       __attribute__((depth(LS_REPLICATION_FACTOR))); // active, mode
channel float  chan_IGL2Conform_genotype       __attribute__((depth(LS_REPLICATION_FACTOR*CHAN_DEPTH_GENOTYPE)));

// Turn-off signal to IGL_Arbiter, Conform, InterE, IntraE
channel bool   chan_IGLArbiter_Off;

#if defined (FIXED_POINT_CONFORM) || defined (FIXED_POINT_LS)
#include "../defines_fixedpt.h"
typedef int3          fixedpt3;
typedef int4	      fixedpt4;
#endif

#if defined (FIXED_POINT_INTERE) || defined (FIXED_POINT_INTRAE)
#include "../defines_fixedpt_64.h"
#endif

// --------------------------------------------------------------------------
// Map the argument into the interval 0 - 180, or 0 - 360
// by adding/subtracting n*ang_max to/from it.
// Originally from: searchoptimum.c
// --------------------------------------------------------------------------

float map_angle_180(float angle)
{
	float x = angle;
	//while (x < 0.0f)
	if (x < 0.0f)   
	{ x += 180.0f; }
	//while (x > 180.0f)
	if (x > 180.0f) 
	{ x -= 180.0f; }
	return x;
}

float map_angle_360(float angle)
{
	float x = angle;
	//while (x < 0.0f)
	if (x < 0.0f)
	{ x += 360.0f; }
	//while (x > 360.0f)
	if (x > 360.0f)
	{ x -= 360.0f;}
	return x;
}

#ifdef FIXED_POINT_LS
#define FIXEDPT_180	0xB40000
#define FIXEDPT_360	0x1680000

fixedpt fixedpt_map_angle_180(fixedpt angle)
{
	fixedpt x = angle;
	//while (x < 0.0f) 
	if (x < 0)
	{ x += FIXEDPT_180; }
	//while (x > 180.0f)
	if (x > FIXEDPT_180)
	{ x -= FIXEDPT_180; }
	return x;
}

fixedpt fixedpt_map_angle_360(fixedpt angle)
{
	fixedpt x = angle;
	//while (x < 0.0f) 
	if (x < 0)
	{ x += FIXEDPT_360; }
	//while (x > 360.0f)
	if (x > FIXEDPT_360)
	{ x -= FIXEDPT_360;}
	return x;
}
#endif