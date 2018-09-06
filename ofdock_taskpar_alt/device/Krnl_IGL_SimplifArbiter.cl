// --------------------------------------------------------------------------
// IGL_Arbiter keeps checking whether any kernel (GA or any LSs) 
// is sending genotypes to Conform, as well as whether 
// GA sent the "turn-off" signal.
// Its name references the logic that is producing genotypes: 
// IC, GG and any LS.
// IC and GG are two logic blocks inside the GA kernel,
// while any LS logic is a kernel itself.

// It uses the valid signals to determine the "mode" value,
// used as a mux selector signal (of genotype logic-producers) in Conform.

// Initially genotypes passed through this kernel getting reordered and 
// synchronized with "mode".
// This has been later optimized, so now genotypes go directly 
// from producer logic/kernel (IC, GG, LSs) to the consumer (Conform) kernel.
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
		bool LS6_end_valid = false;
		bool LS7_end_valid = false;
		bool LS8_end_valid = false;
		bool LS9_end_valid = false;

		bool Off_active;
		bool IC_active;
		bool GG_active;
		bool LS1_end_active;
		bool LS2_end_active;
		bool LS3_end_active;
		bool LS4_end_active;
		bool LS5_end_active;
		bool LS6_end_active;
		bool LS7_end_active;
		bool LS8_end_active;
		bool LS9_end_active;

		while (
			(Off_valid     == false) &&
			(IC_valid      == false) &&  
			(GG_valid      == false) && 
			(LS1_end_valid == false) &&
			(LS2_end_valid == false) &&
			(LS3_end_valid == false) &&
			(LS4_end_valid == false) &&
			(LS5_end_valid == false) &&
			(LS6_end_valid == false) &&
			(LS7_end_valid == false) &&
			(LS8_end_valid == false) &&
			(LS9_end_valid == false) 
		){
			Off_active     = read_channel_nb_intel(chan_IGLArbiter_Off,    &Off_valid);
			IC_active      = read_channel_nb_intel(chan_GA2IGL_IC_active,  &IC_valid);
			GG_active      = read_channel_nb_intel(chan_GA2IGL_GG_active,  &GG_valid);
			LS1_end_active = read_channel_nb_intel(chan_LS2Arbiter_end[0], &LS1_end_valid);
			LS2_end_active = read_channel_nb_intel(chan_LS2Arbiter_end[1], &LS2_end_valid);
			LS3_end_active = read_channel_nb_intel(chan_LS2Arbiter_end[2], &LS3_end_valid);
			LS4_end_active = read_channel_nb_intel(chan_LS2Arbiter_end[3], &LS4_end_valid);
			LS5_end_active = read_channel_nb_intel(chan_LS2Arbiter_end[4], &LS5_end_valid);
			LS6_end_active = read_channel_nb_intel(chan_LS2Arbiter_end[5], &LS6_end_valid);
			LS7_end_active = read_channel_nb_intel(chan_LS2Arbiter_end[6], &LS7_end_valid);
			LS8_end_active = read_channel_nb_intel(chan_LS2Arbiter_end[7], &LS8_end_valid);
			LS9_end_active = read_channel_nb_intel(chan_LS2Arbiter_end[8], &LS9_end_valid);
		}

		active = Off_valid ? 0x00 : 0x01;

		bool mode_LS_bool [9];

		#pragma unroll
		for(uchar i=0; i<9; i++) {
			mode_LS_bool [i] = false;
		}

		// Determine "mode_LS_bool" value
		// This considers all possible cases as all LS could be 
		// potentially producing genotypes simultaneously.
		if (active == 0x01) {
			if ((IC_valid == false) && (GG_valid == false)) {
				if (LS1_end_valid == true) {mode_LS_bool [0] = true; /*printf("LS1 valid!\n");*/}
				if (LS2_end_valid == true) {mode_LS_bool [1] = true; /*printf("LS2 valid!\n");*/}
				if (LS3_end_valid == true) {mode_LS_bool [2] = true; /*printf("LS3 valid!\n");*/}
				if (LS4_end_valid == true) {mode_LS_bool [3] = true; /*printf("LS4 valid!\n");*/}
				if (LS5_end_valid == true) {mode_LS_bool [4] = true; /*printf("LS5 valid!\n");*/}
				if (LS6_end_valid == true) {mode_LS_bool [5] = true; /*printf("LS6 valid!\n");*/}
				if (LS7_end_valid == true) {mode_LS_bool [6] = true; /*printf("LS7 valid!\n");*/}
				if (LS8_end_valid == true) {mode_LS_bool [7] = true; /*printf("LS8 valid!\n");*/}
				if (LS9_end_valid == true) {mode_LS_bool [8] = true; /*printf("LS9 valid!\n");*/}
			}
		} // End if (active == 0x01)

		// Send "mode" to Conform
		for (uchar j=0; j<9; j++) {
			bool enable_write_channel = false;
			char mode_tmp;		

			const char mode_Off  = 0x00;
			const char mode_IC   = 'I';
			const char mode_GG   = 'G';
			const char mode_LS [9]  = {0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09};

			if (Off_valid == true) {
				enable_write_channel = (j==0)? true:false;
				mode_tmp = mode_Off;
			}
			else if (IC_valid == true) {
				enable_write_channel = (j==0)? true:false;
				mode_tmp = mode_IC;
			}
			else if (GG_valid == true) {
				enable_write_channel = (j==0)? true:false;
				mode_tmp = mode_GG;
			}
			else{
				if (mode_LS_bool[j] ==  true) {
					enable_write_channel = true;
					mode_tmp = mode_LS [j];
				}
			}

			if (enable_write_channel == true) {
				write_channel_intel(chan_IGL2Conform_actmode, mode_tmp);
			}
		} // End for (uchar j=0; j<9; j++)

		//printf("IGL Simplif sent!\n");
	} // End of while (active)
}
// --------------------------------------------------------------------------
// --------------------------------------------------------------------------



