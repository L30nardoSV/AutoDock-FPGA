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
/*
__kernel __attribute__ ((max_global_work_dim(0)))
*/
__kernel __attribute__ ((reqd_work_group_size(1,1,1)))
void Krnl_IGL_Arbiter(/*unsigned char DockConst_num_of_genes*/
#if !defined(SW_EMU)
		// IMPORTANT: enable this dummy global argument only for "hw" build.
		// Check ../common_xilinx/utility/boards.mk
		// https://forums.xilinx.com/t5/SDAccel/ERROR-KernelCheck-83-114-in-sdx-2017-4/td-p/818135
		__global int *dummy
#endif
) {

	char active = 0x01;

	// Only for debugging
	/*
	uint LS1_eval = 0;
	uint LS2_eval = 0;
	uint LS3_eval = 0;
	*/

	__attribute__((xcl_pipeline_loop))
	LOOP_WHILE_IGL_MAIN:
	while(active) {
		nb_pipe_status Off_valid     = PIPE_STATUS_FAILURE;
		nb_pipe_status IC_valid	     = PIPE_STATUS_FAILURE;
		nb_pipe_status GG_valid	     = PIPE_STATUS_FAILURE;
		nb_pipe_status LS1_end_valid = PIPE_STATUS_FAILURE;
		nb_pipe_status LS2_end_valid = PIPE_STATUS_FAILURE;
		nb_pipe_status LS3_end_valid = PIPE_STATUS_FAILURE;
		nb_pipe_status LS4_end_valid = PIPE_STATUS_FAILURE;
		nb_pipe_status LS5_end_valid = PIPE_STATUS_FAILURE;
		nb_pipe_status LS6_end_valid = PIPE_STATUS_FAILURE;
		nb_pipe_status LS7_end_valid = PIPE_STATUS_FAILURE;
		nb_pipe_status LS8_end_valid = PIPE_STATUS_FAILURE;
		nb_pipe_status LS9_end_valid = PIPE_STATUS_FAILURE;

		int Off_active;
		int IC_active;
		int GG_active;
		int LS1_end_active;
		int LS2_end_active;
		int LS3_end_active;
		int LS4_end_active;
		int LS5_end_active;
		int LS6_end_active;
		int LS7_end_active;
		int LS8_end_active;
		int LS9_end_active;

		__attribute__((xcl_pipeline_loop))
		LOOP_WHILE_IGL_INNER:
		while (
			(Off_valid     != PIPE_STATUS_SUCCESS) &&
			(IC_valid      != PIPE_STATUS_SUCCESS) &&  
			(GG_valid      != PIPE_STATUS_SUCCESS) && 
			(LS1_end_valid != PIPE_STATUS_SUCCESS) &&
			(LS2_end_valid != PIPE_STATUS_SUCCESS) &&
			(LS3_end_valid != PIPE_STATUS_SUCCESS) &&
			(LS4_end_valid != PIPE_STATUS_SUCCESS) &&
			(LS5_end_valid != PIPE_STATUS_SUCCESS) &&
			(LS6_end_valid != PIPE_STATUS_SUCCESS) &&
			(LS7_end_valid != PIPE_STATUS_SUCCESS) &&
			(LS8_end_valid != PIPE_STATUS_SUCCESS) &&
			(LS9_end_valid != PIPE_STATUS_SUCCESS) 
		){
			Off_valid     = read_pipe(chan_IGLArbiter_Off,     &Off_active);
			IC_valid      = read_pipe(chan_GA2IGL_IC_active,   &IC_active);
			GG_valid      = read_pipe(chan_GA2IGL_GG_active,   &GG_active);
			LS1_end_valid = read_pipe(chan_LS2Arbiter_LS1_end, &LS1_end_active);
			LS2_end_valid = read_pipe(chan_LS2Arbiter_LS2_end, &LS2_end_active);
			LS3_end_valid = read_pipe(chan_LS2Arbiter_LS3_end, &LS3_end_active);
			LS4_end_valid = read_pipe(chan_LS2Arbiter_LS4_end, &LS4_end_active);
			LS5_end_valid = read_pipe(chan_LS2Arbiter_LS5_end, &LS5_end_active);
			LS6_end_valid = read_pipe(chan_LS2Arbiter_LS6_end, &LS6_end_active);
			LS7_end_valid = read_pipe(chan_LS2Arbiter_LS7_end, &LS7_end_active);
			LS8_end_valid = read_pipe(chan_LS2Arbiter_LS8_end, &LS8_end_active);
			LS9_end_valid = read_pipe(chan_LS2Arbiter_LS9_end, &LS9_end_active);
		}

		active = (Off_valid == PIPE_STATUS_SUCCESS)? 0x00 : 0x01;

		bool mode_LS_bool [9];

		__attribute__((opencl_unroll_hint))
		LOOP_FOR_IGL_INIT_MODE_LS_BOOL:
		for(uchar i=0; i<9; i++) {
			mode_LS_bool [i] = false;
		}

		// Determine "mode_LS_bool" value
		// This considers all possible cases as all LS could be 
		// potentially producing genotypes simultaneously.
		if (active == 0x01) {
			if ((IC_valid != PIPE_STATUS_SUCCESS) && (GG_valid != PIPE_STATUS_SUCCESS)) {
				if (LS1_end_valid == PIPE_STATUS_SUCCESS) {mode_LS_bool [0] = true; /*printf("LS1 valid!\n");*/}
				if (LS2_end_valid == PIPE_STATUS_SUCCESS) {mode_LS_bool [1] = true; /*printf("LS2 valid!\n");*/}
				if (LS3_end_valid == PIPE_STATUS_SUCCESS) {mode_LS_bool [2] = true; /*printf("LS3 valid!\n");*/}
				if (LS4_end_valid == PIPE_STATUS_SUCCESS) {mode_LS_bool [3] = true; /*printf("LS4 valid!\n");*/}
				if (LS5_end_valid == PIPE_STATUS_SUCCESS) {mode_LS_bool [4] = true; /*printf("LS5 valid!\n");*/}
				if (LS6_end_valid == PIPE_STATUS_SUCCESS) {mode_LS_bool [5] = true; /*printf("LS6 valid!\n");*/}
				if (LS7_end_valid == PIPE_STATUS_SUCCESS) {mode_LS_bool [6] = true; /*printf("LS7 valid!\n");*/}
				if (LS8_end_valid == PIPE_STATUS_SUCCESS) {mode_LS_bool [7] = true; /*printf("LS8 valid!\n");*/}
				if (LS9_end_valid == PIPE_STATUS_SUCCESS) {mode_LS_bool [8] = true; /*printf("LS9 valid!\n");*/}
			}
		} // End if (active == 0x01)

		// Send "mode" to Conform
		__attribute__((xcl_pipeline_loop))
		LOOP_FOR_IGL_WRITE_MODE:
		for (uchar j=0; j<9; j++) {
			bool enable_write_channel = false;
			char mode_tmp;		

			const char mode_Off  = 0x00;
			const char mode_IC   = 'I';
			const char mode_GG   = 'G';
			const char mode_LS [9]  = {0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09};

			if (Off_valid == PIPE_STATUS_SUCCESS) {
				enable_write_channel = (j==0)? true:false;
				mode_tmp = mode_Off;
			}
			else if (IC_valid == PIPE_STATUS_SUCCESS) {
				enable_write_channel = (j==0)? true:false;
				mode_tmp = mode_IC;
			}
			else if (GG_valid == PIPE_STATUS_SUCCESS) {
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
				write_pipe_block(chan_IGL2Conform_actmode, &mode_tmp);
			}
		} // End for (uchar j=0; j<9; j++)

		//printf("IGL Simplif sent!\n");
	} // End of while (active)
}
// --------------------------------------------------------------------------
// --------------------------------------------------------------------------




