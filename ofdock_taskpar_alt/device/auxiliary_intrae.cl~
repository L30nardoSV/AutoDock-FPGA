// --------------------------------------------------------------------------
// --------------------------------------------------------------------------
float sqrt_custom(const float x)
// sqrt7
////https://www.codeproject.com/Articles/69941/Best-Square-Root-Method-Algorithm-Function-Precisi
{
	uint i = as_uint(x);	//uint i = *(uint*) &x; 
   	i  += 127 << 23;	// adjust bias
  	i >>= 1; 		// approximation of square root
	return as_float(i);	//return *(float*) &i;
}  

// --------------------------------------------------------------------------
// --------------------------------------------------------------------------
// Original function name "distance" had to be changed to "distance_custom" as
// OpenCL provides a distance function

float distance_custom(__local const float* point1,
	              __local const float* point2)

//Returns the distance between point1 and point2 
//The arrays have to store the x, y and z coordinates of the point, respectively.
//---------------------------------
//Originally from: miscallenous.c
//---------------------------------
{
	float sub1, sub2, sub3;
	sub1 = point1 [0] - point2 [0];
	sub2 = point1 [1] - point2 [1];
	sub3 = point1 [2] - point2 [2];

	float temp_sqroot;
	temp_sqroot = sub1*sub1 + sub2*sub2 + sub3*sub3;	
	//printf("native: %f ... ", native_sqrt(temp_sqroot));
	#if defined (NATIVE_PRECISION)
	temp_sqroot = sqrt_custom(temp_sqroot);			
	//printf("approx: %f\n", temp_sqroot);
	#else
	temp_sqroot = sqrt(temp_sqroot);	
	#endif
	return temp_sqroot;					
}
// --------------------------------------------------------------------------
// --------------------------------------------------------------------------
