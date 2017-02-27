//#include "calc_energy.cl"

__kernel 
void __attribute__ ((reqd_work_group_size(NUM_OF_THREADS_PER_BLOCK,1,1)))
sum_evals(unsigned long pop_size,
          /*unsigned long num_of_runs,*/
 __global int* restrict dockpars_evals_of_new_entities,
 __global int* restrict evals_of_runs)

//The GPU global function sums the evaluation counter states
//which are stored in evals_of_new_entities array foreach entity,
//calculates the sums for each run and stores it in evals_of_runs array.
//The number of blocks which should be started equals to num_of_runs,
//since each block performs the summation for one run.
{
    int entity_counter;
    int sum_evals;
    __local int partsum_evals[NUM_OF_THREADS_PER_BLOCK];

    partsum_evals[get_local_id(0)] = 0;

#if defined (ASYNC_COPY)
    __local int local_evals_of_new_entities[MAX_POPSIZE];	// defined in defines.h
	
    async_work_group_copy(local_evals_of_new_entities,
                          dockpars_evals_of_new_entities+get_group_id(0)*pop_size,
                          pop_size,0);

    for (entity_counter=get_local_id(0);
	 entity_counter<pop_size;
	 entity_counter+=NUM_OF_THREADS_PER_BLOCK)
         partsum_evals[get_local_id(0)] += local_evals_of_new_entities[entity_counter];
#else
    for (entity_counter=get_local_id(0);
	 entity_counter<pop_size;
	 entity_counter+=NUM_OF_THREADS_PER_BLOCK)
         partsum_evals[get_local_id(0)] += dockpars_evals_of_new_entities[get_group_id(0)*pop_size+entity_counter];
#endif

    barrier(CLK_LOCAL_MEM_FENCE);

    if (get_local_id(0) == 0)
    {
    	sum_evals = partsum_evals[0];
        for (entity_counter=1; 
	     entity_counter<NUM_OF_THREADS_PER_BLOCK;
	     entity_counter++)
        {
		sum_evals += partsum_evals[entity_counter];
        }

        evals_of_runs[get_group_id(0)] += sum_evals;

	// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	
	//for (entity_counter=0;entity_counter<pop_size;entity_counter++)
	//	printf("dockpars_evals_of_new_entities[%u]: %i\n",entity_counter,dockpars_evals_of_new_entities[get_group_id(0)*pop_size+entity_counter]);

	//printf("lid: %zu, groupid: %zu, #groups: %zu, evals_of_runs[%zu]: %i\n",
	//	get_local_id(0),get_group_id(0),get_num_groups(0),
	//	get_group_id(0),evals_of_runs[get_group_id(0)]);	
	
	// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    }
}
