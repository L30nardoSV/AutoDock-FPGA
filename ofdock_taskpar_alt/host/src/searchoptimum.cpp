/*
 * (C) 2013. Evopro Innovation Kft.
 *
 * searchoptimum.c
 *
 *  Created on: 2008.11.18.
 *      Author: pechan.imre
 */

#include "searchoptimum.h"

/*
void map_angle(double* angle, double ang_max)
*/
void map_angle(float* angle, 	       
	       float ang_max)
//The function maps the first parameter into the interval 0..ang_max by adding/subtracting n*ang_max to/from it.
{
	while ((*angle) < 0)
		(*angle) += ang_max;

	while ((*angle) > ang_max)
		(*angle) -= ang_max;
}

/*
void find_best(double population [][40], const int pop_size, int* best_entity)
*/
void find_best(float population [][40], 	       
	       const int pop_size, 	       
	       int* best_entity)
//The function finds the best entity based on the energy value (sum of the 38th and 39th element) and returns
//its ID in the best_entity parameter. The pop_size parameter must be equal to the population size.
{
	int i;

	//supposing the best entity is the first one
	*best_entity = 0;

	//looking for the best one
	for (i=1; i<pop_size; i++)
	{
		if (population [i][38] + population [i][39] < population [*best_entity][38] + population [*best_entity][39])
		{
			*best_entity = i;
		}
	}
}

/*
void gen_new_genotype(double parent1_genotype [], double parent2_genotype [], const double mutation_rate, const double abs_max_dmov, const double abs_max_dang,
					  const double crossover_rate, const int num_of_genes, double offspring1_genotype [], double offspring2_genotype [], int debug)
*/
void gen_new_genotype(float parent1_genotype [], 		      
		      float parent2_genotype [], 		      
		      const float mutation_rate, 		      
		      const float abs_max_dmov, 		      
		      const float abs_max_dang, 		      
		      const float crossover_rate, 	              
		      const int num_of_genes, 		      
		      float offspring1_genotype [], 		      
		      float offspring2_genotype [], 		      
		      int debug)
//The function performs crossover and mutation and generates two offsprings from two parents whose genotypes are the functions parameters. Mutation rate is the
//probability of mutating a gene in %, abs_max_dmov and abs_max_dang are the maximal delta values of a translation or an orientation/rotatable bond gene during
//mutation.
{

	int covr_point_low, covr_point_high;
	int temp1, temp2;
	int i;


	//choosing crossover points randomly

	temp1 = myrand_int(num_of_genes-1);
	temp2 = myrand_int(num_of_genes-1);

	//but do not crossover between two orientation genes
/*	do
		temp1 = myrand_int(num_of_genes-1);
	while ((temp1 == 3) || (temp1 == 4));

	do
		temp2 = myrand_int(num_of_genes-1);
	while ((temp2 == 3) || (temp2 == 4));*/

	if (temp1 < temp2)
	{
		covr_point_low = temp1;
		covr_point_high = temp2;
	}
	else
	{
		covr_point_low = temp2;
		covr_point_high = temp1;
	}

	if (debug == 1)
	{
		printf("Crossover points: low: %d, high: %d\n", covr_point_low, covr_point_high);
		printf("Parent1: ");
		for (i=0; i<num_of_genes; i++)
			printf("%lf ", parent1_genotype [i]);
		printf("\n");
		printf("Parent2: ");
		for (i=0; i<num_of_genes; i++)
			printf("%lf ", parent2_genotype [i]);
		printf("\n");
	}


	//performing crossover

	if (crossover_rate > 100*myrand())
	{
		if (covr_point_low != covr_point_high)	//two-point crossover
			for (i=0; i<num_of_genes; i++)
				if ((i<=covr_point_low) || (i>covr_point_high))
				{
					offspring1_genotype [i] = parent1_genotype[i];
					offspring2_genotype [i] = parent2_genotype[i];
				}
				else
				{
					offspring1_genotype [i] = parent2_genotype[i];
					offspring2_genotype [i] = parent1_genotype[i];
				}
		else
			for (i=0; i<num_of_genes; i++)		//one-point crossover
				if (i <= covr_point_low)
				{
					offspring1_genotype [i] = parent1_genotype[i];
					offspring2_genotype [i] = parent2_genotype[i];
				}
				else
				{
					offspring1_genotype [i] = parent2_genotype[i];
					offspring2_genotype [i] = parent1_genotype[i];
				}

		if (debug == 1)
		{
			printf("Offspring1 after crossover: ");
			for (i=0; i<num_of_genes; i++)
				printf("%lf ", offspring1_genotype [i]);
			printf("\n");
			printf("Offspring2 after crossover: ");
			for (i=0; i<num_of_genes; i++)
				printf("%lf ", offspring2_genotype [i]);
			printf("\n");
		}
	}
	else	//if no crossover, the offsprings are the parents
	{
		for (i=0; i<num_of_genes; i++)
		{
			offspring1_genotype [i] = parent1_genotype[i];
			offspring2_genotype [i] = parent2_genotype[i];
		}
		if (debug == 1)
			printf("No crossover, offsprings' genotypes equals to those of the parents\n");
	}

	//performing mutation

	for (i=0; i<num_of_genes; i++)	//mutating first offspring
		if (mutation_rate > 100*myrand())
		{
			if (i < 3)
				offspring1_genotype [i] = offspring1_genotype [i] + 2*abs_max_dmov*myrand()-abs_max_dmov;
			else
			{
				offspring1_genotype [i] = (offspring1_genotype [i] + 2*abs_max_dang*myrand()-abs_max_dang);

				if (i == 4)
					map_angle(&(offspring1_genotype [i]), 180);	//mapping angle to 0..180
				else
					map_angle(&(offspring1_genotype [i]), 360);	//mapping angle to 0..360
			}
		}

	for (i=0; i<num_of_genes; i++)	//mutating second offspring
		if (mutation_rate > 100*myrand())
		{
			if (i < 3)
				offspring2_genotype [i] = offspring2_genotype [i] + 2*abs_max_dmov*myrand()-abs_max_dmov;
			else
			{
				offspring2_genotype [i] = (offspring2_genotype [i] + 2*abs_max_dang*myrand()-abs_max_dang);

				if (i == 4)
					map_angle(&(offspring2_genotype [i]), 180);
				else
					map_angle(&(offspring2_genotype [i]), 360);
			}
		}

	if (debug == 1)
	{
		printf("Offspring1 after mutation: ");
		for (i=0; i<num_of_genes; i++)
			printf("%lf ", offspring1_genotype [i]);
		printf("\n");
		printf("Offspring2 after mutation: ");
		for (i=0; i<num_of_genes; i++)
			printf("%lf ", offspring2_genotype [i]);
		printf("\n\n");
	}

}

