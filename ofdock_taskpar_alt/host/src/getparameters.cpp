/*
 * (C) 2013. Evopro Innovation Kft.
 *
 * getparameters.c
 *
 *  Created on: 2008.10.22.
 *      Author: pechan.imre
 */

#include "getparameters.h"

int get_filenames_and_ADcoeffs(const int* argc, char** argv, Dockpars* mypars)
//The function fills the file name and coeffs fields of mypars parameter
//according to the proper command line arguments.
{
	int i;
	int ffile_given, lfile_given;
	long tempint;

	//AutoDock 4 free energy coefficients
	const double coeff_elec_scale_factor = 332.06363;
	const AD4_free_energy_coeffs coeffs_bound = {0.1662, 0.1209, coeff_elec_scale_factor*0.1406, 0.1322, 0.2983};	//this model assumes the bound conformation is the same as the unbound, default in AD4.2
	const AD4_free_energy_coeffs coeffs_extended = {0.1560, 0.0974, coeff_elec_scale_factor*0.1465, 0.1159, 0.2744};	//this model assumes the unbound conformation is extended, default if AD4.0
	const AD4_free_energy_coeffs coeffs_compact = {0.1641, 0.0531, coeff_elec_scale_factor*0.1272, 0.0603, 0.2272};	//this model assumes the unbound conformation is compact


	mypars->coeffs = coeffs_bound;	//default coeffs
	mypars->unbound_model = 0;

	ffile_given = 0;
	lfile_given = 0;

	for (i=1; i<(*argc)-1; i++)
	{
		//Argument: grid parameter file name.
		if (strcmp("-ffile", argv [i]) == 0)
		{
			ffile_given = 1;
			strcpy(mypars->fldfile, argv [i+1]);
		}

		//Argument: ligand pdbqt file name
		if (strcmp("-lfile", argv [i]) == 0)
		{
			lfile_given = 1;
			strcpy(mypars->ligandfile, argv [i+1]);
		}

		//Argument: unbound model to be used.
		//0 means the bound, 1 means the extended, 2 means the compact model's free energy coefficients will be used during docking.
		if (strcmp("-ubmod", argv [i]) == 0)
		{
			sscanf(argv [i+1], "%ld", &tempint);

			if (tempint == 0)
			{
				mypars->coeffs = coeffs_bound;
				mypars->unbound_model = 0;
			}
			else
				if (tempint == 1)
				{
					mypars->coeffs = coeffs_extended;
					mypars->unbound_model = 1;
				}
				else
				{
					mypars->coeffs = coeffs_compact;
					mypars->unbound_model = 2;
				}
		}
	}

	if (ffile_given == 0)
	{
		printf("Error: grid fld file was not defined. Use -ffile argument!\n");
		return 1;
	}

	if (lfile_given == 0)
	{
		printf("Error: ligand pdbqt file was not defined. Use -lfile argument!\n");
		return 1;
	}

	return 0;
}

