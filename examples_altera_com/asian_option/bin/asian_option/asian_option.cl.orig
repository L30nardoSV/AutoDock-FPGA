// Copyright (C) 2013-2016 Altera Corporation, San Jose, California, USA. All rights reserved.
// Permission is hereby granted, free of charge, to any person obtaining a copy of this
// software and associated documentation files (the "Software"), to deal in the Software
// without restriction, including without limitation the rights to use, copy, modify, merge,
// publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to
// whom the Software is furnished to do so, subject to the following conditions:
// The above copyright notice and this permission notice shall be included in all copies or
// substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
// OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
// HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
// WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
// OTHER DEALINGS IN THE SOFTWARE.
// 
// This agreement shall be governed in all respects by the laws of the State of California and
// by the laws of the United States of America.

/*
 * Single Asian Option Pricing
 * Author: Deshanand Singh (dsingh@altera.com)
 *
 * Please see host/src/main.cpp for a complete description of the algorithm
 * and README.txt for a description of the expected output and steps to
 * compile this benchmark.
 *
 */
#pragma OPENCL EXTENSION cl_altera_channels : enable
#pragma OPENCL EXTENSION cl_khr_fp64 : enable

float2 box_muller(float a, float b);

// Mersenne twister constants
#define MT_M 397 
#define MT_N 624 
#define MATRIX_A   0x9908b0dfUL 
#define UPPER_MASK 0x80000000UL 
#define LOWER_MASK 0x7fffffffUL 

// Used to ensure that the uniformly generated random numbers are in the range (0,1)
#define CLAMP_ZERO 0x1.0p-126f 
#define CLAMP_ONE  0x1.fffffep-1f

// In this implementations, we will create vectors of 64 random numbers per clock cycle
// Each of these random numbers will be used to simulate the movement of a stock price
// for a single timestep. In this case, we are simulating 64 timesteps per clock cycle.
#define VECTOR 64 
#define VECTOR_DIV2 32 
#define VECTOR_DIV4 16 

// We will use OpenCL vector types to simplify the code. 64 random numbers can be expressed
// as 4 sets of size-16 vectors provided by OpenCL
typedef float16 vec_float_ty;
typedef uint16 vec_uint_ty;

// 4 channels of random numbers
channel vec_float_ty RANDOM_STREAM_0 __attribute__((depth(8))); 
channel vec_float_ty RANDOM_STREAM_1 __attribute__((depth(8))); 
channel vec_float_ty RANDOM_STREAM_2 __attribute__((depth(8))); 
channel vec_float_ty RANDOM_STREAM_3 __attribute__((depth(8))); 

// 4 channels of unsigned integer types used to initialize the mersenne twister
channel vec_uint_ty INIT_STREAM_0 __attribute__((depth(8))); 
channel vec_uint_ty INIT_STREAM_1 __attribute__((depth(8))); 
channel vec_uint_ty INIT_STREAM_2 __attribute__((depth(8))); 
channel vec_uint_ty INIT_STREAM_3 __attribute__((depth(8))); 

// Double precision ACCUMULATE_STREAM 
// Unfortunately, we do not support channels with a double-precision types at this time
// however, we can get around this with a generic 64-bit channel type 
typedef ulong t_64bit;
channel t_64bit ACCUMULATE_STREAM __attribute__((depth(8)));

#define NUM_THREADS 8192