/*
void perform_LS(double offspring_genotype [], const Liganddata* myligand_ref_ori, const double rho_lower_bound, const double base_dmov_mul_sqrt3,
				const double base_dang_mul_sqrt3, const int max_num_of_iterations, const int max_cons_succ, const int max_cons_fail,
				int* evals_performed, const Gridinfo* myginfo, const double* grids, int ignore_desolv, const double scaled_AD4_coeff_elec, const
				double AD4_coeff_desolv, const double qasp, int debug)
*/
void perform_LS(float offspring_genotype [], 		
		const Liganddata* myligand_ref_ori, 	        
		const float rho_lower_bound, 		
		const float base_dmov_mul_sqrt3, 		
		const float base_dang_mul_sqrt3, 		
		const int max_num_of_iterations, 		
		const int max_cons_succ, 		
		const int max_cons_fail, 		
		int* evals_performed, 		
		const Gridinfo* myginfo, 		
		const float* grids, 		
		int ignore_desolv, 		
		const float scaled_AD4_coeff_elec, 		
		const float AD4_coeff_desolv, 		
		const float qasp, 		
		int debug)
//The function performs the Solis-Wets local search algorithm on the entity whose genotype is the first parameter of the function. The parameters which
//allows the evaluation of the solution and the local search algorithm parameters must be accessible for the funciton, too. The evals_performed parameter
//will be equal to the number of evaluations which was used during the iteration. If the debug parameter is 1, debug messages will be printed to the
//standard output.
{

	//non-tunable parameters of the local search
/*
	const double expansion_factor = 2;
	const double contraction_factor = 0.5;

	double entity_possible_new_genotype [40];
	double genotype_deviate [40];		//38 would be enough...
	double genotype_bias [40];
*/
	const float expansion_factor = 2;
	const float contraction_factor = 0.5;

	float entity_possible_new_genotype [40];
	float genotype_deviate [40];		//38 would be enough...
	float genotype_bias [40];

	int i;
/*
	double rho;
*/
	float rho;

	int cons_succ, cons_fail;		//consecutive successes and failures
	int iteration_cnt;

	Liganddata myligand_temp;


	for (i=0; i<40; i++)
	{
		genotype_bias [i] = 0;
	}

	*evals_performed = 0;
	rho = 1;
	cons_succ = 0;
	cons_fail = 0;
	iteration_cnt = 0;

	//starting iteration

	while ((iteration_cnt < max_num_of_iterations) && (rho > rho_lower_bound))
	{

		//new random deviate

		for (i=0; i<myligand_ref_ori->num_of_rotbonds+6; i++)
			if (i>2)
				genotype_deviate [i] = rho*base_dang_mul_sqrt3*(2*myrand()-1);		//rho is the deviation of the uniform distribution
			else
				genotype_deviate [i] = rho*base_dmov_mul_sqrt3*(2*myrand()-1);		//base_delta_xxx is a scaling factor

		//the entity's possible new genotype

		for (i=0; i<myligand_ref_ori->num_of_rotbonds+6; i++)
		{
			entity_possible_new_genotype [i] = offspring_genotype [i] + genotype_deviate [i] + genotype_bias [i];

			if (i>2)
			{
				if (i == 4)
					map_angle(&(entity_possible_new_genotype [i]), 180);
				else
					map_angle(&(entity_possible_new_genotype [i]), 360);
			}
		}

		//evaluate the new genotype

		myligand_temp = *myligand_ref_ori;
		change_conform(&myligand_temp, entity_possible_new_genotype, debug);
		entity_possible_new_genotype [39] = calc_interE(myginfo, &myligand_temp, grids, 0.00, debug);
		scale_ligand(&myligand_temp, myginfo->spacing);
		entity_possible_new_genotype [38] = calc_intraE(&myligand_temp, 8, ignore_desolv, scaled_AD4_coeff_elec, AD4_coeff_desolv, qasp, debug);
		(*evals_performed)++;

		if (debug == 1)
		{
			printf("\n\n\n%d. iteration\n", iteration_cnt);

			printf("Current genotype: ");
			for (i=0; i<myligand_ref_ori->num_of_rotbonds+6; i++)
				printf("%6.2lf, ", offspring_genotype [i]);
			printf("energies: %lf, %lf", offspring_genotype [38], offspring_genotype [39]);
			printf("\n");

			printf("Current deviate: ");
			for (i=0; i<myligand_ref_ori->num_of_rotbonds+6; i++)
				printf("%6.2lf, ", genotype_deviate [i]);
			printf("\n");

			printf("Current bias: ");
			for (i=0; i<myligand_ref_ori->num_of_rotbonds+6; i++)
				printf("%6.2lf, ", genotype_bias [i]);
			printf("\n");

			printf("Possible new genotype (current genotype + deviate + bias: ");
			for (i=0; i<myligand_ref_ori->num_of_rotbonds+6; i++)
				printf("%6.2lf, ", entity_possible_new_genotype [i]);
			printf("energies: %lf, %lf", entity_possible_new_genotype [38], entity_possible_new_genotype [39]);
			printf("\n");
		}

		//if the new entity is better better

		if (entity_possible_new_genotype [38] + entity_possible_new_genotype [39] < offspring_genotype [38] + offspring_genotype [39])
		{

			for (i=0; i<40; i++)
			{
				offspring_genotype [i] = entity_possible_new_genotype [i];				//updating offspring_genotype
				genotype_bias [i] = 0.6*genotype_bias [i] + 0.4*genotype_deviate [i];	//updating genotype_bias
			}

			cons_succ++;
			cons_fail = 0;

			if (debug == 1)
			{
				printf("SUCCESS, cons_succ=%d, cons_fail=%d, new bias = 0.6*old bias + 0.4*old deviate\n", cons_succ, cons_fail);
			}
		}
		else	//if worser, check the opposite direction
		{

			for (i=0; i<myligand_ref_ori->num_of_rotbonds+6; i++)
			{
				entity_possible_new_genotype [i] = offspring_genotype [i] - genotype_deviate [i] - genotype_bias [i];

				if (i>2)
				{
					if (i == 4)
						map_angle(&(entity_possible_new_genotype [i]), 180);
					else
						map_angle(&(entity_possible_new_genotype [i]), 360);
				}
			}

			//evaluating the genotype

			myligand_temp = *myligand_ref_ori;
			change_conform(&myligand_temp, entity_possible_new_genotype, debug);
			entity_possible_new_genotype [39] = calc_interE(myginfo, &myligand_temp, grids, 0.00, debug);
			scale_ligand(&myligand_temp, myginfo->spacing);
			entity_possible_new_genotype [38] = calc_intraE(&myligand_temp, 8, ignore_desolv, scaled_AD4_coeff_elec, AD4_coeff_desolv, qasp, debug);
			(*evals_performed)++;

			if (debug == 1)
			{
				printf("FAILURE\n");
				printf("Possible new genotype (current genotype - deviate - bias: ");
				for (i=0; i<myligand_ref_ori->num_of_rotbonds+6; i++)
					printf("%6.2lf, ", entity_possible_new_genotype [i]);
				printf("energies: %lf, %lf", entity_possible_new_genotype [38], entity_possible_new_genotype [39]);
				printf("\n");
			}


			//if the new entity is better

			if (entity_possible_new_genotype [38] + entity_possible_new_genotype [39] < offspring_genotype [38] + offspring_genotype [39])
			{

				for (i=0; i<40; i++)
				{
					offspring_genotype [i] = entity_possible_new_genotype [i];				//updating offspring_genotype
					genotype_bias [i] = 0.6*genotype_bias [i] - 0.4*genotype_deviate [i];	//updating genotype_bias
				}

				cons_succ++;
				cons_fail = 0;

				if (debug == 1)
				{
					printf("SUCCESS, cons_succ=%d, cons_fail=%d, new bias = 0.6*old bias - 0.4*old deviate\n", cons_succ, cons_fail);
				}
			}
			else	//failure in both of the directions :-(
			{

				for (i=0; i<40; i++)
				{
					genotype_bias [i] = 0.5*genotype_bias [i];	//updating (halving) genotype_bias
				}

				cons_fail++;
				cons_succ = 0;

				if (debug == 1)
				{
					printf("FAILURE, cons_succ=%d, cons_fail=%d, new bias = 0.5*old bias\n", cons_succ, cons_fail);

				}
			}
		}


		//Changing deviation (rho), if needed

		if (cons_succ >= max_cons_succ)
		{
			if ((rho*base_dang_mul_sqrt3 < 90) && (rho*base_dmov_mul_sqrt3 < 64)) //this limitation is necessary in the FPGA due to the number representation
				rho = expansion_factor*rho;

			cons_fail = 0;
			cons_succ = 0;

			if (debug == 1)
			{
				printf("DOUBLING rho, new value: %lf, cons_succ=%d, cons_fail=%d\n", rho, cons_succ, cons_fail);
			}
		}
		else
			if (cons_fail >= max_cons_fail)
			{
				rho = contraction_factor*rho;
				cons_fail = 0;
				cons_succ = 0;

				if (debug == 1)
				{
					printf("HALVING rho, new value: %lf, cons_succ=%d, cons_fail=%d\n", rho, cons_succ, cons_fail);
				}

			}

		iteration_cnt++;
	}

}