void get_recligpars(const Liganddata* myligand, const Gridinfo* mygrid, Dockpars* mypars)
//The function writes the proper data to mypars' num_of_genes, num_of_atoms, grid_size_xyz
//and other fields according to the myligand and mygrid parameters. The data will
//be in the same format as it is required for writing it to algorithm definded registers.
{
	int i;
	int gridsize_rounded_to_even_xyz [3];

	mypars->num_of_genes = 6+myligand->num_of_rotbonds-1;	//Have to be equal to number of genes-1
	mypars->num_of_genes = mypars->num_of_genes & 0x000000000000003FLL;		//6 bit number	(although this operation is not necessary)

	mypars->num_of_atoms = myligand->num_of_atoms-1;		//Have to be equal to number of atoms-1
	mypars->num_of_atoms = mypars->num_of_atoms & 0x00000000000000FFLL;		//8 bit number

	for (i=0; i<3; i++)
	{
		mypars->grid_size_xyz [i] = mygrid->size_xyz [i]-1;	//Have to be equal to number of grid points-1 in each direction
		mypars->grid_size_xyz [i] = mypars->grid_size_xyz [i] & 0x000000000000007FLL;	//7 bit number
	}

	mypars->sq_spacing = (unsigned long) float2fracint(pow(mygrid->spacing, 2), 17);	//Have to be equal to grid spacing^2 in 1.17
	mypars->sq_spacing = mypars->sq_spacing & 0x000000000003FFFFLL;		//18 bit number
	if (mygrid->spacing == 1)	//handling special case
		mypars->sq_spacing = 0x000000000001FFFFLL;

	for (i=0; i<3; i++)
		if ((mygrid->size_xyz [i] % 2) == 1)
			gridsize_rounded_to_even_xyz [i] = mygrid->size_xyz [i] + 1;
		else
			gridsize_rounded_to_even_xyz [i] = mygrid->size_xyz [i];

	mypars->size_of_cube = (unsigned long) (((double) gridsize_rounded_to_even_xyz [0] * gridsize_rounded_to_even_xyz [1] * gridsize_rounded_to_even_xyz [2])/8.0) & 0x000000000007FFFFLL;
	mypars->size_of_plane = (unsigned long) (((double) gridsize_rounded_to_even_xyz [0] * gridsize_rounded_to_even_xyz [1])/4.0) & 0x0000000000001FFFLL;
	mypars->size_of_line = (unsigned long) (((double) gridsize_rounded_to_even_xyz [0])/2.0) & 0x000000000000007FLL;
	mypars->eldesgrid_id = (unsigned long) myligand->num_of_atypes & 0x000000000000000FLL;

}

/*
void get_commandpars(const int* argc, char** argv, double* spacing, Dockpars* mypars)
*/
void get_commandpars(const int* argc, 		     
		     char** argv, 		     
		     float* spacing, 		     
		     Dockpars* mypars)


