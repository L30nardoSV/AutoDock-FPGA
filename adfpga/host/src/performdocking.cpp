#include "performdocking.h"

Dockparameters dockpars;
kernelconstant_static  KerConstStatic;
#if defined(SINGLE_COPY_POP_ENE)

#else
kernelconstant_dynamic KerConstDynamic;
#endif

int docking_with_fpga (
	const Gridinfo* mygrid,
	/*const*/ float* cpu_floatgrids,
    Dockpars* mypars,
	const Liganddata* myligand_init,
	const int* argc,
	char** argv,
	clock_t clock_start_program
)
/* The function performs the docking algorithm and generates the corresponding result files.
parameter mygrid:
		describes the grid
		filled with get_gridinfo()
parameter cpu_floatgrids:
		points to the memory region containing the grids
		filled with get_gridvalues_f()
parameter mypars:
		describes the docking parameters
		filled with get_commandpars()
parameter myligand_init:
		describes the ligands
		filled with get_liganddata()
parameters argc and argv:
		are the corresponding command line arguments parameter clock_start_program:
		contains the state of the clock tick counter at the beginning of the program
filled with clock() */
{

	if(!init()) {
    		return -1;
  	}
	printf("Init complete!\n"); fflush(stdout);

	Liganddata myligand_reference;
	
//#if defined (FIXED_POINT_INTERE)
#if 0
	size_t size_fixedpt64grids;
#else
	size_t size_floatgrids;

	#if defined(SEPARATE_FGRID_INTERE)
	size_t size_floatgrids2;
	size_t size_floatgrids3;
	#endif
#endif

	size_t size_populations;
	size_t size_energies;
	size_t size_prng_seeds;

#if defined(SINGLE_COPY_POP_ENE)
	size_t size_evals_of_runs;
#endif

	clock_t clock_start_docking;
	clock_t	clock_stop_docking;
	clock_t clock_stop_program_before_clustering;

	timeval tv_start_docking, tv_stop_docking;

	// Allocating CPU memory for initial populations
#if defined(SINGLE_COPY_POP_ENE)
	size_populations = mypars->num_of_runs * mypars->pop_size * ACTUAL_GENOTYPE_LENGTH * sizeof(float);
#else
	size_populations = mypars->pop_size * ACTUAL_GENOTYPE_LENGTH * sizeof(float);
#endif
	cpu_init_populations = (float*) alignedMalloc(size_populations);
	memset(cpu_init_populations, 0, size_populations);

	// Allocating CPU memory for results
#if defined(SINGLE_COPY_POP_ENE)
	size_energies = mypars->num_of_runs * mypars->pop_size * sizeof(float);
#else
	size_energies = mypars->pop_size * sizeof(float);
#endif
	cpu_energies = (float*) alignedMalloc(size_energies);		
	cpu_result_ligands = (Ligandresult*) alignedMalloc(sizeof(Ligandresult)*(mypars->num_of_runs));	
	cpu_final_populations = (float*) alignedMalloc(size_populations);

	// Allocating memory in CPU for reference orientation angles
#if defined(SINGLE_COPY_POP_ENE)
	cpu_ref_ori_angles = (float*) alignedMalloc(mypars->num_of_runs*3*sizeof(float));
#else
	cpu_ref_ori_angles = (float*) alignedMalloc(3*sizeof(float));
#endif

	// Generating initial populations and random orientation angles of reference ligand
	// (ligand will be moved to origo and scaled as well)
	myligand_reference = *myligand_init;
	gen_initpop_and_reflig(mypars, cpu_init_populations, cpu_ref_ori_angles, &myligand_reference, mygrid);

	// Allocating memory in CPU for pseudorandom number generator seeds, 
	// and generating them (seed for each thread during GA)
	uint num_of_prng_blocks = 25;
	size_prng_seeds = num_of_prng_blocks * mypars->num_of_runs * sizeof(uint);
	cpu_prng_seeds = (uint*) alignedMalloc(size_prng_seeds);
	genseed(time(NULL)); //initializing seed generator

	for (uint i=0; i<num_of_prng_blocks*mypars->num_of_runs; i++) {
#if defined (REPRO)
		cpu_prng_seeds[i] = 1u;
#else
		cpu_prng_seeds[i] = genseed(0u);
#endif
	}

#if defined(SINGLE_COPY_POP_ENE)
	// allocating memory in CPU for evaluation counters
	size_evals_of_runs = mypars->num_of_runs*sizeof(int);
	cpu_evals_of_runs = (int*) alignedMalloc(size_evals_of_runs);
	memset(cpu_evals_of_runs, 0, size_evals_of_runs);

	// allocating memory in CPU for generation counters
	cpu_gens_of_runs = (int*) alignedMalloc(size_evals_of_runs);
	memset(cpu_gens_of_runs, 0, size_evals_of_runs);
#endif

	// Preparing the constant data fields for the GPU
	// ----------------------------------------------------------------------
	// The original function does CUDA calls initializing const Kernel data.
	// We create a struct to hold those constants
	// and return them <here> (<here> = where prepare_const_fields_for_gpu() is called),
	// so we can send them to Kernels from <here>, instead of from calcenergy.cpp as originally.
	// ----------------------------------------------------------------------
#if defined(SINGLE_COPY_POP_ENE)
	if (prepare_conststatic_fields_for_gpu(&myligand_reference, mypars, cpu_ref_ori_angles, &KerConstStatic) == 1)
#else
	if (prepare_conststatic_fields_for_gpu(&myligand_reference, mypars, &KerConstStatic) == 1)
#endif
		return 1;

	// Preparing parameter struct
	dockpars.num_of_atoms = ((uchar) myligand_reference.num_of_atoms);
	dockpars.num_of_atypes = ((uchar) myligand_reference.num_of_atypes);
	dockpars.num_of_intraE_contributors = ((uint) myligand_reference.num_of_intraE_contributors);
	dockpars.gridsize_x = ((uchar) mygrid->size_xyz[0]);
	dockpars.gridsize_y = ((uchar) mygrid->size_xyz[1]);
	dockpars.gridsize_z = ((uchar) mygrid->size_xyz[2]);
	dockpars.g1 = dockpars.gridsize_x;
	dockpars.g2 = dockpars.gridsize_x * dockpars.gridsize_y;
	dockpars.g3 = dockpars.gridsize_x * dockpars.gridsize_y * dockpars.gridsize_z;
	dockpars.grid_spacing = ((float) mygrid->spacing);
	dockpars.rotbondlist_length = ((uint) NUM_OF_THREADS_PER_BLOCK * (myligand_reference.num_of_rotcyc));
	dockpars.coeff_elec = ((float) mypars->coeffs.scaled_AD4_coeff_elec);
	dockpars.coeff_desolv = ((float) mypars->coeffs.AD4_coeff_desolv);
	dockpars.num_of_energy_evals = (uint) mypars->num_of_energy_evals;
	dockpars.num_of_generations = (uint) mypars->num_of_generations;
	dockpars.pop_size = (uint) mypars->pop_size;
	dockpars.num_of_genes = (uint)(myligand_reference.num_of_rotbonds + 6);
	dockpars.tournament_rate = (mypars->tournament_rate) / 100;
	dockpars.crossover_rate = (mypars->crossover_rate) / 100;
	dockpars.mutation_rate = (mypars->mutation_rate) / 100;
	dockpars.abs_max_dang = mypars->abs_max_dang;
	dockpars.abs_max_dmov = mypars->abs_max_dmov;
	dockpars.lsearch_rate = mypars->lsearch_rate;
	dockpars.num_of_lsentities = (uint) (mypars->lsearch_rate/100.0*mypars->pop_size + 0.5);
	dockpars.rho_lower_bound = mypars->rho_lower_bound;
	dockpars.base_dmov_mul_sqrt3 = mypars->base_dmov_mul_sqrt3;
	dockpars.base_dang_mul_sqrt3 = mypars->base_dang_mul_sqrt3;
	dockpars.cons_limit = (uint) mypars->cons_limit;
	dockpars.max_num_of_iters = (uint) mypars->max_num_of_iters;
	dockpars.qasp = mypars->qasp;
	dockpars.smooth = mypars->smooth;

/*
printf("%i %i\n", dockpars.num_of_intraE_contributors, myligand_reference.num_of_intraE_contributors);
*/

	// Variables holding multiplications between kernel-constants.
	// Calculating them here and then pass them to Krnl_GA
	const float two_absmaxdmov = 2.0 * dockpars.abs_max_dmov;
	const float two_absmaxdang = 2.0 * dockpars.abs_max_dang;

	// Variables holding multiplications between kernel-constants.
	// Calculating them here and then pass them to Krnl_InterE
	#if defined(SEPARATE_FGRID_INTERE)

	#else
	const uint mul_tmp2 = dockpars.num_of_atypes * dockpars.g3;
	const uint mul_tmp3 = (dockpars.num_of_atypes + 1) * dockpars.g3;
	#endif

	// Variable holding a multiplication between kernel-constants
	// Calculating them it and then pass them to Krnl_IntraE
	const uint square_num_of_atypes = dockpars.num_of_atypes * dockpars.num_of_atypes;

	const uchar num_rotbonds = myligand_reference.num_of_rotbonds;

 	// Allocating GPU memory for populations, floatgrids,
	// energies, evaluation counters, and random number generator states
//#if defined (FIXED_POINT_INTERE)
#if 0
	size_fixedpt64grids = (sizeof(fixedpt64)) * (mygrid->num_of_atypes+2) * (mygrid->size_xyz[0]) * (mygrid->size_xyz[1]) * (mygrid->size_xyz[2]);
#else
	#if defined(SEPARATE_FGRID_INTERE)
	size_floatgrids = sizeof(float) * mygrid->num_of_atypes * mygrid->size_xyz[0]*mygrid->size_xyz[1]* mygrid->size_xyz[2];
	size_floatgrids2= sizeof(float) * mygrid->size_xyz[0] * mygrid->size_xyz[1] * mygrid->size_xyz[2];
	size_floatgrids3= sizeof(float) * mygrid->size_xyz[0] * mygrid->size_xyz[1] * mygrid->size_xyz[2];
	#else
	size_floatgrids = (sizeof(float)) * (mygrid->num_of_atypes+2) * (mygrid->size_xyz[0]) * (mygrid->size_xyz[1]) * (mygrid->size_xyz[2]);
	#endif
#endif

#if defined (FIXED_POINT_INTERE)
	mallocBufferObject(context, CL_MEM_READ_ONLY, MAX_NUM_OF_ATOMS*sizeof(fixedpt64), &mem_KerConstStatic_fixpt64_atom_charges_const);
#endif
	mallocBufferObject(context, CL_MEM_READ_ONLY, MAX_NUM_OF_ATOMS*sizeof(float), &mem_KerConstStatic_atom_charges_const);

	mallocBufferObject(context, CL_MEM_READ_ONLY, MAX_NUM_OF_ATOMS*sizeof(char), &mem_KerConstStatic_atom_types_const);

	//mallocBufferObject(context, CL_MEM_READ_ONLY, 3*MAX_INTRAE_CONTRIBUTORS*sizeof(char), &mem_KerConstStatic_intraE_contributors_const);
	mallocBufferObject(context, CL_MEM_READ_ONLY, MAX_INTRAE_CONTRIBUTORS*sizeof(cl_char3), &mem_KerConstStatic_intraE_contributors_const);

    mallocBufferObject(context, CL_MEM_READ_ONLY, ATYPE_NUM*sizeof(float), &mem_KerConstStatic_reqm_const);
	mallocBufferObject(context, CL_MEM_READ_ONLY, ATYPE_NUM*sizeof(float), &mem_KerConstStatic_reqm_hbond_const);
  	mallocBufferObject(context, CL_MEM_READ_ONLY, ATYPE_NUM*sizeof(uint), &mem_KerConstStatic_atom1_types_reqm_const);
  	mallocBufferObject(context, CL_MEM_READ_ONLY, ATYPE_NUM*sizeof(uint), &mem_KerConstStatic_atom2_types_reqm_const);

	mallocBufferObject(context, CL_MEM_READ_ONLY, MAX_NUM_OF_ATYPES*MAX_NUM_OF_ATYPES*sizeof(float), &mem_KerConstStatic_VWpars_AC_const);
	mallocBufferObject(context, CL_MEM_READ_ONLY, MAX_NUM_OF_ATYPES*MAX_NUM_OF_ATYPES*sizeof(float), &mem_KerConstStatic_VWpars_BD_const);
	mallocBufferObject(context, CL_MEM_READ_ONLY, MAX_NUM_OF_ATYPES*sizeof(float), &mem_KerConstStatic_dspars_S_const);
	mallocBufferObject(context, CL_MEM_READ_ONLY, MAX_NUM_OF_ATYPES*sizeof(float), &mem_KerConstStatic_dspars_V_const);

	#if defined (FIXED_POINT_CONFORM)
	// fixed-point
	mallocBufferObject(context, CL_MEM_READ_ONLY, MAX_NUM_OF_ROTATIONS*sizeof(fixedpt), &mem_KerConstStatic_rotlist_const);
	mallocBufferObject(context, CL_MEM_READ_ONLY, MAX_NUM_OF_ATOMS*sizeof(cl_int3), &mem_KerConstStatic_ref_coords_const);
	mallocBufferObject(context, CL_MEM_READ_ONLY, MAX_NUM_OF_ROTBONDS*sizeof(cl_int3), &mem_KerConstStatic_rotbonds_moving_vectors_const);
	mallocBufferObject(context, CL_MEM_READ_ONLY, MAX_NUM_OF_ROTBONDS*sizeof(cl_int3), &mem_KerConstStatic_rotbonds_unit_vectors_const);
	mallocBufferObject(context, CL_MEM_READ_ONLY, MAX_NUM_OF_RUNS*sizeof(cl_int4), &mem_KerConstStatic_ref_orientation_quats_const);
	#else
	// floating-point (original)
	mallocBufferObject(context, CL_MEM_READ_ONLY, MAX_NUM_OF_ROTATIONS*sizeof(int), &mem_KerConstStatic_rotlist_const);
	mallocBufferObject(context, CL_MEM_READ_ONLY, MAX_NUM_OF_ATOMS*sizeof(cl_float3), &mem_KerConstStatic_ref_coords_const);
	mallocBufferObject(context, CL_MEM_READ_ONLY, MAX_NUM_OF_ROTBONDS*sizeof(cl_float3), &mem_KerConstStatic_rotbonds_moving_vectors_const);
	mallocBufferObject(context, CL_MEM_READ_ONLY, MAX_NUM_OF_ROTBONDS*sizeof(cl_float3), &mem_KerConstStatic_rotbonds_unit_vectors_const);
	mallocBufferObject(context, CL_MEM_READ_ONLY, MAX_NUM_OF_RUNS*sizeof(cl_float4), &mem_KerConstStatic_ref_orientation_quats_const);
	#endif

//#if defined (FIXED_POINT_INTERE)
#if 0
	mallocBufferObject(context, CL_MEM_READ_ONLY, size_fixedpt64grids, &mem_dockpars_fgrids);
#else
	mallocBufferObject(context, CL_MEM_READ_ONLY, size_floatgrids, &mem_dockpars_fgrids);

	#if defined(SEPARATE_FGRID_INTERE)
	mallocBufferObject(context, CL_MEM_READ_ONLY, size_floatgrids2, &mem_dockpars_fgrids2);
	mallocBufferObject(context, CL_MEM_READ_ONLY, size_floatgrids3, &mem_dockpars_fgrids3);
	#endif
#endif

	mallocBufferObject(context,CL_MEM_READ_WRITE, size_populations, &mem_dockpars_conformations_current);
	mallocBufferObject(context,CL_MEM_READ_WRITE, size_energies, &mem_dockpars_energies_current);

#if defined(SINGLE_COPY_POP_ENE)
	mallocBufferObject(context,CL_MEM_WRITE_ONLY, size_evals_of_runs, &mem_evals_performed);
	mallocBufferObject(context,CL_MEM_WRITE_ONLY, size_evals_of_runs, &mem_gens_performed);
#else
	mallocBufferObject(context,CL_MEM_WRITE_ONLY, 2*sizeof(uint), &mem_evals_and_generations_performed);
#endif

#if defined(SINGLE_COPY_POP_ENE)

#else
	uint array_evals_and_generations_performed [2]; // [0]: evals, [1]: generations 
#endif

#if defined (FIXED_POINT_INTERE)
	memcopyBufferObjectToDevice(command_queue_ga, mem_KerConstStatic_fixpt64_atom_charges_const, &KerConstStatic.fixpt64_atom_charges_const[0], MAX_NUM_OF_ATOMS*sizeof(fixedpt64));
#endif
	memcopyBufferObjectToDevice(command_queue_ga, mem_KerConstStatic_atom_charges_const, &KerConstStatic.atom_charges_const[0], MAX_NUM_OF_ATOMS*sizeof(float));

	memcopyBufferObjectToDevice(command_queue_ga, mem_KerConstStatic_atom_types_const, &KerConstStatic.atom_types_const[0], MAX_NUM_OF_ATOMS*sizeof(char));

	//memcopyBufferObjectToDevice(command_queue_ga, mem_KerConstStatic_intraE_contributors_const, &KerConstStatic.intraE_contributors_const[0], 3*MAX_INTRAE_CONTRIBUTORS*sizeof(char));
	memcopyBufferObjectToDevice(command_queue_ga, mem_KerConstStatic_intraE_contributors_const, &KerConstStatic.intraE_contributors_const[0], MAX_INTRAE_CONTRIBUTORS*sizeof(cl_char3));

	memcopyBufferObjectToDevice(command_queue_ga, mem_KerConstStatic_reqm_const, &KerConstStatic.reqm_const, ATYPE_NUM*sizeof(float));
  	memcopyBufferObjectToDevice(command_queue_ga, mem_KerConstStatic_reqm_hbond_const, &KerConstStatic.reqm_hbond_const, ATYPE_NUM*sizeof(float));
  	memcopyBufferObjectToDevice(command_queue_ga, mem_KerConstStatic_atom1_types_reqm_const, &KerConstStatic.atom1_types_reqm_const, ATYPE_NUM*sizeof(uint));
  	memcopyBufferObjectToDevice(command_queue_ga, mem_KerConstStatic_atom2_types_reqm_const, &KerConstStatic.atom2_types_reqm_const, ATYPE_NUM*sizeof(uint));

	memcopyBufferObjectToDevice(command_queue_ga, mem_KerConstStatic_VWpars_AC_const, &KerConstStatic.VWpars_AC_const[0], MAX_NUM_OF_ATYPES*MAX_NUM_OF_ATYPES*sizeof(float));
	memcopyBufferObjectToDevice(command_queue_ga, mem_KerConstStatic_VWpars_BD_const, &KerConstStatic.VWpars_BD_const[0], MAX_NUM_OF_ATYPES*MAX_NUM_OF_ATYPES*sizeof(float));
	memcopyBufferObjectToDevice(command_queue_ga, mem_KerConstStatic_dspars_S_const, &KerConstStatic.dspars_S_const[0], MAX_NUM_OF_ATYPES*sizeof(float));
	memcopyBufferObjectToDevice(command_queue_ga, mem_KerConstStatic_dspars_V_const, &KerConstStatic.dspars_V_const[0], MAX_NUM_OF_ATYPES*sizeof(float));

	#if defined (FIXED_POINT_CONFORM)
	// Fixed-point
	memcopyBufferObjectToDevice(command_queue_ga, mem_KerConstStatic_rotlist_const, &KerConstStatic.rotlist_const[0], MAX_NUM_OF_ROTATIONS*sizeof(fixedpt));
	memcopyBufferObjectToDevice(command_queue_ga, mem_KerConstStatic_ref_coords_const, &KerConstStatic.ref_coords_const[0], MAX_NUM_OF_ATOMS*sizeof(cl_int3));
	memcopyBufferObjectToDevice(command_queue_ga, mem_KerConstStatic_rotbonds_moving_vectors_const, &KerConstStatic.rotbonds_moving_vectors_const[0], MAX_NUM_OF_ROTBONDS*sizeof(cl_int3));
	memcopyBufferObjectToDevice(command_queue_ga, mem_KerConstStatic_rotbonds_unit_vectors_const, &KerConstStatic.rotbonds_unit_vectors_const[0], MAX_NUM_OF_ROTBONDS*sizeof(cl_int3));
	memcopyBufferObjectToDevice(command_queue_ga, mem_KerConstStatic_ref_orientation_quats_const, &KerConstStatic.ref_orientation_quats_const[0], MAX_NUM_OF_RUNS*sizeof(cl_int4));
	#else
	// Floating-point (original)
	memcopyBufferObjectToDevice(command_queue_ga, mem_KerConstStatic_rotlist_const, &KerConstStatic.rotlist_const[0], MAX_NUM_OF_ROTATIONS*sizeof(int));
	memcopyBufferObjectToDevice(command_queue_ga, mem_KerConstStatic_ref_coords_const, &KerConstStatic.ref_coords_const[0], MAX_NUM_OF_ATOMS*sizeof(cl_float3));
	memcopyBufferObjectToDevice(command_queue_ga, mem_KerConstStatic_rotbonds_moving_vectors_const, &KerConstStatic.rotbonds_moving_vectors_const[0], MAX_NUM_OF_ROTBONDS*sizeof(cl_float3));
	memcopyBufferObjectToDevice(command_queue_ga, mem_KerConstStatic_rotbonds_unit_vectors_const, &KerConstStatic.rotbonds_unit_vectors_const[0], MAX_NUM_OF_ROTBONDS*sizeof(cl_float3));
	memcopyBufferObjectToDevice(command_queue_ga, mem_KerConstStatic_ref_orientation_quats_const, &KerConstStatic.ref_orientation_quats_const[0], MAX_NUM_OF_RUNS*sizeof(cl_float4));
	#endif

//#if defined (FIXED_POINT_INTERE)
#if 0
/*
	cpu_fixedpt64grids = (fixedpt64*) alignedMalloc((sizeof(fixedpt64))*(mygrid->num_of_atypes+2)*
						  			    (mygrid->size_xyz[0])*
			   					            (mygrid->size_xyz[1])*
									    (mygrid->size_xyz[2]));
*/
	cpu_fixedpt64grids = (fixedpt64*) alignedMalloc(size_fixedpt64grids);

	float* mypoi;
	fixedpt64* myqoi;
	mypoi = cpu_floatgrids;
	myqoi = cpu_fixedpt64grids;

	for (int t=0; t < mygrid->num_of_atypes+2; t++) {
		//reading values
		for (int z=0; z < mygrid->size_xyz[2]; z++)
			for (int y=0; y < mygrid->size_xyz[1]; y++)
				for (int x=0; x < mygrid->size_xyz[0]; x++)
				{
					//fscanf(fp, "%f", mypoi);
					//mypoi++;
					float tmp_grids = *mypoi;
					mypoi++;
					*myqoi = fixedpt64_fromfloat(tmp_grids);

					// test to prove that it requires 32.32
					// and 16.16 is not enough
					//fixedpt myqoi16 = fixedpt_fromfloat(tmp_grids);
					//printf("%-10f %-10f %-10f\n", tmp_grids, fixedpt64_tofloat(*myqoi), fixedpt_tofloat(myqoi16));
					
					myqoi++;

					
				}
	}

	memcopyBufferObjectToDevice(command_queue_ga, mem_dockpars_fgrids, cpu_fixedpt64grids, size_fixedpt64grids);
#else
	memcopyBufferObjectToDevice(command_queue_ga, mem_dockpars_fgrids, cpu_floatgrids, size_floatgrids);

	#if defined(SEPARATE_FGRID_INTERE)
	memcopyBufferObjectToDevice(command_queue_ga, mem_dockpars_fgrids2, cpu_floatgrids + mygrid->num_of_atypes * mygrid->size_xyz[0] * mygrid->size_xyz[1] * mygrid->size_xyz[2], size_floatgrids2);
	memcopyBufferObjectToDevice(command_queue_ga, mem_dockpars_fgrids3, cpu_floatgrids + (mygrid->num_of_atypes+1) * mygrid->size_xyz[0] * mygrid->size_xyz[1] * mygrid->size_xyz[2], size_floatgrids3);
	#endif
#endif

	clock_start_docking = clock();

	// Krnl_GA
	uint narg_ga = 0;
#ifdef SINGLE_COPY_POP_ENE
	setKernelArg(kernel_ga, narg_ga++, sizeof(mem_dockpars_conformations_current), &mem_dockpars_conformations_current);
	setKernelArg(kernel_ga, narg_ga++, sizeof(mem_dockpars_energies_current), &mem_dockpars_energies_current);
	setKernelArg(kernel_ga, narg_ga++, sizeof(mem_evals_performed), &mem_evals_performed);
	setKernelArg(kernel_ga, narg_ga++, sizeof(mem_gens_performed), &mem_gens_performed);
	setKernelArg(kernel_ga, narg_ga++, sizeof(uint), &dockpars.pop_size);
	setKernelArg(kernel_ga, narg_ga++, sizeof(uint), &dockpars.num_of_energy_evals);
	setKernelArg(kernel_ga, narg_ga++, sizeof(uint), &dockpars.num_of_generations);
	setKernelArg(kernel_ga, narg_ga++, sizeof(float), &dockpars.tournament_rate);
	setKernelArg(kernel_ga, narg_ga++, sizeof(float), &dockpars.mutation_rate);
	setKernelArg(kernel_ga, narg_ga++, sizeof(float), &dockpars.abs_max_dmov);
	setKernelArg(kernel_ga, narg_ga++, sizeof(float), &dockpars.abs_max_dang);
	setKernelArg(kernel_ga, narg_ga++, sizeof(float), &two_absmaxdmov);
	setKernelArg(kernel_ga, narg_ga++, sizeof(float), &two_absmaxdang);
	setKernelArg(kernel_ga, narg_ga++, sizeof(float), &dockpars.crossover_rate);
	setKernelArg(kernel_ga, narg_ga++, sizeof(uint), &dockpars.num_of_lsentities);
	setKernelArg(kernel_ga, narg_ga++, sizeof(uchar), &dockpars.num_of_genes);
	//setKernelArg(kernel_ga, narg_ga++, sizeof(ushort), run_cnt);
	//setKernelArg(kernel_ga, narg_ga++, sizeof(uint), offset_pop);
	//setKernelArg(kernel_ga, narg_ga, sizeof(uint), offset_ene);
#else
	setKernelArg(kernel_ga, narg_ga++, sizeof(mem_dockpars_conformations_current), &mem_dockpars_conformations_current);
	setKernelArg(kernel_ga, narg_ga++, sizeof(mem_dockpars_energies_current), &mem_dockpars_energies_current);
	setKernelArg(kernel_ga, narg_ga++, sizeof(mem_evals_and_generations_performed), &mem_evals_and_generations_performed);
	setKernelArg(kernel_ga, narg_ga++, sizeof(uint), &dockpars.pop_size);
	setKernelArg(kernel_ga, narg_ga++, sizeof(uint), &dockpars.num_of_energy_evals);
	setKernelArg(kernel_ga, narg_ga++, sizeof(uint), &dockpars.num_of_generations);
	setKernelArg(kernel_ga, narg_ga++, sizeof(float), &dockpars.tournament_rate);
	setKernelArg(kernel_ga, narg_ga++, sizeof(float), &dockpars.mutation_rate);
	setKernelArg(kernel_ga, narg_ga++, sizeof(float), &dockpars.abs_max_dmov);
	setKernelArg(kernel_ga, narg_ga++, sizeof(float), &dockpars.abs_max_dang);
	setKernelArg(kernel_ga, narg_ga++, sizeof(float), &two_absmaxdmov);
	setKernelArg(kernel_ga, narg_ga++, sizeof(float), &two_absmaxdang);
	setKernelArg(kernel_ga, narg_ga++, sizeof(float), &dockpars.crossover_rate);
	setKernelArg(kernel_ga, narg_ga++, sizeof(uint), &dockpars.num_of_lsentities);
	setKernelArg(kernel_ga, narg_ga++, sizeof(uchar), &dockpars.num_of_genes);
#endif

	// Krnl_PoseCalc
	setKernelArg(kernel_pc, 0, sizeof(mem_KerConstStatic_rotlist_const), &mem_KerConstStatic_rotlist_const);
	setKernelArg(kernel_pc, 1, sizeof(mem_KerConstStatic_ref_coords_const), &mem_KerConstStatic_ref_coords_const);
	setKernelArg(kernel_pc, 2, sizeof(mem_KerConstStatic_rotbonds_moving_vectors_const), &mem_KerConstStatic_rotbonds_moving_vectors_const);
	setKernelArg(kernel_pc, 3, sizeof(mem_KerConstStatic_rotbonds_unit_vectors_const), &mem_KerConstStatic_rotbonds_unit_vectors_const);
	setKernelArg(kernel_pc, 4, sizeof(uint), &dockpars.rotbondlist_length);
	setKernelArg(kernel_pc, 5, sizeof(uchar), &dockpars.num_of_atoms);
	setKernelArg(kernel_pc, 6, sizeof(uchar), &dockpars.num_of_genes);
	setKernelArg(kernel_pc, 7, sizeof(mem_KerConstStatic_ref_orientation_quats_const), &mem_KerConstStatic_ref_orientation_quats_const);
	//setKernelArg(kernel_pc, 7, sizeof(uchar), &num_rotbonds);
	//setKernelArg(kernel_pc, 8, sizeof(mem_KerConstStatic_ref_orientation_quats_const), &mem_KerConstStatic_ref_orientation_quats_const);	
	#if defined(SINGLE_COPY_POP_ENE)

	#else
		#if defined (FIXED_POINT_CONFORM)
	// Fixed-point
	setKernelArg(kernel_pc, 8, sizeof(fixedpt), &KerConstDynamic.ref_orientation_quats_const[0]);
	setKernelArg(kernel_pc, 9, sizeof(fixedpt), &KerConstDynamic.ref_orientation_quats_const[1]);
	setKernelArg(kernel_pc, 10, sizeof(fixedpt), &KerConstDynamic.ref_orientation_quats_const[2]);
	setKernelArg(kernel_pc, 11, sizeof(fixedpt), &KerConstDynamic.ref_orientation_quats_const[3]);
		#else
	// Floating-point (original)
	setKernelArg(kernel_pc, 8, sizeof(float), &KerConstDynamic.ref_orientation_quats_const[0]);
	setKernelArg(kernel_pc, 9, sizeof(float), &KerConstDynamic.ref_orientation_quats_const[1]);
	setKernelArg(kernel_pc, 10, sizeof(float), &KerConstDynamic.ref_orientation_quats_const[2]);
	setKernelArg(kernel_pc, 11, sizeof(float), &KerConstDynamic.ref_orientation_quats_const[3]);
		#endif
	#endif

	uchar gridsizex_minus1 = dockpars.gridsize_x - 1;
	uchar gridsizey_minus1 = dockpars.gridsize_y - 1;
	uchar gridsizez_minus1 = dockpars.gridsize_z - 1;

#if defined (FIXED_POINT_INTERE)
#else
	float fgridsizex_minus1 = (float) gridsizex_minus1;
	float fgridsizey_minus1 = (float) gridsizey_minus1;
	float fgridsizez_minus1 = (float) gridsizez_minus1;
#endif

	// Krnl_InterE
	uint narg_ie = 0;
	setKernelArg(kernel_ie, narg_ie++, sizeof(mem_dockpars_fgrids), &mem_dockpars_fgrids);
#ifdef FIXED_POINT_INTERE
	setKernelArg(kernel_ie, narg_ie++, sizeof(mem_KerConstStatic_fixpt64_atom_charges_const), &mem_KerConstStatic_fixpt64_atom_charges_const);
#else
	setKernelArg(kernel_ie, narg_ie++, sizeof(mem_KerConstStatic_atom_charges_const), &mem_KerConstStatic_atom_charges_const);
#endif
	setKernelArg(kernel_ie, narg_ie++, sizeof(mem_KerConstStatic_atom_types_const), &mem_KerConstStatic_atom_types_const);
	setKernelArg(kernel_ie, narg_ie++, sizeof(uchar), &dockpars.g1);
	setKernelArg(kernel_ie, narg_ie++, sizeof(uint), &dockpars.g2);
	setKernelArg(kernel_ie, narg_ie++, sizeof(uint), &dockpars.g3);
	setKernelArg(kernel_ie, narg_ie++, sizeof(uchar), &dockpars.num_of_atoms);

#ifdef FIXED_POINT_INTERE
	setKernelArg(kernel_ie, narg_ie++, sizeof(uchar), &gridsizex_minus1);
	setKernelArg(kernel_ie, narg_ie++, sizeof(uchar), &gridsizey_minus1);
	setKernelArg(kernel_ie, narg_ie++, sizeof(uchar), &gridsizez_minus1);
#else
	setKernelArg(kernel_ie, narg_ie++, sizeof(float), &fgridsizex_minus1);
	setKernelArg(kernel_ie, narg_ie++, sizeof(float), &fgridsizey_minus1);
	setKernelArg(kernel_ie, narg_ie++, sizeof(float), &fgridsizez_minus1);
#endif

#ifdef SEPARATE_FGRID_INTERE
	setKernelArg(kernel_ie, narg_ie++, sizeof(mem_dockpars_fgrids2), &mem_dockpars_fgrids2);
	setKernelArg(kernel_ie, narg_ie++, sizeof(mem_dockpars_fgrids3), &mem_dockpars_fgrids3);
#else
	setKernelArg(kernel_ie, narg_ie++, sizeof(uint), &mul_tmp2);
	setKernelArg(kernel_ie, narg_ie++, sizeof(uint), &mul_tmp3);
#endif

	// Krnl_IntraE
	setKernelArg(kernel_ia, 0, sizeof(mem_KerConstStatic_atom_charges_const), &mem_KerConstStatic_atom_charges_const);
	setKernelArg(kernel_ia, 1, sizeof(mem_KerConstStatic_atom_types_const), &mem_KerConstStatic_atom_types_const);
	setKernelArg(kernel_ia, 2, sizeof(mem_KerConstStatic_intraE_contributors_const), &mem_KerConstStatic_intraE_contributors_const);
  	setKernelArg(kernel_ia, 3, sizeof(dockpars.smooth), &dockpars.smooth);
  	setKernelArg(kernel_ia, 4, sizeof(mem_KerConstStatic_reqm_const), &mem_KerConstStatic_reqm_const);
  	setKernelArg(kernel_ia, 5, sizeof(mem_KerConstStatic_reqm_hbond_const), &mem_KerConstStatic_reqm_hbond_const);
  	setKernelArg(kernel_ia, 6, sizeof(mem_KerConstStatic_atom1_types_reqm_const), &mem_KerConstStatic_atom1_types_reqm_const);
  	setKernelArg(kernel_ia, 7, sizeof(mem_KerConstStatic_atom2_types_reqm_const), &mem_KerConstStatic_atom2_types_reqm_const);
	setKernelArg(kernel_ia, 8, sizeof(mem_KerConstStatic_VWpars_AC_const), &mem_KerConstStatic_VWpars_AC_const);
	setKernelArg(kernel_ia, 9, sizeof(mem_KerConstStatic_VWpars_BD_const), &mem_KerConstStatic_VWpars_BD_const);
	setKernelArg(kernel_ia, 10, sizeof(mem_KerConstStatic_dspars_S_const), &mem_KerConstStatic_dspars_S_const);
	setKernelArg(kernel_ia, 11, sizeof(mem_KerConstStatic_dspars_V_const), &mem_KerConstStatic_dspars_V_const);
	setKernelArg(kernel_ia, 12, sizeof(uchar), &dockpars.num_of_atoms);
	setKernelArg(kernel_ia, 13, sizeof(uint), &dockpars.num_of_intraE_contributors);
	setKernelArg(kernel_ia, 14, sizeof(float), &dockpars.grid_spacing);
	setKernelArg(kernel_ia, 15, sizeof(uchar), &dockpars.num_of_atypes);
	setKernelArg(kernel_ia, 16, sizeof(float), &dockpars.coeff_elec);
	setKernelArg(kernel_ia, 17, sizeof(float), &dockpars.qasp);
	setKernelArg(kernel_ia, 18, sizeof(float), &dockpars.coeff_desolv);

	// Krnl_PRNG_GG_float
	setKernelArg(kernel_prng_gg_float, 1, sizeof(uchar), &dockpars.num_of_genes);

	// Krnl_PRNG_float
	setKernelArg(kernel_prng_ls_float, 1, sizeof(uchar), &dockpars.num_of_genes);

	// Krnl_PRNG_uchar
	setKernelArg(kernel_prng_gg_uchar, 1, sizeof(uchar), &dockpars.num_of_genes);

#ifdef FIXED_POINT_LS
	fixedpt fixpt_base_dmov_mul_sqrt3 = fixedpt_fromfloat(dockpars.base_dmov_mul_sqrt3);
	fixedpt fixpt_base_dang_mul_sqrt3 = fixedpt_fromfloat(dockpars.base_dang_mul_sqrt3);
	fixedpt fixpt_rho_lower_bound = fixedpt_fromfloat(dockpars.rho_lower_bound);
#endif

	ushort Host_max_num_of_iters = (ushort) dockpars.max_num_of_iters;
	uchar Host_cons_limit = (uchar) dockpars.cons_limit;

	// Krnl_LS
	setKernelArg(kernel_ls, 0, sizeof(ushort), &Host_max_num_of_iters);
#ifdef FIXED_POINT_LS
	setKernelArg(kernel_ls, 1, sizeof(fixedpt), &fixpt_rho_lower_bound);
	setKernelArg(kernel_ls, 2, sizeof(fixedpt), &fixpt_base_dmov_mul_sqrt3);
#else
	setKernelArg(kernel_ls, 1, sizeof(float), &dockpars.rho_lower_bound);
	setKernelArg(kernel_ls, 2, sizeof(float), &dockpars.base_dmov_mul_sqrt3);
#endif
	setKernelArg(kernel_ls, 3, sizeof(uchar), &dockpars.num_of_genes);
#ifdef FIXED_POINT_LS
	setKernelArg(kernel_ls, 4, sizeof(fixedpt), &fixpt_base_dang_mul_sqrt3);
#else
	setKernelArg(kernel_ls, 4, sizeof(float), &dockpars.base_dang_mul_sqrt3);
#endif

	setKernelArg(kernel_ls, 5, sizeof(uchar), &Host_cons_limit);

	setKernelArg(kernel_prng_ls2_float, 1, sizeof(uchar), &dockpars.num_of_genes);

	// Krnl_LS2
	setKernelArg(kernel_ls2, 0, sizeof(ushort), &Host_max_num_of_iters);
#ifdef FIXED_POINT_LS
	setKernelArg(kernel_ls2, 1, sizeof(fixedpt), &fixpt_rho_lower_bound);
	setKernelArg(kernel_ls2, 2, sizeof(fixedpt), &fixpt_base_dmov_mul_sqrt3);
#else
	setKernelArg(kernel_ls2, 1, sizeof(float), &dockpars.rho_lower_bound);
	setKernelArg(kernel_ls2, 2, sizeof(float), &dockpars.base_dmov_mul_sqrt3);
#endif
	setKernelArg(kernel_ls2, 3, sizeof(uchar), &dockpars.num_of_genes);
#ifdef FIXED_POINT_LS
	setKernelArg(kernel_ls2, 4, sizeof(fixedpt), &fixpt_base_dang_mul_sqrt3);
#else
	setKernelArg(kernel_ls2, 4, sizeof(float), &dockpars.base_dang_mul_sqrt3);
#endif
	//setKernelArg(kernel_ls2, 5, sizeof(uint), &dockpars.cons_limit);
	setKernelArg(kernel_ls2, 5, sizeof(uchar), &Host_cons_limit);

	setKernelArg(kernel_prng_ls3_float, 1, sizeof(uchar), &dockpars.num_of_genes);

	// Krnl_LS3
	setKernelArg(kernel_ls3, 0, sizeof(ushort), &Host_max_num_of_iters);
#ifdef FIXED_POINT_LS
	setKernelArg(kernel_ls3, 1, sizeof(fixedpt), &fixpt_rho_lower_bound);
	setKernelArg(kernel_ls3, 2, sizeof(fixedpt), &fixpt_base_dmov_mul_sqrt3);
#else
	setKernelArg(kernel_ls3, 1, sizeof(float), &dockpars.rho_lower_bound);
	setKernelArg(kernel_ls3, 2, sizeof(float), &dockpars.base_dmov_mul_sqrt3);
#endif
	setKernelArg(kernel_ls3, 3, sizeof(uchar), &dockpars.num_of_genes);
#ifdef FIXED_POINT_LS
	setKernelArg(kernel_ls3, 4, sizeof(fixedpt), &fixpt_base_dang_mul_sqrt3);
#else
	setKernelArg(kernel_ls3, 4, sizeof(float), &dockpars.base_dang_mul_sqrt3);
#endif

	setKernelArg(kernel_ls3, 5, sizeof(uchar), &Host_cons_limit);
	
	setKernelArg(kernel_ls123_ushort, 9, sizeof(uint), &dockpars.pop_size);

	setKernelArg(kernel_prng_bt_ushort_float, 2, sizeof(uint), &dockpars.pop_size);

	setKernelArg(kernel_prng_ls4_float, 1, sizeof(uchar), &dockpars.num_of_genes);

	setKernelArg(kernel_prng_ls5_float, 1, sizeof(uchar), &dockpars.num_of_genes);

	// Krnl_LS4
	setKernelArg(kernel_ls4, 0, sizeof(ushort), &Host_max_num_of_iters);
#ifdef FIXED_POINT_LS
	setKernelArg(kernel_ls4, 1, sizeof(fixedpt), &fixpt_rho_lower_bound);
	setKernelArg(kernel_ls4, 2, sizeof(fixedpt), &fixpt_base_dmov_mul_sqrt3);
#else
	setKernelArg(kernel_ls4, 1, sizeof(float), &dockpars.rho_lower_bound);
	setKernelArg(kernel_ls4, 2, sizeof(float), &dockpars.base_dmov_mul_sqrt3);
#endif
	setKernelArg(kernel_ls4, 3, sizeof(uchar), &dockpars.num_of_genes);
#ifdef FIXED_POINT_LS
	setKernelArg(kernel_ls4, 4, sizeof(fixedpt), &fixpt_base_dang_mul_sqrt3);
#else
	setKernelArg(kernel_ls4, 4, sizeof(float), &dockpars.base_dang_mul_sqrt3);
#endif
	setKernelArg(kernel_ls4, 5, sizeof(uchar), &Host_cons_limit);

	// Krnl_LS5
	setKernelArg(kernel_ls5, 0, sizeof(ushort),  &Host_max_num_of_iters);
#ifdef FIXED_POINT_LS
	setKernelArg(kernel_ls5, 1, sizeof(fixedpt), &fixpt_rho_lower_bound);
	setKernelArg(kernel_ls5, 2, sizeof(fixedpt), &fixpt_base_dmov_mul_sqrt3);
#else
	setKernelArg(kernel_ls5, 1, sizeof(float), &dockpars.rho_lower_bound);
	setKernelArg(kernel_ls5, 2, sizeof(float), &dockpars.base_dmov_mul_sqrt3);
#endif
	setKernelArg(kernel_ls5, 3, sizeof(uchar), &dockpars.num_of_genes);
#ifdef FIXED_POINT_LS
	setKernelArg(kernel_ls5, 4, sizeof(fixedpt), &fixpt_base_dang_mul_sqrt3);
#else
	setKernelArg(kernel_ls5, 4, sizeof(float), &dockpars.base_dang_mul_sqrt3);
#endif
	setKernelArg(kernel_ls5, 5, sizeof(uchar), &Host_cons_limit);

	setKernelArg(kernel_prng_ls6_float,1, sizeof(uchar), &dockpars.num_of_genes);
	setKernelArg(kernel_prng_ls7_float,1, sizeof(uchar), &dockpars.num_of_genes);
	setKernelArg(kernel_prng_ls8_float,1, sizeof(uchar), &dockpars.num_of_genes);
	setKernelArg(kernel_prng_ls9_float,1, sizeof(uchar), &dockpars.num_of_genes);

	// Krnl_LS6
	setKernelArg(kernel_ls6, 0, sizeof(ushort), &Host_max_num_of_iters);
#ifdef FIXED_POINT_LS
	setKernelArg(kernel_ls6, 1, sizeof(fixedpt), &fixpt_rho_lower_bound);
	setKernelArg(kernel_ls6, 2, sizeof(fixedpt), &fixpt_base_dmov_mul_sqrt3);
#else
	setKernelArg(kernel_ls6, 1, sizeof(float), &dockpars.rho_lower_bound);
	setKernelArg(kernel_ls6, 2, sizeof(float), &dockpars.base_dmov_mul_sqrt3);
#endif
	setKernelArg(kernel_ls6, 3, sizeof(uchar), &dockpars.num_of_genes);
#ifdef FIXED_POINT_LS
	setKernelArg(kernel_ls6, 4, sizeof(fixedpt), &fixpt_base_dang_mul_sqrt3);
#else
	setKernelArg(kernel_ls6, 4, sizeof(float), &dockpars.base_dang_mul_sqrt3);
#endif
	setKernelArg(kernel_ls6, 5, sizeof(uchar), &Host_cons_limit);

	// Krnl_LS7
	setKernelArg(kernel_ls7, 0, sizeof(ushort), &Host_max_num_of_iters);
#ifdef FIXED_POINT_LS
	setKernelArg(kernel_ls7, 1, sizeof(fixedpt), &fixpt_rho_lower_bound);
	setKernelArg(kernel_ls7, 2, sizeof(fixedpt), &fixpt_base_dmov_mul_sqrt3);
#else
	setKernelArg(kernel_ls7, 1, sizeof(float), &dockpars.rho_lower_bound);
	setKernelArg(kernel_ls7, 2, sizeof(float), &dockpars.base_dmov_mul_sqrt3);
#endif
	setKernelArg(kernel_ls7, 3, sizeof(uchar), &dockpars.num_of_genes);
#ifdef FIXED_POINT_LS
	setKernelArg(kernel_ls7, 4, sizeof(fixedpt), &fixpt_base_dang_mul_sqrt3);
#else
	setKernelArg(kernel_ls7, 4, sizeof(float), &dockpars.base_dang_mul_sqrt3);
#endif
	setKernelArg(kernel_ls7, 5, sizeof(uchar), &Host_cons_limit);

	// Krnl_LS8
	setKernelArg(kernel_ls8, 0, sizeof(ushort), &Host_max_num_of_iters);
#ifdef FIXED_POINT_LS
	setKernelArg(kernel_ls8, 1, sizeof(fixedpt), &fixpt_rho_lower_bound);
	setKernelArg(kernel_ls8, 2, sizeof(fixedpt), &fixpt_base_dmov_mul_sqrt3);
#else
	setKernelArg(kernel_ls8, 1, sizeof(float), &dockpars.rho_lower_bound);
	setKernelArg(kernel_ls8, 2, sizeof(float), &dockpars.base_dmov_mul_sqrt3);
#endif
	setKernelArg(kernel_ls8, 3, sizeof(uchar), &dockpars.num_of_genes);
#ifdef FIXED_POINT_LS
	setKernelArg(kernel_ls8, 4, sizeof(fixedpt), &fixpt_base_dang_mul_sqrt3);
#else
	setKernelArg(kernel_ls8, 4, sizeof(float), &dockpars.base_dang_mul_sqrt3);
#endif
	setKernelArg(kernel_ls8, 5, sizeof(uchar), &Host_cons_limit);

	// Krnl_LS9
	setKernelArg(kernel_ls9, 0, sizeof(ushort), &Host_max_num_of_iters);
#ifdef FIXED_POINT_LS
	setKernelArg(kernel_ls9, 1, sizeof(fixedpt), &fixpt_rho_lower_bound);
	setKernelArg(kernel_ls9, 2, sizeof(fixedpt), &fixpt_base_dmov_mul_sqrt3);
#else
	setKernelArg(kernel_ls9, 1, sizeof(float), &dockpars.rho_lower_bound);
	setKernelArg(kernel_ls9, 2, sizeof(float), &dockpars.base_dmov_mul_sqrt3);
#endif
	setKernelArg(kernel_ls9, 3, sizeof(uchar), &dockpars.num_of_genes);
#ifdef FIXED_POINT_LS
	setKernelArg(kernel_ls9, 4, sizeof(fixedpt), &fixpt_base_dang_mul_sqrt3);
#else
	setKernelArg(kernel_ls9, 4, sizeof(float), &dockpars.base_dang_mul_sqrt3);
#endif
	setKernelArg(kernel_ls9, 5, sizeof(uchar), &Host_cons_limit);

#if defined(SINGLE_COPY_POP_ENE)
	memcopyBufferObjectToDevice(command_queue_ga, mem_dockpars_conformations_current, cpu_init_populations, size_populations);
#endif

	printf("Docking runs to be executed: %u\n", mypars->num_of_runs); 
	printf("Execution run: \n");

	for (uint run_cnt = 0; run_cnt < mypars->num_of_runs; run_cnt++)
	{
		printf(" %u", run_cnt + 1);
		if ((run_cnt + 1) % 10 == 0) { printf("\n"); } // Next line if nrun is multiple of 10
		fflush(stdout);

#if defined(SINGLE_COPY_POP_ENE)

#else
		myligand_reference = *myligand_init;
		gen_initpop_and_reflig(mypars, cpu_init_populations, cpu_ref_ori_angles, &myligand_reference, mygrid);

		if (prepare_constdynamic_fields_for_gpu(&myligand_reference, mypars, cpu_ref_ori_angles, &KerConstDynamic) == 1)
			return 1;

 		memcopyBufferObjectToDevice(command_queue_ga,mem_dockpars_conformations_current, 	cpu_init_populations, size_populations);
#endif

#ifdef SINGLE_COPY_POP_ENE
		uint Host_Offset_Pop = run_cnt * dockpars.pop_size * ACTUAL_GENOTYPE_LENGTH;
		uint Host_Offset_Ene = run_cnt * dockpars.pop_size;
		uint narg_ga_2 = narg_ga;
		setKernelArg(kernel_ga, narg_ga_2++, sizeof(ushort), &run_cnt);
		setKernelArg(kernel_ga, narg_ga_2++, sizeof(uint), &Host_Offset_Pop);
		setKernelArg(kernel_ga, narg_ga_2++, sizeof(uint), &Host_Offset_Ene);
#endif

	// Krnl_PoseCalc
	/*
	#if defined(SINGLE_COPY_POP_ENE)
		#if defined (FIXED_POINT_CONFORM)
		setKernelArg(kernel_pc, 8, sizeof(fixedpt), &KerConstStatic.ref_orientation_quats_const[4*run_cnt]);
		setKernelArg(kernel_pc, 9, sizeof(fixedpt), &KerConstStatic.ref_orientation_quats_const[4*run_cnt + 1]);
		setKernelArg(kernel_pc, 10, sizeof(fixedpt), &KerConstStatic.ref_orientation_quats_const[4*run_cnt + 2]);
		setKernelArg(kernel_pc, 11, sizeof(fixedpt), &KerConstStatic.ref_orientation_quats_const[4*run_cnt + 3]);
		#else
		setKernelArg(kernel_pc, 8, sizeof(float), &KerConstStatic.ref_orientation_quats_const[4*run_cnt]);
		setKernelArg(kernel_pc, 9, sizeof(float), &KerConstStatic.ref_orientation_quats_const[4*run_cnt + 1]);
		setKernelArg(kernel_pc, 10, sizeof(float), &KerConstStatic.ref_orientation_quats_const[4*run_cnt + 2]);
		setKernelArg(kernel_pc, 11, sizeof(float), &KerConstStatic.ref_orientation_quats_const[4*run_cnt + 3]);
		#endif
	#else
		#if defined (FIXED_POINT_CONFORM)
		setKernelArg(kernel_pc, 8, sizeof(fixedpt), &KerConstDynamic.ref_orientation_quats_const[0]);
		setKernelArg(kernel_pc, 9, sizeof(fixedpt), &KerConstDynamic.ref_orientation_quats_const[1]);
		setKernelArg(kernel_pc, 10, sizeof(fixedpt), &KerConstDynamic.ref_orientation_quats_const[2]);
		setKernelArg(kernel_pc, 11, sizeof(fixedpt), &KerConstDynamic.ref_orientation_quats_const[3]);
		#else
		setKernelArg(kernel_pc, 8, sizeof(float), &KerConstDynamic.ref_orientation_quats_const[0]);
		setKernelArg(kernel_pc, 9, sizeof(float), &KerConstDynamic.ref_orientation_quats_const[1]);
		setKernelArg(kernel_pc, 10, sizeof(float), &KerConstDynamic.ref_orientation_quats_const[2]);
		setKernelArg(kernel_pc, 11, sizeof(float), &KerConstDynamic.ref_orientation_quats_const[3]);
		#endif
	#endif
	*/
		setKernelArg(kernel_pc, 8, sizeof(ushort), &run_cnt);

		setKernelArg(kernel_prng_gg_float, 0, sizeof(uint), &cpu_prng_seeds[num_of_prng_blocks * run_cnt]);
		setKernelArg(kernel_prng_gg_uchar, 0, sizeof(uint), &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 2]);
		setKernelArg(kernel_prng_bt_ushort_float, 0, sizeof(uint), &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 14]);
		setKernelArg(kernel_prng_bt_ushort_float, 1, sizeof(uint), &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 15]);

		setKernelArg(kernel_ls123_ushort, 0, sizeof(uint), &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 5]);
		setKernelArg(kernel_ls123_ushort, 1, sizeof(uint), &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 6]);
		setKernelArg(kernel_ls123_ushort, 2, sizeof(uint), &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 7]);
		setKernelArg(kernel_ls123_ushort, 3, sizeof(uint), &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 8]);
		setKernelArg(kernel_ls123_ushort, 4, sizeof(uint), &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 9]);
		setKernelArg(kernel_ls123_ushort, 5, sizeof(uint), &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 10]);
		setKernelArg(kernel_ls123_ushort, 6, sizeof(uint), &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 11]);
		setKernelArg(kernel_ls123_ushort, 7, sizeof(uint), &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 12]);
		setKernelArg(kernel_ls123_ushort, 8, sizeof(uint), &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 13]);

		setKernelArg(kernel_prng_ls_float,  0, sizeof(uint), &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 1]);
		setKernelArg(kernel_prng_ls2_float, 0, sizeof(uint), &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 3]);
		setKernelArg(kernel_prng_ls3_float, 0, sizeof(uint), &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 4]);
		setKernelArg(kernel_prng_ls4_float, 0, sizeof(uint), &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 16]);
		setKernelArg(kernel_prng_ls5_float, 0, sizeof(uint), &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 17]);
		setKernelArg(kernel_prng_ls6_float, 0, sizeof(uint), &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 18]);
		setKernelArg(kernel_prng_ls7_float, 0, sizeof(uint), &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 19]);
		setKernelArg(kernel_prng_ls8_float, 0, sizeof(uint), &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 20]);
		setKernelArg(kernel_prng_ls9_float, 0, sizeof(uint), &cpu_prng_seeds[num_of_prng_blocks * run_cnt + 21]);

		runKernelTask(command_queue_ga, kernel_ga, NULL, NULL);
		runKernelTask(command_queue_pc, kernel_pc, NULL, NULL);
		runKernelTask(command_queue_ie, kernel_ie, NULL, NULL);
		runKernelTask(command_queue_ia, kernel_ia, NULL, NULL);
		runKernelTask(command_queue_ls123_ushort, kernel_ls123_ushort, NULL, NULL);
		runKernelTask(command_queue_igl_arb, kernel_igl_arb, NULL, NULL);		
		runKernelTask(command_queue_prng_gg_float, kernel_prng_gg_float, NULL, NULL);
		runKernelTask(command_queue_prng_gg_uchar, kernel_prng_gg_uchar, NULL, NULL);
		runKernelTask(command_queue_prng_bt_ushort_float, kernel_prng_bt_ushort_float, NULL, NULL);
		runKernelTask(command_queue_ls,  kernel_ls,  NULL, NULL);
		runKernelTask(command_queue_ls2, kernel_ls2, NULL, NULL);
		runKernelTask(command_queue_ls3, kernel_ls3, NULL, NULL);
		runKernelTask(command_queue_ls4, kernel_ls4, NULL, NULL);
		runKernelTask(command_queue_ls5, kernel_ls5, NULL, NULL);
		runKernelTask(command_queue_ls6, kernel_ls6, NULL, NULL);
		runKernelTask(command_queue_ls7, kernel_ls7, NULL, NULL);
		runKernelTask(command_queue_ls8, kernel_ls8, NULL, NULL);
		runKernelTask(command_queue_ls9, kernel_ls9, NULL, NULL);
		runKernelTask(command_queue_prng_ls_float,  kernel_prng_ls_float,  NULL, NULL);
		runKernelTask(command_queue_prng_ls2_float, kernel_prng_ls2_float, NULL, NULL);
		runKernelTask(command_queue_prng_ls3_float, kernel_prng_ls3_float, NULL, NULL);
		runKernelTask(command_queue_prng_ls4_float, kernel_prng_ls4_float, NULL, NULL);
		runKernelTask(command_queue_prng_ls5_float, kernel_prng_ls5_float, NULL, NULL);
		runKernelTask(command_queue_prng_ls6_float, kernel_prng_ls6_float, NULL, NULL);
		runKernelTask(command_queue_prng_ls7_float, kernel_prng_ls7_float, NULL, NULL);
		runKernelTask(command_queue_prng_ls8_float, kernel_prng_ls8_float, NULL, NULL);
		runKernelTask(command_queue_prng_ls9_float, kernel_prng_ls9_float, NULL, NULL);

		clFinish(command_queue_ga); 
		clFinish(command_queue_pc); 
		clFinish(command_queue_ie); 
		clFinish(command_queue_ia);
		clFinish(command_queue_ls123_ushort); 
		clFinish(command_queue_igl_arb);
		clFinish(command_queue_prng_gg_float); 
		clFinish(command_queue_prng_gg_uchar);		
		clFinish(command_queue_prng_bt_ushort_float);
		clFinish(command_queue_ls);
		clFinish(command_queue_ls2);
		clFinish(command_queue_ls3);
		clFinish(command_queue_ls4);
		clFinish(command_queue_ls5);
		clFinish(command_queue_ls6);
		clFinish(command_queue_ls7);
		clFinish(command_queue_ls8);
		clFinish(command_queue_ls9);
		clFinish(command_queue_prng_ls_float);
		clFinish(command_queue_prng_ls2_float);
		clFinish(command_queue_prng_ls3_float);
		clFinish(command_queue_prng_ls4_float);
		clFinish(command_queue_prng_ls5_float);
		clFinish(command_queue_prng_ls6_float);
		clFinish(command_queue_prng_ls7_float);
		clFinish(command_queue_prng_ls8_float);
		clFinish(command_queue_prng_ls9_float);			

		clock_stop_docking = clock();