/*
void binary_tournament_selection(double popultaion [][40], const int pop_size, int* parent1, int* parent2, double rand_level, int debug)
*/
void binary_tournament_selection(float popultaion [][40], 				 
				 const int pop_size, 				 
				 int* parent1, 				 
				 int* parent2, 				 
			         float rand_level, 				 
				 int debug)
//The function performs binary tournament selection. The first parameter must containt the population data. rand_level is the probability
//with which the new entity should be selected as parent. The two selected parents are returned in the parent1 and parent2 parameters.
//If the debug parameter is 1, debug messages will be printed to the screen.
{

//printf("WHT\n");


	int parent_candidates [2];

	//generating two different parent candidates
	parent_candidates [0] = myrand_int(pop_size);
	do
#if defined (REPRO)
		parent_candidates [1] = myrand_int(pop_size) + 1;
#else
		parent_candidates [1] = myrand_int(pop_size);
#endif	
	while (parent_candidates [0] == parent_candidates [1]);

	//the better will be the first parent with rand_level prability and the second with 1-rand_level probability
	if (popultaion [parent_candidates [0]][38] + popultaion [parent_candidates [0]][39] <
		popultaion [parent_candidates [1]][38] + popultaion [parent_candidates [1]][39])
		if (myrand() < rand_level)
			*parent1 = parent_candidates [0];
		else
			*parent1 = parent_candidates [1];
	else
		if (myrand() < rand_level)
			*parent1 = parent_candidates [1];
		else
			*parent1 = parent_candidates [0];

/*	if ((popultaion [parent_candidates [0]][38] + popultaion [parent_candidates [0]][39] <
			 popultaion [parent_candidates [1]][38] + popultaion [parent_candidates [1]][39]) && (*parent1 == parent_candidates [0]))
		first_better++;
	else
		first_worser++;*/

	if (debug == 1)
	{
		printf("Selecting first parent: %d (candidates were %d (E=%lf) and %d (E=%lf))\n", *parent1, parent_candidates [0], popultaion [parent_candidates [0]][38] + popultaion [parent_candidates [0]][39],
				parent_candidates [1], popultaion [parent_candidates [1]][38] + popultaion [parent_candidates [1]][39]);
	}

	//generating two different parent candidates (which differ from parent1 as well)
	do
#if defined (REPRO)
		parent_candidates [0] = myrand_int(pop_size) + 2;
#else
		parent_candidates [0] = myrand_int(pop_size);
#endif	
	while (parent_candidates [0] == *parent1);
	
	do
#if defined (REPRO)
		parent_candidates [1] = myrand_int(pop_size) + 3;
#else
		parent_candidates [1] = myrand_int(pop_size);
#endif
	while ((parent_candidates [1] == parent_candidates [0]) || (parent_candidates [1] == *parent1));

	//the better will be the second parent
	if (popultaion [parent_candidates [0]][38] + popultaion [parent_candidates [0]][39] <
		popultaion [parent_candidates [1]][38] + popultaion [parent_candidates [1]][39])
		if (myrand() < rand_level)
			*parent2 = parent_candidates [0];
		else
			*parent2 = parent_candidates [1];
	else
		if (myrand() < rand_level)
			*parent2 = parent_candidates [1];
		else
			*parent2 = parent_candidates [0];

/*	if ((popultaion [parent_candidates [0]][38] + popultaion [parent_candidates [0]][39] <
			 popultaion [parent_candidates [1]][38] + popultaion [parent_candidates [1]][39]) && (*parent1 == parent_candidates [0]))
		second_better++;
	else
		second_worser++;*/

	if (debug == 1)
	{
		printf("Selecting second parent: %d (candidates were %d (E=%lf) and %d (E=%lf))\n", *parent2, parent_candidates [0], popultaion [parent_candidates [0]][38] + popultaion [parent_candidates [0]][39],
				parent_candidates [1], popultaion [parent_candidates [1]][38] + popultaion [parent_candidates [1]][39]);
	}


}

