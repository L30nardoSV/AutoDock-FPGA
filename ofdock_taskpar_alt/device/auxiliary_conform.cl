// --------------------------------------------------------------------------
// The function returns the moving vector in the second parameter 
// which moves the ligand (that is, its geometrical center point) 
// given by the first parameter to the origo).
// Originally from: processligand.c
// --------------------------------------------------------------------------
void get_movvec_to_origo(        const uint   myligand_num_of_atoms,
			 __local const float* myligand_atom_idxyzq,
				       float* movvec)
{
	float tmp_x = 0.0f, tmp_y = 0.0f, tmp_z = 0.0f; 
	uint i, i_times_5;

	// **********************************************
	// ADD VENDOR SPECIFIC PRAGMA
	// **********************************************
	LOOP_GET_MOVVEC_TO_ORIGO:
	for (i=0; i<myligand_num_of_atoms; i++) {
		i_times_5 = i*5;
		tmp_x += myligand_atom_idxyzq [i_times_5+1];
		tmp_y += myligand_atom_idxyzq [i_times_5+2];
		tmp_z += myligand_atom_idxyzq [i_times_5+3];
	}

	// **********************************************
	// CALCULATE -1/myligand_num_of_atoms in the host
	// **********************************************
	#if defined (OPT_MATH)
	movvec [0] = native_divide(-1*tmp_x, myligand_num_of_atoms);
	movvec [1] = native_divide(-1*tmp_y, myligand_num_of_atoms);
	movvec [2] = native_divide(-1*tmp_z, myligand_num_of_atoms);
	#else
	movvec [0] = -1*tmp_x/myligand_num_of_atoms;
	movvec [1] = -1*tmp_y/myligand_num_of_atoms;
	movvec [2] = -1*tmp_z/myligand_num_of_atoms;
	#endif
}

// --------------------------------------------------------------------------
// The function moves the ligand given by the first parameter 
// according to the vector given by the second one.
// Originally from: processligand.c
// --------------------------------------------------------------------------
void move_ligand(        const uint   myligand_num_of_atoms,
	 	 __local       float* myligand_atom_idxyzq, 
			 const float* movvec)
{
	uint i, i_times_5;

	// **********************************************
	// ADD VENDOR SPECIFIC PRAGMA
	// **********************************************
	LOOP_MOVE_LIGAND:
	for (i=0; i<myligand_num_of_atoms; i++) {
		i_times_5 = i*5;
		myligand_atom_idxyzq [i_times_5+1] += movvec [0];
		myligand_atom_idxyzq [i_times_5+2] += movvec [1];
		myligand_atom_idxyzq [i_times_5+3] += movvec [2];
	}
}

