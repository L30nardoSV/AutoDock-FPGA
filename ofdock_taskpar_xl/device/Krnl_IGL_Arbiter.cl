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
// IMPORTANT: enable this dummy global argument
// for hw_emu and hw build
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

while(active) {
/*
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
*/
	int Off_valid     = 1;
	int IC_valid	  = 1;
	int GG_valid	  = 1;
	int LS1_end_valid = 1;
	int LS2_end_valid = 1;
	int LS3_end_valid = 1;
	int LS4_end_valid = 1;
	int LS5_end_valid = 1;
	int LS6_end_valid = 1;
	int LS7_end_valid = 1;
	int LS8_end_valid = 1;
	int LS9_end_valid = 1;

/*bool Off_active;*/ 	 int Off_active;
/*bool IC_active;*/  	 int IC_active;
/*bool GG_active;*/  	 int GG_active;
/*bool LS1_end_active;*/ int LS1_end_active;
/*bool LS2_end_active;*/ int LS2_end_active;
/*bool LS3_end_active;*/ int LS3_end_active;
/*bool LS4_end_active;*/ int LS4_end_active;
/*bool LS5_end_active;*/ int LS5_end_active;
/*bool LS6_end_active;*/ int LS6_end_active;
/*bool LS7_end_active;*/ int LS7_end_active;
/*bool LS8_end_active;*/ int LS8_end_active;
/*bool LS9_end_active;*/ int LS9_end_active;

/*
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
*/
	while (
		(Off_valid     != 0) &&
		(IC_valid      != 0) &&  
		(GG_valid      != 0) && 
		(LS1_end_valid != 0) &&
		(LS2_end_valid != 0) &&
		(LS3_end_valid != 0) &&
		(LS4_end_valid != 0) &&
		(LS5_end_valid != 0) &&
		(LS6_end_valid != 0) &&
		(LS7_end_valid != 0) &&
		(LS8_end_valid != 0) &&
		(LS9_end_valid != 0) 
	){
/*
		Off_active     = read_channel_nb_altera(chan_IGLArbiter_Off,     &Off_valid);
		IC_active      = read_channel_nb_altera(chan_GA2IGL_IC_active,   &IC_valid);
		GG_active      = read_channel_nb_altera(chan_GA2IGL_GG_active, 	 &GG_valid);
		LS1_end_active = read_channel_nb_altera(chan_LS2Arbiter_LS1_end, &LS1_end_valid);
		LS2_end_active = read_channel_nb_altera(chan_LS2Arbiter_LS2_end, &LS2_end_valid);
		LS3_end_active = read_channel_nb_altera(chan_LS2Arbiter_LS3_end, &LS3_end_valid);
		LS4_end_active = read_channel_nb_altera(chan_LS2Arbiter_LS4_end, &LS4_end_valid);
		LS5_end_active = read_channel_nb_altera(chan_LS2Arbiter_LS5_end, &LS5_end_valid);
		LS6_end_active = read_channel_nb_altera(chan_LS2Arbiter_LS6_end, &LS6_end_valid);
		LS7_end_active = read_channel_nb_altera(chan_LS2Arbiter_LS7_end, &LS7_end_valid);
		LS8_end_active = read_channel_nb_altera(chan_LS2Arbiter_LS8_end, &LS8_end_valid);
		LS9_end_active = read_channel_nb_altera(chan_LS2Arbiter_LS9_end, &LS9_end_valid);
*/
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

	uchar bound_tmp = 0;
/*
	active = Off_valid ? 0x00 : 0x01;
*/
	active = (Off_valid == 0)? 0x00 : 0x01;

	char mode [9];	// mode for all LS

	// Determine "mode" value
	// This considers all possible cases as all LS could be 
	// potentially producing genotypes simultaneously.
	// Be careful modifying the nested conditional-statements below,
	// as even a litle mistake may be undetectable in emulation.
	if (active == 0x01) {
/*
		if (IC_valid == true) {
*/
		if (IC_valid == 0) {
			bound_tmp++;
//printf("IGL - IC: bound_tmp: %u\n", bound_tmp);
		}
/*		
		else if (GG_valid == true) {
*/
		else if (GG_valid == 0) {
			bound_tmp++;
//printf("IGL - GG: bound_tmp: %u\n", bound_tmp);
		}	
		else{
			// Reorder the mode & from LS

			// **************************************************************************************
			// LS1: yes
			// **************************************************************************************
			if (LS1_end_valid == 0) {mode[0] = 0x01; bound_tmp++;
				
				// ======================================================================================
				// LS1: yes
				// LS2: yes 
				// ======================================================================================
				if (LS2_end_valid == 0) {mode[1] = 0x02; bound_tmp++;

					// --------------------------------------------------------------------------------------
					// LS1: yes
					// LS2: yes 
					// LS3: yes
					// --------------------------------------------------------------------------------------
					if (LS3_end_valid == 0) {mode[2] = 0x03; bound_tmp++;

						// LS1: yes
						// LS2: yes 
						// LS3: yes
						// LS4: yes
						if (LS4_end_valid == 0) {mode[3] = 0x04; bound_tmp++;

							if (LS5_end_valid == 0) {mode[4] = 0x05; bound_tmp++;
								if (LS6_end_valid == 0) {mode[5] = 0x06; bound_tmp++;
									if (LS7_end_valid == 0) {mode[6] = 0x07; bound_tmp++;
										if (LS8_end_valid == 0) {mode[7] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[8] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[7] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid == 0) {mode[6] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[7] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[6] = 0x09; bound_tmp++;}
										}
									}
								} else {
									if (LS7_end_valid == 0) {mode[5] = 0x07; bound_tmp++;
										if (LS8_end_valid == 0) {mode[6] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[7] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[6] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid == 0) {mode[5] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[6] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[5] = 0x09; bound_tmp++;}
										}
									}
								}
							} else { // LS5: no
								if (LS6_end_valid == 0) {mode[4] = 0x06; bound_tmp++;
									if (LS7_end_valid == 0) {mode[5] = 0x07; bound_tmp++;
										if (LS8_end_valid == 0) {mode[6] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[7] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[6] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid == 0) {mode[5] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[6] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[5] = 0x09; bound_tmp++;}
										}
									}
								} else {
									if (LS7_end_valid == 0) {mode[4] = 0x07; bound_tmp++;
										if (LS8_end_valid == 0) {mode[5] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[6] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[5] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid == 0) {mode[4] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[5] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[4] = 0x09; bound_tmp++;}
										}
									}
								}
							}
						}

						// LS1: yes
						// LS2: yes 
						// LS3: yes
						// LS4: no
						else {
							if (LS5_end_valid == 0) {mode[3] = 0x05; bound_tmp++;
								if (LS6_end_valid == 0) {mode[4] = 0x06; bound_tmp++;
									if (LS7_end_valid == 0) {mode[5] = 0x07; bound_tmp++;
										if (LS8_end_valid == 0) {mode[6] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[7] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[6] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid == 0) {mode[5] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[6] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[5] = 0x09; bound_tmp++;}
										}
									}
								} else {
									if (LS7_end_valid == 0) {mode[4] = 0x07; bound_tmp++;
										if (LS8_end_valid == 0) {mode[5] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[6] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[5] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid == 0) {mode[4] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[5] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[4] = 0x09; bound_tmp++;}
										}
									}
								}
							} else { // LS5: no
								if (LS6_end_valid == 0) {mode[3] = 0x06; bound_tmp++;
									if (LS7_end_valid == 0) {mode[4] = 0x07; bound_tmp++;
										if (LS8_end_valid == 0) {mode[5] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[6] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[5] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid == 0) {mode[4] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[5] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[4] = 0x09; bound_tmp++;}
										}
									}
								} else {
									if (LS7_end_valid == 0) {mode[3] = 0x07; bound_tmp++;
										if (LS8_end_valid == 0) {mode[4] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[5] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[4] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid == 0) {mode[3] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[4] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[3] = 0x09; bound_tmp++;}
										}
									}
								}
							}
						}
					}
					// --------------------------------------------------------------------------------------
					// LS1: yes
					// LS2: yes 
					// LS3: no
					// --------------------------------------------------------------------------------------
					else { 
						// LS1: yes
						// LS2: yes 
						// LS3: no
						// LS4: yes
						if (LS4_end_valid == 0) {mode[2] = 0x04; bound_tmp++;

							if (LS5_end_valid == 0) {mode[3] = 0x05; bound_tmp++;
								if (LS6_end_valid == 0) {mode[4] = 0x06; bound_tmp++;
									if (LS7_end_valid == 0) {mode[5] = 0x07; bound_tmp++;
										if (LS8_end_valid == 0) {mode[6] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[7] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[6] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid == 0) {mode[5] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[6] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[5] = 0x09; bound_tmp++;}
										}
									}
								} else {
									if (LS7_end_valid == 0) {mode[4] = 0x07; bound_tmp++;
										if (LS8_end_valid == 0) {mode[5] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[6] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[5] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid == 0) {mode[4] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[5] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[4] = 0x09; bound_tmp++;}
										}
									}
								}
							} else { // LS5: no
								if (LS6_end_valid == 0) {mode[3] = 0x06; bound_tmp++;
									if (LS7_end_valid == 0) {mode[4] = 0x07; bound_tmp++;
										if (LS8_end_valid == 0) {mode[5] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[6] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[5] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid == 0) {mode[4] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[5] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[4] = 0x09; bound_tmp++;}
										}
									}
								} else {
									if (LS7_end_valid == 0) {mode[3] = 0x07; bound_tmp++;
										if (LS8_end_valid == 0) {mode[4] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[5] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[4] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid == 0) {mode[3] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[4] = 0x09; bound_tmp++;}
										}
										else {
											if (LS9_end_valid == 0) {mode[3] = 0x09; bound_tmp++;}
										}
									}
								}
							}

						// LS1: yes
						// LS2: yes 
						// LS3: no
						// LS4: no
						} else { 
							if (LS5_end_valid == 0) {mode[2] = 0x05; bound_tmp++;
								if (LS6_end_valid == 0) {mode[3] = 0x06; bound_tmp++;
									if (LS7_end_valid == 0) {mode[4] = 0x07; bound_tmp++;
										if (LS8_end_valid == 0) {mode[5] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[6] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[5] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid == 0) {mode[4] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[5] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[4] = 0x09; bound_tmp++;}
										}
									}
								} else {
									if (LS7_end_valid == 0) {mode[3] = 0x07; bound_tmp++;
										if (LS8_end_valid == 0) {mode[4] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[5] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[4] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid == 0) {mode[3] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[4] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[3] = 0x09; bound_tmp++;}
										}
									}
								}
							} else { // LS5: no
								if (LS6_end_valid == 0) {mode[2] = 0x06; bound_tmp++;
									if (LS7_end_valid == 0) {mode[3] = 0x07; bound_tmp++;
										if (LS8_end_valid == 0) {mode[4] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[5] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[4] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid == 0) {mode[3] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[4] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[3] = 0x09; bound_tmp++;}
										}
									}
								} else {
									if (LS7_end_valid == 0) {mode[2] = 0x07; bound_tmp++;
										if (LS8_end_valid == 0) {mode[3] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[4] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[3] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid == 0) {mode[2] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[3] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[2] = 0x09; bound_tmp++;}
										}
									}
								}
							}
						}

					} 
					// --------------------------------------------------------------------------------------
				}

				// ======================================================================================
				// LS1: yes
				// LS2: no 
				// ======================================================================================
				else {
					// --------------------------------------------------------------------------------------
					// LS1: yes
					// LS2: no 
					// LS3: yes
					// --------------------------------------------------------------------------------------
					if (LS3_end_valid == 0) {mode[1] = 0x03; bound_tmp++;

						// LS1: yes
						// LS2: no 
						// LS3: yes
						// LS4: yes
						if (LS4_end_valid == 0) {mode[2] = 0x04; bound_tmp++;

							if (LS5_end_valid == 0) {mode[3] = 0x05; bound_tmp++;
								if (LS6_end_valid == 0) {mode[4] = 0x06; bound_tmp++;
									if (LS7_end_valid == 0) {mode[5] = 0x07; bound_tmp++;
										if (LS8_end_valid == 0) {mode[6] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[7] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[6] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid == 0) {mode[5] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[6] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[5] = 0x09; bound_tmp++;}
										}
									}
								} else {
									if (LS7_end_valid == 0) {mode[4] = 0x07; bound_tmp++;
										if (LS8_end_valid == 0) {mode[5] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[6] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[5] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid == 0) {mode[4] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[5] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[4] = 0x09; bound_tmp++;}
										}
									}
								}
							} else { // LS5: no
								if (LS6_end_valid == 0) {mode[3] = 0x06; bound_tmp++;
									if (LS7_end_valid == 0) {mode[4] = 0x07; bound_tmp++;
										if (LS8_end_valid == 0) {mode[5] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[6] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[5] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid == 0) {mode[4] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[5] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[4] = 0x09; bound_tmp++;}
										}
									}
								} else {
									if (LS7_end_valid == 0) {mode[3] = 0x07; bound_tmp++;
										if (LS8_end_valid == 0) {mode[4] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[5] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[4] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid == 0) {mode[3] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[4] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[3] = 0x09; bound_tmp++;}
										}
									}
								}
							}
						}

						// LS1: yes
						// LS2: no 
						// LS3: yes
						// LS4: no
						else {
							if (LS5_end_valid == 0) {mode[2] = 0x05; bound_tmp++;
								if (LS6_end_valid == 0) {mode[3] = 0x06; bound_tmp++;
									if (LS7_end_valid == 0) {mode[4] = 0x07; bound_tmp++;
										if (LS8_end_valid == 0) {mode[5] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[6] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[5] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid == 0) {mode[4] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[5] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[4] = 0x09; bound_tmp++;}
										}
									}
								} else {
									if (LS7_end_valid == 0) {mode[3] = 0x07; bound_tmp++;
										if (LS8_end_valid == 0) {mode[4] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[5] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[4] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid == 0) {mode[3] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[4] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[3] = 0x09; bound_tmp++;}
										}
									}
								}
							} else { // LS5: no
								if (LS6_end_valid == 0) {mode[2] = 0x06; bound_tmp++;
									if (LS7_end_valid == 0) {mode[3] = 0x07; bound_tmp++;
										if (LS8_end_valid == 0) {mode[4] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[5] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[4] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid == 0) {mode[3] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[4] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[3] = 0x09; bound_tmp++;}
										}
									}
								} else {
									if (LS7_end_valid == 0) {mode[2] = 0x07; bound_tmp++;
										if (LS8_end_valid == 0) {mode[3] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[4] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[3] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid == 0) {mode[2] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[3] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[2] = 0x09; bound_tmp++;}
										}
									}
								}
							}
						}
					}
					// --------------------------------------------------------------------------------------
					// LS1: yes
					// LS2: no 
					// LS3: no
					// --------------------------------------------------------------------------------------
					else { 
						// LS1: yes
						// LS2: no 
						// LS3: no
						// LS4: yes
						if (LS4_end_valid == 0) {mode[1] = 0x04; bound_tmp++;

							if (LS5_end_valid == 0) {mode[2] = 0x05; bound_tmp++;
								if (LS6_end_valid == 0) {mode[3] = 0x06; bound_tmp++;
									if (LS7_end_valid == 0) {mode[4] = 0x07; bound_tmp++;
										if (LS8_end_valid == 0) {mode[5] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[6] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[5] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid == 0) {mode[4] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[5] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[4] = 0x09; bound_tmp++;}
										}
									}
								} else {
									if (LS7_end_valid == 0) {mode[3] = 0x07; bound_tmp++;
										if (LS8_end_valid == 0) {mode[4] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[5] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[4] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid == 0) {mode[3] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[4] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[3] = 0x09; bound_tmp++;}
										}
									}
								}
							} else { // LS5: no
								if (LS6_end_valid == 0) {mode[2] = 0x06; bound_tmp++;
									if (LS7_end_valid == 0) {mode[3] = 0x07; bound_tmp++;
										if (LS8_end_valid == 0) {mode[4] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[5] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[4] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid == 0) {mode[3] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[4] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[3] = 0x09; bound_tmp++;}
										}
									}
								} else {
									if (LS7_end_valid == 0) {mode[2] = 0x07; bound_tmp++;
										if (LS8_end_valid == 0) {mode[3] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[4] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[3] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid == 0) {mode[2] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[3] = 0x09; bound_tmp++;}
										}
										else {
											if (LS9_end_valid == 0) {mode[2] = 0x09; bound_tmp++;}
										}
									}
								}
							}

						// LS1: yes
						// LS2: no 
						// LS3: no
						// LS4: no
						} else { 
							if (LS5_end_valid == 0) {mode[1] = 0x05; bound_tmp++;
								if (LS6_end_valid == 0) {mode[2] = 0x06; bound_tmp++;
									if (LS7_end_valid == 0) {mode[3] = 0x07; bound_tmp++;
										if (LS8_end_valid == 0) {mode[4] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[5] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[4] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid == 0) {mode[3] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[4] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[3] = 0x09; bound_tmp++;}
										}
									}
								} else {
									if (LS7_end_valid == 0) {mode[2] = 0x07; bound_tmp++;
										if (LS8_end_valid == 0) {mode[3] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[4] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[3] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid == 0) {mode[2] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[3] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[2] = 0x09; bound_tmp++;}
										}
									}
								}
							} else { // LS5: no
								if (LS6_end_valid == 0) {mode[1] = 0x06; bound_tmp++;
									if (LS7_end_valid == 0) {mode[2] = 0x07; bound_tmp++;
										if (LS8_end_valid == 0) {mode[3] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[4] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[3] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid == 0) {mode[2] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[3] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[2] = 0x09; bound_tmp++;}
										}
									}
								} else {
									if (LS7_end_valid == 0) {mode[1] = 0x07; bound_tmp++;
										if (LS8_end_valid == 0) {mode[2] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[3] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[2] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid == 0) {mode[1] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[2] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[1] = 0x09; bound_tmp++;}
										}
									}
								}
							}
						}

					} 
					// --------------------------------------------------------------------------------------
				}
				// ======================================================================================
			}

			// **************************************************************************************
			// LS1: no
			// **************************************************************************************
			else { 
				// ======================================================================================
				// LS1: no
				// LS2: yes 
				// ======================================================================================
				if (LS2_end_valid == 0) {mode[0] = 0x02; bound_tmp++;

					// --------------------------------------------------------------------------------------
					// LS1: no
					// LS2: yes 
					// LS3: yes
					// --------------------------------------------------------------------------------------
					if (LS3_end_valid == 0) {mode[1] = 0x03; bound_tmp++;

						// LS1: no
						// LS2: yes 
						// LS3: yes
						// LS4: yes
						if (LS4_end_valid == 0) {mode[2] = 0x04; bound_tmp++;

							if (LS5_end_valid == 0) {mode[3] = 0x05; bound_tmp++;
								if (LS6_end_valid == 0) {mode[4] = 0x06; bound_tmp++;
									if (LS7_end_valid == 0) {mode[5] = 0x07; bound_tmp++;
										if (LS8_end_valid == 0) {mode[6] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[7] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[6] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid == 0) {mode[5] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[6] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[5] = 0x09; bound_tmp++;}
										}
									}
								} else {
									if (LS7_end_valid == 0) {mode[4] = 0x07; bound_tmp++;
										if (LS8_end_valid == 0) {mode[5] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[6] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[5] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid == 0) {mode[4] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[5] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[4] = 0x09; bound_tmp++;}
										}
									}
								}
							} else { // LS5: no
								if (LS6_end_valid == 0) {mode[3] = 0x06; bound_tmp++;
									if (LS7_end_valid == 0) {mode[4] = 0x07; bound_tmp++;
										if (LS8_end_valid == 0) {mode[5] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[6] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[5] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid == 0) {mode[4] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[5] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[4] = 0x09; bound_tmp++;}
										}
									}
								} else {
									if (LS7_end_valid == 0) {mode[3] = 0x07; bound_tmp++;
										if (LS8_end_valid == 0) {mode[4] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[5] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[4] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid == 0) {mode[3] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[4] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[3] = 0x09; bound_tmp++;}
										}
									}
								}
							}
						}

						// LS1: no
						// LS2: yes 
						// LS3: yes
						// LS4: no
						else {
							if (LS5_end_valid == 0) {mode[2] = 0x05; bound_tmp++;
								if (LS6_end_valid == 0) {mode[3] = 0x06; bound_tmp++;
									if (LS7_end_valid == 0) {mode[4] = 0x07; bound_tmp++;
										if (LS8_end_valid == 0) {mode[5] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[6] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[5] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid == 0) {mode[4] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[5] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[4] = 0x09; bound_tmp++;}
										}
									}
								} else {
									if (LS7_end_valid == 0) {mode[3] = 0x07; bound_tmp++;
										if (LS8_end_valid == 0) {mode[4] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[5] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[4] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid == 0) {mode[3] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[4] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[3] = 0x09; bound_tmp++;}
										}
									}
								}
							} else { // LS5: no
								if (LS6_end_valid == 0) {mode[2] = 0x06; bound_tmp++;
									if (LS7_end_valid == 0) {mode[3] = 0x07; bound_tmp++;
										if (LS8_end_valid == 0) {mode[4] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[5] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[4] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid == 0) {mode[3] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[4] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[3] = 0x09; bound_tmp++;}
										}
									}
								} else {
									if (LS7_end_valid == 0) {mode[2] = 0x07; bound_tmp++;
										if (LS8_end_valid == 0) {mode[3] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[4] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[3] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid == 0) {mode[2] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[3] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[2] = 0x09; bound_tmp++;}
										}
									}
								}
							}
						}
					}
					// --------------------------------------------------------------------------------------
					// LS1: no
					// LS2: yes 
					// LS3: no
					// --------------------------------------------------------------------------------------
					else { 
						// LS1: no
						// LS2: yes 
						// LS3: no
						// LS4: yes
						if (LS4_end_valid == 0) {mode[1] = 0x04; bound_tmp++;

							if (LS5_end_valid == 0) {mode[2] = 0x05; bound_tmp++;
								if (LS6_end_valid == 0) {mode[3] = 0x06; bound_tmp++;
									if (LS7_end_valid == 0) {mode[4] = 0x07; bound_tmp++;
										if (LS8_end_valid == 0) {mode[5] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[6] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[5] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid == 0) {mode[4] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[5] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[4] = 0x09; bound_tmp++;}
										}
									}
								} else {
									if (LS7_end_valid == 0) {mode[3] = 0x07; bound_tmp++;
										if (LS8_end_valid == 0) {mode[4] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[5] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[4] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid == 0) {mode[3] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[4] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[3] = 0x09; bound_tmp++;}
										}
									}
								}
							} else { // LS5: no
								if (LS6_end_valid == 0) {mode[2] = 0x06; bound_tmp++;
									if (LS7_end_valid == 0) {mode[3] = 0x07; bound_tmp++;
										if (LS8_end_valid == 0) {mode[4] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[5] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[4] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid == 0) {mode[3] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[4] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[3] = 0x09; bound_tmp++;}
										}
									}
								} else {
									if (LS7_end_valid == 0) {mode[2] = 0x07; bound_tmp++;
										if (LS8_end_valid == 0) {mode[3] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[4] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[3] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid == 0) {mode[2] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[3] = 0x09; bound_tmp++;}
										}
										else {
											if (LS9_end_valid == 0) {mode[2] = 0x09; bound_tmp++;}
										}
									}
								}
							}

						// LS1: no
						// LS2: yes 
						// LS3: no
						// LS4: no
						} else { 
							if (LS5_end_valid == 0) {mode[1] = 0x05; bound_tmp++;
								if (LS6_end_valid == 0) {mode[2] = 0x06; bound_tmp++;
									if (LS7_end_valid == 0) {mode[3] = 0x07; bound_tmp++;
										if (LS8_end_valid == 0) {mode[4] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[5] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[4] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid == 0) {mode[3] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[4] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[3] = 0x09; bound_tmp++;}
										}
									}
								} else {
									if (LS7_end_valid == 0) {mode[2] = 0x07; bound_tmp++;
										if (LS8_end_valid == 0) {mode[3] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[4] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[3] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid == 0) {mode[2] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[3] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[2] = 0x09; bound_tmp++;}
										}
									}
								}
							} else { // LS5: no
								if (LS6_end_valid == 0) {mode[1] = 0x06; bound_tmp++;
									if (LS7_end_valid == 0) {mode[2] = 0x07; bound_tmp++;
										if (LS8_end_valid == 0) {mode[3] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[4] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[3] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid == 0) {mode[2] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[3] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[2] = 0x09; bound_tmp++;}
										}
									}
								} else {
									if (LS7_end_valid == 0) {mode[1] = 0x07; bound_tmp++;
										if (LS8_end_valid == 0) {mode[2] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[3] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[2] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid == 0) {mode[1] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[2] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[1] = 0x09; bound_tmp++;}
										}
									}
								}
							}
						}

					} 
					// --------------------------------------------------------------------------------------
				}

				// ======================================================================================
				// LS1: no
				// LS2: no 
				// ======================================================================================
				else {
					// --------------------------------------------------------------------------------------
					// LS1: no
					// LS2: no 
					// LS3: yes
					// --------------------------------------------------------------------------------------
					if (LS3_end_valid == 0) {mode[0] = 0x03; bound_tmp++;

						// LS1: no
						// LS2: no 
						// LS3: yes
						// LS4: yes
						if (LS4_end_valid == 0) {mode[1] = 0x04; bound_tmp++;

							if (LS5_end_valid == 0) {mode[2] = 0x05; bound_tmp++;
								if (LS6_end_valid == 0) {mode[3] = 0x06; bound_tmp++;
									if (LS7_end_valid == 0) {mode[4] = 0x07; bound_tmp++;
										if (LS8_end_valid == 0) {mode[5] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[6] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[5] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid == 0) {mode[4] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[5] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[4] = 0x09; bound_tmp++;}
										}
									}
								} else {
									if (LS7_end_valid == 0) {mode[3] = 0x07; bound_tmp++;
										if (LS8_end_valid == 0) {mode[4] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[5] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[4] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid == 0) {mode[3] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[4] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[3] = 0x09; bound_tmp++;}
										}
									}
								}
							} else { // LS5: no
								if (LS6_end_valid == 0) {mode[2] = 0x06; bound_tmp++;
									if (LS7_end_valid == 0) {mode[3] = 0x07; bound_tmp++;
										if (LS8_end_valid == 0) {mode[4] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[5] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[4] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid == 0) {mode[3] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[4] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[3] = 0x09; bound_tmp++;}
										}
									}
								} else {
									if (LS7_end_valid == 0) {mode[2] = 0x07; bound_tmp++;
										if (LS8_end_valid == 0) {mode[3] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[4] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[3] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid == 0) {mode[2] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[3] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[2] = 0x09; bound_tmp++;}
										}
									}
								}
							}
						}

						// LS1: no
						// LS2: no 
						// LS3: yes
						// LS4: no
						else {
							if (LS5_end_valid == 0) {mode[1] = 0x05; bound_tmp++;
								if (LS6_end_valid == 0) {mode[2] = 0x06; bound_tmp++;
									if (LS7_end_valid == 0) {mode[3] = 0x07; bound_tmp++;
										if (LS8_end_valid == 0) {mode[4] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[5] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[4] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid == 0) {mode[3] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[4] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[3] = 0x09; bound_tmp++;}
										}
									}
								} else {
									if (LS7_end_valid == 0) {mode[2] = 0x07; bound_tmp++;
										if (LS8_end_valid == 0) {mode[3] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[4] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[3] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid == 0) {mode[2] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[3] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[2] = 0x09; bound_tmp++;}
										}
									}
								}
							} else { // LS5: no
								if (LS6_end_valid == 0) {mode[1] = 0x06; bound_tmp++;
									if (LS7_end_valid == 0) {mode[2] = 0x07; bound_tmp++;
										if (LS8_end_valid == 0) {mode[3] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[4] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[3] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid == 0) {mode[2] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[3] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[2] = 0x09; bound_tmp++;}
										}
									}
								} else {
									if (LS7_end_valid == 0) {mode[1] = 0x07; bound_tmp++;
										if (LS8_end_valid == 0) {mode[2] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[3] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[2] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid == 0) {mode[1] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[2] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[1] = 0x09; bound_tmp++;}
										}
									}
								}
							}
						}
					}
					// --------------------------------------------------------------------------------------
					// LS1: no
					// LS2: no 
					// LS3: no
					// --------------------------------------------------------------------------------------
					else { 
						// LS1: no
						// LS2: no 
						// LS3: no
						// LS4: yes
						if (LS4_end_valid == 0) {mode[0] = 0x04; bound_tmp++;

							if (LS5_end_valid == 0) {mode[1] = 0x05; bound_tmp++;
								if (LS6_end_valid == 0) {mode[2] = 0x06; bound_tmp++;
									if (LS7_end_valid == 0) {mode[3] = 0x07; bound_tmp++;
										if (LS8_end_valid == 0) {mode[4] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[5] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[4] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid == 0) {mode[3] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[4] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[3] = 0x09; bound_tmp++;}
										}
									}
								} else {
									if (LS7_end_valid == 0) {mode[2] = 0x07; bound_tmp++;
										if (LS8_end_valid == 0) {mode[3] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[4] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[3] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid == 0) {mode[2] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[3] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[2] = 0x09; bound_tmp++;}
										}
									}
								}
							} else { // LS5: no
								if (LS6_end_valid == 0) {mode[1] = 0x06; bound_tmp++;
									if (LS7_end_valid == 0) {mode[2] = 0x07; bound_tmp++;
										if (LS8_end_valid == 0) {mode[3] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[4] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[3] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid == 0) {mode[2] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[3] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[2] = 0x09; bound_tmp++;}
										}
									}
								} else {
									if (LS7_end_valid == 0) {mode[1] = 0x07; bound_tmp++;
										if (LS8_end_valid == 0) {mode[2] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[3] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[2] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid == 0) {mode[1] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[2] = 0x09; bound_tmp++;}
										}
										else {
											if (LS9_end_valid == 0) {mode[1] = 0x09; bound_tmp++;}
										}
									}
								}
							}

						// LS1: no
						// LS2: no 
						// LS3: no
						// LS4: no
						} else { 
							if (LS5_end_valid == 0) {mode[0] = 0x05; bound_tmp++;
								if (LS6_end_valid == 0) {mode[1] = 0x06; bound_tmp++;
									if (LS7_end_valid == 0) {mode[2] = 0x07; bound_tmp++;
										if (LS8_end_valid == 0) {mode[3] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[4] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[3] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid == 0) {mode[2] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[3] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[2] = 0x09; bound_tmp++;}
										}
									}
								} else {
									if (LS7_end_valid == 0) {mode[1] = 0x07; bound_tmp++;
										if (LS8_end_valid == 0) {mode[2] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[3] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[2] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid == 0) {mode[1] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[2] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[1] = 0x09; bound_tmp++;}
										}
									}
								}
							} else { // LS5: no
								if (LS6_end_valid == 0) {mode[0] = 0x06; bound_tmp++;
									if (LS7_end_valid == 0) {mode[1] = 0x07; bound_tmp++;
										if (LS8_end_valid == 0) {mode[2] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[3] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[2] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid == 0) {mode[1] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[2] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[1] = 0x09; bound_tmp++;}
										}
									}
								} else {
									if (LS7_end_valid == 0) {mode[0] = 0x07; bound_tmp++;
										if (LS8_end_valid == 0) {mode[1] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[2] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[1] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid == 0) {mode[0] = 0x08; bound_tmp++;
											if (LS9_end_valid == 0) {mode[1] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid == 0) {mode[0] = 0x09; bound_tmp++;}
										}
									}
								}
							}
						}

					} 
					// --------------------------------------------------------------------------------------
				}
				// ======================================================================================
			}
			// **************************************************************************************			
		}
	} // End if (active == true)

	uchar bound = active ? bound_tmp : 1;

	// Send "mode" to Conform
	for (uchar j=0; j<bound; j++) {
/*
		char mode_tmp = Off_valid? 0x00: IC_valid? 'I': GG_valid? 'G': mode[j];
*/
		char mode_tmp = (Off_valid == 0)? 0x00: (IC_valid == 0)? 'I': (GG_valid == 0)? 'G': mode[j];

		char2 actmode = {active, mode_tmp};
/*
		write_channel_altera(chan_IGL2Conform_actmode, actmode);
*/
		write_pipe_block(chan_IGL2Conform_actmode, &actmode);

		#if defined (DEBUG_KRNL_IGL_ARBITER)
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


