// --------------------------------------------------------------------------
// The function maps the first parameter into the interval 0..ang_max
// by adding/subtracting n*ang_max to/from it.
// Originally from: searchoptimum.c
// --------------------------------------------------------------------------
/*
void map_angle(__local float* angle, const float ang_max)
{
	float x = (*angle);


	// **********************************************
	// ADD VENDOR SPECIFIC PRAGMA
	// **********************************************
	LOOP_WHILE_MAP_ANGLE_1:
	while (x < 0.0f) {
		x += ang_max;
	}

	// **********************************************
	// ADD VENDOR SPECIFIC PRAGMA
	// **********************************************
	LOOP_WHILE_MAP_ANGLE_2:
	while (x > ang_max) {
		x -= ang_max;
	}

	(*angle) = x;
}
*/

/*
void map_angle_180(__local float* angle)
{
	float x = (*angle);

	while (x < 0.0f) {
		x += 180.0f;
	}

	while (x > 180.0f) {
		x -= 180.0f;
	}

	(*angle) = x;
}

void map_angle_360(__local float* angle)
{
	float x = (*angle);

	while (x < 0.0f) {
		x += 360.0f;
	}

	while (x > 360.0f) {
		x -= 360.0f;
	}

	(*angle) = x;
}
*/










// **********************************************
// **********************************************
// **********************************************
// **********************************************

float map_angle_180(float angle)
{
	float x = angle;

	while (x < 0.0f) {
		x += 180.0f;
	}
	
	while (x > 180.0f) {
		x -= 180.0f;
	}

	return x;
}

// **********************************************
// **********************************************
// **********************************************
// **********************************************

	
/*
float map_angle_180(float angle)
{
	float x = angle;

	bool lt180n       = false;
	//bool gt180n_lt0   = false;
	//bool gt0_lt180p	  = false;
	bool gt180p	  = false;	

	if (x < -180.0f){
		lt180n = true;	
		x = -1*x;			
	}
	else {
		if (x < 0) {
			//gt180n_lt0 = true;
			x = x + 180.0f;
		}
		else {	// x is positive

			//if (x < 180.0f) {
			//	gt0_lt180p = true;
			//}
			//else {
			//	gt180p = true;			
			//}	

			if (x > 180.0f) {
				gt180p = true;			
			}		
		}
	}
	
	if ((lt180n==true) || (gt180p==true)) {
		while(x > 180.0f) {
			x -= 180.0f;
		}
		
		if (lt180n==true) {
			x = 180.0f-x;
		}
	}

	return x;
}
*/

// **********************************************
// **********************************************
// **********************************************
// **********************************************

float map_angle_360(float angle)
{
	float x = angle;

	while (x < 0.0f) {
		x += 360.0f;
	}

	while (x > 360.0f) {
		x -= 360.0f;
	}

	return x;
}

// **********************************************
// **********************************************
// **********************************************
// **********************************************


/*
float map_angle(float angle, const float limit)
{
	float x = angle;

	bool lt_nlimit = false;
	bool gt_plimit = false;	

	if (x < -limit){
		lt_nlimit = true;	
		x = -1*x;			
	}
	else {
		if (x < 0) {
			x = x + limit;
		}
		else {	// x is positive
			if (x > limit) {
				gt_plimit = true;			
			}		
		}
	}
	
	if ((lt_nlimit==true) || (gt_plimit==true)) {
		while(x > limit) {
			x -= limit;
		}
		
		if (lt_nlimit==true) {
			x = limit-x;
		}
	}

	return x;
}
*/

