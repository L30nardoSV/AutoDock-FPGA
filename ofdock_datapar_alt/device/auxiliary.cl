//#include "calc_energy.cl"

// -------------------------------------------------------
//
// -------------------------------------------------------
unsigned int gpu_rand(__global unsigned int* restrict prng_states)

//The GPU device function generates a random int
//with a linear congruential generator.
//Each thread (supposing num_of_runs*pop_size blocks and NUM_OF_THREADS_PER_BLOCK threads per block)
//has its own state which is stored in the global memory area pointed by
//prng_states (thread with ID tx in block with ID bx stores its state in prng_states[bx*NUM_OF_THREADS_PER_BLOCK+$
//The random number generator uses the gcc linear congruential generator constants.
{
        unsigned int state;

#if defined (REPRO)
	state = 1;
#else
        //current state of the threads own PRNG
        //state = prng_states[get_group_id(0)*NUM_OF_THREADS_PER_BLOCK + get_local_id(0)];
	state = prng_states[get_global_id(0)];

        //calculating next state
        state = (RAND_A*state+RAND_C);
#endif
        //saving next state to memory
        //prng_states[get_group_id(0)*NUM_OF_THREADS_PER_BLOCK + get_local_id(0)] = state;
	prng_states[get_global_id(0)] = state;

        return state;
}

// -------------------------------------------------------
//
// -------------------------------------------------------
float gpu_randf(__global unsigned int* restrict prng_states)

//The GPU device function generates a
//random float greater than (or equal to) 0 and less than 1.
//It uses gpu_rand() function.
{
        float state;

	//state will be between 0 and 1
#if defined (REPRO)
	state = 0.55f; //0.55f;
#else
	#if defined (NATIVE_PRECISION)
	state =  native_divide(gpu_rand(prng_states),MAX_UINT)*0.999999f;
	#elif defined (HALF_PRECISION)
	state =  half_divide(gpu_rand(prng_states),MAX_UINT)*0.999999f;
	#else	// Full precision // from 151 to 152
	//state = ((float) gpu_rand(prng_states))/MAX_UINT*0.999999f;
	state = (((float) gpu_rand(prng_states))/MAX_UINT)*0.999999f;
	#endif	
#endif

        return state;
}

// -------------------------------------------------------
//
// -------------------------------------------------------
void map_angle(__local float* angle)

//The GPU device function maps
//the input parameter to the interval 0...360
//(supposing that it is an angle).
{
        while (*angle >= 360.0f)
                *angle -= 360.0f;

        while (*angle < 0.0f)
                *angle += 360.0f;
}

// -------------------------------------------------------
//
// -------------------------------------------------------