#if defined(SINGLE_COPY_POP_ENE)

#else
		//copy results from device
		memcopyBufferObjectFromDevice(command_queue_ga,array_evals_and_generations_performed,mem_evals_and_generations_performed,2*sizeof(uint));
		mypars->num_of_energy_evals = array_evals_and_generations_performed[0];
		mypars->num_of_generations  = array_evals_and_generations_performed[1];
	
		memcopyBufferObjectFromDevice(command_queue_ga,cpu_final_populations,mem_dockpars_conformations_current,size_populations);
		memcopyBufferObjectFromDevice(command_queue_ga,cpu_energies,mem_dockpars_energies_current,size_energies);

		//processing results
/*
		// Fix genotypes so map angle is used for genotypes 3,4,5
		// Check what format is used by host regarding the angles
		for (int ent_cnt=0; ent_cnt<mypars->pop_size; ent_cnt++) {
				
			float temp_genotype[ACTUAL_GENOTYPE_LENGTH];
			memcpy(temp_genotype, cpu_final_populations+ent_cnt*ACTUAL_GENOTYPE_LENGTH, ACTUAL_GENOTYPE_LENGTH*sizeof(float));

			for (int gene_cnt=3; gene_cnt<ACTUAL_GENOTYPE_LENGTH; gene_cnt++) {
				
				if (gene_cnt == 4) {
					//temp_genotype[gene_cnt] = map_angle_180(temp_genotype[gene_cnt]);
				}
				else {
					temp_genotype[gene_cnt] = map_angle_360(temp_genotype[gene_cnt]);
				}
			}
			memcpy(cpu_final_populations+ent_cnt*ACTUAL_GENOTYPE_LENGTH, temp_genotype, ACTUAL_GENOTYPE_LENGTH*sizeof(float));
			
		}
*/

