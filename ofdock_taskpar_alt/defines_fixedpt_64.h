// The fixed-point representation has the 16.16 format
// Intended to be used in ofdock_taskpar_alt/Krnl_Conform.cl

// Starting points:
// https://sourceforge.net/p/fixedptc/code/ci/default/tree/fixedptc.h
// https://code.google.com/archive/p/libfixmath/

// ---------------------------------------------------------------------
// Fixed-point Defines
// ---------------------------------------------------------------------

// Enable the 64-bits data type (double, long) extension
#pragma OPENCL EXTENSION cl_khr_fp64 : enable

typedef long           fixedpt64;
//typedef	int4	       fixedptd64;

#define FIXEDPT64_BITS	64
#define FIXEDPT64_WBITS	48
#define FIXEDPT64_FBITS	16
#define FIXEDPT64_FMASK	(((fixedpt64)1 << FIXEDPT64_FBITS) - 1)

//#define FIXEDPT64_FBITS	(FIXEDPT64_BITS - FIXEDPT64_WBITS)

#if FIXEDPT64_WBITS >= FIXEDPT64_BITS
#error "FIXEDPT64_WBITS must be less than or equal to FIXEDPT64_BITS"
#endif

#if FIXEDPT64_FBITS >= FIXEDPT64_BITS
#error "FIXEDPT64_FBITS must be less than to FIXEDPT64_BITS"
#endif

// ---------------------------------------------------------------------
// Fixed-point Constants
// ---------------------------------------------------------------------

#define FIXEDPT64_ONE	    ((fixedpt64)((fixedpt64)1 << FIXEDPT64_FBITS))
#define FIXEDPT64_ONE_HALF  (FIXEDPT64_ONE >> 1)
#define FIXEDPT64_TWO	    (FIXEDPT64_ONE + FIXEDPT64_ONE)

#define FIXEDPT64_MAX  	    0x7FFFFFFFFFFFFFFF // the maximum value of fixedpt64
#define FIXEDPT64_MIN  	    0x8000000000000000 // the minimum value of fixedpt64
#define FIXEDPT64_OVERFLOW  0x8000000000000000 // the value used to indicate overflows

/*
// #define fixedpt_rconst(R)   ((fixedpt)((R) * FIXEDPT_ONE + ((R) >= 0 ? 0.5 : -0.5)))
inline fixedpt64
fixedpt64_rconst(float R) {
	return ((fixedpt64)((R) * FIXEDPT64_ONE + ((R) >= 0 ? 0.5 : -0.5)));
}
#define FIXEDPT_PI	    fixedpt_rconst(3.14159265358979323846)
*/

#define FIXEDPT64_PI      		0x3243F
#define FIXEDPT64_HALF_PI 		(FIXEDPT64_PI >> 1)
#define FIXEDPT64_TWO_PI		(FIXEDPT64_PI << 1)
#define FIXEDPT64_THREE_PI_DIV_TWO 	(FIXEDPT64_PI + FIXEDPT64_HALF_PI)

#define FIXEDPT64_E      		178145
// ---------------------------------------------------------------------
// Fixed-point Functions
// ---------------------------------------------------------------------

// ---------------------------------------------------------------------
inline fixedpt64
fixedpt64_abs(fixedpt64 x) { 
	return (x < 0 ? -x : x); 
}

// ---------------------------------------------------------------------
inline fixedpt64
fixedpt64_floor(fixedpt64 x) {
	return (x & 0xFFFFFFFFFFFF0000UL);
}

// ---------------------------------------------------------------------
inline fixedpt64
fixedpt64_ceil(fixedpt64 x) { 
	return (x & 0xFFFFFFFFFFFF0000UL) + ((x & 0x000000000000FFFFUL) ? FIXEDPT64_ONE : 0); 
}

// ---------------------------------------------------------------------
inline fixedpt64
fixedpt64_fromint(int I) {
	return I * FIXEDPT64_ONE;
}

// ---------------------------------------------------------------------
inline int
fixedpt64_toint(fixedpt64 F) {   
	return (F >> FIXEDPT64_FBITS);
}

// ---------------------------------------------------------------------
inline float
fixedpt64_tofloat(fixedpt64 T) {
	return (float)T / FIXEDPT64_ONE;
}

