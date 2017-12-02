//channel bool  chan_Conf2LS_LS2_token;
//channel bool  chan_Conf2LS_LS3_token;

channel bool  chan_LS23_active;
channel char  chan_LS23_mode;
channel float chan_LS23_genotype     __attribute__((depth(ACTUAL_GENOTYPE_LENGTH)));

channel bool chan_LS2Arbiter_LS2_end;
channel bool chan_LS2Arbiter_LS3_end;

// --------------------------------------------------------------------------
// --------------------------------------------------------------------------
__kernel __attribute__ ((max_global_work_dim(0)))
void Krnl_Conf_Arbiter2(unsigned int DockConst_num_of_genes) {

	__local float genotype2 [ACTUAL_GENOTYPE_LENGTH];
	__local float genotype3 [ACTUAL_GENOTYPE_LENGTH];
	__local float genotype_if_bound_1 [ACTUAL_GENOTYPE_LENGTH];
	__local float genotype [2][ACTUAL_GENOTYPE_LENGTH];

	bool active = true;
	bool LS2_last_geno = false;
	bool LS3_last_geno = false;
	bool bothLS_last_geno = false;

	uint LS2_eval = 0;
	uint LS3_eval = 0;

while(active) {
	bool Off_valid     = false;
	bool LS2_end_valid = false;
	bool LS3_end_valid = false;
	bool Off_active;
	bool LS2_end_active;
	bool LS3_end_active;

	while (
		(Off_valid == false) && (LS2_end_valid == false) && (LS3_end_valid == false)
	){
		Off_active     = read_channel_nb_altera(chan_ConfArbiter_Off,    &Off_valid);
		LS2_end_active = read_channel_nb_altera(chan_LS2Arbiter_LS2_end, &LS2_end_valid);
		LS3_end_active = read_channel_nb_altera(chan_LS2Arbiter_LS3_end, &LS3_end_valid);

		/*
		printf("%-15s %5s",   "Off_valid: ",     Off_valid?"true":"false");
		printf("%-15s %5s ",  "LS2_end_valid: ", LS2_end_valid?"true":"false");
		printf("%-15s %5s\n", "LS3_end_valid: ", LS3_end_valid?"true":"false");
		*/
	}
	
	/*
	if ((LS2_end_valid == true) &&  (LS3_end_valid == true)){
		printf("BOTH LS WANT TO PROCESS DATA!!!!!!\n");
	}
	*/

	uchar bound_tmp = 0;

	/*
	active = Off_valid?Off_active:
		 LS2_end_valid?true:
		 LS3_end_valid?true:
		 false; // last case should never occur, otherwise above while would be still running
	*/
	active = Off_valid ? Off_active : true;

	// get genos from LS2 and LS3
/*
	if (active == true) {

		// if LS2 sent geno
		if (LS2_end_valid == true) {
			bound_tmp++;
			for (uchar i=0; i<DockConst_num_of_genes; i++) {
				genotype2 [i] = read_channel_altera(chan_LS2Conf_LS2_genotype);
			}
			LS2_eval++;

			#if defined (DEBUG_KRNL_CONF_ARBITER)
			printf("LS2 genotype: %u\n", LS2_eval);
			#endif
		}

		// if LS3 sent geno
		if (LS3_end_valid == true) {
			bound_tmp++;
			for (uchar i=0; i<DockConst_num_of_genes; i++) {
				genotype3 [i] = read_channel_altera(chan_LS2Conf_LS3_genotype);
			}
			LS3_eval++;

			#if defined (DEBUG_KRNL_CONF_ARBITER)
			printf("LS3 genotype: %u\n", LS3_eval);
			#endif
		}
	} // End if (active == true)
*/



	if (active == true) {
		for (uchar i=0; i<DockConst_num_of_genes; i++) {
			// if LS2 sent geno
			if (LS2_end_valid == true) {
				genotype2 [i] = read_channel_altera(chan_LS2Conf_LS2_genotype);
			}

			// if LS3 sent geno
			if (LS3_end_valid == true) {
				genotype3 [i] = read_channel_altera(chan_LS2Conf_LS3_genotype);
			}
		}
		
		// if LS2 sent geno
		if (LS2_end_valid == true) {
			bound_tmp++;
			LS2_eval++;
		}

		// if LS3 sent geno
		if (LS3_end_valid == true) {
			bound_tmp++;
			LS3_eval++;
		}
	} // End if (active == true)














	
	uchar bound = (active)?bound_tmp:1;

	// mode for both LS
	char mode [2];
	mode [0] = (LS2_end_valid)? 0x02: 0x00; 
	mode [1] = (LS3_end_valid)? 0x03: 0x00;
	char mode_if_bound_1 = LS2_end_valid?0x02:(LS3_end_valid?0x03:0x00);

	// genotype for both LS
	#pragma ivdep
	for (uchar i=0; i<DockConst_num_of_genes; i++) {
		genotype[0][i & 0x3F] = (LS2_end_valid)?genotype2[i]:0.0f;
		genotype[1][i & 0x3F] = (LS3_end_valid)?genotype3[i]:0.0f;
		genotype_if_bound_1[i] = LS2_end_valid?genotype2[i]:(LS3_end_valid?genotype3[i]:0.0f);
	}

	// Send data to Krnl_Conform2
	for (uchar j=0; j<bound; j++) {
		write_channel_altera(chan_LS23_active, active);
		mem_fence(CLK_CHANNEL_MEM_FENCE);

		write_channel_altera(chan_LS23_mode,(bound==1)?mode_if_bound_1:mode[j]);
		mem_fence(CLK_CHANNEL_MEM_FENCE);

		/*
		for (uchar i=0; i<DockConst_num_of_genes; i++) {
			write_channel_altera(chan_LS23_genotype, (bound==1)?genotype_if_bound_1[i]:genotype[j][i & 0x3F]);
		}
		*/

		for (uchar i=0; i<DockConst_num_of_genes; i++) {
			float tmp;
			
			if (i > 2) {
				tmp = ((bound==1)?genotype_if_bound_1[i]:genotype[j][i & 0x3F]) * DEG_TO_RAD;
			}

			write_channel_altera(chan_LS23_genotype, tmp);
		}

		#if defined (DEBUG_KRNL_CONF_ARBITER)
		printf("bound: %u, mode: %u\n", bound, (bound==1)?mode_if_bound_1:mode[j]);
		#endif
	}

	if (LS2_end_active == true) {
		LS2_eval = 0;
	}

	if (LS3_end_active == true) {
		LS3_eval = 0;
	}

} // End of while (active)

}
// --------------------------------------------------------------------------
// --------------------------------------------------------------------------
