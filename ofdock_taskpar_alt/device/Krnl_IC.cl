// --------------------------------------------------------------------------
// Calculating energies of initial population 
// --------------------------------------------------------------------------

__kernel __attribute__ ((max_global_work_dim(0)))
void Krnl_IC(__global   const float*           restrict GlobPopulationCurrent,
	     __constant       Dockparameters*  restrict DockConst
)
{		
	      char active   = 1; 	
	const char mode     = 1; 	
	      char ack      = 0;

	__local float genotype [ACTUAL_GENOTYPE_LENGTH];

	active = read_channel_altera(chan_GA2IC_active);

	for (ushort pop_cnt = 0; pop_cnt < DockConst->pop_size; pop_cnt++) {

		///*__local*/ float genotype [ACTUAL_GENOTYPE_LENGTH];
		
		for (uchar pipe_cnt=0; pipe_cnt<ACTUAL_GENOTYPE_LENGTH; pipe_cnt++) {
			genotype[pipe_cnt] = GlobPopulationCurrent[pop_cnt*ACTUAL_GENOTYPE_LENGTH + pipe_cnt];			
		} 	

		write_channel_altera(chan_IC2Conf_active, active);
		mem_fence(CLK_CHANNEL_MEM_FENCE);
		write_channel_altera(chan_IC2Conf_mode,   mode);
		mem_fence(CLK_CHANNEL_MEM_FENCE);
		write_channel_altera(chan_IC2Conf_cnt,    pop_cnt);
		mem_fence(CLK_CHANNEL_MEM_FENCE);

		for (uchar pipe_cnt=0; pipe_cnt<ACTUAL_GENOTYPE_LENGTH; pipe_cnt++) {
			write_channel_altera(chan_IC2Conf_genotype, genotype[pipe_cnt]);
		}
		
		#if defined (DEBUG_KRNL_IC)
		printf("pop_cnt (Krnl_IC): %u\n", pop_cnt); 		
		#endif


	} // End of for-loop pop_cnt		

	ack = read_channel_altera(chan_Store2IC_ack);		
	
	#if defined (DEBUG_KRNL_IC)
	printf("eval_cnt (Krnl_IC): %u\n", DockConst->pop_size); 	
	#endif

	write_channel_altera(chan_IC2GA_eval_cnt, DockConst->pop_size);

	#if defined (DEBUG_ACTIVE_KERNEL)
	printf("	%-20s: %s\n", "Krnl_IC", "disabled");
	#endif
}
