// The fixed-point representation has the 10.10 format
// Intended to be used in ofdock_taskpar_alt/Krnl_Conform.cl

// Starting point:
// https://sourceforge.net/p/fixedptc/code/ci/default/tree/fixedptc.h

// ---------------------------------------------------------------------
// Fixed-point Defines
// ---------------------------------------------------------------------

// Enable the 64-bits data type (double, long) extension
#pragma OPENCL EXTENSION cl_khr_fp64 : enable

typedef int           fixedpt;
typedef	long	      fixedptd;
/*
typedef	unsigned int  fixedptu;
typedef	unsigned long fixedptud;
*/

#define FIXEDPT_BITS	32
#define FIXEDPT_WBITS	16
#define FIXEDPT_FBITS	16
#define FIXEDPT_FMASK	(((fixedpt)1 << FIXEDPT_FBITS) - 1)

//#define FIXEDPT_FBITS	(FIXEDPT_BITS - FIXEDPT_WBITS)

#if FIXEDPT_WBITS >= FIXEDPT_BITS
#error "FIXEDPT_WBITS must be less than or equal to FIXEDPT_BITS"
#endif

#if FIXEDPT_FBITS >= FIXEDPT_BITS
#error "FIXEDPT_FBITS must be less than to FIXEDPT_BITS"
#endif

// ---------------------------------------------------------------------
// Fixed-point Constants
// ---------------------------------------------------------------------

#define FIXEDPT_ONE	    ((fixedpt)((fixedpt)1 << FIXEDPT_FBITS))
#define FIXEDPT_ONE_HALF    (FIXEDPT_ONE >> 1)
#define FIXEDPT_TWO	    (FIXEDPT_ONE + FIXEDPT_ONE)

#define FIXEDPT_MAX  	    0x7FFFFFFF /*!< the maximum value of fix16_t */
#define FIXEDPT_MIN  	    0x80000000 /*!< the minimum value of fix16_t */
#define FIXEDPT_OVERFLOW    0x80000000 /*!< the value used to indicate overflows when FIXMATH_NO_OVERFLOW is not specified */

/*
// #define fixedpt_rconst(R)   ((fixedpt)((R) * FIXEDPT_ONE + ((R) >= 0 ? 0.5 : -0.5)))
inline const fixedpt
fixedpt_rconst(float R) {
	return ((fixedpt)((R) * FIXEDPT_ONE + ((R) >= 0 ? 0.5 : -0.5)));
}
*/
/*
#define FIXEDPT_PI	    fixedpt_rconst(3.14159265358979323846)
#define FIXEDPT_HALF_PI fixedpt_rconst(3.14159265358979323846 / 2)
*/

#define FIXEDPT_PI      		0x3243F
#define FIXEDPT_HALF_PI 		(FIXEDPT_PI >> 1)
#define FIXEDPT_TWO_PI			(FIXEDPT_PI << 1)
#define FIXEDPT_THREE_PI_DIV_TWO 	(FIXEDPT_PI + FIXEDPT_HALF_PI)

// ---------------------------------------------------------------------
// Fixed-point Functions
// ---------------------------------------------------------------------

// ---------------------------------------------------------------------
inline fixedpt
fixedpt_fromint(int I) {
	return I * FIXEDPT_ONE;
}

// ---------------------------------------------------------------------
inline int
fixedpt_toint(fixedpt F) {   
	return (F >> FIXEDPT_FBITS);
}

// ---------------------------------------------------------------------
inline float
fixedpt_tofloat(fixedpt T) {
	return (float)T / FIXEDPT_ONE;
}

// ---------------------------------------------------------------------
inline fixedpt
fixedpt_fromfloat(float F) {
	float tmp = F * FIXEDPT_ONE;
	return (fixedpt)tmp;
}

// ---------------------------------------------------------------------
/*
inline fixedpt
fixedpt_add(fixedpt A, fixedpt B) {
	uint _A = A;
	uint _B = B;
	uint sum = _A + _B;

	if (!((_A ^ _B) & 0x80000000) && ((_A ^ sum) & 0x80000000)) {
		sum = FIXEDPT_OVERFLOW;
	}

	return sum;
}

inline fixedpt 
fixedpt_sadd(fixedpt A, fixedpt B) {
	fixedpt result = fixedpt_add (A, B);

	if (result == FIXEDPT_OVERFLOW) {
		result = (A >= 0) ? FIXEDPT_MAX : FIXEDPT_MIN;
	}

	return result;
}
*/

inline fixedpt
fixedpt_sadd(fixedpt A, fixedpt B) {
	uint _A = A;
	uint _B = B;
	uint sum = _A + _B;

	// apply saturation when overflow
	if (!((_A ^ _B) & 0x80000000) && ((_A ^ sum) & 0x80000000)) {
		/*
		sum = FIXEDPT_OVERFLOW;
		*/
		sum = (A >= 0) ? FIXEDPT_MAX : FIXEDPT_MIN;
	}

	return sum;
}

// ---------------------------------------------------------------------
/*
inline fixedpt
fixedpt_sub(fixedpt A, fixedpt B) {
	uint _A = A;
	uint _B = B;
	uint diff = _A - _B;
	   
	if (((_A ^ _B) & 0x80000000) && ((_A ^ diff) & 0x80000000)) {
		diff = FIXEDPT_OVERFLOW;
	}

	return diff;
}

inline fixedpt
fixedpt_ssub(fixedpt A, fixedpt B) {
	fixedpt result = fixedpt_sub(A, B);

	if (result == FIXEDPT_OVERFLOW) {
		result = (A >= 0) ? FIXEDPT_MAX : FIXEDPT_MIN;
	}

	return result;
}
*/