//The function processes the command line arguments given with the argc and argv parameters,
//and fills the proper fields of mypars according to that. If a parameter was not defined
//in the command line, the default value will be assigned. The maypars' fileds will contain
//the data in the same format as it is required for writing it to algorithm definded registers.
{
	int i;
	long tempint;
	double tempdb;
	int arg_recognized;


	//default values
	tempdb = log(6.0/(*spacing))/log(2.0)+10;	//calculating default dmov_mask (for 6 Angstr�m)
	tempint = (int) floor(tempdb+0.5);
	if (tempint < 1)
		tempint = 1;
	if (tempint > 16)
		tempint = 16;
	mypars->dmov_mask = (unsigned long) floor(pow(2,tempint)-1);

	mypars->dang_mask = 0xFFFF; //+/- 90�
	mypars->initpop_gen_or_loadfile = 0;
	mypars->mutation_rate = 0x5; //2%
	mypars->crossover_rate = 0xCC;	//80%
	mypars->tournament_rate = 0x99;	//60%
	mypars->num_of_energy_evals = 2500000;
	mypars->num_of_generations = 27000;
	mypars->seed_gen_or_loadfile = 0;
	mypars->gen_pdbs = 0;
	mypars->lsearch_rate = 0.06;	//6%
	mypars->rho_lower_bound = 0xA;	//0.01
	mypars->base_dmov_mul_sqrt3 = (unsigned long) float2fracint(2.0/(*spacing)*sqrt(3), 10);	//2 A
	mypars->base_dang_mul_sqrt3 = (unsigned long) float2fracint(75.0/180*512*sqrt(3), 8);		//75�
	mypars->cons_limit = 3;	//4
	mypars->max_num_of_iters = 300;
	mypars->pop_size = 150 - 1;
	mypars->num_of_runs = 1;
	mypars->reflig_en_reqired = 0;
	mypars->handle_symmetry = 0;
	mypars->gen_finalpop = 0;
	mypars->gen_best = 0;
	strcpy(mypars->resname, "docking");
	mypars->qasp = 0.01097;		//original AutoDock QASP parameter
	mypars->rmsd_tolerance = 2.0;	//2 Angstr�m


	//overwriting values which were defined as a command line argument
	for (i=1; i<(*argc)-1; i+=2)
	{
		arg_recognized = 0;

		//Argument: number of energy evaluations. Must be a positive integer.
		if (strcmp("-nev", argv [i]) == 0)
		{
			arg_recognized = 1;
			sscanf(argv [i+1], "%ld", &tempint);

			if ((tempint > 0) && (tempint < 260000000))
				mypars->num_of_energy_evals = (unsigned long) tempint;
			else
				printf("Warning: value of -nev argument ignored. Value must be between 0 and 260000000.\n");
		}

		//Argument: number of generations. Must be a positive integer.
		if (strcmp("-ngen", argv [i]) == 0)
		{
			arg_recognized = 1;
			sscanf(argv [i+1], "%ld", &tempint);

			if ((tempint > 0) && (tempint < 16250000))
				mypars->num_of_generations = (unsigned long) tempint;
			else
				printf("Warning: value of -ngen argument ignored. Value must be between 0 and 16250000.\n");
		}

		//Argument: name of result files.
		if (strcmp("-resnam", argv [i]) == 0)
		{
			arg_recognized = 1;
			strcpy(mypars->resname, argv [i+1]);
		}

		//Argument: mutation rate. Must be a float between 0 and 100.
		//Means the rate of mutations (cca) in percent.
		if (strcmp("-mrat", argv [i]) == 0)
		{
			arg_recognized = 1;
			sscanf(argv [i+1], "%lf", &tempdb);

			if ((tempdb >= 0.0) && (tempdb < 100.0))
				mypars->mutation_rate = (unsigned long) floor(tempdb/100*255);
			else
				printf("Warning: value of -mrat argument ignored. Value must be a double between 0 and 100.\n");
		}

		//Argument: crossover rate. Must be a float between 0 and 100.
		//Means the rate of crossovers (cca) in percent.
		if (strcmp("-crat", argv [i]) == 0)
		{
			arg_recognized = 1;
			sscanf(argv [i+1], "%lf", &tempdb);

			if ((tempdb >= 0.0) && (tempdb <= 100.0))
				mypars->crossover_rate = (unsigned long) floor(tempdb/100*255);
			else
				printf("Warning: value of -crat argument ignored. Value must be a double between 0 and 100.\n");
		}

		//Argument: tournament rate. Must be a float between 50 and 100.
		//Means the probability that the better entity wins the tournament round during selectin
		if (strcmp("-trat", argv [i]) == 0)
		{
			arg_recognized = 1;
			sscanf(argv [i+1], "%lf", &tempdb);

			if ((tempdb >= /*5*/0.0) && (tempdb <= 100.0))
				mypars->tournament_rate = (unsigned long) floor(tempdb/100*255);
			else
				printf("Warning: value of -trat argument ignored. Value must be a double between 0 and 100.\n");
		}

		//Argument: maximal delta movement during mutation. Must be a double greater than 0.
		//Will be rounded to the nearest value of the following set: 2^(N-10)*grid spacing angstr�m, N=1..16.
		if (strcmp("-dmov", argv [i]) == 0)
		{
			arg_recognized = 1;
			sscanf(argv [i+1], "%lf", &tempdb);

			if (tempdb > 0)
			{
				tempdb = log(tempdb/(*spacing))/log(2.0)+10;	//actually this should be rounded instead of N
				tempint = (int) floor(tempdb+0.5);
				if (tempint < 1)
					tempint = 1;
				if (tempint > 16)
					tempint = 16;
				mypars->dmov_mask = (unsigned long) floor(pow(2,tempint)-1);
			}
			else
				printf("Warning: value of -dmov argument ignored. Value must be a double greater than 0.\n");
		}

		//Argument: maximal delta angle during mutation. Must be a double greater than 0.
		//Will be rounded to the nearest value of the following set: 2^(N-8)*180/512 degrees, N=1..17.
		if (strcmp("-dang", argv [i]) == 0)
		{
			arg_recognized = 1;
			sscanf(argv [i+1], "%lf", &tempdb);

			if (tempdb > 0)
			{
				tempdb = log(512.0/180.0*tempdb)/log(2.0)+8;	//actually, this should be rounded instead of N
				tempint = (int) floor(tempdb+0.5);
				if (tempint < 1)
					tempint = 1;
				if (tempint > 17)
					tempint = 17;
				mypars->dang_mask = (unsigned long) floor(pow(2,tempint)-1);
			}
			else
				printf("Warning: value of -dang argument ignored. Value must be a double greater than 0.\n");
		}

		//Argument: load initial population from file instead of generating one.
		//If the value is zero, the initial population will be generated randomly, otherwise it will be loaded from a file.
		if (strcmp("-pload", argv [i]) == 0)
		{
			arg_recognized = 1;
			sscanf(argv [i+1], "%ld", &tempint);

			if (tempint == 0)
				mypars->initpop_gen_or_loadfile = 0;
			else
				mypars->initpop_gen_or_loadfile = 1;
		}

		//Argument: load FPGA random generator seeds from file instead of generating one.
		//If the value is zero, the seeds will be generated randomly, otherwise they will be loaded from a file.
		if (strcmp("-sload", argv [i]) == 0)
		{
			arg_recognized = 1;
			sscanf(argv [i+1], "%ld", &tempint);

			if (tempint == 0)
				mypars->seed_gen_or_loadfile = 0;
			else
				mypars->seed_gen_or_loadfile = 1;
		}

		//Argument: number of pdb files to be generated.
		//The files will include the best docking poses from the final population.
		if (strcmp("-npdb", argv [i]) == 0)
		{
			arg_recognized = 1;
			sscanf(argv [i+1], "%ld", &tempint);

			if ((tempint < 0) || (tempint > CPU_MAX_POP_SIZE))
				printf("Warning: value of -npdb argument ignored. Value must be an integer between 0 and %d.\n", CPU_MAX_POP_SIZE);
			else
				mypars->gen_pdbs = tempint;
		}

		//Argument: local search rate. Must be a float between 0 and 100.
		//Means the rate of local search (cca) in percent.
		if (strcmp("-lsrat", argv [i]) == 0)
		{
			arg_recognized = 1;
			sscanf(argv [i+1], "%lf", &tempdb);

			if ((tempdb >= 0.0) && (tempdb < 100.0))
				mypars->lsearch_rate = tempdb/100.0;
			else
				printf("Warning: value of -lrat argument ignored. Value must be a double between 0 and 100.\n");
		}

		//Argument: rho lower bound. Must be a float between 0 and 1.
		//Means the lower bound of the rho parameter (possible stop condition for local search).
		if (strcmp("-rholb", argv [i]) == 0)
		{
			arg_recognized = 1;
			sscanf(argv [i+1], "%lf", &tempdb);

			if ((tempdb >= 0.0) && (tempdb < 1.0))
				mypars->rho_lower_bound = (unsigned long) float2fracint(tempdb, 10);
			else
				printf("Warning: value of -rholb argument ignored. Value must be a double between 0 and 1.\n");
		}

		//Argument: local search delta movement. Must be a float between 0 and grid spacing*64 A.
		//Means the spread of unifily distributed delta movement of local search.
		if (strcmp("-lsmov", argv [i]) == 0)
		{
			arg_recognized = 1;
			sscanf(argv [i+1], "%lf", &tempdb);

			if ((tempdb > 0.0) && (tempdb < (*spacing)*64/sqrt(3)))
				mypars->base_dmov_mul_sqrt3 = (unsigned long) float2fracint(tempdb/(*spacing)*sqrt(3), 10);
			else
				printf("Warning: value of -lsmov argument ignored. Value must be a double between 0 and %lf.\n", 64*(*spacing));
		}

		//Argument: local search delta angle. Must be a float between 0 and 103�.
		//Means the spread of unifily distributed delta angle of local search.
		if (strcmp("-lsang", argv [i]) == 0)
		{
			arg_recognized = 1;
			sscanf(argv [i+1], "%lf", &tempdb);

			if ((tempdb > 0.0) && (tempdb < 103.0))
				mypars->base_dang_mul_sqrt3 = (unsigned long) float2fracint(tempdb/180*512*sqrt(3), 8);
			else
				printf("Warning: value of -lsang argument ignored. Value must be a double between 0 and 103.\n");
		}

		//Argument: consecutive success/failure limit. Must be an integer between 1 and 255.
		//Means the number of consecutive successes/failures after which value of rho have to be doubled/halved.
		if (strcmp("-cslim", argv [i]) == 0)
		{
			arg_recognized = 1;
			sscanf(argv [i+1], "%ld", &tempint);

			if ((tempint > 0) && (tempint < 256))
				mypars->cons_limit = (unsigned long) (tempint-1);
			else
				printf("Warning: value of -cslim argument ignored. Value must be an integer between 1 and 255.\n");
		}

		//Argument: maximal number of iterations for local search. Must be an integer between 1 and 262143.
		//Means the number of iterations after which the local search algorithm has to terminate.
		if (strcmp("-lsit", argv [i]) == 0)
		{
			arg_recognized = 1;
			sscanf(argv [i+1], "%ld", &tempint);

			if ((tempint > 0) && (tempint < 262144))
				mypars->max_num_of_iters = (unsigned long) tempint;
			else
				printf("Warning: value of -lsit argument ignored. Value must be an integer between 1 and 262143.\n");
		}

		//Argument: size of population. Must be an integer between 32 and CPU_MAX_POP_SIZE.
		//Means the size of the population in the genetic algorithm.
		if (strcmp("-psize", argv [i]) == 0)
		{
			arg_recognized = 1;
			sscanf(argv [i+1], "%ld", &tempint);

			if ((tempint >= 2) && (tempint <= CPU_MAX_POP_SIZE))
				mypars->pop_size = (unsigned long) (tempint-1);
			else
				printf("Warning: value of -psize argument ignored. Value must be an integer between 2 and %d.\n", CPU_MAX_POP_SIZE);
		}

		//Argument: handle molecular symmetry during rmsd calculation
		//If the value is not zero, molecular syymetry will be taken into account during rmsd calculation and clustering.
		if (strcmp("-hsym", argv [i]) == 0)
		{
			arg_recognized = 1;
			sscanf(argv [i+1], "%ld", &tempint);

			if (tempint == 0)
				mypars->handle_symmetry = 0;
			else
				mypars->handle_symmetry = 1;
		}

		//Argument: generate final population result files.
		//If the value is zero, result files containing the final populations won't be generatied, otherwise they will.
		if (strcmp("-gfpop", argv [i]) == 0)
		{
			arg_recognized = 1;
			sscanf(argv [i+1], "%ld", &tempint);

			if (tempint == 0)
				mypars->gen_finalpop = 0;
			else
				mypars->gen_finalpop = 1;
		}

		//Argument: generate best.pdbqt
		//If the value is zero, best.pdbqt file containing the coordinates of the best result found during all of the runs won't be generated, otherwise it will
		if (strcmp("-gbest", argv [i]) == 0)
		{
			arg_recognized = 1;
			sscanf(argv [i+1], "%ld", &tempint);

			if (tempint == 0)
				mypars->gen_best = 0;
			else
				mypars->gen_best = 1;
		}

		//Argument: number of runs. Must be an integer between 1 and 1000.
		//Means the number of required runs
		if (strcmp("-nrun", argv [i]) == 0)
		{
			arg_recognized = 1;
			sscanf(argv [i+1], "%ld", &tempint);

			if ((tempint >= 1) && (tempint <= 1000))
				mypars->num_of_runs = (int) tempint;
			else
				printf("Warning: value of -nrun argument ignored. Value must be an integer between 1 and 1000.\n");
		}

		//Argument: use modified QASP (from VirtualDrug) instead of original one used by AutoDock
		//If the value is not zero, the modified parameter will be used.
		if (strcmp("-modqp", argv [i]) == 0)
		{
			arg_recognized = 1;
			sscanf(argv [i+1], "%ld", &tempint);

			if (tempint == 0)
				mypars->qasp = 0.01097;		//original AutoDock QASP parameter
			else
				mypars->qasp = 0.00679;		//from VirtualDrug
		}

		//Argument: energies of reference ligand required.
		//If the value is not zero, energy values of the reference ligand is required.
		if (strcmp("-rlige", argv [i]) == 0)
		{
			arg_recognized = 1;
			sscanf(argv [i+1], "%ld", &tempint);

			if (tempint == 0)
				mypars->reflig_en_reqired = 0;
			else
				mypars->reflig_en_reqired = 1;
		}

		//Argument: rmsd tolerance for clustering.
		//This will be used during clustering for the tolerance distance.
		if (strcmp("-rmstol", argv [i]) == 0)
		{
			arg_recognized = 1;
			sscanf(argv [i+1], "%lf", &tempdb);

			if (tempdb > 0.0)
				mypars->rmsd_tolerance = tempdb;
			else
				printf("Warning: value of -rmstol argument ignored. Value must be a double greater than 0.\n");
		}

		//Argument: unbound model to be used.
		if (strcmp("-ubmod", argv [i]) == 0)
			arg_recognized = 1;

		//Argument: name of grid parameter file.
		if (strcmp("-ffile", argv [i]) == 0)
			arg_recognized = 1;

		//Argument: name of ligand pdbqt file
		if (strcmp("-lfile", argv [i]) == 0)
			arg_recognized = 1;

		if (arg_recognized != 1)
			printf("Warning: unknown argument '%s'.\n", argv [i]);

	}

	//validating some settings

	if (mypars->pop_size + 1 < mypars->gen_pdbs)
	{
		printf("Warning: value of -npdb argument igonred. Value mustn't be greater than the population size.\n");
		mypars->gen_pdbs = 1;
	}

}