// --------------------------------------------------------------------------
// The function finds the best entity based on the energy value 
// i.e. sum of the 38th and 39th element
// and returns its ID in the best_entity parameter. 
// The pop_size parameter must be equal to the population size.
// Originally from: searchoptimum.c
// --------------------------------------------------------------------------
uint find_best(__local        float* restrict loc_energies,
		        const uint pop_size)
{
	ushort best_entity = 0;

	for (ushort i=1; i<pop_size; i++) {
		#if defined (DEBUG_FIND_BEST)
		printf("iteration: %u, energy_iteration_entity: %f, best_entity: %u, energy_best_entity: %f ...", 
			i, loc_energies[i], best_entity, loc_energies[best_entity]);
		#endif
				
		if (loc_energies[best_entity] > loc_energies[i])
		{
			best_entity = i;
			
			#if defined (DEBUG_FIND_BEST)
			printf("RES: best_entity: %u, energy_best_entity: %f\n",
			       best_entity, 
			       loc_energies[best_entity]);
			#endif
	
		}

		#if defined (DEBUG_FIND_BEST)
		printf("\n");
		#endif
	}

	return best_entity;
}

// --------------------------------------------------------------------------
// --------------------------------------------------------------------------
float myrand(uint* prng)
{
	*prng = RAND_A*(*prng) + RAND_C;
	return convert_float(*prng/MAX_UINT)*0.999999f;	
}

// --------------------------------------------------------------------------
// --------------------------------------------------------------------------
uint myrand_uint(uint* prng, const uint limit)
{
	*prng = RAND_A*(*prng) + RAND_C;
	return  (*prng/MAX_UINT)*limit;	
}

