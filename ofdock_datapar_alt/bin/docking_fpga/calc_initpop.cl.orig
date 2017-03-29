#include "calc_energy.cl"

__kernel 
void __attribute__ ((reqd_work_group_size(NUM_OF_THREADS_PER_BLOCK,1,1)))
calc_initpop(      char   dockpars_num_of_atoms,
	           char   dockpars_num_of_atypes,
	           int    dockpars_num_of_intraE_contributors,
	           char   dockpars_gridsize_x,
	           char   dockpars_gridsize_y,
	           char   dockpars_gridsize_z,
	           float  dockpars_grid_spacing,
    __global const float* restrict dockpars_fgrids, // cannot be allocated in __constant (too large)
	           int    dockpars_rotbondlist_length,
  	           float  dockpars_coeff_elec,
	           float  dockpars_coeff_desolv,
    __global const float* restrict dockpars_conformations_current,
    __global       float* restrict dockpars_energies_current,
    __global       int*   restrict dockpars_evals_of_new_entities,
	           int    dockpars_pop_size,
	           float  dockpars_qasp,


	__global kernelconstant* restrict KerConst
/*
        __constant float* restrict atom_charges_const,
        __constant char*  restrict atom_types_const,
        __constant char*  restrict intraE_contributors_const,
        __constant float* restrict VWpars_AC_const,
        __constant float* restrict VWpars_BD_const,
        __constant float* restrict dspars_S_const,
        __constant float* restrict dspars_V_const,
        __constant int*   restrict rotlist_const,
        __constant float* restrict ref_coords_x_const,
        __constant float* restrict ref_coords_y_const,
        __constant float* restrict ref_coords_z_const,
        __constant float* restrict rotbonds_moving_vectors_const,
        __constant float* restrict rotbonds_unit_vectors_const,
        __constant float* restrict ref_orientation_quats_const
*/

)
{

	__local float  genotype[GENOTYPE_LENGTH_IN_GLOBMEM]; 
	__local float  energy;  
      	__local int    run_id;

	// Altera doesn't allow local var outside kernels
	// so this local vars are passed from a kernel
	__local float calc_coords_x[MAX_NUM_OF_ATOMS];
	__local float calc_coords_y[MAX_NUM_OF_ATOMS];
	__local float calc_coords_z[MAX_NUM_OF_ATOMS];
	__local float partial_energies[NUM_OF_THREADS_PER_BLOCK];

	event_t ev = async_work_group_copy(genotype,
			      dockpars_conformations_current + GENOTYPE_LENGTH_IN_GLOBMEM*get_group_id(0),
			      GENOTYPE_LENGTH_IN_GLOBMEM, 0);

	wait_group_events(1,&ev);

    	//determining run ID
    	if (get_local_id(0) == 0)
		run_id = get_group_id(0) / dockpars_pop_size;


	// =============================================================
	// =============================================================
	// =============================================================
    	// WARNING: only energy of threadIdx.x=0 will be valid
	calc_energy(    dockpars_rotbondlist_length,
			dockpars_num_of_atoms,
			dockpars_gridsize_x,
			dockpars_gridsize_y,
                    	dockpars_gridsize_z,
			dockpars_fgrids,
			dockpars_num_of_atypes,
			dockpars_num_of_intraE_contributors,
			dockpars_grid_spacing,
			dockpars_coeff_elec,
                    	dockpars_qasp,
			dockpars_coeff_desolv,
			genotype,
			&energy,
			&run_id,
   			// Altera doesn't allow local var outside kernels
			// so this local vars are passed from a kernel
	                calc_coords_x,
	                calc_coords_y,
	                calc_coords_z,
	                partial_energies,

			KerConst

/*
                    	atom_charges_const,
                    	atom_types_const,
                    	intraE_contributors_const,
                    	VWpars_AC_const,
                    	VWpars_BD_const,
                   	dspars_S_const,
                    	dspars_V_const,
                    	rotlist_const,
                    	ref_coords_x_const,
                    	ref_coords_y_const,
                    	ref_coords_z_const,
                    	rotbonds_moving_vectors_const,
                    	rotbonds_unit_vectors_const,
                    	ref_orientation_quats_const
*/

);
	// =============================================================
	// =============================================================
	// =============================================================



        if (get_local_id(0) == 0) {
        	dockpars_energies_current[get_group_id(0)] = energy;
                dockpars_evals_of_new_entities[get_group_id(0)] = 1;

		// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
		
		//printf("%u,lid: %zu, groupid: %zu, #groups: %zu, dockpars_energies_current[%zu]: %f, dockpars_evals_of_new_entities[%zu]: %i\n",
		//	GENOTYPE_LENGTH_IN_GLOBMEM,			
		//	get_local_id(0),get_group_id(0),get_num_groups(0),
		//	get_group_id(0),dockpars_energies_current[get_group_id(0)],
		//	get_group_id(0),dockpars_evals_of_new_entities[get_group_id(0)]);	
		
		// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      }

}


#include "sum_evals.cl"
#include "gen_and_eval_newpops.cl"
#include "perform_ls.cl"