// This kernel computes the initial state for the mersenne twister RNG
// We've hardcoded the initial seed value to 777, but this could be anything. It could
// even be a parameter to the kernel should the user require control of this value from
// the host.
//
// The code below is slightly complicated because we wish to produce 64 values at a time;
// however, the mersenne twister state has 624 values. This is not evenly divisible by 64
// so there are some initial values that are writtent to the channel which are never used
//
__kernel void mersenne_twister_init(void)
{
    unsigned int state = 777;
    uint ival[VECTOR];
    #pragma unroll VECTOR
    for (int i=0; i<VECTOR; i++) {
       ival[i] = 777;
    }
    for (unsigned int n=0; n<MT_N; n++) {
       #pragma unroll
       for (int i=0; i<VECTOR-1; i++) {
          ival[i] = ival[i+1];
       }
       ival[VECTOR-1] = state;
       state = (1812433253U * (state ^ (state >> 30)) + n) & 0xffffffffUL;
       if ((n & (VECTOR-1)) == 47) {
          vec_uint_ty I0, I1, I2, I3;
          #pragma unroll VECTOR_DIV4
          for (int i=0; i<VECTOR_DIV4; i++) {
             I0[i]=ival[i];
             I1[i]=ival[i+1*VECTOR_DIV4];
             I2[i]=ival[i+2*VECTOR_DIV4];
             I3[i]=ival[i+3*VECTOR_DIV4];
          }
          write_channel_altera(INIT_STREAM_0, I0);
          write_channel_altera(INIT_STREAM_1, I1);
          write_channel_altera(INIT_STREAM_2, I2);
          write_channel_altera(INIT_STREAM_3, I3);
       }
    }
}

// This kernel implements the mersenne twister random number generator. 
// It is almost a direct implementation of the algorithm shown
// here: http://en.wikipedia.org/wiki/Mersenne_twister
//
__kernel void mersenne_twister_generate(ulong N)
{
   unsigned int mt[MT_N];

   bool read_from_initialization = true;
   ushort num_initializers_read = 0;

   for (ulong n=0; n<N/VECTOR+(MT_N/VECTOR+1); n++) {
      uint y[VECTOR];      

      bool write_channel = false;
      if (read_from_initialization) {
         vec_uint_ty I0 = read_channel_altera(INIT_STREAM_0);
         vec_uint_ty I1 = read_channel_altera(INIT_STREAM_1);
         vec_uint_ty I2 = read_channel_altera(INIT_STREAM_2);
         vec_uint_ty I3 = read_channel_altera(INIT_STREAM_3);
         #pragma unroll VECTOR_DIV4
         for (int i=0; i<VECTOR_DIV4; i++) {
            y[i]=I0[i];
            y[i+1*VECTOR_DIV4]=I1[i];
            y[i+2*VECTOR_DIV4]=I2[i];
            y[i+3*VECTOR_DIV4]=I3[i];
         }
         if (++num_initializers_read == MT_N/VECTOR+1) read_from_initialization=false;
      } else {
         // You'll notice quite alot of this design pattern in this particular example
         // We unroll inner loops fully as much as possible. This technique will generally
         // lead to the best performance on the FPGA as long as the resulting pipelined
         // implementation can fit within the avilable resources.
         //
         #pragma unroll VECTOR
         for (int i=0; i<VECTOR; i++) {
            y[i] = (mt[i]&UPPER_MASK)|(mt[i+1]&LOWER_MASK);
            y[i] = mt[i+MT_M] ^ (y[i] >> 1) ^ (y[i] & 0x1UL ? MATRIX_A : 0x0UL);
         }
         write_channel = true;
      }
  
      #pragma unroll 
      for (int i=0; i<MT_N-VECTOR; i++) {
         mt[i]=mt[i+VECTOR];
      }

      float U[VECTOR];
      #pragma unroll VECTOR
      for (int i=0; i<VECTOR; i++) {
         mt[MT_N-VECTOR+i]=y[i];

         // Tempering
         y[i] ^= (y[i] >> 11);
         y[i] ^= (y[i] << 7) & 0x9d2c5680UL;
         y[i] ^= (y[i] << 15) & 0xefc60000UL;
         y[i] ^= (y[i] >> 18);

         U[i] = (float)y[i] / 4294967296.0f;

         if (U[i] == 0.0f) U[i] = CLAMP_ZERO; 
         if (U[i] == 1.0f) U[i] = CLAMP_ONE;
      }

      if (write_channel) {
         vec_float_ty U0, U1, U2, U3; 
         #pragma unroll VECTOR_DIV4
         for (int i=0; i<VECTOR_DIV4; i++) {
            U0[i]=U[i];
            U1[i]=U[i+1*VECTOR_DIV4];
            U2[i]=U[i+2*VECTOR_DIV4];
            U3[i]=U[i+3*VECTOR_DIV4];
         }
         write_channel_altera(RANDOM_STREAM_0, U0);
         write_channel_altera(RANDOM_STREAM_1, U1);
         write_channel_altera(RANDOM_STREAM_2, U2);
         write_channel_altera(RANDOM_STREAM_3, U3);
      }
   }
}

