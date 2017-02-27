#include "auxiliary.cl"

// -------------------------------------------------------
//
// -------------------------------------------------------
void gpu_perform_elitist_selection(          int    dockpars_pop_size,	
				    __global float* restrict dockpars_energies_current,
				    __global float* restrict dockpars_energies_next,
				    __global int*   restrict dockpars_evals_of_new_entities,
					     int    dockpars_num_of_genes,
				    __global float* restrict dockpars_conformations_next,
		           __global const float* restrict dockpars_conformations_current,
				    // Altera doesn't allow local var outside kernels
			            // so this local vars are passed from a kernel
			            __local float* best_energies,
			            __local int* best_IDs,
			            __local int* best_ID)

//The GPU device function performs elitist selection, 
//that is, it looks for the best entity in conformations_current and
//energies_current of the run that corresponds to the block ID, 
//and copies it to the place of the first entity in
//conformations_next and energies_next.
{
	int entity_counter;
	int gene_counter;
	float best_energy;

	// Altera doesn't allow local var outside kernels
	// so this local vars are passed from a kernel
	//__local float best_energies[NUM_OF_THREADS_PER_BLOCK];
	//__local int best_IDs[NUM_OF_THREADS_PER_BLOCK];
	//__local int best_ID;

	if (get_local_id(0) < dockpars_pop_size)
	{
		best_energies[get_local_id(0)] = dockpars_energies_current[get_group_id(0)+get_local_id(0)];
		best_IDs[get_local_id(0)] = get_local_id(0);
	}

	for (entity_counter=NUM_OF_THREADS_PER_BLOCK+get_local_id(0); 
	     entity_counter<dockpars_pop_size; 
	     entity_counter+=NUM_OF_THREADS_PER_BLOCK)

	     if (dockpars_energies_current[get_group_id(0)+entity_counter] < best_energies[get_local_id(0)])
	     {
	     	best_energies[get_local_id(0)] = dockpars_energies_current[get_group_id(0)+entity_counter];
	     	best_IDs[get_local_id(0)] = entity_counter;
	     }

        barrier(CLK_LOCAL_MEM_FENCE);

	//this could be implemented with a tree-like structure
	//which may be slightly faster
	if (get_local_id(0) == 0)		
	{
		best_energy = best_energies[0];
		//best_ID = best_IDs[0];
		best_ID[0] = best_IDs[0];

		for (entity_counter=1; 
		     entity_counter<NUM_OF_THREADS_PER_BLOCK; 
		     entity_counter++)

		     if ((best_energies[entity_counter] < best_energy) && (entity_counter < dockpars_pop_size))
		     {
			best_energy = best_energies[entity_counter];
			//best_ID = best_IDs[entity_counter];
			best_ID[0] = best_IDs[entity_counter];
		     }

		//setting energy value of new entity
		dockpars_energies_next[get_group_id(0)] = best_energy;

		//0 evals were performed for entity selected with elitism (since it was copied only)
		dockpars_evals_of_new_entities[get_group_id(0)] = 0;
	}

	//now best_id stores the id of the best entity in the population,
	//copying genotype and energy value to the first entity of new population

	barrier(CLK_LOCAL_MEM_FENCE);

	for (gene_counter=get_local_id(0); 
	     gene_counter<dockpars_num_of_genes; 
	     gene_counter+=NUM_OF_THREADS_PER_BLOCK)
	{
	     //dockpars_conformations_next[GENOTYPE_LENGTH_IN_GLOBMEM*get_group_id(0)+gene_counter] = dockpars_conformations_current[GENOTYPE_LENGTH_IN_GLOBMEM*get_group_id(0)+GENOTYPE_LENGTH_IN_GLOBMEM*best_ID+gene_counter];

	     dockpars_conformations_next[GENOTYPE_LENGTH_IN_GLOBMEM*get_group_id(0)+gene_counter] = dockpars_conformations_current[GENOTYPE_LENGTH_IN_GLOBMEM*get_group_id(0)+GENOTYPE_LENGTH_IN_GLOBMEM*best_ID[0]+gene_counter];
	}

}