inline fixedpt
fixedpt_ssub(fixedpt A, fixedpt B) {
	uint _A = A;
	uint _B = B;
	uint diff = _A - _B;
	   
	// apply saturation when overflow
	if (((_A ^ _B) & 0x80000000) && ((_A ^ diff) & 0x80000000)) {
		/*
		diff = FIXEDPT_OVERFLOW;
		*/
		diff = (A >= 0) ? FIXEDPT_MAX : FIXEDPT_MIN;
	}

	return diff;
}

// ---------------------------------------------------------------------

// no overflow
inline fixedpt
fixedpt_nomul(fixedpt A, fixedpt B)
{
	return ((fixedptd)A * B) >> FIXEDPT_FBITS;
}
/*
inline fixedpt
fixedpt_mul(fixedpt A, fixedpt B)
{
	fixedptd product = (fixedptd)A * B;
	
	// The upper 17 bits should all be the same (the sign).
	uint upper = product >> 47;

	fixedpt r_tmp = product >> 16;

	if (product < 0) {
		if (~upper)
			r_tmp = FIXEDPT_OVERFLOW;	
	}
	else {
		if (upper)
			r_tmp = FIXEDPT_OVERFLOW;
	}
	
	return r_tmp;
}

inline fixedpt
fixedpt_smul(fixedpt A, fixedpt B)
{
	fixedpt result = fixedpt_mul(A, B);
	
	if (result == FIXEDPT_OVERFLOW)
	{
		if ((A >= 0) == (B >= 0)) {
			result = FIXEDPT_MAX;
		}
		else {
			result = FIXEDPT_MIN;
		}
	}
	
	return result;
}
*/

inline fixedpt
fixedpt_smul(fixedpt A, fixedpt B)
{
	fixedptd product = (fixedptd)A * B;
	
	// The upper 17 bits should all be the same (the sign).
	uint upper = product >> 47;

	fixedpt r_tmp = product >> 16;

	// apply saturation when overflow
	if (product < 0) {
		if (~upper)
			/*
			r_tmp = FIXEDPT_OVERFLOW;
			*/		
			if ((A >= 0) == (B >= 0)) {
				r_tmp = FIXEDPT_MAX;
			}
			else {
				r_tmp = FIXEDPT_MIN;
			}	
	}
	else {
		if (upper)
			/*
			r_tmp = FIXEDPT_OVERFLOW;
			*/
			if ((A >= 0) == (B >= 0)) {
				r_tmp = FIXEDPT_MAX;
			}
			else {
				r_tmp = FIXEDPT_MIN;
			}	
	}
	
	return r_tmp;
}

// ---------------------------------------------------------------------

/* Returns the sine of the given fixedpt number. 
 * Note: the loss of precision is extraordinary! */

inline fixedpt
fixedpt_sin(fixedpt fp)
{
/*
 	printf("%i\n" , fixedpt_rconst(3.14159265358979323846));
	printf("%x\n" , fixedpt_rconst(3.14159265358979323846));
	printf("coeff1 %x\n" , fixedpt_rconst(7.61e-03));
	printf("coeff2 %x\n" , fixedpt_rconst(1.6605e-01));
*/

	int sign = 1;
	fixedpt sqr, result;
	const fixedpt SK[2] = {
		/*fixedpt_rconst(7.61e-03)*/ 0x1F3,
		/*fixedpt_rconst(1.6605e-01)*/ 0x2A82
	};

	fp %= /*2 * FIXEDPT_PI*/FIXEDPT_TWO_PI;
	if (fp < 0)
		fp = /*FIXEDPT_PI * 2*/FIXEDPT_TWO_PI + fp;
	if ((fp > FIXEDPT_HALF_PI) && (fp <= FIXEDPT_PI)) 
		fp = FIXEDPT_PI - fp;
	else if ((fp > FIXEDPT_PI) && (fp <= (/*FIXEDPT_PI + FIXEDPT_HALF_PI*/FIXEDPT_THREE_PI_DIV_TWO))) {
		fp = fp - FIXEDPT_PI;
		sign = -1;
	} else if (fp > (/*FIXEDPT_PI + FIXEDPT_HALF_PI*/FIXEDPT_THREE_PI_DIV_TWO)) {
		fp = (/*FIXEDPT_PI << 1*/FIXEDPT_TWO_PI) - fp;
		sign = -1;
	}
	sqr = /*fixedpt_mul(fp, fp);*/ fixedpt_nomul(fp, fp);
	result = SK[0];
	result = /*fixedpt_mul(result, sqr);*/ fixedpt_nomul(result, sqr);
	result -= SK[1];
	result = /*fixedpt_mul(result, sqr);*/ fixedpt_nomul(result, sqr);
	result += FIXEDPT_ONE;
	result = /*fixedpt_mul(result, fp);*/ fixedpt_nomul(result, fp);
	return sign * result;
}

// ---------------------------------------------------------------------
inline fixedpt
fixedpt_cos(fixedpt A)
{
	return (fixedpt_sin(FIXEDPT_HALF_PI - A));
}

// ---------------------------------------------------------------------