/*
		arrange_result(cpu_final_populations+run_cnt*mypars->pop_size*GENOTYPE_LENGTH_IN_GLOBMEM, 
			       cpu_energies+run_cnt*mypars->pop_size, mypars->pop_size);
*/

		arrange_result(cpu_final_populations, cpu_energies, mypars->pop_size);

/*
		make_resfiles(cpu_final_populations+run_cnt*mypars->pop_size*GENOTYPE_LENGTH_IN_GLOBMEM, 
			      cpu_energies+run_cnt*mypars->pop_size, 
			      &myligand_reference,
			      myligand_init, 
			      mypars, 
   			      cpu_evals_of_runs[run_cnt], 
			      generation_cnt, 
			      mygrid, 
			      cpu_floatgrids, 
			      cpu_ref_ori_angles+3*run_cnt, 
			      argc, 
			      argv, 
			      0,
			      run_cnt, 
                              &(cpu_result_ligands [run_cnt]));
*/
		// Writing out final_population generated by get_result
		make_resfiles(cpu_final_populations, 
			      cpu_energies, 
			      &myligand_reference,
			      myligand_init, 
			      mypars, 
			      mypars->num_of_energy_evals, 
			      mypars->num_of_generations, 
			      mygrid, 
			      cpu_floatgrids,
			      cpu_ref_ori_angles, 
			      argc, 
			      argv, 
			      0,
			      run_cnt, 
			      &cpu_result_ligands[run_cnt]);
