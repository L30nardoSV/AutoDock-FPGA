channel bool  chan_IGL_active;
channel char  chan_IGL_mode;
channel float chan_IGL_genotype __attribute__((depth(ACTUAL_GENOTYPE_LENGTH)));

// --------------------------------------------------------------------------
// --------------------------------------------------------------------------
__kernel __attribute__ ((max_global_work_dim(0)))
void Krnl_Conf_Arbiter(unsigned int DockConst_num_of_genes) {

	__local float genotype[ACTUAL_GENOTYPE_LENGTH];

	bool active = true;

while(active) {

	//printf("BEFORE In Conf_Arbiter CHANNEL\n");
	// --------------------------------------------------------------
	// Wait for genotypes in channel
	// --------------------------------------------------------------
	bool IC_valid     = false;
	bool GG_valid     = false;
	bool LS_valid     = false;
	bool Off_valid    = false;

	float IC_active;
	float GG_active;
	float LS_active;
	bool Off_active;

	uchar pipe_cnt = 0;

	while (
	       (Off_valid == false) && (pipe_cnt < DockConst_num_of_genes) 
	) {
		IC_active  = read_channel_nb_altera(chan_IC2Conf_genotype, &IC_valid);
		GG_active  = read_channel_nb_altera(chan_GG2Conf_genotype, &GG_valid);
		LS_active  = read_channel_nb_altera(chan_LS2Conf_genotype, &LS_valid);
		Off_active = read_channel_nb_altera(chan_Off2Conf_active,  &Off_valid);

		if (IC_valid || GG_valid || LS_valid) {
			genotype[pipe_cnt] = (IC_valid)  ?  IC_active :
	       			    	     (GG_valid)  ?  GG_active : 
				     	     (LS_valid)  ?  LS_active :
                                     	     (Off_valid) ?  0.0f:
				     	     0.0f; // last case should never occur, otherwise above while would be still running
			
			if (pipe_cnt > 2) {
				genotype [pipe_cnt] = genotype [pipe_cnt]*DEG_TO_RAD;
			}
			
			pipe_cnt++;
		}	
	}

	char mode;

	/*
	active = (IC_valid)     ? true :
		 (GG_valid)     ? true :
		 (LS_valid)     ? true :
		 (Off_valid)    ? Off_active :
		 false; // last case should never occur, otherwise above while would be still running
	*/
	active = (Off_valid) ? Off_active : true; 

	/*
	mode = (IC_valid)  ? 0x01 :
	       (GG_valid)  ? 0x02 :
	       (LS_valid)  ? 0x03 :
	       (Off_valid) ? 0x05 :
	       0x05; // last case should never occur, otherwise above while would be still running
	*/
	mode = (Off_valid) ? 0x05 : (IC_valid) ? 0x01 : (GG_valid) ? 0x02 : 0x03 ; // last case is LS (0x03)
	       
	// --------------------------------------------------------------
	//printf("AFTER In Conf_Arbiter CHANNEL\n");


	// communicate to Krnl_Conform
	for (uchar i=0; i<DockConst_num_of_genes; i++) {
		if (i == 0) {
			write_channel_altera(chan_IGL_active, active);
			mem_fence(CLK_CHANNEL_MEM_FENCE);

			write_channel_altera(chan_IGL_mode,   mode);
			mem_fence(CLK_CHANNEL_MEM_FENCE);
		}

		write_channel_altera(chan_IGL_genotype, genotype[i]);
	}

	

} // End of while (active)

}
// --------------------------------------------------------------------------
// --------------------------------------------------------------------------
