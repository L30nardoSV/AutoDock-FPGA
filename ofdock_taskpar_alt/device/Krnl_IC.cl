// --------------------------------------------------------------------------
// Calculating energies of initial population 
// --------------------------------------------------------------------------

__kernel __attribute__ ((max_global_work_dim(0)))
void Krnl_IC(//__global const float*           restrict GlobFgrids,
	     __global       float*           restrict GlobPopulationCurrent,
	     //__global       float*           restrict GlobEnergyCurrent,
	     //__global       float*           restrict GlobPopulationNext,
	     //__global       float*           restrict GlobEnergyNext,
             //__global       unsigned int*    restrict GlobPRNG,
	     //__global const kernelconstant*  restrict KerConst,
	     __global const Dockparameters*  restrict DockConst
	     //,
	     //__global       unsigned int*    restrict GlobEvals_performed,
	     //__global       unsigned int*    restrict GlobGenerations_performed
)
{	
	uint eval_cnt = 0; 	
	char active = 1; 	
	char mode   = 1; 	
	char ack    = 0;

	__local float genotype [ACTUAL_GENOTYPE_LENGTH];

	active = read_channel_altera(chan_GA2IC_active);

	//for (uint pop_cnt = 0; pop_cnt < DockConst->pop_size; pop_cnt++) {
	for (ushort pop_cnt = 0; pop_cnt < DockConst->pop_size; pop_cnt++) {		
		
		//for (uint pipe_cnt=0; pipe_cnt<ACTUAL_GENOTYPE_LENGTH; pipe_cnt++) {
		for (uchar pipe_cnt=0; pipe_cnt<ACTUAL_GENOTYPE_LENGTH; pipe_cnt++) {
			genotype[pipe_cnt] = GlobPopulationCurrent[pop_cnt*ACTUAL_GENOTYPE_LENGTH + pipe_cnt];			
		} 	

		write_channel_altera(chan_IC2Conf_active, active);
		mem_fence(CLK_CHANNEL_MEM_FENCE);
		write_channel_altera(chan_IC2Conf_mode,   mode);
		mem_fence(CLK_CHANNEL_MEM_FENCE);
		write_channel_altera(chan_IC2Conf_cnt,    pop_cnt);
		mem_fence(CLK_CHANNEL_MEM_FENCE);

		//for (uint pipe_cnt=0; pipe_cnt<ACTUAL_GENOTYPE_LENGTH; pipe_cnt++) {
		for (uchar pipe_cnt=0; pipe_cnt<ACTUAL_GENOTYPE_LENGTH; pipe_cnt++) {
			write_channel_altera(chan_IC2Conf_genotype, genotype[pipe_cnt]);
		}

		//printf("pop_cnt (INC): %u\n", pop_cnt); 		
	} // End of for-loop pop_cnt		


	ack = read_channel_altera(chan_Store2IC_ack);	

	eval_cnt = DockConst->pop_size; 		
	
	//printf("eval_cnt (INC): %u\n", eval_cnt); 	

	write_channel_altera(chan_IC2GA_eval_cnt, eval_cnt);

	#if defined (DEBUG_ACTIVE_KERNEL)
	printf("	%-20s: %s\n", "Krnl_IC", "disabled");
	#endif
}
