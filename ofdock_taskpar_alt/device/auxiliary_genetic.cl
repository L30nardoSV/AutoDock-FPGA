// --------------------------------------------------------------------------
// These functions map the argument into the interval 0 - 180, or 0 - 360
// by adding/subtracting n*ang_max to/from it.
// Originally from: searchoptimum.c
// --------------------------------------------------------------------------

float map_angle_180(float angle)
{
	float x = angle;

	//while (x < 0.0f) {
	if (x < 0.0f) {
		x += 180.0f;
	}
	
	//while (x > 180.0f) {
	if (x > 180.0f) {
		x -= 180.0f;
	}

	return x;
}

float map_angle_360(float angle)
{
	float x = angle;

	//while (x < 0.0f) {
	if (x < 0.0f) {
		x += 360.0f;
	}

	//while (x > 360.0f) {
	if (x > 360.0f) {
		x -= 360.0f;
	}

	return x;
}

// --------------------------------------------------------------------------
// The function finds the best entity based on the energy value 
// and returns its ID in the best_entity parameter. 
// The pop_size parameter must be equal to the population size.
// Originally from: searchoptimum.c
// --------------------------------------------------------------------------
#if 1
// current implementation, II (inner loop) = 6
ushort find_best(
	 __local      float* restrict loc_energies,
		const ushort          pop_size) {

	ushort best_entity = 0;

	for (ushort i=1; i<pop_size; i++) {
		if (loc_energies[i] < loc_energies[best_entity]) {
			best_entity = i;
		}
	}

	return best_entity;
}
#endif

// --------------------------------------------------------------------------
// --------------------------------------------------------------------------
#if 0
float myrand(uint* prng)
{
#if defined (REPRO)
	*prng = 1;
#else
	*prng = RAND_A*(*prng) + RAND_C;
#endif

/*
	return convert_float(*prng/MAX_UINT)*0.999999f;	
*/
	float res_tmp = 0.999999f / MAX_UINT;
	res_tmp *= *prng;
	return res_tmp;
}
#endif

float myrand(uint* restrict prng)
{
	uint p_tmp = *prng;

#if defined (REPRO)
	p_tmp = 1;
#else
	p_tmp = RAND_A * p_tmp + RAND_C;
#endif
	*prng = p_tmp;

	float res_tmp = 0.999999f / MAX_UINT;
	res_tmp *= p_tmp;	
	return res_tmp;
}

float myrand_local(__local uint* restrict prng)
{
	uint p_tmp = *prng;

#if defined (REPRO)
	p_tmp = 1;
#else
	p_tmp = RAND_A * p_tmp + RAND_C;
#endif
	*prng = p_tmp;

	float res_tmp = 0.999999f / MAX_UINT;
	res_tmp *= p_tmp;	
	return res_tmp;
}

// --------------------------------------------------------------------------
// --------------------------------------------------------------------------
/*uint myrand_uint(uint* prng, const uint limit)*/
uint myrand_uint(uint* restrict prng, const ushort limit)
{
#if defined (REPRO)
	*prng = 1;
#else
	*prng = RAND_A*(*prng) + RAND_C;
#endif
	return  (*prng/MAX_UINT)*limit;
}

// --------------------------------------------------------------------------
// --------------------------------------------------------------------------
ushort myrand_ushort(uint* restrict prng, const ushort limit)
{
#if defined (REPRO)
	*prng = 1;
#else
	*prng = RAND_A*(*prng) + RAND_C;
#endif
	return (*prng/MAX_UINT)*limit;
	//return ((*prng >> 31)*limit) & 0xFFFF;
}

ushort myrand_local_ushort(__local uint* restrict prng, const ushort limit)
{
#if defined (REPRO)
	*prng = 1;
#else
	*prng = RAND_A*(*prng) + RAND_C;
#endif
	return (*prng/MAX_UINT)*limit;
	//return ((*prng >> 31)*limit) & 0xFFFF;
}

// --------------------------------------------------------------------------
// --------------------------------------------------------------------------
uchar myrand_uchar(uint* restrict prng, const uchar limit)
{
#if defined (REPRO)
	*prng = 1;
#else
	*prng = RAND_A*(*prng) + RAND_C;
#endif
	return (*prng/MAX_UINT)*limit;
	//return ((*prng >> 31)*limit) & 0xFF;
}

