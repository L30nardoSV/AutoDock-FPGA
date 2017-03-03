// --------------------------------------------------------------------------
// The function performs the Solis-Wets local search algorithm on the 
// entity whose genotype is the first parameter. 
// The parameters which allows the evaluation of the solution and 
// the local search algorithm parameters must be accessible for the funciton, too. 
// The evals_performed parameter will be equal to the number of evaluations 
// which was used during the iteration. 
// If the debug parameter is 1, debug messages will be printed to the standard output.
// Originally from: searchoptimum.c
// --------------------------------------------------------------------------
void perform_LS(
		// ligand
		__global      float* restrict GlobLigandAtom_idxyzq,
		__local       float* offspring_genotype,
	        __local       float* entity_possible_new_genotype,
		__local       float* loc_LS_templigand_atom_idxyzq,
		// ligand params
		         const uint   myligand_num_of_atoms, 
		         const uint   myligand_num_of_rotbonds,
		         const uint   myligand_num_of_intraE_contributors,
		// grid params
		__global const float* restrict Glob_fgrids,
		         const uint   myginfo_size_x,
			 const uint   myginfo_size_y,
			 const uint   myginfo_size_z,
		         const uint   g1,
			 const uint   g2,
			 const uint   g3,
		         const float  myginfo_spacing,
			 const uint   myginfo_num_of_atypes, 
		// dockpars params
		         const float rho_lower_bound, 
		         const float base_dmov_mul_sqrt3,
		         const float base_dang_mul_sqrt3, 
		         const uint  max_num_of_iterations, 
		         const uint  max_cons_succ, 
		         const uint  max_cons_fail,
		         uint* evals_performed,

		__global uint* restrict GlobPRNG

)
{
	uint i;
	float genotype_deviate [40];		//38 would be enough...
	float genotype_bias [40];

	// **********************************************
	// ADD VENDOR SPECIFIC PRAGMA
	// **********************************************
	LOOP_PERFORM_LS_1:
	for (i=0; i<40; i++) 
	{
		genotype_bias [i] = 0.0f;
	}

	float rho = 1.0f;

	//consecutive successes and failures
	uint cons_succ = 0;
	uint cons_fail = 0;	
	uint iteration_cnt = 0;
	*evals_performed = 0;

	//starting iteration
	// **********************************************
	// ADD VENDOR SPECIFIC PRAGMA
	// **********************************************
	LOOP_WHILE_PERFORM_LS_1:
	while ((iteration_cnt < max_num_of_iterations) && (rho > rho_lower_bound))
	{	
		// -----------------------------------------------------------------
		//new random deviate

		//__attribute__ ((xcl_pipeline_loop))
		//LOOP_PERFORM_LS_2:
		//for (i=0; i<myligand_num_of_rotbonds+6; i++)
		//{
		//	if (i>2){
		//		//rho is the deviation of the uniform distribution
		//		genotype_deviate [i] = rho*base_dang_mul_sqrt3*(2.0f*myrand(GlobPRNG)-1.0f);
		//	}			
		//	else{
		//		//base_delta_xxx is a scaling factor
		//		genotype_deviate [i] = rho*base_dmov_mul_sqrt3*(2.0f*myrand(GlobPRNG)-1.0f);
		//	}
		//}

		genotype_deviate [0] = rho*base_dmov_mul_sqrt3*(2*myrand(GlobPRNG)-1);
		genotype_deviate [1] = rho*base_dmov_mul_sqrt3*(2*myrand(GlobPRNG)-1);
		genotype_deviate [2] = rho*base_dmov_mul_sqrt3*(2*myrand(GlobPRNG)-1);

		// **********************************************
		// ADD VENDOR SPECIFIC PRAGMA
		// **********************************************
		LOOP_PERFORM_LS_2:
		for (i=3; i<myligand_num_of_rotbonds+6; i++)
		{
			//rho is the deviation of the uniform distribution
			genotype_deviate [i] = rho*base_dang_mul_sqrt3*(2*myrand(GlobPRNG)-1);
		
		}

		// -----------------------------------------------------------------
		////the entity's possible new genotype
		//__attribute__ ((xcl_pipeline_loop))
		//LOOP_PERFORM_LS_3:
		//for (i=0; i<myligand_num_of_rotbonds+6; i++)
		//{
		//	entity_possible_new_genotype [i] = offspring_genotype [i] + genotype_deviate [i] + genotype_bias [i];
		//	if (i>2) {
		//		if (i == 4) {map_angle(&(entity_possible_new_genotype [i]), 180.0f);}
		//		else	    {map_angle(&(entity_possible_new_genotype [i]), 360.0f);}
		//	}
		//}

		entity_possible_new_genotype [0] = offspring_genotype [0] + genotype_deviate [0] + genotype_bias [0];
		entity_possible_new_genotype [1] = offspring_genotype [1] + genotype_deviate [1] + genotype_bias [1];
		entity_possible_new_genotype [2] = offspring_genotype [2] + genotype_deviate [2] + genotype_bias [2];
		
		entity_possible_new_genotype [3] = offspring_genotype [3] + genotype_deviate [3] + genotype_bias [3];
		map_angle(&(entity_possible_new_genotype [3]), 360.0f);

		entity_possible_new_genotype [4] = offspring_genotype [4] + genotype_deviate [4] + genotype_bias [4];
		map_angle(&(entity_possible_new_genotype [4]), 180.0f);

		// **********************************************
		// ADD VENDOR SPECIFIC PRAGMA
		// **********************************************
		LOOP_PERFORM_LS_3:
		for (i=5; i<myligand_num_of_rotbonds+6; i++)
		{
			entity_possible_new_genotype [i] = offspring_genotype [i] + genotype_deviate [i] + genotype_bias [i];  
			map_angle(&(entity_possible_new_genotype [i]), 360.0f);
		}
		// -----------------------------------------------------------------





























		//evaluate the new genotype
		async_work_group_copy(loc_LS_templigand_atom_idxyzq, GlobLigandAtom_idxyzq, MAX_NUM_OF_ATOMS*5, 0);

		//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
		//Krnl_Conform
		uint pipe_cnt;

//ENABLE BACK!!!!!
/*
		for (pipe_cnt=0; pipe_cnt<myligand_num_of_atoms*5; pipe_cnt++)
		{
			write_channel_altera(chan_GA2Conf_ligandatom_idxyzq, loc_LS_templigand_atom_idxyzq[pipe_cnt]);
		}

		for (pipe_cnt=0; pipe_cnt<40; pipe_cnt++)
		{
			write_channel_altera(chan_GA2Conf_genotype, entity_possible_new_genotype[pipe_cnt]);
		}
*/
		//Krnl_InterE
		entity_possible_new_genotype[39] = read_channel_altera(chan_Intere2GA_intere);
		
		//Krnl_IntraE
		entity_possible_new_genotype[38] = read_channel_altera(chan_Intrae2GA_intrae);



		// REQUIRES FENCES TO SYNC 













//




		#if defined (DEBUG_PERFORM_LS)
		printf("\n\n\n%u. iteration\n", iteration_cnt);

		printf("Current genotype: ");
		for (i=0; i<myligand_num_of_rotbonds+6; i++) {printf("%6.2f, ", offspring_genotype [i]);}
		printf("energies: %f, %f", offspring_genotype [38], offspring_genotype [39]); printf("\n");

		printf("Current deviate: ");
		for (i=0; i<myligand_num_of_rotbonds+6; i++) {printf("%6.2f, ", genotype_deviate [i]);} printf("\n");

		printf("Current bias: ");
		for (i=0; i<myligand_num_of_rotbonds+6; i++) {printf("%6.2f, ", genotype_bias [i]);} printf("\n");

		printf("Possible new genotype (current genotype + deviate + bias: ");
		for (i=0; i<myligand_num_of_rotbonds+6; i++) {printf("%6.2f, ", entity_possible_new_genotype [i]);}
		printf("energies: %f, %f", entity_possible_new_genotype [38], entity_possible_new_genotype [39]); printf("\n");
		#endif

		//if the new entity is better better
		if (entity_possible_new_genotype [38] + entity_possible_new_genotype [39] < 
		    offspring_genotype [38] + offspring_genotype [39])
		{
			// **********************************************
			// ADD VENDOR SPECIFIC PRAGMA
			// **********************************************
			LOOP_PERFORM_LS_4:
			for (i=0; i<40; i++) {
				//updating offspring_genotype
				offspring_genotype [i] = entity_possible_new_genotype [i];

				//updating genotype_bias
				genotype_bias [i] = 0.6f*genotype_bias [i] + 0.4f*genotype_deviate [i];
			}

			cons_succ++;
			cons_fail = 0;

			#if defined (DEBUG_PERFORM_LS)
			printf("SUCCESS, cons_succ=%u, cons_fail=%u, new bias = 0.6*old bias + 0.4*old deviate\n", 
				cons_succ, cons_fail);
			#endif

		}
		else	//if worser, check the opposite direction
		{

			//__attribute__ ((xcl_pipeline_loop))
			//LOOP_PERFORM_LS_5:
			//for (i=0; i<myligand_num_of_rotbonds+6; i++)
			//{
			//	entity_possible_new_genotype [i] = offspring_genotype [i] - genotype_deviate [i] - genotype_bias [i];
			//	if (i>2) {
			//		if (i == 4) {map_angle(&(entity_possible_new_genotype [i]), 180.0f);}
			//		else        {map_angle(&(entity_possible_new_genotype [i]), 360.0f);}
			//	}
			//}


			entity_possible_new_genotype [0] = offspring_genotype [0] - genotype_deviate [0] - genotype_bias [0];
			entity_possible_new_genotype [1] = offspring_genotype [1] - genotype_deviate [1] - genotype_bias [1];
			entity_possible_new_genotype [2] = offspring_genotype [2] - genotype_deviate [2] - genotype_bias [2];
			entity_possible_new_genotype [3] = offspring_genotype [3] - genotype_deviate [3] - genotype_bias [3];
			map_angle(&(entity_possible_new_genotype [3]), 360.0f);
			entity_possible_new_genotype [4] = offspring_genotype [4] - genotype_deviate [4] - genotype_bias [4];
			map_angle(&(entity_possible_new_genotype [4]), 180.0f);

			// **********************************************
			// ADD VENDOR SPECIFIC PRAGMA
			// **********************************************
			LOOP_PERFORM_LS_5:
			for (i=5; i<myligand_num_of_rotbonds+6; i++)
			{
				entity_possible_new_genotype [i] = offspring_genotype [i] - genotype_deviate [i] - genotype_bias [i];
				map_angle(&(entity_possible_new_genotype [i]), 360.0f);
			}

			//evaluating the genotype
			async_work_group_copy(loc_LS_templigand_atom_idxyzq, GlobLigandAtom_idxyzq, MAX_NUM_OF_ATOMS*5, 0);

			//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
			// Krnl_Conform

// ENABLE THEM BACK!!!!
/*
			for (pipe_cnt=0; pipe_cnt<myligand_num_of_atoms*5; pipe_cnt++)
			{
				write_channel_altera(chan_GA2Conf_ligandatom_idxyzq, loc_LS_templigand_atom_idxyzq[pipe_cnt]);
			}

			for (pipe_cnt=0; pipe_cnt<40; pipe_cnt++)
			{
				write_channel_altera(chan_GA2Conf_genotype, entity_possible_new_genotype[pipe_cnt]);
			}
*/

			//Krnl_InterE
			entity_possible_new_genotype[39] = read_channel_altera(chan_Intere2GA_intere);
		
			//Krnl_IntraE
			entity_possible_new_genotype[38] = read_channel_altera(chan_Intrae2GA_intrae);


			(*evals_performed)++;
			//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

			#if defined (DEBUG_PERFORM_LS)
			printf("FAILURE\n");
			printf("Possible new genotype (current genotype - deviate - bias: ");
			for (i=0; i<myligand_num_of_rotbonds+6; i++) {printf("%6.2f, ", entity_possible_new_genotype [i]);}
			printf("energies: %f, %f", entity_possible_new_genotype [38], entity_possible_new_genotype [39]); 
		 	printf("\n");
			#endif

			//if the new entity is better
			if (entity_possible_new_genotype [38] + entity_possible_new_genotype [39] < 
		            offspring_genotype [38] + offspring_genotype [39])
			{
				// **********************************************
				// ADD VENDOR SPECIFIC PRAGMA
				// **********************************************
				LOOP_PERFORM_LS_6:
				for (i=0; i<40; i++) {
					//updating offspring_genotype
					offspring_genotype [i] = entity_possible_new_genotype [i];

					//updating genotype_bias
					genotype_bias [i] = 0.6f*genotype_bias [i] - 0.4f*genotype_deviate [i];
				}

				cons_succ++;
				cons_fail = 0;

				#if defined (DEBUG_PERFORM_LS)
				printf("SUCCESS, cons_succ=%u, cons_fail=%u, new bias = 0.6*old bias - 0.4*old deviate\n", cons_succ, cons_fail);
				#endif
			}
			else	//failure in both of the directions :-(
			{
				// **********************************************
				// ADD VENDOR SPECIFIC PRAGMA
				// **********************************************
				LOOP_PERFORM_LS_7:
				for (i=0; i<40; i++) {
					//updating (halving) genotype_bias
					genotype_bias [i] = 0.5f*genotype_bias [i];
				}

				cons_fail++;
				cons_succ = 0;

				#if defined (DEBUG_PERFORM_LS)
				printf("FAILURE, cons_succ=%u, cons_fail=%u, new bias = 0.5*old bias\n", cons_succ, cons_fail);
				#endif
			}
		}












		//Changing deviation (rho), if needed
		if (cons_succ >= max_cons_succ)
		{
			//this limitation is necessary in the FPGA due to the number representation
			if ((rho*base_dang_mul_sqrt3 < 90) && (rho*base_dmov_mul_sqrt3 < 64)) 
			{
				//rho = EXPANSION_FACTOR*rho;
				rho = LS_EXP_FACTOR*rho;
			}

			cons_fail = 0;
			cons_succ = 0;

			#if defined (DEBUG_PERFORM_LS)
			//printf("performLS: rho (EXP): %u\n", rho);
			printf("DOUBLING rho, new value: %f, cons_succ=%u, cons_fail=%u\n", rho, cons_succ, cons_fail);
			#endif
		}
		else
			if (cons_fail >= max_cons_fail)
			{
				//rho = CONTRACTION_FACTOR*rho;
				rho = LS_CONT_FACTOR*rho;
					
				cons_fail = 0;
				cons_succ = 0;

				#if defined (DEBUG_PERFORM_LS)
				//printf("performLS: rho (CON): %u\n", rho);
				printf("HALVING rho, new value: %f, cons_succ=%u, cons_fail=%u\n", rho, cons_succ, cons_fail);
				#endif
			}












//






















		iteration_cnt++;
		//printf("performLS: iteration_cnt (INC): %u\n", iteration_cnt);

	}


}