#endif
	} // End of for (run_cnt = 0; run_cnt < mypars->num_of_runs; run_cnt++)

	printf("\n"); 

#if defined(SINGLE_COPY_POP_ENE)

	//copy results from device
	memcopyBufferObjectFromDevice(command_queue_ga, cpu_evals_of_runs, mem_evals_performed, size_evals_of_runs);
	memcopyBufferObjectFromDevice(command_queue_ga, cpu_gens_of_runs, mem_gens_performed, size_evals_of_runs);

	memcopyBufferObjectFromDevice(command_queue_ga, cpu_final_populations, mem_dockpars_conformations_current, size_populations);
	memcopyBufferObjectFromDevice(command_queue_ga, cpu_energies, mem_dockpars_energies_current, size_energies);


	for (uint run_cnt = 0; run_cnt < mypars->num_of_runs; run_cnt++) {

		arrange_result(cpu_final_populations+run_cnt*mypars->pop_size*ACTUAL_GENOTYPE_LENGTH, 
			       cpu_energies+run_cnt*mypars->pop_size, 
			       mypars->pop_size);

		make_resfiles(cpu_final_populations+run_cnt*mypars->pop_size*ACTUAL_GENOTYPE_LENGTH, 
			      cpu_energies+run_cnt*mypars->pop_size, 
			      &myligand_reference,
			      myligand_init, 
			      mypars, 
   			      cpu_evals_of_runs[run_cnt], 
			      cpu_gens_of_runs[run_cnt], /*generation_cnt, */
			      mygrid, 
			      cpu_floatgrids, 
			      cpu_ref_ori_angles+3*run_cnt, 
			      argc, 
			      argv, 
			      0,
			      run_cnt, 
                              &(cpu_result_ligands [run_cnt]));
	} // End of for (run_cnt = 0; run_cnt < mypars->num_of_runs; run_cnt++)

#endif

/*
#if defined (DOCK_DEBUG)
	for (int cnt_pop=0;cnt_pop<size_populations/sizeof(float);cnt_pop++)
		printf("total_num_pop: %u, cpu_final_populations[%u]: %f\n",(uint)(size_populations/sizeof(float)),cnt_pop,cpu_final_populations[cnt_pop]);

	for (int cnt_pop=0;cnt_pop<size_energies/sizeof(float);cnt_pop++)
		printf("total_num_energies: %u, cpu_energies[%u]: %f\n",    (uint)(size_energies/sizeof(float)),cnt_pop,cpu_energies[cnt_pop]);
#endif
*/

	clock_stop_program_before_clustering = clock();

	clusanal_gendlg(cpu_result_ligands, 
			mypars->num_of_runs,
			myligand_init, mypars,
			mygrid,
			argc,
			argv,
			ELAPSEDSECS(clock_stop_docking, clock_start_docking)/mypars->num_of_runs,
			ELAPSEDSECS(clock_stop_program_before_clustering, clock_start_program));

	clock_stop_docking = clock();

  	// Free the resources allocated
  	cleanup();

	return 0;
}