/*
void get_seeds_and_initpop(Dockpars* mypars, double init_population [][40], const Liganddata* myligand, const Gridinfo* mygrid)
*/
void get_seeds_and_initpop(Dockpars* mypars, 			   
			   float init_population [][40], 			   
			   const Liganddata* myligand, 			   
			   const Gridinfo* mygrid)

//The function will fill the seed field of mypars, and the init_population parameter, which represents the initial population.
//The values will be generated randomly, or will be read from seeds.txt and initpop.txt (if they exist) according to the
//command line arguments which have to be stored in mypars parameter. That's why get_commandpars function must be called before
//invoking get_seeds_and_initpop.
{
	int entity_id, gene_id;
	int gen_pop, gen_seeds;
	FILE* fp;
	int pop_size = mypars->pop_size + 1;

	//initial population

	gen_pop = 0;

	if (mypars->initpop_gen_or_loadfile == 1)	//Reading initial population from file
	{
		fp = fopen("initpop.txt","r");
		if (fp == NULL)
		{
			printf("Warning: can't find initpop.txt. A new population will be generated.\n");
			gen_pop = 1;
		}
		else
		{
			for (entity_id=0; entity_id<pop_size; entity_id++)
				for (gene_id=0; gene_id<38; gene_id++)
					fscanf(fp, "%lf", &(init_population [entity_id][gene_id]));

			fscanf(fp, "%lf", &(mypars->ref_ori_angles [0]));	//reading reference orienation angles from file
			fscanf(fp, "%lf", &(mypars->ref_ori_angles [1]));
			fscanf(fp, "%lf", &(mypars->ref_ori_angles [2]));

			fclose(fp);
		}

	}
	else
		gen_pop = 1;

	if (gen_pop == 1)		//Generating initial population
	{
		for (entity_id=0; entity_id<pop_size; entity_id++)
			for (gene_id=0; gene_id<3; gene_id++)
#if defined (REPRO)
				init_population [entity_id][gene_id] = 30.1186;
#else
				init_population [entity_id][gene_id] = myrand()*(mygrid->size_xyz_angstr [gene_id]);
#endif

		for (entity_id=0; entity_id<pop_size; entity_id++)
			for (gene_id=3; gene_id<myligand->num_of_rotbonds+6; gene_id++)
				if (gene_id == 4)
#if defined (REPRO)
					init_population [entity_id][gene_id] = 26.0555;
#else
					init_population [entity_id][gene_id] = myrand()*180;
#endif
				else
#if defined (REPRO)
					init_population [entity_id][gene_id] = 22.0452;
#else
					init_population [entity_id][gene_id] = myrand()*360;
#endif

		//generating reference orientation angles
#if defined (REPRO)
		mypars->ref_ori_angles [0] = 190.279;	
		mypars->ref_ori_angles [1] = 190.279;
		mypars->ref_ori_angles [2] = 190.279;
#else
		mypars->ref_ori_angles [0] = floor(myrand()*360*100)/100;	
		mypars->ref_ori_angles [1] = floor(myrand()*360*100)/100;
		mypars->ref_ori_angles [2] = floor(myrand()*360*100)/100;
#endif

		fp = fopen("initpop.txt", "w");			//Writing initial population to initpop.txt
		if (fp == NULL)
			printf("Warning: can't create initpop.txt.\n");
		else
		{
			for (entity_id=0; entity_id<pop_size; entity_id++)
				for (gene_id=0; gene_id<38; gene_id++)
					fprintf(fp, "%lf ", init_population [entity_id][gene_id]);

			fprintf(fp, "%lf ", mypars->ref_ori_angles [0]);	//writing reference orientation angles to initpop.txt
			fprintf(fp, "%lf ", mypars->ref_ori_angles [1]);
			fprintf(fp, "%lf ", mypars->ref_ori_angles [2]);

			fclose(fp);
		}
	}

	//seeds

	gen_seeds = 0;

	if (mypars->seed_gen_or_loadfile == 1)	//Reading seeds from file
	{
		fp = fopen("seeds.txt","r");
		if (fp == NULL)
		{
			printf("Warning: can't find seeds.txt. New seeds will be generated.\n");
			gen_seeds = 1;
		}
		else
		{
			fscanf(fp, "%ld", &(mypars->seed));
			fclose(fp);
		}

	}
	else
		gen_seeds = 1;

	if (gen_seeds == 1)		//Generating seeds
	{
#if defined (REPRO)
		mypars->seed = (unsigned long) 1;
#else
		mypars->seed = (unsigned long) floor(myrand()*pow(2,36));
#endif
		fp = fopen("seeds.txt", "w");			//Writing seeds to seeds.txt
		if (fp == NULL)
			printf("Warning: can't create seeds.txt.\n");
		else
		{
			fprintf(fp, "%ld ", mypars->seed);
			fclose(fp);
		}
	}

}

void get_ref_orientation(Liganddata* myligand, const Dockpars* mypars)
//The function sets the initial orientation of myligand based on the ref_ori field of mypars.
//The corresponding grid information (mygrid) is required too.
{
	int i;
/*
	double init_orientation [38];
*/
	float init_orientation [38];

	for (i=0; i<38; i++)
		switch (i)
		{
		case 3: init_orientation [i] = mypars->ref_ori_angles [0];
				break;
		case 4: init_orientation [i] = mypars->ref_ori_angles [1];
				break;
		case 5: init_orientation [i] = mypars->ref_ori_angles [2];
				break;
		default: init_orientation [i] = 0;
		}

	change_conform(myligand, init_orientation, 0);

}