//void genetic_steady_state(double population [][40], const Liganddata* myligand_ref_ori, const Gridinfo* myginfo, const double* grids, const Dockpars* mypars, int ignore_desolv, int debug)
////The function performs a steady state genetic algorithm based search on the search space. The first parameter is the population which must be filled with initial
////values before calling this function. The other parameters are variables which describe the grids, the docking parameters and  the ligand to be docked. If the debug
////parameter is 1, debug messages will be printed to the standard output.
//{
//	int eval_cnt;
//	Liganddata myligand_temp;
//	double offspring1_genotype [40] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
//								       0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
//								       0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
//								       0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
//	double offspring2_genotype [40] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0,	//required only because gen_new_genotype() returns two offsprings
//								       0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
//								       0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
//								       0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
//	int pop_size;
//
//	int worser_parent_id;
//	int parent1, parent2, entity_for_ls;
//	int i;
//	int LS_eval;
//
//	double abs_max_dmov, abs_max_dang, mutation_rate, lsearch_rate, rho_lower_bound, base_dmov_mul_sqrt3, base_dang_mul_sqrt3;
//
//
//	//capturing and converting algorithm parameters
//
//	abs_max_dmov = (double) mypars->dmov_mask/pow(2, 10);	//	+/-
//	abs_max_dang = (double) mypars->dang_mask/pow(2, 8)*180/512;				//	+/-
//	mutation_rate = (double) mypars->mutation_rate/255*100;
//	lsearch_rate = (double) mypars->lsearch_rate/262143*100*3;
//	rho_lower_bound = (double) mypars->rho_lower_bound/pow(2, 10);
//	base_dmov_mul_sqrt3 = (double) mypars->base_dmov_mul_sqrt3*myginfo->spacing/pow(2, 10);
//	base_dang_mul_sqrt3 = (double) mypars->base_dang_mul_sqrt3*180/512/pow(2, 8);
//	pop_size = mypars->pop_size + 1;
//
//	eval_cnt = 0;
//
//	while (eval_cnt < mypars->num_of_energy_evals)
//	{
//		myligand_temp = *myligand_ref_ori;
//
//		if (eval_cnt < pop_size)
//		{
//			change_conform(&myligand_temp, &(population [eval_cnt][0]), debug);
//			population [eval_cnt][39] = calc_interE(myginfo, &myligand_temp, grids, 0.00, debug);
//			scale_ligand(&myligand_temp, myginfo->spacing);
//			population [eval_cnt][38] = calc_intraE(&myligand_temp, 8, ignore_desolv, mypars->coeffs.scaled_AD4_coeff_elec, mypars->coeffs.AD4_coeff_desolv, mypars->qasp, debug);
//			eval_cnt++;
//		}
//		else
//		{
//			if (100*myrand() > lsearch_rate)	//if local search won't be performed in this cycle
//			{
//
//				//choosing parents totally randomly and deciding which is the worser (this may be succeeded)
//
//				parent1 = myrand_int(pop_size);
//				parent2 = myrand_int(pop_size);
//
//				if (population [parent1][38] + population [parent1][39] < population [parent2][38] + population [parent2][39])
//					worser_parent_id = parent2;
//				else
//					worser_parent_id = parent1;
//
//				//generating new offspring (only offspring1_genotype will be kept)
//
//				gen_new_genotype(population [parent1], population [parent2], mutation_rate, abs_max_dmov, abs_max_dang, 100, myligand_temp.num_of_rotbonds+6,
//								 offspring1_genotype, offspring2_genotype, debug);
//
//				//evaluating new offspring
//
//				change_conform(&myligand_temp, offspring1_genotype, debug);
//				offspring1_genotype [39] = calc_interE(myginfo, &myligand_temp, grids, 0.00, debug);
//				scale_ligand(&myligand_temp, myginfo->spacing);
//				offspring1_genotype [38] = calc_intraE(&myligand_temp, 8, ignore_desolv, mypars->coeffs.scaled_AD4_coeff_elec, mypars->coeffs.AD4_coeff_desolv, mypars->qasp, debug);
//
//				//if the offspring is better than its worser parent, it succeeds
//
//				if (offspring1_genotype [38] + offspring1_genotype [39] < population [worser_parent_id][38] + population [worser_parent_id][39])
//				{
//					for (i=0; i<40; i++)
//						population [worser_parent_id][i] = offspring1_genotype [i];
//
//				}
//				eval_cnt++;
//			}
//			else
//			{
//
//				//choosing an entity randomly
//
//				entity_for_ls = myrand_int(pop_size);
//
//				//performing local search
//
//				perform_LS(population [entity_for_ls], myligand_ref_ori, rho_lower_bound, base_dmov_mul_sqrt3, base_dang_mul_sqrt3, mypars->max_num_of_iters,
//						   mypars->cons_limit+1, mypars->cons_limit+1, &LS_eval, myginfo, grids, ignore_desolv, mypars->coeffs.scaled_AD4_coeff_elec,
//						   mypars->coeffs.AD4_coeff_desolv, mypars->qasp, debug);
//				eval_cnt += LS_eval;
//			}
//		}
//	}
//
//}