uchar myrand_local_uchar(__local uint* restrict prng, const uchar limit)
{
#if defined (REPRO)
	*prng = 1;
#else
	*prng = RAND_A*(*prng) + RAND_C;
#endif
	return (*prng/MAX_UINT)*limit;
	//return ((*prng >> 31)*limit) & 0xFF;
}

// --------------------------------------------------------------------------
// The function performs binary tournament selection. 
// rand_level is the probability with which the new entity should be selected as parent. 
// The two selected parents are returned in the parent1 and parent2 parameters.
// Originally from: searchoptimum.c
// --------------------------------------------------------------------------
void binary_tournament_selection(              
						/*uint*           prng,*/
						uint*  restrict prngA,
						uint*  restrict prngB,
						uint*  restrict prngC,
						uint*  restrict prngD,
						uint*  restrict prngE,
					        uint*  restrict prngF,
				 __local        float* restrict loc_energies,
				                ushort*         parent1, 
				                ushort*         parent2,
 					  const ushort          pop_size, 
				          const float           rand_level)
{
	ushort parent_candidates [2];

	//parent_candidates [0] = myrand_ushort(prng, pop_size);
	parent_candidates [0] = myrand_ushort(prngA, pop_size);

#if defined (REPRO)
	parent_candidates [1] = myrand_uint(prng, pop_size) + 1;
#else
	//parent_candidates [1] = myrand_ushort(prng, pop_size);
	parent_candidates [1] = myrand_ushort(prngB, pop_size);
#endif

	if (loc_energies[parent_candidates[0]] < loc_energies[parent_candidates[1]]) {
		//if (myrand(prng) < rand_level) {
		if (myrand(prngC) < rand_level) {
			*parent1 = parent_candidates [0];}
		else	{
			*parent1 = parent_candidates [1];}
	}
	else {
		//if (myrand(prng) < rand_level) {
		if (myrand(prngC) < rand_level) {
			*parent1 = parent_candidates [1];}
		else	{
			*parent1 = parent_candidates [0];}	
	}

	#if defined (DEBUG_TOURNAMENT_SELECTION)
	printf("Selecting first parent: %u (candidates were %u (E=%f) and %u (E=%f))\n", *parent1, 
		parent_candidates [0], GlobEnergyCurrent [parent_candidates [0]],
		parent_candidates [1], GlobEnergyCurrent [parent_candidates [1]]);
	#endif

	//generating two different parent candidates (which differ from parent1 as well)
#if defined (REPRO)
	parent_candidates [0] = myrand_uint(prng, pop_size) + 2;
	parent_candidates [1] = myrand_uint(prng, pop_size) + 3;
#else
	//parent_candidates [0] = myrand_ushort(prng, pop_size);
	//parent_candidates [1] = myrand_ushort(prng, pop_size);

	parent_candidates [0] = myrand_ushort(prngD, pop_size);
	parent_candidates [1] = myrand_ushort(prngE, pop_size);
#endif

	//the better will be the second parent
	if (loc_energies[parent_candidates[0]] < loc_energies[parent_candidates[1]]) {
		//if (myrand(prng) < rand_level) {
		if (myrand(prngF) < rand_level) {
			*parent2 = parent_candidates [0];}
		else		          	       {
			*parent2 = parent_candidates [1];}
	}
	else {
		//if (myrand(prng) < rand_level) {
		if (myrand(prngF) < rand_level) {
			*parent2 = parent_candidates [1];}
		else			               {
			*parent2 = parent_candidates [0];}	
	}

	#if defined (DEBUG_TOURNAMENT_SELECTION)
	printf("Selecting second parent: %u (candidates were %u (E=%f) and %u (E=%f))\n", *parent2,
	       parent_candidates [0], GlobEnergyCurrent [parent_candidates [0]] ,
	       parent_candidates [1], GlobEnergyCurrent [(arent_candidates [1]]);
	#endif
}

// --------------------------------------------------------------------------
// The function performs crossover and mutation and 
// generates an offspring from two parents whose genotypes are the functions parameters. 
// Mutation rate is the probability of mutating a gene in %, 
// abs_max_dmov and abs_max_dang are the maximal delta values of a translation 
// or an orientation/rotatable bond gene during mutation.
// Originally from: searchoptimum.c
// --------------------------------------------------------------------------
void gen_new_genotype(     
			
					uint* restrict prng,
					uint* restrict prng1,
		   	        const float*  restrict parent1_genotype,
		                const float*  restrict parent2_genotype,
				const ushort           num_genes,
		              	const float            mutation_rate,
			      	const float            abs_max_dmov,
			      	const float            abs_max_dang,
			      	const float            crossover_rate,
		      	 __local      float*  restrict offspring_genotype)
{
	uchar covr_point_low, covr_point_high;
	uchar temp1, temp2;

	temp1 = myrand_uchar(prng, num_genes-1);
	temp2 = myrand_uchar(prng, num_genes-1);

	/*
	temp1 = myrand_local_uchar(&prngGG[0], num_genes-1);
	temp2 = myrand_local_uchar(&prngGG[1], num_genes-1);
	*/

	//if (temp1 < temp2) {covr_point_low = temp1;
	//		    covr_point_high = temp2;}
	//else {		    covr_point_low = temp2;
	//		    covr_point_high = temp1;}


/*
	float priv_offspring_genotype [ACTUAL_GENOTYPE_LENGTH];
*/

	float __attribute__ ((
			      memory,
			      numbanks(1),
			      bankwidth(4),
			      singlepump,
			      numreadports(2),
			      numwriteports(1)
			    )) priv_offspring_genotype [ACTUAL_GENOTYPE_LENGTH]; 



	bool twopoint_cross_yes = false;
	if (temp1 == temp2) {	
		covr_point_low = temp1;
	}
	else {
		twopoint_cross_yes = true;
		if (temp1 < temp2) {
			covr_point_low = temp1;
			covr_point_high = temp2;
		}
		else {		    
			covr_point_low = temp2;
			covr_point_high = temp1;
		}
	}

	#if defined (DEBUG_GEN_NEW_GENOTYPE)
	printf("Crossover points: low: %u, high: %u\n", covr_point_low, covr_point_high);
	printf("Parent1: ");
	for (i=0; i<ACTUAL_GENOTYPE_LENGTH; i++) {printf("%f ", parent1_genotype [i]);} printf("\n");

	printf("Parent2: ");
	for (i=0; i<ACTUAL_GENOTYPE_LENGTH; i++) {printf("%f ", parent2_genotype [i]);} printf("\n");
	#endif


	// =======================================
	// performing crossover
	// =======================================

#if 0
// alternative implementation, crossover split

	if (crossover_rate > myrand(prng))
/*
	if (crossover_rate > myrand(prng1))
*/
	{
		//two-point crossover
		//if (covr_point_low != covr_point_high)
		if (twopoint_cross_yes == true)
		{
			for (uchar i=0; i<num_genes; i++) {
				if ((i<=covr_point_low) || (i>covr_point_high)) 
				{
					//offspring_genotype [i] = parent1_genotype[i];
					priv_offspring_genotype [i] = parent1_genotype[i];
				}
				else {
					//offspring_genotype [i] = parent2_genotype[i];
					priv_offspring_genotype [i] = parent2_genotype[i];
				}
			}
		}
		//one-point crossover
		else {
			for (uchar i=0; i<num_genes; i++) {
				if (i <= covr_point_low)
				{
					//offspring_genotype [i] = parent1_genotype[i];
					priv_offspring_genotype [i] = parent1_genotype[i];
				}
				else {
					//offspring_genotype [i] = parent2_genotype[i];
					priv_offspring_genotype [i] = parent2_genotype[i];
				}
			}
		}

		#if defined (DEBUG_GEN_NEW_GENOTYPE)
		printf("Offspring1 after crossover: ");
		for (i=0; i<ACTUAL_GENOTYPE_LENGTH; i++) {printf("%f ", offspring_genotype [i]);} printf("\n");
		#endif

	}
	else	//if no crossover, the offsprings are the parents
	{
		for (uchar i=0; i<num_genes; i++) {
			//offspring_genotype [i] = parent1_genotype[i];
			priv_offspring_genotype [i] = parent1_genotype[i];
		}

		#if defined (DEBUG_GEN_NEW_GENOTYPE)
		printf("No crossover, offsprings' genotypes equals to those of the parents\n");
		#endif
	}
#endif


#if 1
// Current implementation, crossover compacted, fully pipelined
	///*
	bool crossover_yes = (crossover_rate > myrand(prng));
	//*/
	/*
	bool crossover_yes = (crossover_rate > myrand_local(&prngGG[2]));
	*/

///*
	for (uchar i=0; i<num_genes; i++) {
//*/
/*
	#pragma unroll
	for (uchar i=0; i<ACTUAL_GENOTYPE_LENGTH; i++) {
*/
		if (   	(
			crossover_yes && (										// crossover
			( (twopoint_cross_yes == true)  && ((i <= covr_point_low) || (i > covr_point_high)) )  ||	// two-point crossover 			 		
			( (twopoint_cross_yes == false) && (i <= covr_point_low))  					// one-point crossover
					 )
			) || 
			(!crossover_yes)	// no crossover
		   ) {
			priv_offspring_genotype [i] = parent1_genotype[i];
		}
		else {
			priv_offspring_genotype [i] = parent2_genotype[i];
		}
	}


#endif




	// =======================================
	// performing mutation
	// =======================================
#if 0
// alternative implementation, mutation compacted, fully unrolled, II (GG) = 99

	#pragma unroll
	for (uchar i=0; i<ACTUAL_GENOTYPE_LENGTH; i++) {
		if (mutation_rate > myrand(prng)) {
			if (i < 3) {
				priv_offspring_genotype [i] = priv_offspring_genotype [i] + 2*abs_max_dmov*myrand(prng)-abs_max_dmov;
			}
			else {
				priv_offspring_genotype [i] = priv_offspring_genotype [i] + 2*abs_max_dang*myrand(prng1)-abs_max_dang;

				if (i == 4) {priv_offspring_genotype [4] = map_angle_180(priv_offspring_genotype [4]);}	//mapping angle to 0..180
				else        {priv_offspring_genotype [i] = map_angle_360(priv_offspring_genotype [i]);}	//mapping angle to 0..360
			}
		}
	}
#endif

#if 1
// Current implementation, mutation split, II (GG) = 3
	
	#pragma unroll
	for (uchar i=0; i<3; i++) {
		if (mutation_rate > myrand(prng)) {
			priv_offspring_genotype [i] = priv_offspring_genotype [i] + 2*abs_max_dmov*myrand(prng1)-abs_max_dmov;
		}
	}

	if (mutation_rate > myrand(prng)) {
		priv_offspring_genotype [3] = priv_offspring_genotype [3] + 2*abs_max_dang*myrand(prng1)-abs_max_dang;
		priv_offspring_genotype [3] = map_angle_360(priv_offspring_genotype [3]);
	}
		
	if (mutation_rate > myrand(prng)) {
		priv_offspring_genotype [4] = priv_offspring_genotype [4] + 2*abs_max_dang*myrand(prng1)-abs_max_dang;
		priv_offspring_genotype [4] = map_angle_180(priv_offspring_genotype [4]);
	}
	///*
	for (uchar i=5; i<num_genes; i++) {
		if (mutation_rate > myrand(prng)) {
			priv_offspring_genotype [i] = priv_offspring_genotype [i] + 2*abs_max_dang*myrand(prng1)-abs_max_dang;
			priv_offspring_genotype [i] = map_angle_360(priv_offspring_genotype [i]);
		}
	}
	//*/
	/*
	for (uchar i=5; i<num_genes; i++) {
		if (mutation_rate > myrand(prng)) {
			priv_offspring_genotype [i] = priv_offspring_genotype [i] + 2*abs_max_dang*myrand_local(&prngGG[i])-abs_max_dang;
			priv_offspring_genotype [i] = map_angle_360(priv_offspring_genotype [i]);
		}
	}
	*/
#endif

	#if defined (DEBUG_GEN_NEW_GENOTYPE)
	printf("Offspring1 after mutation: ");
	for (i=0; i<ACTUAL_GENOTYPE_LENGTH; i++) {printf("%f ", offspring_genotype [i]);} printf("\n");
	#endif

	for (uchar i=0; i<num_genes; i++) {
		offspring_genotype [i] = priv_offspring_genotype [i];
	}
}
