// --------------------------------------------------------------------------
// Calculating energies of initial population 
// --------------------------------------------------------------------------

__kernel __attribute__ ((max_global_work_dim(0)))
void Krnl_IC(__global       float*           restrict GlobPopulationCurrent,
	     //__global const Dockparameters*  restrict DockConst
	     __constant const Dockparameters*  restrict DockConst
	     //         const unsigned int              DockConst_pop_size
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
	//for (ushort pop_cnt = 0; pop_cnt < DockConst_pop_size; pop_cnt++) {		
		
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
		
		#if defined (DEBUG_KRNL_IC)
		printf("pop_cnt (Krnl_IC): %u\n", pop_cnt); 		
		#endif

	} // End of for-loop pop_cnt		


	ack = read_channel_altera(chan_Store2IC_ack);	

	eval_cnt = DockConst->pop_size;
	//eval_cnt = DockConst_pop_size; 	
	
	#if defined (DEBUG_KRNL_IC)
	printf("eval_cnt (Krnl_IC): %u\n", eval_cnt); 	
	#endif

	write_channel_altera(chan_IC2GA_eval_cnt, eval_cnt);

	#if defined (DEBUG_ACTIVE_KERNEL)
	printf("	%-20s: %s\n", "Krnl_IC", "disabled");
	#endif
}