/*
void genetic_generational(double population [][40], 
			  const Liganddata* myligand_ref_ori, 
			  const Gridinfo* myginfo, 
			  const double* grids, 
			  Dockpars* mypars, 
			  int ignore_desolv, 
			  int debug)
//The function performs a generational genetic algorithm based search on the search space. The first parameter is the population which must be filled with initial values
//before calling this function. The other parameters are variables which describe the grids, the docking parameters and  the ligand to be docked. If the debug
//parameter is 1, debug messages will be printed to the standard output.
{
	double offspring1_genotype [40] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
					   0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
					   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
					   0, 0, 0, 0, 0, 0, 0, 0, 0, 0};

	//required only because gen_new_genotype() returns two offsprings
	double offspring2_genotype [40] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
					   0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
					   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
					   0, 0, 0, 0, 0, 0, 0, 0, 0, 0};

	Liganddata myligand_temp;

	unsigned int eval_cnt;
	unsigned int generation_cnt;
	unsigned int pop_size;

	int parent1, parent2, entity_for_ls;
	unsigned int i;
	int j;
	int LS_eval;
	unsigned int new_pop_cnt;

	int best_entity_id;

	double abs_max_dmov;
	double abs_max_dang;
	double mutation_rate;
	double lsearch_rate; 
	double crossover_rate; 
	double tournament_rate; 
	double rho_lower_bound; 
	double base_dmov_mul_sqrt3;
	double base_dang_mul_sqrt3;

	double new_population [CPU_MAX_POP_SIZE][40];

	double avg_energy;
	int num_of_evals_for_ls;
	unsigned int num_of_entity_for_ls;

	int evals_for_ls_in_this_cycle;

	eval_cnt = 0;
	generation_cnt = 1;

	//capturing and converting algorithm parameters
	pop_size = mypars->pop_size + 1;
	abs_max_dmov = ((double) mypars->dmov_mask)/pow(2, 10);	//	+/-, and in grid spacing, not in Angstr\F6m!
	abs_max_dang = ((double) mypars->dang_mask)/pow(2, 8)*180.0/512.0; //	+/-
	mutation_rate = ((double) mypars->mutation_rate)/255.0*100.0;
	lsearch_rate = mypars->lsearch_rate*100.0;
	crossover_rate = ((double) mypars->crossover_rate)/255.0*100.0;
	tournament_rate = ((double) mypars->tournament_rate)/255.0*100.0;
	rho_lower_bound = ((double) mypars->rho_lower_bound)/pow(2, 10);
	base_dmov_mul_sqrt3 = ((double) mypars->base_dmov_mul_sqrt3)/pow(2, 10);
	base_dang_mul_sqrt3 = ((double) mypars->base_dang_mul_sqrt3)*180.0/512.0/pow(2, 8);
	
	num_of_evals_for_ls = 0;
	num_of_entity_for_ls = floor(((double) pop_size)*lsearch_rate/100.0+0.5);


	// TESTEO
	//printf("\nParameters of the genetic algorihtm:\n");
	//printf("Rate of crossover: %f%%\n",crossover_rate);
	//printf("Rate of mutation: %f%%\n",mutation_rate);
	//printf("Rate of local search: %f%%\n",lsearch_rate);
	//printf("Population size: %d\n", pop_size);
	//printf("Maximal delta movement during mutation: +/-%fA\n",abs_max_dmov);
	//printf("maximal delta angle during mutation: +/-%f\n", abs_max_dang);
	//printf("Rho lower bound: %f\n",rho_lower_bound); 
	//printf("Maximal delta movement during ls: +/-%fA\n",base_dmov_mul_sqrt3);
	//printf("Maximal delta angle during ls: +/-%f\B0\n",base_dang_mul_sqrt3);



	if (debug == 1)
	{
		printf("Parameters of the genetic algorihtm:\n");
		printf("Rate of crossover: %lf%%, rate of mutation: %lf%%, rate of local search: %lf%%\n", crossover_rate, mutation_rate, lsearch_rate);
		printf("Population size: %d\n", pop_size);
		printf("Maximal delta movement during mutation: +/-%lfA, maximal delta angle during mutation: +/-%lf\B0\n", abs_max_dmov, abs_max_dang);
		printf("Rho lower bound: %lf, maximal delta movement during ls: +/-%lfA, maximal delta angle during ls: +/-%lf\B0\n", rho_lower_bound, base_dmov_mul_sqrt3, base_dang_mul_sqrt3);
	}



	// TESTEO

	//unsigned int leo_cnt;




	while ((eval_cnt < mypars->num_of_energy_evals) && (generation_cnt < mypars->num_of_generations))
	{

		// ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
		if (eval_cnt < pop_size)	//calculating energies of initial population
		{
			myligand_temp = *myligand_ref_ori;


			// TESTEO
			//for (leo_cnt = 0; leo_cnt < 48; leo_cnt++) {
			//printf("myligand_temp.atom_idxyzq [%u][1] = %f \n", leo_cnt, myligand_temp.atom_idxyzq [leo_cnt][1]);
			//printf("myligand_temp.atom_idxyzq [%u][2] = %f \n", leo_cnt, myligand_temp.atom_idxyzq [leo_cnt][2]);
			//printf("myligand_temp.atom_idxyzq [%u][3] = %f \n", leo_cnt, myligand_temp.atom_idxyzq [leo_cnt][3]);
			//}



			// TESTEO
			//for (leo_cnt = 0; leo_cnt < 40; leo_cnt++) {
			//	printf("population [%u][%u] = %f \n", eval_cnt, leo_cnt, population [eval_cnt][leo_cnt]);
			//}


			change_conform(&myligand_temp, 
				       &(population [eval_cnt][0]), 
				       debug);



			// TESTEO
			//for (leo_cnt = 0; leo_cnt < 48; leo_cnt++) {
			//printf("myligand_temp.atom_idxyzq [%u][1] = %f \n", leo_cnt, myligand_temp.atom_idxyzq [leo_cnt][1]);
			//printf("myligand_temp.atom_idxyzq [%u][2] = %f \n", leo_cnt, myligand_temp.atom_idxyzq [leo_cnt][2]);
			//printf("myligand_temp.atom_idxyzq [%u][3] = %f \n", leo_cnt, myligand_temp.atom_idxyzq [leo_cnt][3]);
			//}





			population [eval_cnt][39] = calc_interE(myginfo, &myligand_temp, grids, 0.00, debug);



			// TESTEO
			//for (leo_cnt = 0; leo_cnt < 48; leo_cnt++) {
			//printf("myligand_temp.atom_idxyzq [%u][1] = %f \n", leo_cnt, myligand_temp.atom_idxyzq [leo_cnt][1]);
			//printf("myligand_temp.atom_idxyzq [%u][2] = %f \n", leo_cnt, myligand_temp.atom_idxyzq [leo_cnt][2]);
			//printf("myligand_temp.atom_idxyzq [%u][3] = %f \n", leo_cnt, myligand_temp.atom_idxyzq [leo_cnt][3]);
			//}






			scale_ligand(&myligand_temp, myginfo->spacing);
			population [eval_cnt][38] = calc_intraE(&myligand_temp, 8, ignore_desolv, 
								mypars->coeffs.scaled_AD4_coeff_elec, 
								mypars->coeffs.AD4_coeff_desolv, 
								mypars->qasp, debug);



			// TESTEO
			//for (leo_cnt = 0; leo_cnt < 48; leo_cnt++) {
			//printf("myligand_temp.atom_idxyzq [%u][1] = %f \n", leo_cnt, myligand_temp.atom_idxyzq [leo_cnt][1]);
			//printf("myligand_temp.atom_idxyzq [%u][2] = %f \n", leo_cnt, myligand_temp.atom_idxyzq [leo_cnt][2]);
			//printf("myligand_temp.atom_idxyzq [%u][3] = %f \n", leo_cnt, myligand_temp.atom_idxyzq [leo_cnt][3]);
			//}








			// TESTEO
			//printf("population[%u][38] = %f \n", eval_cnt, population[eval_cnt][38]);
			//printf("population[%u][39] = %f \n", eval_cnt,population[eval_cnt][39]);




			eval_cnt++;
		}
		else
		{

			//creating a new population
			find_best(population, pop_size, &best_entity_id);	//identifying best entity


			// TESTEO
			//printf("best_entity_id = %i\n", best_entity_id);
			
			
			if (debug == 1)
			{
				avg_energy = 0;
				printf("\n\n\nFinal state of the %d. generation:\n", generation_cnt);
				printf("----------------------------\n\n");
				for (i=0; i<pop_size; i++)
				{
					avg_energy += population [i][38] + population [i][39];
					printf("Entity %3d: ", i);
					for (j=0; j<myligand_temp.num_of_rotbonds+6; j++)
						printf("%8.3lf ", population [i][j]);
					printf("   energies: %10.3lf %10.3lf (sum: %10.3lf)\n", population [i][38], population [i][39], population [i][38] + population [i][39]);
				}
				printf("\nAverage energy: %lf\nBest energy: %lf %lf (sum: %lf)\n\n", avg_energy/pop_size, population[best_entity_id][38], population[best_entity_id][39], population[best_entity_id][38] + population[best_entity_id][39]);
			}
			
			//elitism - copying the best entity to new population

			memcpy(new_population [0], population [best_entity_id], 40*sizeof(double));	


			// TESTEO
			//for (i = 0; i < 40; i++) {
			//	printf("new_population[0][%u] = %f\n", i, new_population[0][i]);
			//}

			

			//new population consists of one member currently
			new_pop_cnt = 1;	


			// -----------------------------------------------------------------------
			while (new_pop_cnt < pop_size)
			{


				//printf("TOMA\n");

				//selecting two individuals randomly
				binary_tournament_selection(population, pop_size, &parent1, &parent2, tournament_rate/100.0, debug);



				//printf("TOMA2\n");

				// TESTEO
				//printf("parent1 = %i, parent2 = %i\n", parent1, parent2);



				// TESTEO
				//for (i = 0; i < 40; i++) {
				//	printf("population [parent1][%u] = %f, population [parent2][%u] = %f\n", i, population [parent1][i], i, population [parent2][i]);
				//}


				// TESTEO
				//printf("mutation_rate = %f\n", mutation_rate);
				//printf("abs_max_dmov = %f\n", abs_max_dmov);
				//printf("abs_max_dang = %f\n", abs_max_dang);
				//printf("crossover_rate = %f\n", crossover_rate);
				//printf("myligand_temp.num_of_rotbonds+6 = %i\n", myligand_temp.num_of_rotbonds+6);


				//mating parents
				gen_new_genotype(population [parent1], population [parent2], 
						 mutation_rate, abs_max_dmov, abs_max_dang, crossover_rate, 
						 myligand_temp.num_of_rotbonds+6,
						 offspring1_genotype, offspring2_genotype, debug);

	
				// TESTEO
				//for (i = 0; i < 40; i++) {
				//	printf("offspring1_genotype[%u] = %f\n", i, offspring1_genotype[i]);
				//}



				//printf("GREAT\n");


				//evaluating first offspring
				myligand_temp = *myligand_ref_ori;

				change_conform(&myligand_temp, offspring1_genotype, debug);


				//printf("GREAT 2\n");



				// TESTEO
				//for (leo_cnt = 0; leo_cnt < 256; leo_cnt++) {
				//printf("myligand_temp.atom_idxyzq [%u][0] = %f \n", leo_cnt, myligand_temp.atom_idxyzq [leo_cnt][0]);	
				//printf("myligand_temp.atom_idxyzq [%u][1] = %f \n", leo_cnt, myligand_temp.atom_idxyzq [leo_cnt][1]);
				//printf("myligand_temp.atom_idxyzq [%u][2] = %f \n", leo_cnt, myligand_temp.atom_idxyzq [leo_cnt][2]);	
				//printf("myligand_temp.atom_idxyzq [%u][3] = %f \n", leo_cnt, myligand_temp.atom_idxyzq [leo_cnt][3]);
				//printf("myligand_temp.atom_idxyzq [%u][4] = %f \n", leo_cnt, myligand_temp.atom_idxyzq [leo_cnt][4]);		
				//}



				offspring1_genotype [39] = calc_interE(myginfo, &myligand_temp, grids, 0.00, debug);
				scale_ligand(&myligand_temp, myginfo->spacing);
				offspring1_genotype [38] = calc_intraE(&myligand_temp, 8, ignore_desolv, 
								       mypars->coeffs.scaled_AD4_coeff_elec, 
								       mypars->coeffs.AD4_coeff_desolv, 
								       mypars->qasp, debug);



				// TESTEO
				//printf("offspring1_genotype [39] = %f\n", offspring1_genotype [39]);
				//printf("offspring1_genotype [38] = %f\n", offspring1_genotype [38]);




				eval_cnt++;

				//copying first offspring to population
				memcpy(new_population [new_pop_cnt], offspring1_genotype, 40*sizeof(double));
				new_pop_cnt++;

				//if there is still empty space in the population, evaluating second offspring
				if (new_pop_cnt < pop_size)		
				{
					//printf("NEW POPS\n");

					myligand_temp = *myligand_ref_ori;
					change_conform(&myligand_temp, offspring2_genotype, debug);


				// TESTEO
				//for (leo_cnt = 0; leo_cnt < 48; leo_cnt++) {
				////printf("myligand_temp.atom_idxyzq [%u][0] = %f \n", leo_cnt, myligand_temp.atom_idxyzq [leo_cnt][0]);	
				//printf("myligand_temp.atom_idxyzq [%u][1] = %f \n", leo_cnt, myligand_temp.atom_idxyzq [leo_cnt][1]);
				//printf("myligand_temp.atom_idxyzq [%u][2] = %f \n", leo_cnt, myligand_temp.atom_idxyzq [leo_cnt][2]);	
				//printf("myligand_temp.atom_idxyzq [%u][3] = %f \n", leo_cnt, myligand_temp.atom_idxyzq [leo_cnt][3]);
				////printf("myligand_temp.atom_idxyzq [%u][4] = %f \n", leo_cnt, myligand_temp.atom_idxyzq [leo_cnt][4]);		
				}



					offspring2_genotype [39] = calc_interE(myginfo, &myligand_temp, grids, 0.00, debug);
					scale_ligand(&myligand_temp, myginfo->spacing);
					offspring2_genotype [38] = calc_intraE(&myligand_temp, 8, ignore_desolv, 
									       mypars->coeffs.scaled_AD4_coeff_elec, 
									       mypars->coeffs.AD4_coeff_desolv, 
									       mypars->qasp, debug);
					eval_cnt++;

					

					// TESTEO
					//printf("offspring2_genotype [39] = %f\n", offspring2_genotype [39]);
					//printf("offspring2_genotype [38] = %f\n", offspring2_genotype [38]);


					//copying second offspring to population
					memcpy(new_population [new_pop_cnt], offspring2_genotype, 40*sizeof(double));
					new_pop_cnt++;
				}
			} // End of while (new_pop_cnt < pop_size)
			// -----------------------------------------------------------------------


			//updating old population with new one
			memcpy(population, new_population, pop_size*40*sizeof(double));

			if (debug == 1)
			{
				find_best(population, pop_size, &best_entity_id);
				avg_energy = 0;
				printf("\n\n\nState of the %d. generation before local search:\n", generation_cnt+1);
				printf("----------------------------\n\n");
				for (i=0; i<pop_size; i++)
				{
					avg_energy += population [i][38] + population [i][39];
					printf("Entity %3d: ", i);
					for (j=0; j<myligand_temp.num_of_rotbonds+6; j++)
						printf("%lf ", population [i][j]);
					printf("   energies: %lf %lf (sum: %lf)\n", population [i][38], population [i][39], population [i][38] + population [i][39]);
				}
				printf("\nAverage energy: %lf\nBest energy: %lf %lf (sum: %lf)\n\n", avg_energy/pop_size, population[best_entity_id][38], population[best_entity_id][39],
						population[best_entity_id][38] + population[best_entity_id][39]);
			}


			evals_for_ls_in_this_cycle = 0;


			// -----------------------------------------------------------------------

			for (i=0; i<num_of_entity_for_ls; i++)	//subjecting num_of_entity_for_ls pieces of offsprings to LS
			{

				// choosing an entity randomly, and
				// without checking if it has already been subjected to LS in this cycle
				entity_for_ls = myrand_int(pop_size);	

				//printf("entity_for_ls: %i\n", entity_for_ls);


				if (debug == 1)
				{
					printf("Entity %d before local search: ", entity_for_ls);
					for (j=0; j<myligand_temp.num_of_rotbonds+6; j++)
						printf("%lf ", population [entity_for_ls][j]);
					printf("   energies: %lf %lf\n", population [entity_for_ls][38], population [entity_for_ls][39]);
				}


				//performing local search
				perform_LS(population [entity_for_ls], 
					   myligand_ref_ori, 
					   rho_lower_bound, 
					   base_dmov_mul_sqrt3, 
					   base_dang_mul_sqrt3, 
					   mypars->max_num_of_iters,
				           mypars->cons_limit+1, 
					   mypars->cons_limit+1, 
					   &LS_eval, 
					   myginfo,
					   grids,
					   ignore_desolv,
					   mypars->coeffs.scaled_AD4_coeff_elec,
					   mypars->coeffs.AD4_coeff_desolv, 
					   mypars->qasp, debug);

				eval_cnt += LS_eval;

				evals_for_ls_in_this_cycle += LS_eval;


				if (debug == 1)
				{
					printf("Entity %d after local search (%d evaluations): ", entity_for_ls, LS_eval);
					for (j=0; j<myligand_temp.num_of_rotbonds+6; j++)
						printf("%lf ", population [entity_for_ls][j]);
					printf("   energies: %lf %lf\n", population [entity_for_ls][38], population [entity_for_ls][39]);
				}


				num_of_evals_for_ls += LS_eval;

			} // End of for (i=0; i<num_of_entity_for_ls; i++)

			// -----------------------------------------------------------------------




			generation_cnt++;
			//printf("%d evaluations was performed during LS for %d entities, average: %lf\n", evals_for_ls_in_this_cycle, num_of_entity_for_ls, ((double) evals_for_ls_in_this_cycle)/((double) num_of_entity_for_ls));
		

		} // End of if (eval_cnt < pop_size)	//calculating energies of initial population
		// ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


	} // End of while ((eval_cnt < mypars->num_of_energy_evals) && (generation_cnt < mypars->num_of_generations))




	// MIGHT NOT BE NEEDED
	// TESTEO
	//for (leo_cnt = 0; leo_cnt < 48; leo_cnt++) {
	////printf("myligand_temp.atom_idxyzq [%u][0] = %f \n", leo_cnt, myligand_temp.atom_idxyzq [leo_cnt][0]);	
	//printf("myligand_temp.atom_idxyzq [%u][1] = %f \n", leo_cnt, myligand_temp.atom_idxyzq [leo_cnt][1]);
	//printf("myligand_temp.atom_idxyzq [%u][2] = %f \n", leo_cnt, myligand_temp.atom_idxyzq [leo_cnt][2]);	
	//printf("myligand_temp.atom_idxyzq [%u][3] = %f \n", leo_cnt, myligand_temp.atom_idxyzq [leo_cnt][3]);
	////printf("myligand_temp.atom_idxyzq [%u][4] = %f \n", leo_cnt, myligand_temp.atom_idxyzq [leo_cnt][4]);		
	//}




	mypars->evals_performed = eval_cnt;
	mypars->generations_used = generation_cnt;


	if (debug == 1)
	{
		printf("Energy evaluations for LS: %d out of %d\n", num_of_evals_for_ls, eval_cnt);
		printf("Number of generations: %d\n", generation_cnt);
	}


}
*/