// --------------------------------------------------------------------------
// The function rotates the point given by the first parameter 
// around an axis which is parallel to vector normvec and 
// which can be moved to the origo with vector movvec. 
// The direction of rotation with angle 
// is considered relative to normvec according to right hand rule. 
// Originally from: miscallenous.c
// --------------------------------------------------------------------------
void rotate_custom(__local float* point, 
	    	   const float movvec_x,  
		   const float movvec_y,
		   const float movvec_z,
	    	   const float normvec_x,
		   const float normvec_y,
		   const float normvec_z,
	    	   const float angle)
{
	float point_temp0, point_temp1, point_temp2;

	KernelQuaternion quatrot_left, quatrot_right, quatrot_temp;
	float anglediv2, cos_anglediv2, sin_anglediv2;

	//the point must be moved according to moving vector
	point_temp0 = point [0] - movvec_x;	// point [0] = point [0] - movvec_x;
	point_temp1 = point [1] - movvec_y;	// point [1] = point [1] - movvec_y;
	point_temp2 = point [2] - movvec_z;	// point [2] = point [2] - movvec_z;

	#if defined (DEBUG_ROTATE)
	printf("Moving vector coordinates (x,y,z): %f, %f, %f\n", movvec_x,movvec_y,movvec_z);
	printf("Unit vector coordinates (x,y,z):   %f, %f, %f\n", normvec_x,normvec_y,normvec_z);
	#endif

	//Related equations:
	//q = quater_w+i*quater_x+j*quater_y+k*quater_z
	//v = i*point_x+j*point_y+k*point_z
	//The coordinates of the rotated point can be calculated as:
	//q*v*(q^-1), where
	//q^-1 = quater_w-i*quater_x-j*quater_y-k*quater_z
	//and * is the quaternion multiplication defined as follows:
	//(a1+i*b1+j*c1+k*d1)*(a2+i*b2+j*c2+k*d2) = (a1a2-b1b2-c1c2-d1d2)+
	//i*(a1b2+a2b1+c1d2-c2d1)+
	//j*(a1c2+a2c1+b2d1-b1d2)+
	//k*(a1d2+a2d1+b1c2-b2c1)

	//anglediv2 = (*angle)/2/180*M_PI; 
	anglediv2 = angle*DEG_TO_RAD_DIV_2; 

	#if defined (NATIVE_PRECISION)
	cos_anglediv2 = native_cos(anglediv2);
	sin_anglediv2 = native_sin(anglediv2);
	#else
	cos_anglediv2 = cos(anglediv2);
	sin_anglediv2 = sin(anglediv2);
	#endif

	//rotation quaternion
	quatrot_left.q = cos_anglediv2;
	quatrot_left.x = sin_anglediv2*normvec_x;
	quatrot_left.y = sin_anglediv2*normvec_y;
	quatrot_left.z = sin_anglediv2*normvec_z;

	//inverse of rotation quaternion
	quatrot_right.q = quatrot_left.q;
	quatrot_right.x = 0 - quatrot_left.x; // quatrot_right.x = -1.0f*quatrot_left.x;
	quatrot_right.y = 0 - quatrot_left.y; // -1.0f*quatrot_left.y;
	quatrot_right.z = 0 - quatrot_left.z; // -1.0f*quatrot_left.z;

	#if defined (DEBUG_ROTATE)
	printf("q (w,x,y,z): %f, %f, %f, %f\n", quatrot_left.q, quatrot_left.x, quatrot_left.y, quatrot_left.z);
	printf("q^-1 (w,x,y,z): %f, %f, %f, %f\n", quatrot_right.q, quatrot_right.x, quatrot_right.y, quatrot_right.z);
	printf("v (w,x,y,z): %f, %f, %f, %f\n", 0.0f, point_temp0, point_temp1, point_temp2);
	#endif

	//Quaternion multiplications
	//Since the q field of v is 0 as well as the result's q element, 
	//simplifications can be made...

	// Some redundant additions were removed
	quatrot_temp.q = 0 - quatrot_left.x*point_temp0 - quatrot_left.y*point_temp1 - quatrot_left.z*point_temp2;
	quatrot_temp.x = quatrot_left.q*point_temp0 + quatrot_left.y*point_temp2 - quatrot_left.z*point_temp1;
	quatrot_temp.y = quatrot_left.q*point_temp1 - quatrot_left.x*point_temp2 + quatrot_left.z*point_temp0;
	quatrot_temp.z = quatrot_left.q*point_temp2 + quatrot_left.x*point_temp1 - quatrot_left.y*point_temp0;

	#if defined (DEBUG_ROTATE)
	printf("q*v (w,x,y,z): %f, %f, %f, %f\n", quatrot_temp.q, quatrot_temp.x, quatrot_temp.y, quatrot_temp.z);
	#endif

	point_temp0 = quatrot_temp.q*quatrot_right.x + quatrot_temp.x*quatrot_right.q + quatrot_temp.y*quatrot_right.z - quatrot_temp.z*quatrot_right.y;
	point_temp1 = quatrot_temp.q*quatrot_right.y - quatrot_temp.x*quatrot_right.z + quatrot_temp.y*quatrot_right.q + quatrot_temp.z*quatrot_right.x;
	point_temp2 = quatrot_temp.q*quatrot_right.z + quatrot_temp.x*quatrot_right.y - quatrot_temp.y*quatrot_right.x + quatrot_temp.z*quatrot_right.q;

	#if defined (DEBUG_ROTATE)
	printf("q*v*q^-1 (w,x,y,z): %f, %f, %f, %f\n", 0.0f, point_temp0, point_temp1, point_temp2);
	#endif

	//Moving the point back
	point [0] = point_temp0 + movvec_x;
	point [1] = point_temp1 + movvec_y;
	point [2] = point_temp2 + movvec_z;

	#if defined (DEBUG_ROTATE)
	printf("rotated point (x,y,z): %f, %f, %f\n\n", point [0], point [1], point [2]);
	#endif
}