// Box-Muller transform. Create pairs of independent normally distributed
// random numbers from a pair of uniformly distributed random numbers
//
float2 box_muller(float a, float b)
{
   float radius = sqrt(-2.0f * log(a));
   float angle = 2.0f*b;
   float2 result;
   result.x = radius*cospi(angle);
   result.y = radius*sinpi(angle);
   return result;
}

// This kernel performs the geometric brownian motion of the stock prices using the
// random numbers that were generated from the Mersenne Twister. Each thread performs
// an independent batch of (m) paths.
//
__kernel 
__attribute__((reqd_work_group_size(NUM_THREADS,1,1)))
void black_scholes( int m, int n, 
   float drift,
   float vol,
   float S_0,
   float K)
{
   // running statistics -- use double precision for the accumulator
   double sum = 0.0;
	
   // loop over all simulations
   for(int path=0;path<m;path++) {
      float S = S_0;
      float arithmetic_average = 0.0f; // We're not including the initial price in the average
      for (int t_i=0; t_i<n/VECTOR; t_i++) { 
         float U[VECTOR], Z[VECTOR];
         vec_float_ty U0 = read_channel_altera(RANDOM_STREAM_0);
         vec_float_ty U1 = read_channel_altera(RANDOM_STREAM_1);
         vec_float_ty U2 = read_channel_altera(RANDOM_STREAM_2);
         vec_float_ty U3 = read_channel_altera(RANDOM_STREAM_3);

         #pragma unroll VECTOR_DIV4
         for (int i=0; i<VECTOR_DIV4; i++) {
            U[i]=U0[i];
            U[i+1*VECTOR_DIV4]=U1[i];
            U[i+2*VECTOR_DIV4]=U2[i];
            U[i+3*VECTOR_DIV4]=U3[i];
         }
        
         #pragma unroll VECTOR_DIV2 
         for (int i=0; i<VECTOR_DIV2; i++) {
            float2 z = box_muller(U[2*i], U[2*i+1]);
            Z[2*i] = z.x;
            Z[2*i+1] = z.y;
         }

         #pragma unroll VECTOR
         for (int i=0; i<VECTOR; i++) {
            // Convert uniform distribution to normal 
            float gauss_rnd = Z[i];

            // Simulate the path movement using geometric brownian motion 
            S *= drift * exp(vol * gauss_rnd);
            arithmetic_average += S;
         }
      }
      arithmetic_average /= (float)(n);

      // Check if the average value exceeds the strike price
      float call_value = arithmetic_average - K;
      if (call_value > 0.0f) {
         sum += call_value;
      }
   }
   // send a final result to the accumulate kernel after each thread has already accumulated (m) paths
   write_channel_altera(ACCUMULATE_STREAM, *(t_64bit*)&sum);
}

// This kernel performs the final reduction across all simulation paths that are computed from 
// the multithreaded black scholes kernel
// A single result is written back to global memory. The host can use this to compute the discounted
// price of the asian option.
//
__kernel void accumulate_partial_results(__global double *result)
{
   double total_sum = 0.0;
   for(int i=0; i<NUM_THREADS; i++) {
      t_64bit ul_partial_sum = read_channel_altera(ACCUMULATE_STREAM);
      total_sum += *(double*)&ul_partial_sum;
   }
   *result = total_sum;
}

