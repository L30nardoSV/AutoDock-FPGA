#include "../defines.h"

// --------------------------------------------------------------------------
// The function maps the first parameter into the interval 0..ang_max
// by adding/subtracting n*ang_max to/from it.
// Originally from: searchoptimum.c
// --------------------------------------------------------------------------
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

// --------------------------------------------------------------------------
// The function finds the best entity based on the energy value 
// i.e. sum of the 38th and 39th element
// and returns its ID in the best_entity parameter. 
// The pop_size parameter must be equal to the population size.
// Originally from: searchoptimum.c
// --------------------------------------------------------------------------
uint find_best(__global const float* restrict GlobPopulation, 
	       __local        float* restrict loc_pop_i,
	       __local        float* restrict loc_pop_energies,
		        const uint pop_size)
{
	uint i;
	uint best_entity = 0;

	// **********************************************
	// ADD VENDOR SPECIFIC PRAGMA
	// **********************************************
	LOOP_FIND_BEST_1:
	for (i=0; i<pop_size; i++) {
	//for (i=0; i<CPU_MAX_POP_SIZE; i++) {
		async_work_group_copy(loc_pop_i+i*2, GlobPopulation+(i*40)+38, 2, 0);
		loc_pop_energies[i] = loc_pop_i[i*2] + loc_pop_i[i*2+1];
	}

	// **********************************************
	// ADD VENDOR SPECIFIC PRAGMA
	// *********************************************
	LOOP_FIND_BEST_2:
	for (i=1; i<pop_size+1; i++) {

		#if defined (DEBUG_FIND_BEST)
		printf("iteration: %u, energy_iteration_entity: %f, best_entity: %u, energy_best_entity: %f ...", 
			i, loc_pop_energies[i], best_entity, loc_pop_energies[best_entity]);
		#endif
		
		if (loc_pop_energies[best_entity] > loc_pop_energies[i])    
		{
			best_entity = i;
			
			#if defined (DEBUG_FIND_BEST)
			printf("RES: best_entity: %u, energy_best_entity: %f\n",
			       best_entity, 
			       loc_pop_energies[best_entity]);
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
uint myrand_basic (__global uint* restrict GlobPRNG)
{
	uint temprand_uint;

#if defined (REPRO)
	temprand_uint = 1;
#else
	temprand_uint = GlobPRNG[0];
	temprand_uint = (RAND_A*temprand_uint + RAND_C);
#endif
	GlobPRNG[0] = temprand_uint;

	return temprand_uint;
}

// --------------------------------------------------------------------------
// --------------------------------------------------------------------------
float myrand(__global uint* restrict GlobPRNG)
{
	uint   temprand_uint;
	float temprand_float;

	temprand_uint = myrand_basic(GlobPRNG);
	temprand_float = convert_float(native_divide(temprand_uint,MAX_UINT))*0.999999f;
	return temprand_float;
}

// --------------------------------------------------------------------------
// --------------------------------------------------------------------------
uint myrand_uint(__global uint* restrict GlobPRNG,
		 const uint limit)
{
	uint   temprand_uint;
	temprand_uint = myrand_basic(GlobPRNG);
	// no native_divide() used here as values are integers
	temprand_uint = (temprand_uint/MAX_UINT)*limit;
	return temprand_uint;
	
}

// --------------------------------------------------------------------------
// The function performs binary tournament selection. 
// The first parameter must containt the population data. 
// rand_level is the probability with which the new entity should be selected as parent. 
// The two selected parents are returned in the parent1 and parent2 parameters.
// Originally from: searchoptimum.c
// --------------------------------------------------------------------------
void binary_tournament_selection(__global const float* restrict GlobPopulation,
				 const uint pop_size, 
				 uint* parent1, 
				 uint* parent2, 
				 const float rand_level,
				 __global uint* restrict GlobPRNG,
				 __local float* loc_pop_par0,
				 __local float* loc_pop_par1)
{
	uint parent_candidates [2];

	//generating two different parent candidates
	parent_candidates [0] = myrand_uint(GlobPRNG, pop_size);

	LOOP_DOWHILE_BIN_TOURNAMENT_SEL_1:
	do
	{
#if defined (REPRO)
		parent_candidates [1] = myrand_uint(GlobPRNG, pop_size) + 1;
#else
		parent_candidates [1] = myrand_uint(GlobPRNG, pop_size);
#endif	
	}
	while (parent_candidates [0] == parent_candidates [1]);

	//the better will be the first parent with rand_level prability 
	//and the second with 1-rand_level probability
	async_work_group_copy(loc_pop_par0, GlobPopulation+(parent_candidates[0]*40)+38, 2, 0);
	async_work_group_copy(loc_pop_par1, GlobPopulation+(parent_candidates[1]*40)+38, 2, 0);

	if(loc_pop_par0[0] + loc_pop_par0[1] < loc_pop_par1[0] + loc_pop_par1[1])
	{
		if (myrand(GlobPRNG) < 100*rand_level) {*parent1 = parent_candidates [0];}
		else			               {*parent1 = parent_candidates [1];}
	}
	else
	{
		if (myrand(GlobPRNG) < 100*rand_level) {*parent1 = parent_candidates [1];}
		else			               {*parent1 = parent_candidates [0];}	
	}


	#if defined (DEBUG_TOURNAMENT_SELECTION)
	printf("Selecting first parent: %u (candidates were %u (E=%f) and %u (E=%f))\n", *parent1, 
		parent_candidates [0], 
		GlobPopulation [(parent_candidates [0]*40) + 38] + GlobPopulation [(parent_candidates [0]*40) + 39],
		parent_candidates [1],
		GlobPopulation [(parent_candidates [1]*40) + 38] + GlobPopulation [(parent_candidates [1]*40) + 39]);
	#endif

	//generating two different parent candidates (which differ from parent1 as well)
	LOOP_DOWHILE_BIN_TOURNAMENT_SEL_2:
	do
#if defined (REPRO)
		parent_candidates [0] = myrand_uint(GlobPRNG, pop_size) + 2;
#else
		parent_candidates [0] = myrand_uint(GlobPRNG, pop_size);
#endif
	while (parent_candidates [0] == *parent1);

	LOOP_DOWHILE_BIN_TOURNAMENT_SEL_3:
	do
#if defined (REPRO)
		parent_candidates [1] = myrand_uint(GlobPRNG, pop_size) + 3;
#else
		parent_candidates [1] = myrand_uint(GlobPRNG, pop_size);
#endif
	while ((parent_candidates [1] == parent_candidates [0]) || (parent_candidates [1] == *parent1));

	//the better will be the second parent
	async_work_group_copy(loc_pop_par0, GlobPopulation+(parent_candidates[0]*40)+38, 2, 0);
	async_work_group_copy(loc_pop_par1, GlobPopulation+(parent_candidates[1]*40)+38, 2, 0);

	if(loc_pop_par0[0] + loc_pop_par0[1] < loc_pop_par1[0] + loc_pop_par1[1])
	{
		if (myrand(GlobPRNG) < 100*rand_level) {*parent2 = parent_candidates [0];}
		else		          	       {*parent2 = parent_candidates [1];}
	}
	else
	{
		if (myrand(GlobPRNG) < 100*rand_level) {*parent2 = parent_candidates [1];}
		else			               {*parent2 = parent_candidates [0];}	
	}


	#if defined (DEBUG_TOURNAMENT_SELECTION)
	printf("Selecting second parent: %u (candidates were %u (E=%f) and %u (E=%f))\n", *parent2,
	       parent_candidates [0],
	       GlobPopulation [(parent_candidates [0]*40) + 38] + GlobPopulation [(parent_candidates [0]*40) + 39],
	       parent_candidates [1],
	       GlobPopulation [(parent_candidates [1]*40) + 38] + GlobPopulation [(parent_candidates [1]*40) + 39]);
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
void gen_new_genotype(__global uint* restrict GlobPRNG,
		      __local const float* parent1_genotype,
		      __local const float* parent2_genotype, 
		              const float  mutation_rate,
			      const float  abs_max_dmov,
			      const float  abs_max_dang,
			      const float  crossover_rate,
			      const uint   num_of_genes,
		      __local       float* offspring1_genotype
		      // __local float* offspring2_genotype
		     )
{
	uint covr_point_low, covr_point_high;
	uint temp1, temp2;
	uint i;

	//choosing crossover points randomly
	temp1 = myrand_uint(GlobPRNG, num_of_genes-1);
	temp2 = myrand_uint(GlobPRNG, num_of_genes-1);


	//if (temp1 < temp2) {covr_point_low = temp1;
	//		    covr_point_high = temp2;}
	//else {		    covr_point_low = temp2;
	//		    covr_point_high = temp1;}


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
	for (i=0; i<num_of_genes; i++) {printf("%f ", parent1_genotype [i]);} printf("\n");

	printf("Parent2: ");
	for (i=0; i<num_of_genes; i++) {printf("%f ", parent2_genotype [i]);} printf("\n");
	#endif

	//performing crossover
	if (crossover_rate > 100.0f*myrand(GlobPRNG))
	{
		//two-point crossover
		//if (covr_point_low != covr_point_high)
		if (twopoint_cross_yes == true)
		{
			// **********************************************
			// ADD VENDOR SPECIFIC PRAGMA
			// **********************************************
			LOOP_GEN_NEW_GENOTYPE_1:
			for (i=0; i<num_of_genes; i++)
			{
				if ((i<=covr_point_low) || (i>covr_point_high)) 
				{
					offspring1_genotype [i] = parent1_genotype[i];
				}
				else {
					offspring1_genotype [i] = parent2_genotype[i];
				}
			}
		}
		//one-point crossover
		else {
			// **********************************************
			// ADD VENDOR SPECIFIC PRAGMA
			// **********************************************
			LOOP_GEN_NEW_GENOTYPE_2:
			for (i=0; i<num_of_genes; i++)
			{
				if (i <= covr_point_low)
				{
					offspring1_genotype [i] = parent1_genotype[i];
				}
				else {
					offspring1_genotype [i] = parent2_genotype[i];
				}
			}
		}

		#if defined (DEBUG_GEN_NEW_GENOTYPE)
		printf("Offspring1 after crossover: ");
		for (i=0; i<num_of_genes; i++) {printf("%f ", offspring1_genotype [i]);} printf("\n");
		#endif

	}
	else	//if no crossover, the offsprings are the parents
	{
		// **********************************************
		// ADD VENDOR SPECIFIC PRAGMA
		// **********************************************
		LOOP_GEN_NEW_GENOTYPE_3:
		for (i=0; i<num_of_genes; i++)
		{
			offspring1_genotype [i] = parent1_genotype[i];
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
//				offspring1_genotype [i] = offspring1_genotype [i] + 2.0f*abs_max_dmov*myrand(GlobPRNG)-abs_max_dmov;
//			}
//			else
//			{
//				offspring1_genotype [i] = (offspring1_genotype [i] + 2.0f*abs_max_dang*myrand(GlobPRNG)-abs_max_dang);
//
//				if (i == 4) {map_angle(&(offspring1_genotype [i]), 180.0f);}	//mapping angle to 0..180
//				else        {map_angle(&(offspring1_genotype [i]), 360.0f);}	//mapping angle to 0..360
//
//			}
//		}
//	}

	// **********************************************
	// ADD VENDOR SPECIFIC PRAGMA
	// **********************************************
	LOOP_GEN_NEW_GENOTYPE_4:
	for (i=0; i<3; i++)
	{
		if (mutation_rate > 100*myrand(GlobPRNG))
		{
			offspring1_genotype [i] = offspring1_genotype [i] + 2*abs_max_dmov*myrand(GlobPRNG)-abs_max_dmov;
		}
	}

	if (mutation_rate > 100*myrand(GlobPRNG))
	{
		offspring1_genotype [3] = offspring1_genotype [3] + 2*abs_max_dmov*myrand(GlobPRNG)-abs_max_dmov;
		map_angle(&(offspring1_genotype [3]), 360.0f);
	}
		
	if (mutation_rate > 100*myrand(GlobPRNG))
	{
		offspring1_genotype [4] = offspring1_genotype [4] + 2*abs_max_dang*myrand(GlobPRNG)-abs_max_dang;
		map_angle(&(offspring1_genotype [4]), 180.0f);
	}

	// **********************************************
	// ADD VENDOR SPECIFIC PRAGMA
	// **********************************************
	LOOP_GEN_NEW_GENOTYPE_5:
	for (i=5; i<num_of_genes; i++)
	{
		if (mutation_rate > 100*myrand(GlobPRNG))
		{
			offspring1_genotype [i] = offspring1_genotype [i] + 2*abs_max_dang*myrand(GlobPRNG)-abs_max_dang;
			map_angle(&(offspring1_genotype [i]), 360.0f);	//mapping angle to 0..360
		}
	}

	#if defined (DEBUG_GEN_NEW_GENOTYPE)
	printf("Offspring1 after mutation: ");
	for (i=0; i<num_of_genes; i++) {printf("%f ", offspring1_genotype [i]);} printf("\n");
	#endif

}