// --------------------------------------------------------------------------
// The function performs binary tournament selection. 
// The first parameter must containt the population data. 
// rand_level is the probability with which the new entity should be selected as parent. 
// The two selected parents are returned in the parent1 and parent2 parameters.
// Originally from: searchoptimum.c
// --------------------------------------------------------------------------
void binary_tournament_selection(               uint*           prng,
				 __local        float* restrict loc_energies,
				                uint*           parent1, 
				                uint*           parent2,
					  const uint            pop_size,  
				          const float           rand_level)
{
	uint parent_candidates [2];

	parent_candidates [0] = myrand_uint(prng, pop_size);
	parent_candidates [1] = myrand_uint(prng, pop_size);

	if (loc_energies[parent_candidates[0]] < loc_energies[parent_candidates[1]])
	{
		if (myrand(prng) < rand_level) {
			*parent1 = parent_candidates [0];}
		else	{
			*parent1 = parent_candidates [1];}
	}
	else
	{
		if (myrand(prng) < rand_level) {
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
	parent_candidates [0] = myrand_uint(prng, pop_size);
	parent_candidates [1] = myrand_uint(prng, pop_size);

	//the better will be the second parent
	if (loc_energies[parent_candidates[0]] < loc_energies[parent_candidates[1]])
	{
		if (myrand(prng) < rand_level) {
			*parent2 = parent_candidates [0];}
		else		          	       {
			*parent2 = parent_candidates [1];}
	}
	else
	{
		if (myrand(prng) < rand_level) {
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
// generates two offsprings from two parents whose genotypes are the functions parameters. 
// Mutation rate is the probability of mutating a gene in %, 
// abs_max_dmov and abs_max_dang are the maximal delta values of a translation 
// or an orientation/rotatable bond gene during mutation.
// Originally from: searchoptimum.c
// --------------------------------------------------------------------------
void gen_new_genotype(	                uint*           prng,
		      /*__local*/ const float*          parent1_genotype,
		      /*__local*/ const float*          parent2_genotype, 
		              const float           mutation_rate,
			      const float           abs_max_dmov,
			      const float           abs_max_dang,
			      const float           crossover_rate,
		      __local       float*          offspring_genotype)
{
	uint covr_point_low, covr_point_high;
	uint temp1, temp2;

	temp1 = myrand_uint(prng, ACTUAL_GENOTYPE_LENGTH-1);
	temp2 = myrand_uint(prng, ACTUAL_GENOTYPE_LENGTH-1);

	//if (temp1 < temp2) {covr_point_low = temp1;
	//		    covr_point_high = temp2;}
	//else {		    covr_point_low = temp2;
	//		    covr_point_high = temp1;}


	float priv_offspring_genotype [ACTUAL_GENOTYPE_LENGTH];



	bool twopoint_cross_yes = false;
	if (temp1 == temp2)
	{	
		covr_point_low = temp1;
	}
	else
	{
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

	//performing crossover
	if (crossover_rate > 100*myrand(prng))
	{
		//two-point crossover
		//if (covr_point_low != covr_point_high)
		if (twopoint_cross_yes == true)
		{
			for (uchar i=0; i<ACTUAL_GENOTYPE_LENGTH; i++)
			{
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
			for (uchar i=0; i<ACTUAL_GENOTYPE_LENGTH; i++)
			{
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
		for (uchar i=0; i<ACTUAL_GENOTYPE_LENGTH; i++)
		{
			//offspring_genotype [i] = parent1_genotype[i];
			priv_offspring_genotype [i] = parent1_genotype[i];
		}

		#if defined (DEBUG_GEN_NEW_GENOTYPE)
		printf("No crossover, offsprings' genotypes equals to those of the parents\n");
		#endif
	}

	//performing mutation

	////mutating first offspring
	//// THIS LOOP IS NOT PIPELINED AS IT CONTAINS ANOTHER LOOP
	////__attribute__ ((xcl_pipeline_loop))
	//LOOP_GEN_NEW_GENOTYPE_4:
	
//	for (i=0; i<num_of_genes; i++)
//	{
//		if (mutation_rate > 100.0f*myrand(GlobPRNG))
//		{
//			if (i < 3)
//			{
//				offspring_genotype [i] = offspring1genotype [i] + 2.0f*abs_max_dmov*myrand(GlobPRNG)-abs_max_dmov;
//			}
//			else
//			{
//				offspring_genotype [i] = (offspring_genotype [i] + 2.0f*abs_max_dang*myrand(GlobPRNG)-abs_max_dang);
//
//				if (i == 4) {map_angle(&(offspring_genotype [i]), 180.0f);}	//mapping angle to 0..180
//				else        {map_angle(&(offspring_genotype [i]), 360.0f);}	//mapping angle to 0..360
//
//			}
//		}
//	}


	for (uchar i=0; i<3; i++)
	{
		if (mutation_rate > 100*myrand(prng))
		{
			priv_offspring_genotype [i] = priv_offspring_genotype [i] + 2*abs_max_dmov*myrand(prng)-abs_max_dmov;
		}
	}

	if (mutation_rate > 100*myrand(prng))
	{
		//priv_offspring_genotype [3] = priv_offspring_genotype [3] + 2*abs_max_dmov*myrand(prng)-abs_max_dmov;
		priv_offspring_genotype [3] = priv_offspring_genotype [3] + 2*abs_max_dang*myrand(prng)-abs_max_dang;
		priv_offspring_genotype [3] = map_angle_360(priv_offspring_genotype [3]);
	}
		
	if (mutation_rate > 100*myrand(prng))
	{
		priv_offspring_genotype [4] = priv_offspring_genotype [4] + 2*abs_max_dang*myrand(prng)-abs_max_dang;
		priv_offspring_genotype [4] = map_angle_180(priv_offspring_genotype [4]);
	}

	for (uchar i=5; i<ACTUAL_GENOTYPE_LENGTH; i++)
	{
		if (mutation_rate > 100*myrand(prng))
		{
			priv_offspring_genotype [i] = priv_offspring_genotype [i] + 2*abs_max_dang*myrand(prng)-abs_max_dang;
			priv_offspring_genotype [i] = map_angle_360(priv_offspring_genotype [i]);
		}
	}

	#if defined (DEBUG_GEN_NEW_GENOTYPE)
	printf("Offspring1 after mutation: ");
	for (i=0; i<ACTUAL_GENOTYPE_LENGTH; i++) {printf("%f ", offspring_genotype [i]);} printf("\n");
	#endif

	for (uchar i=0; i< ACTUAL_GENOTYPE_LENGTH; i++) {
		offspring_genotype [i] = priv_offspring_genotype [i];
	}
}
