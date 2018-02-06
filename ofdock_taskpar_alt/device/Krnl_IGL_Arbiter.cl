// --------------------------------------------------------------------------
// --------------------------------------------------------------------------
__kernel __attribute__ ((max_global_work_dim(0)))
void Krnl_IGL_Arbiter(/*unsigned char DockConst_num_of_genes*/) {

	char active = 0x01;

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
	bool LS4_end_valid = false;
	bool LS5_end_valid = false;

	bool Off_active;
	bool IC_active;
	bool GG_active;
	bool LS1_end_active;
	bool LS2_end_active;
	bool LS3_end_active;
	bool LS4_end_active;
	bool LS5_end_active;

	while (
		(Off_valid     == false) &&
		(IC_valid      == false) &&  
		(GG_valid      == false) && 
		(LS1_end_valid == false) &&
		(LS2_end_valid == false) &&
		(LS3_end_valid == false) &&
		(LS4_end_valid == false) &&
		(LS5_end_valid == false) 
	){
		Off_active     = read_channel_nb_altera(chan_IGLArbiter_Off,     &Off_valid);
		IC_active      = read_channel_nb_altera(chan_GA2IGL_IC_active,   &IC_valid);
		GG_active      = read_channel_nb_altera(chan_GA2IGL_GG_active, 	 &GG_valid);
		LS1_end_active = read_channel_nb_altera(chan_LS2Arbiter_LS1_end, &LS1_end_valid);
		LS2_end_active = read_channel_nb_altera(chan_LS2Arbiter_LS2_end, &LS2_end_valid);
		LS3_end_active = read_channel_nb_altera(chan_LS2Arbiter_LS3_end, &LS3_end_valid);
		LS4_end_active = read_channel_nb_altera(chan_LS2Arbiter_LS4_end, &LS4_end_valid);
		LS5_end_active = read_channel_nb_altera(chan_LS2Arbiter_LS5_end, &LS5_end_valid);
	}

	uchar bound_tmp = 0;
	active = Off_valid ? 0x00 : 0x01;
	char mode [5];	// mode for all LS

/*
	float genotypeICGG  [ACTUAL_GENOTYPE_LENGTH]; 
	float genotype   [3][ACTUAL_GENOTYPE_LENGTH];
*/

	// get genotype from IC, GG, LS1, LS2, LS3
	if (active == 0x01) {

		if (IC_valid == true) {
			bound_tmp++;
		}
		else if (GG_valid == true) {
			bound_tmp++;
		}	
		else{
			// Reorder the mode & genotype coming from LS
			if (LS1_end_valid) {mode[0] = 0x01; bound_tmp++;
				
				if (LS2_end_valid) {mode[1] = 0x02; bound_tmp++;

					if (LS3_end_valid) {mode[2] = 0x03; bound_tmp++;
						if (LS4_end_valid) {mode[3] = 0x04; bound_tmp++;
							if (LS5_end_valid) {mode[4] = 0x05; bound_tmp++;}
						}
						else {
							if (LS5_end_valid) {mode[3] = 0x05; bound_tmp++;}
						}
					}
					else { // LS1: yes, LS2: yes, LS3: no
						if (LS4_end_valid) {mode[2] = 0x04; bound_tmp++;
							if (LS5_end_valid) {mode[3] = 0x05; bound_tmp++;}
						}
						else {
							if (LS5_end_valid) {mode[2] = 0x05; bound_tmp++;}
						}
					}
				}
				else { // LS1: yes, LS2: no
					if (LS3_end_valid) {mode[1] = 0x03; bound_tmp++;
						if (LS4_end_valid) {mode[2] = 0x04; bound_tmp++;
							if (LS5_end_valid) {mode[3] = 0x05; bound_tmp++;}
						}
						else {
							if (LS5_end_valid) {mode[2] = 0x05; bound_tmp++;}
						}
					} 
					else { // LS1: yes, LS2: no, LS3: no
						if (LS4_end_valid) {mode[1] = 0x04; bound_tmp++;
							if (LS5_end_valid) {mode[2] = 0x05; bound_tmp++;}
						}
						else {
							if (LS5_end_valid) {mode[1] = 0x05; bound_tmp++;}
						}

					}
				}
			}
			else { // LS1: no
				if (LS2_end_valid) {mode[0] = 0x02; bound_tmp++;
					if (LS3_end_valid) {mode[1] = 0x03; bound_tmp++;
						if (LS4_end_valid) {mode[2] = 0x04; bound_tmp++;
							if (LS5_end_valid) {mode[3] = 0x05; bound_tmp++;}
						}
						else {
							if (LS5_end_valid) {mode[2] = 0x05; bound_tmp++;}
						}
					}
					else { // LS1: no, LS2: yes, LS3: no
						if (LS4_end_valid) {mode[1] = 0x04; bound_tmp++;
							if (LS5_end_valid) {mode[2] = 0x05; bound_tmp++;}
						}
						else {
							if (LS5_end_valid) {mode[1] = 0x05; bound_tmp++;}
						}
					}
				}
				else { // LS1: no, LS2: no
					if (LS3_end_valid) {mode[0] = 0x03; bound_tmp++;
						if (LS4_end_valid) {mode[1] = 0x04; bound_tmp++;
							if (LS5_end_valid) {mode[2] = 0x05; bound_tmp++;}
						}
						else {
							if (LS5_end_valid) {mode[1] = 0x05; bound_tmp++;}
						}
					}
					else { // LS1: no, LS2: no, LS3: no
						if (LS4_end_valid) {mode[0] = 0x04; bound_tmp++;
							if (LS5_end_valid) {mode[1] = 0x05; bound_tmp++;}
						}
						else {
							if (LS5_end_valid) {mode[0] = 0x05; bound_tmp++;}
						}

					}
				}
			}			
		}
	} // End if (active == true)

	uchar bound = active ? bound_tmp : 1;

/*
	if ((LS1_end_valid || LS2_end_valid || LS3_end_valid)) {
		printf("bound_tmp: %-5u, LS1: %-5s, LS2: %-5s, LS3: %-5s\n", bound_tmp, LS1_end_valid?"yes":"no", LS2_end_valid?"yes":"no", LS3_end_valid?"yes":"no");
	}
*/

	// send data to Krnl_Conform
	for (uchar j=0; j<bound; j++) {

		char mode_tmp = Off_valid? 0x00: IC_valid? 'I': GG_valid? 'G': mode[j];

//printf("IGL: %u\n", mode_tmp);

		char2 actmode = {active, mode_tmp};

		write_channel_altera(chan_IGL2Conform_actmode, actmode);
/*
		mem_fence(CLK_CHANNEL_MEM_FENCE);
*/

/*
		for (uchar i=0; i<DockConst_num_of_genes; i++) {

			float gene_tmp = (IC_valid || GG_valid)? genotypeICGG[i]: genotype[j][i & MASK_GENOTYPE];
		
			if (i > 2) {
				gene_tmp = gene_tmp * DEG_TO_RAD;
			}

			write_channel_altera(chan_IGL2Conform_genotype, gene_tmp);
		}
*/
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