// ---------------------------------------------------------------------
inline fixedpt64
fixedpt64_fromfloat(float F) {
	float tmp = F * FIXEDPT64_ONE;
	return (fixedpt64)tmp;
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

inline fixedpt64
fixedpt64_sadd(fixedpt64 A, fixedpt64 B) {
	ulong _A = A;
	ulong _B = B;
	ulong sum = _A + _B;

	// apply saturation when overflow
	if (!((_A ^ _B) & 0x8000000000000000) && ((_A ^ sum) & 0x8000000000000000)) {
		sum = (A >= 0) ? FIXEDPT64_MAX : FIXEDPT64_MIN;
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

inline fixedpt64
fixedpt64_ssub(fixedpt64 A, fixedpt64 B) {
	ulong _A = A;
	ulong _B = B;
	ulong diff = _A - _B;
	   
	// apply saturation when overflow
	if (((_A ^ _B) & 0x8000000000000000) && ((_A ^ diff) & 0x8000000000000000)) {
		diff = (A >= 0) ? FIXEDPT64_MAX : FIXEDPT64_MIN;
	}

	return diff;
}

// ---------------------------------------------------------------------

// no overflow
inline fixedpt64
fixedpt64_nomul(fixedpt64 inArg0, fixedpt64 inArg1)
{
		// Each argument is divided to 16-bit parts.
	//					AB
	//			*	 CD
	// -----------
	//					BD	16 * 16 -> 32 bit products
	//				 CB
	//				 AD
	//				AC
	//			 |----| 64 bit product

	if (inArg0 < 0 && inArg1 < 0) {
		inArg0 = -inArg0;
		inArg1 = -inArg1;
	}

	long A = (inArg0 >> FIXEDPT64_FBITS); 
	long C = (inArg1 >> FIXEDPT64_FBITS);
	ulong B = (inArg0 & 0xFFFF);
	ulong D = (inArg1 & 0xFFFF);
	
	long AC = A*C;
	long AD_CB = A*D + C*B;
	ulong BD = B*D;
	
	long product_hi = AC + (AD_CB >> FIXEDPT64_FBITS);
	
	// Handle carry from lower 32 bits to upper part of result.
	ulong ad_cb_temp = AD_CB << FIXEDPT64_FBITS;
	ulong product_lo = BD + ad_cb_temp;
	if (product_lo < BD)
		product_hi++;
	
	fixedpt64 r_tmp = (product_hi << FIXEDPT64_FBITS) | (product_lo >> FIXEDPT64_FBITS);

	return r_tmp;
}

/* 64-bit implementation of fixedpt64_mul. 
 * This is a relatively good compromise for compilers that do not support
 * uint128_t. Uses 16*16->32bit multiplications.
 */
fixedpt64 fixedpt64_smul(fixedpt64 inArg0, fixedpt64 inArg1)
{
	// Each argument is divided to 16-bit parts.
	//					AB
	//			*	 CD
	// -----------
	//					BD	16 * 16 -> 32 bit products
	//				 CB
	//				 AD
	//				AC
	//			 |----| 64 bit product

	// two inputs negative
	// this last case was missing
	if (inArg0 < 0 && inArg1 < 0) {
		inArg0 = -inArg0;
		inArg1 = -inArg1;
	}

	long A = (inArg0 >> FIXEDPT64_FBITS); 
	long C = (inArg1 >> FIXEDPT64_FBITS);
	ulong B = (inArg0 & 0xFFFF);
	ulong D = (inArg1 & 0xFFFF);
	
	long AC = A*C;
	long AD_CB = A*D + C*B;
	ulong BD = B*D;
	
	long product_hi = AC + (AD_CB >> FIXEDPT64_FBITS);
	
	// Handle carry from lower 32 bits to upper part of result.
	ulong ad_cb_temp = AD_CB << FIXEDPT64_FBITS;
	ulong product_lo = BD + ad_cb_temp;
	if (product_lo < BD)
		product_hi++;
	
	fixedpt64 r_tmp = (product_hi << FIXEDPT64_FBITS) | (product_lo >> FIXEDPT64_FBITS);
	//fixedpt64 r_tmp = (product_hi << FIXEDPT64_FBITS) | (product_lo >> FIXEDPT64_WBITS);

	// The upper 48 bits should all be the same (the sign).
	if (product_hi >> 63 != product_hi >> 15) {
		/*
		return fix16_overflow;
		*/
		if ((inArg0 >= 0) == (inArg1 >= 0)) {
			r_tmp = FIXEDPT64_MAX;
		}
		else {
			r_tmp = FIXEDPT64_MIN;
		}	
	}

	return r_tmp;
}

// ---------------------------------------------------------------------
#if 0

/* Returns the sine of the given fixedpt number. 
 * Note: the loss of precision is extraordinary! */

inline fixedpt64
fixedpt64_sin(fixedpt64 fp)
{
/*
 	printf("%i\n" , fixedpt_rconst(3.14159265358979323846));
	printf("%x\n" , fixedpt_rconst(3.14159265358979323846));
	printf("coeff1 %x\n" , fixedpt_rconst(7.61e-03));
	printf("coeff2 %x\n" , fixedpt_rconst(1.6605e-01));
*/

	int sign = 1;
	fixedpt64 sqr, result;
	const fixedpt64 SK[2] = {
		/*fixedpt_rconst(7.61e-03)*/ 0x1F3,
		/*fixedpt_rconst(1.6605e-01)*/ 0x2A82
	};

	fp %= /*2 * FIXEDPT_PI*/FIXEDPT64_TWO_PI;
	if (fp < 0)
		fp = /*FIXEDPT_PI * 2*/FIXEDPT64_TWO_PI + fp;
	if ((fp > FIXEDPT64_HALF_PI) && (fp <= FIXEDPT64_PI)) 
		fp = FIXEDPT64_PI - fp;
	else if ((fp > FIXEDPT64_PI) && (fp <= (/*FIXEDPT_PI + FIXEDPT_HALF_PI*/FIXEDPT64_THREE_PI_DIV_TWO))) {
		fp = fp - FIXEDPT64_PI;
		sign = -1;
	} else if (fp > (/*FIXEDPT_PI + FIXEDPT_HALF_PI*/FIXEDPT64_THREE_PI_DIV_TWO)) {
		fp = (/*FIXEDPT_PI << 1*/FIXEDPT64_TWO_PI) - fp;
		sign = -1;
	}
	sqr = /*fixedpt_mul(fp, fp);*/ fixedpt64_nomul(fp, fp);
	result = SK[0];
	result = /*fixedpt_mul(result, sqr);*/ fixedpt64_nomul(result, sqr);
	result -= SK[1];
	result = /*fixedpt_mul(result, sqr);*/ fixedpt64_nomul(result, sqr);
	result += FIXEDPT64_ONE;
	result = /*fixedpt_mul(result, fp);*/ fixedpt64_nomul(result, fp);
	return sign * result;
}

// ---------------------------------------------------------------------
inline fixedpt64
fixedpt64_cos(fixedpt64 A)
{
	return (fixedpt64_sin(FIXEDPT64_HALF_PI - A));
}

// ---------------------------------------------------------------------

#endif



#if 0
// ---------------------------------------------------------------------
inline fixedpt64
fixedpt64_div(fixedpt64 a, fixedpt64 b)
{
	// This uses the basic binary restoring division algorithm.
	// It appears to be faster to do the whole division manually than
	// trying to compose a 64-bit divide out of 32-bit divisions on
	// platforms without hardware divide.
	
	/*
	if (b == 0)
		return FIXEDPT64_MIN;
	*/
	
	unsigned long remainder = (a >= 0) ? a : (-a);
	unsigned long divider   = (b >= 0) ? b : (-b);

	unsigned long quotient = 0;
	unsigned long bit = /*0x10000*/ FIXEDPT64_ONE;
	
	/* The algorithm requires D >= R */
	while (divider < remainder)
	{
		divider <<= 1;
		bit <<= 1;
	}
	
	// L30nardoSV added
	fixedpt64 result;


	if (b == 0) {
		/*return FIXEDPT64_MIN;*/
		result = FIXEDPT64_MIN;
	}
	/*#ifndef FIXMATH_NO_OVERFLOW*/
	else if (!bit) {
		/*return fix16_overflow;*/
		if ((a >= 0) == (b >= 0))
			/*return*/ result = FIXEDPT64_MAX;
		else
			/*return*/ result = FIXEDPT64_MIN;
	}
	/*#endif*/
	
	// L30nardoSV added
	else {	
		if (divider & /*0x80000000*/ 0x8000000000000000)
		{
			// Perform one step manually to avoid overflows later.
			// We know that divider's bottom bit is 0 here.
			if (remainder >= divider)
			{
					quotient |= bit;
					remainder -= divider;
			}
			divider >>= 1;
			bit >>= 1;
		}
	
		/* Main division loop */
		while (bit && remainder)
		{
			if (remainder >= divider)
			{
					quotient |= bit;
					remainder -= divider;
			}
		
			remainder <<= 1;
			bit >>= 1;
		}	 
	
	/*		
		#ifndef FIXMATH_NO_ROUNDING
		if (remainder >= divider)
		{
			quotient++;
		}
		#endif
	*/
	
		/*fix16_t*/ /*fixedpt64*/ result = quotient;
	
		/* Figure out the sign of result */
		if ((a ^ b) & /*0x80000000*/ 0x8000000000000000)
		{
			/*#ifndef FIXMATH_NO_OVERFLOW*/
			if (result == /*fix16_minimum*/FIXEDPT64_MIN) {
				//return fix16_overflow;
				if ((a >= 0) == (b >= 0))
					/*return*/ result = FIXEDPT64_MAX;
				else
					/*return*/ result = FIXEDPT64_MIN;
			}
			/*#endif*/
		
			result = -result;
		}
	} // end added else L30nardoSV
	return result;
}

// ---------------------------------------------------------------------

/*
#define FIXEDPT64_MAX  	    0x7FFFFFFFFFFFFFFF  // the maximum value of fixedpt64
#define FIXEDPT64_MIN  	    0x8000000000000000  // the minimum value of fixedpt64

Their logarithms are respectively 18.96,  ?
The second log could be a bit larger in magnitude (maybe 20)
But for the sake of simplicity, we use 18 and -18 (1179648 and -1179648 as fixedpt64)
*/


inline fixedpt64
fixedpt64_exp(fixedpt64 inValue)
{
	#if 0
	if(inValue == 0            ) return FIXEDPT64_ONE;
	if(inValue == FIXEDPT64_ONE) return FIXEDPT64_E;
	if(inValue >= /*681391*/ 1179648      ) return FIXEDPT64_MAX;
	if(inValue <= /*-772243*/ -1179648     ) return 0;
	#endif
	
fixedpt64 result;

if(inValue == 0) {
	result = FIXEDPT64_ONE;

} 
else if (inValue == FIXEDPT64_ONE) {
	result = FIXEDPT64_E;
}	
else if (inValue >= /*681391*/ 1179648) {
	result = FIXEDPT64_MAX;
}	
else if (inValue <= /*-772243*/ -1179648) {
	result = 0;
}
else {
	

                      
	/* The algorithm is based on the power series for exp(x):
	 * http://en.wikipedia.org/wiki/Exponential_function#Formal_definition
	 * 
	 * From term n, we get term n+1 by multiplying with x/n.
	 * When the sum term drops to zero, we can stop summing.
	 */
            
	// The power-series converges much faster on positive values
	// and exp(-x) = 1/exp(x).
	bool neg = (inValue < 0);
	if (neg) inValue = -inValue;
            
	/*fixedpt64*/ result = inValue + FIXEDPT64_ONE;
	fixedpt64 term = inValue;

	/*uint_fast8_t*/ unsigned char i = 2; 
	bool out_of_loop = false;      
	while ((i < 30) && (out_of_loop == false))
	/*for (i = 2; i < 30; i++)*/
	{
		term = fixedpt64_nomul(term, fixedpt64_div(inValue, fixedpt64_fromint(i)));
		result += term;
                
		if ((term < 500) && ((i > 15) || (term < 20))) {
			/*break;*/
			out_of_loop = true;
		}
		
		// L30nardoSV added
		i++;
	}
            
	if (neg) result = fixedpt64_div(FIXEDPT64_ONE, result);
      
} // End of global if-else
      
	return result;	
}

// ---------------------------------------------------------------------
inline fixedpt64
fixedpt64_sqrt(fixedpt64 inValue)
{
	bool  neg = (inValue < 0);
	unsigned long  num = (neg ? -inValue : inValue);
	unsigned long  result = 0;
	unsigned long  bit;
	unsigned char  n;
	
	// Many numbers will be less than 15, so
	// this gives a good balance between time spent
	// in if vs. time spent in the while loop
	// when searching for the starting value.
	/*
	if (num & 0xFFF00000)
	*/
	if (num & 0xFFFFFFFFFFF00000)
		bit = (unsigned long)1 << /*30*/ 62;
	else
		bit = (unsigned long)1 << /*18*/ 18;
	
	while (bit > num) bit >>= 2;
	
	// The main part is executed twice, in order to avoid
	// using 64 bit values in computations.
	// using 128 bit values in computations.
	for (n = 0; n < 2; n++)
	{
		// First we get the top 24 bits of the answer.
		while (bit)
		{
			if (num >= result + bit)
			{
				num -= result + bit;
				result = (result >> 1) + bit;
			}
			else
			{
				result = (result >> 1);
			}
			bit >>= 2;
		}
		
		if (n == 0)
		{
			// Then process it again to get the lowest 8 bits.
			if (num > 65535)
			{
				// The remainder 'num' is too large to be shifted left
				// by 16, so we have to add 1 to result manually and
				// adjust 'num' accordingly.
				// num = a - (result + 0.5)^2
				//	 = num + result^2 - (result + 0.5)^2
				//	 = num - result - 0.5
				num -= result;
				num = (num << 16) - 0x8000;
				result = (result << 16) + 0x8000;
			}
			else
			{
				num <<= 16;
				result <<= 16;
			}
			
			bit = 1 << 14;
		}
	}

	return (neg ? -(fixedpt64)result : (fixedpt64)result);
}

// ---------------------------------------------------------------------
#endif

