// Output channels IGL_Arbiter -> Conform
channel bool  chan_IGL2Conform_active	    __attribute__((depth(5)));
channel char  chan_IGL2Conform_mode	    __attribute__((depth(5)));
channel float chan_IGL2Conform_genotype     __attribute__((depth(5*ACTUAL_GENOTYPE_LENGTH)));
// --------------------------------------------------------------------------
// --------------------------------------------------------------------------
__kernel __attribute__ ((max_global_work_dim(0)))
void Krnl_IGL_Arbiter(unsigned int DockConst_num_of_genes) {

	__local float genotypeIC  [ACTUAL_GENOTYPE_LENGTH]; 
	__local float genotypeGG  [ACTUAL_GENOTYPE_LENGTH];
	__local float genotype1   [ACTUAL_GENOTYPE_LENGTH];
	__local float genotype2   [ACTUAL_GENOTYPE_LENGTH];
	__local float genotype3   [ACTUAL_GENOTYPE_LENGTH];
	__local float genotype [3][ACTUAL_GENOTYPE_LENGTH];

	bool active = true;

	// Only for debugging
	/*
	uint LS1_eval = 0;
	uint LS2_eval = 0;
	uint LS3_eval = 0;
	*/

while(active) {
	bool Off_valid     = false;
	bool IC_valid	   = false;
	bool GG_valid	   = false;
	bool LS1_end_valid = false;
	bool LS2_end_valid = false;
	bool LS3_end_valid = false;

	bool Off_active;
	bool IC_active;
	bool GG_active;
	bool LS1_end_active;
	bool LS2_end_active;
	bool LS3_end_active;

	while (
		(Off_valid     == false) &&
		(IC_valid      == false) &&  
		(GG_valid      == false) && 
		(LS1_end_valid == false) &&
		(LS2_end_valid == false) &&
		(LS3_end_valid == false) 
	){
		Off_active     = read_channel_nb_altera(chan_IGLArbiter_Off,     &Off_valid);
		IC_active      = read_channel_nb_altera(chan_GA2IGL_IC_active,   &IC_valid);
		GG_active      = read_channel_nb_altera(chan_GA2IGL_GG_active, 	 &GG_valid);
		LS1_end_active = read_channel_nb_altera(chan_LS2Arbiter_LS1_end, &LS1_end_valid);
		LS2_end_active = read_channel_nb_altera(chan_LS2Arbiter_LS2_end, &LS2_end_valid);
		LS3_end_active = read_channel_nb_altera(chan_LS2Arbiter_LS3_end, &LS3_end_valid);	
	}

	uchar bound_tmp = 0;
	
	active = Off_valid ? Off_active : true;

	// get genotype from IC, GG, LS1, LS2, LS3
	if (active == true) {
		#pragma ivdep
		for (uchar i=0; i<DockConst_num_of_genes; i++) {
			// if IC sent geno
			if (IC_valid == true) {
				//printf("%-15s %5s\n",   "IC_valid: ", "reading genotypes");
				genotypeIC [i] = read_channel_altera(chan_IC2Conf_genotype);
			}

			// if GG sent geno
			if (GG_valid == true) {
				///printf("%-15s %5s\n",   "GG_valid: ", "reading genotypes");
				genotypeGG [i] = read_channel_altera(chan_GG2Conf_genotype);
			}	

			// if LS1 sent geno
			if (LS1_end_valid == true) {
				//printf("%-15s %5s\n",   "LS1_valid: ", "reading genotypes");
				genotype1 [i] = read_channel_altera(chan_LS2Conf_LS1_genotype);
			}

			// if LS2 sent geno
			if (LS2_end_valid == true) {
				//printf("%-15s %5s\n",   "LS1_valid: ", "reading genotypes");
				genotype2 [i] = read_channel_altera(chan_LS2Conf_LS2_genotype);
			}

			// if LS3 sent geno
			if (LS3_end_valid == true) {
				//printf("%-15s %5s\n",   "LS1_valid: ", "reading genotypes");
				genotype3 [i] = read_channel_altera(chan_LS2Conf_LS3_genotype);
			}
		} // End of for-loop genes

		if (IC_valid      == true) { bound_tmp++; }
		if (GG_valid      == true) { bound_tmp++; }
		if (LS1_end_valid == true) { bound_tmp++; /*LS1_eval++;*/ }		
		if (LS2_end_valid == true) { bound_tmp++; /*LS2_eval++;*/ }
		if (LS3_end_valid == true) { bound_tmp++; /*LS3_eval++;*/ }

	} // End if (active == true)

	uchar bound = active ? bound_tmp : 1;

	// mode for all LS
	char mode [3];

	// reorder the mode coming from LS
	
	// only a single LS is sending genotypes to Conform
	if ( LS1_end_valid && !LS2_end_valid && !LS3_end_valid) { mode[0] = 0x01; /*printf("only LS1\n");*/ }
	if (!LS1_end_valid &&  LS2_end_valid && !LS3_end_valid) { mode[0] = 0x02; /*printf("only LS2\n");*/ }
	if (!LS1_end_valid && !LS2_end_valid &&  LS3_end_valid) { mode[0] = 0x03; /*printf("only LS3\n");*/ }

	// two LS are sending genotypes to Conform
	if ( LS1_end_valid &&  LS2_end_valid && !LS3_end_valid) { mode[0] = 0x01; mode[1] = 0x02; /*printf("LS1 & LS2\n");*/ }
	if ( LS1_end_valid && !LS2_end_valid &&  LS3_end_valid) { mode[0] = 0x01; mode[1] = 0x03; /*printf("LS1 & LS3\n");*/ }
	if (!LS1_end_valid &&  LS2_end_valid &&  LS3_end_valid) { mode[0] = 0x02; mode[1] = 0x03; /*printf("LS2 & LS3\n");*/ }

	// all three LS are sending genotypes to Conform
	if (LS1_end_valid && LS2_end_valid && LS3_end_valid) {
	   	mode[0] = 0x01;  mode[1] = 0x02; mode[2] = 0x03;
		//printf("LS1 & LS2 & LS3\n");
	}

	// reorder the genotype coming from LS
	#pragma ivdep
	for (uchar i=0; i<DockConst_num_of_genes; i++) {
		// only a single LS is sending genotypes to Conform
		if ( LS1_end_valid && !LS2_end_valid && !LS3_end_valid) { genotype[0][i & 0x3F] = genotype1[i]; }
		if (!LS1_end_valid &&  LS2_end_valid && !LS3_end_valid) { genotype[0][i & 0x3F] = genotype2[i]; }
		if (!LS1_end_valid && !LS2_end_valid &&  LS3_end_valid) { genotype[0][i & 0x3F] = genotype3[i]; }

		// two LS are sending genotypes to Conform
		if ( LS1_end_valid &&  LS2_end_valid && !LS3_end_valid) {
			genotype[0][i & 0x3F] = genotype1[i];
			genotype[1][i & 0x3F] = genotype2[i];
		}

		if ( LS1_end_valid && !LS2_end_valid &&  LS3_end_valid) {
			genotype[0][i & 0x3F] = genotype1[i];
			genotype[1][i & 0x3F] = genotype3[i];
		}

		if (!LS1_end_valid &&  LS2_end_valid &&  LS3_end_valid) {
	   		genotype[0][i & 0x3F] = genotype2[i];
			genotype[1][i & 0x3F] = genotype3[i];
		}

		// all three LS are sending genotypes to Conform
		if (LS1_end_valid && LS2_end_valid && LS3_end_valid) {
			genotype[0][i & 0x3F] = genotype1[i];
			genotype[1][i & 0x3F] = genotype2[i];
			genotype[2][i & 0x3F] = genotype3[i];
		}
	}

	// send data to Krnl_Conform
	for (uchar j=0; j<bound; j++) {
		write_channel_altera(chan_IGL2Conform_active, active);
		mem_fence(CLK_CHANNEL_MEM_FENCE);

		// important: keep the Off_valid option
		// otherwise wrong docking results in some runs
		char mode_tmp = Off_valid? 0x00: IC_valid? 'I': GG_valid? 'G': /*0x01*/ mode[j];
	
		write_channel_altera(chan_IGL2Conform_mode, mode_tmp);
		mem_fence(CLK_CHANNEL_MEM_FENCE);

		for (uchar i=0; i<DockConst_num_of_genes; i++) {

			float gene_tmp = IC_valid? genotypeIC[i]: GG_valid? genotypeGG[i]: /*genotype1[i]*/ genotype[j][i & 0x3F];
		
			if (i > 2) {
				gene_tmp = gene_tmp * DEG_TO_RAD;
			}

			write_channel_altera(chan_IGL2Conform_genotype, gene_tmp);
		}

		#if defined (DEBUG_KRNL_CONF_ARBITER)
		printf("bound: %u, mode: %u\n", bound, mode_tmp);
		#endif
	}

// Only for debugging
/*
	if (LS1_end_active == true) {
		LS1_eval = 0;
	}

	if (LS2_end_active == true) {
		LS2_eval = 0;
	}

	if (LS3_end_active == true) {
		LS3_eval = 0;
	}
*/
} // End of while (active)

}
// --------------------------------------------------------------------------
// --------------------------------------------------------------------------
