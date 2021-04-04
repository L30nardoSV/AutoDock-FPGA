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

	uchar bound_tmp = 0;
	active = Off_valid ? 0x00 : 0x01;
	char mode [LS_REPLICATION_FACTOR];	// mode for all LS

	// Determine "mode" value
	// This considers all possible cases as all LS could be 
	// potentially producing genotypes simultaneously.
	// Be careful modifying the nested conditional-statements below,
	// as even a litle mistake may be undetectable in emulation.
	if (active == 0x01) {

		if (IC_valid == true) {
			bound_tmp++;
		}
		else if (GG_valid == true) {
			bound_tmp++;
		}	
		else{
			// Reorder the mode & from LS

			// **************************************************************************************
			// LS1: yes
			// **************************************************************************************
			if (LS1_end_valid) {mode[0] = 0x01; bound_tmp++;
				
				// ======================================================================================
				// LS1: yes
				// LS2: yes 
				// ======================================================================================
				if (LS2_end_valid) {mode[1] = 0x02; bound_tmp++;

					// --------------------------------------------------------------------------------------
					// LS1: yes
					// LS2: yes 
					// LS3: yes
					// --------------------------------------------------------------------------------------
					if (LS3_end_valid) {mode[2] = 0x03; bound_tmp++;

						// LS1: yes
						// LS2: yes 
						// LS3: yes
						// LS4: yes
						if (LS4_end_valid) {mode[3] = 0x04; bound_tmp++;

							if (LS5_end_valid) {mode[4] = 0x05; bound_tmp++;
								if (LS6_end_valid) {mode[5] = 0x06; bound_tmp++;
									if (LS7_end_valid) {mode[6] = 0x07; bound_tmp++;
										if (LS8_end_valid) {mode[7] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[8] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[7] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid) {mode[6] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[7] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[6] = 0x09; bound_tmp++;}
										}
									}
								} else {
									if (LS7_end_valid) {mode[5] = 0x07; bound_tmp++;
										if (LS8_end_valid) {mode[6] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[7] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[6] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid) {mode[5] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[6] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[5] = 0x09; bound_tmp++;}
										}
									}
								}
							} else { // LS5: no
								if (LS6_end_valid) {mode[4] = 0x06; bound_tmp++;
									if (LS7_end_valid) {mode[5] = 0x07; bound_tmp++;
										if (LS8_end_valid) {mode[6] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[7] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[6] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid) {mode[5] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[6] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[5] = 0x09; bound_tmp++;}
										}
									}
								} else {
									if (LS7_end_valid) {mode[4] = 0x07; bound_tmp++;
										if (LS8_end_valid) {mode[5] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[6] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[5] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid) {mode[4] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[5] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[4] = 0x09; bound_tmp++;}
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
							if (LS5_end_valid) {mode[3] = 0x05; bound_tmp++;
								if (LS6_end_valid) {mode[4] = 0x06; bound_tmp++;
									if (LS7_end_valid) {mode[5] = 0x07; bound_tmp++;
										if (LS8_end_valid) {mode[6] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[7] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[6] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid) {mode[5] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[6] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[5] = 0x09; bound_tmp++;}
										}
									}
								} else {
									if (LS7_end_valid) {mode[4] = 0x07; bound_tmp++;
										if (LS8_end_valid) {mode[5] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[6] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[5] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid) {mode[4] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[5] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[4] = 0x09; bound_tmp++;}
										}
									}
								}
							} else { // LS5: no
								if (LS6_end_valid) {mode[3] = 0x06; bound_tmp++;
									if (LS7_end_valid) {mode[4] = 0x07; bound_tmp++;
										if (LS8_end_valid) {mode[5] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[6] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[5] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid) {mode[4] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[5] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[4] = 0x09; bound_tmp++;}
										}
									}
								} else {
									if (LS7_end_valid) {mode[3] = 0x07; bound_tmp++;
										if (LS8_end_valid) {mode[4] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[5] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[4] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid) {mode[3] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[4] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[3] = 0x09; bound_tmp++;}
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
						if (LS4_end_valid) {mode[2] = 0x04; bound_tmp++;

							if (LS5_end_valid) {mode[3] = 0x05; bound_tmp++;
								if (LS6_end_valid) {mode[4] = 0x06; bound_tmp++;
									if (LS7_end_valid) {mode[5] = 0x07; bound_tmp++;
										if (LS8_end_valid) {mode[6] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[7] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[6] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid) {mode[5] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[6] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[5] = 0x09; bound_tmp++;}
										}
									}
								} else {
									if (LS7_end_valid) {mode[4] = 0x07; bound_tmp++;
										if (LS8_end_valid) {mode[5] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[6] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[5] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid) {mode[4] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[5] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[4] = 0x09; bound_tmp++;}
										}
									}
								}
							} else { // LS5: no
								if (LS6_end_valid) {mode[3] = 0x06; bound_tmp++;
									if (LS7_end_valid) {mode[4] = 0x07; bound_tmp++;
										if (LS8_end_valid) {mode[5] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[6] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[5] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid) {mode[4] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[5] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[4] = 0x09; bound_tmp++;}
										}
									}
								} else {
									if (LS7_end_valid) {mode[3] = 0x07; bound_tmp++;
										if (LS8_end_valid) {mode[4] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[5] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[4] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid) {mode[3] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[4] = 0x09; bound_tmp++;}
										}
										else {
											if (LS9_end_valid) {mode[3] = 0x09; bound_tmp++;}
										}
									}
								}
							}

						// LS1: yes
						// LS2: yes 
						// LS3: no
						// LS4: no
						} else { 
							if (LS5_end_valid) {mode[2] = 0x05; bound_tmp++;
								if (LS6_end_valid) {mode[3] = 0x06; bound_tmp++;
									if (LS7_end_valid) {mode[4] = 0x07; bound_tmp++;
										if (LS8_end_valid) {mode[5] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[6] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[5] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid) {mode[4] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[5] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[4] = 0x09; bound_tmp++;}
										}
									}
								} else {
									if (LS7_end_valid) {mode[3] = 0x07; bound_tmp++;
										if (LS8_end_valid) {mode[4] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[5] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[4] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid) {mode[3] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[4] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[3] = 0x09; bound_tmp++;}
										}
									}
								}
							} else { // LS5: no
								if (LS6_end_valid) {mode[2] = 0x06; bound_tmp++;
									if (LS7_end_valid) {mode[3] = 0x07; bound_tmp++;
										if (LS8_end_valid) {mode[4] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[5] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[4] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid) {mode[3] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[4] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[3] = 0x09; bound_tmp++;}
										}
									}
								} else {
									if (LS7_end_valid) {mode[2] = 0x07; bound_tmp++;
										if (LS8_end_valid) {mode[3] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[4] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[3] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid) {mode[2] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[3] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[2] = 0x09; bound_tmp++;}
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
					if (LS3_end_valid) {mode[1] = 0x03; bound_tmp++;

						// LS1: yes
						// LS2: no 
						// LS3: yes
						// LS4: yes
						if (LS4_end_valid) {mode[2] = 0x04; bound_tmp++;

							if (LS5_end_valid) {mode[3] = 0x05; bound_tmp++;
								if (LS6_end_valid) {mode[4] = 0x06; bound_tmp++;
									if (LS7_end_valid) {mode[5] = 0x07; bound_tmp++;
										if (LS8_end_valid) {mode[6] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[7] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[6] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid) {mode[5] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[6] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[5] = 0x09; bound_tmp++;}
										}
									}
								} else {
									if (LS7_end_valid) {mode[4] = 0x07; bound_tmp++;
										if (LS8_end_valid) {mode[5] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[6] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[5] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid) {mode[4] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[5] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[4] = 0x09; bound_tmp++;}
										}
									}
								}
							} else { // LS5: no
								if (LS6_end_valid) {mode[3] = 0x06; bound_tmp++;
									if (LS7_end_valid) {mode[4] = 0x07; bound_tmp++;
										if (LS8_end_valid) {mode[5] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[6] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[5] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid) {mode[4] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[5] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[4] = 0x09; bound_tmp++;}
										}
									}
								} else {
									if (LS7_end_valid) {mode[3] = 0x07; bound_tmp++;
										if (LS8_end_valid) {mode[4] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[5] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[4] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid) {mode[3] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[4] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[3] = 0x09; bound_tmp++;}
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
							if (LS5_end_valid) {mode[2] = 0x05; bound_tmp++;
								if (LS6_end_valid) {mode[3] = 0x06; bound_tmp++;
									if (LS7_end_valid) {mode[4] = 0x07; bound_tmp++;
										if (LS8_end_valid) {mode[5] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[6] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[5] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid) {mode[4] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[5] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[4] = 0x09; bound_tmp++;}
										}
									}
								} else {
									if (LS7_end_valid) {mode[3] = 0x07; bound_tmp++;
										if (LS8_end_valid) {mode[4] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[5] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[4] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid) {mode[3] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[4] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[3] = 0x09; bound_tmp++;}
										}
									}
								}
							} else { // LS5: no
								if (LS6_end_valid) {mode[2] = 0x06; bound_tmp++;
									if (LS7_end_valid) {mode[3] = 0x07; bound_tmp++;
										if (LS8_end_valid) {mode[4] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[5] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[4] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid) {mode[3] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[4] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[3] = 0x09; bound_tmp++;}
										}
									}
								} else {
									if (LS7_end_valid) {mode[2] = 0x07; bound_tmp++;
										if (LS8_end_valid) {mode[3] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[4] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[3] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid) {mode[2] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[3] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[2] = 0x09; bound_tmp++;}
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
						if (LS4_end_valid) {mode[1] = 0x04; bound_tmp++;

							if (LS5_end_valid) {mode[2] = 0x05; bound_tmp++;
								if (LS6_end_valid) {mode[3] = 0x06; bound_tmp++;
									if (LS7_end_valid) {mode[4] = 0x07; bound_tmp++;
										if (LS8_end_valid) {mode[5] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[6] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[5] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid) {mode[4] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[5] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[4] = 0x09; bound_tmp++;}
										}
									}
								} else {
									if (LS7_end_valid) {mode[3] = 0x07; bound_tmp++;
										if (LS8_end_valid) {mode[4] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[5] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[4] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid) {mode[3] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[4] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[3] = 0x09; bound_tmp++;}
										}
									}
								}
							} else { // LS5: no
								if (LS6_end_valid) {mode[2] = 0x06; bound_tmp++;
									if (LS7_end_valid) {mode[3] = 0x07; bound_tmp++;
										if (LS8_end_valid) {mode[4] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[5] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[4] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid) {mode[3] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[4] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[3] = 0x09; bound_tmp++;}
										}
									}
								} else {
									if (LS7_end_valid) {mode[2] = 0x07; bound_tmp++;
										if (LS8_end_valid) {mode[3] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[4] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[3] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid) {mode[2] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[3] = 0x09; bound_tmp++;}
										}
										else {
											if (LS9_end_valid) {mode[2] = 0x09; bound_tmp++;}
										}
									}
								}
							}

						// LS1: yes
						// LS2: no 
						// LS3: no
						// LS4: no
						} else { 
							if (LS5_end_valid) {mode[1] = 0x05; bound_tmp++;
								if (LS6_end_valid) {mode[2] = 0x06; bound_tmp++;
									if (LS7_end_valid) {mode[3] = 0x07; bound_tmp++;
										if (LS8_end_valid) {mode[4] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[5] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[4] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid) {mode[3] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[4] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[3] = 0x09; bound_tmp++;}
										}
									}
								} else {
									if (LS7_end_valid) {mode[2] = 0x07; bound_tmp++;
										if (LS8_end_valid) {mode[3] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[4] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[3] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid) {mode[2] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[3] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[2] = 0x09; bound_tmp++;}
										}
									}
								}
							} else { // LS5: no
								if (LS6_end_valid) {mode[1] = 0x06; bound_tmp++;
									if (LS7_end_valid) {mode[2] = 0x07; bound_tmp++;
										if (LS8_end_valid) {mode[3] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[4] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[3] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid) {mode[2] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[3] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[2] = 0x09; bound_tmp++;}
										}
									}
								} else {
									if (LS7_end_valid) {mode[1] = 0x07; bound_tmp++;
										if (LS8_end_valid) {mode[2] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[3] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[2] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid) {mode[1] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[2] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[1] = 0x09; bound_tmp++;}
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
				if (LS2_end_valid) {mode[0] = 0x02; bound_tmp++;

					// --------------------------------------------------------------------------------------
					// LS1: no
					// LS2: yes 
					// LS3: yes
					// --------------------------------------------------------------------------------------
					if (LS3_end_valid) {mode[1] = 0x03; bound_tmp++;

						// LS1: no
						// LS2: yes 
						// LS3: yes
						// LS4: yes
						if (LS4_end_valid) {mode[2] = 0x04; bound_tmp++;

							if (LS5_end_valid) {mode[3] = 0x05; bound_tmp++;
								if (LS6_end_valid) {mode[4] = 0x06; bound_tmp++;
									if (LS7_end_valid) {mode[5] = 0x07; bound_tmp++;
										if (LS8_end_valid) {mode[6] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[7] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[6] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid) {mode[5] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[6] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[5] = 0x09; bound_tmp++;}
										}
									}
								} else {
									if (LS7_end_valid) {mode[4] = 0x07; bound_tmp++;
										if (LS8_end_valid) {mode[5] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[6] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[5] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid) {mode[4] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[5] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[4] = 0x09; bound_tmp++;}
										}
									}
								}
							} else { // LS5: no
								if (LS6_end_valid) {mode[3] = 0x06; bound_tmp++;
									if (LS7_end_valid) {mode[4] = 0x07; bound_tmp++;
										if (LS8_end_valid) {mode[5] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[6] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[5] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid) {mode[4] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[5] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[4] = 0x09; bound_tmp++;}
										}
									}
								} else {
									if (LS7_end_valid) {mode[3] = 0x07; bound_tmp++;
										if (LS8_end_valid) {mode[4] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[5] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[4] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid) {mode[3] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[4] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[3] = 0x09; bound_tmp++;}
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
							if (LS5_end_valid) {mode[2] = 0x05; bound_tmp++;
								if (LS6_end_valid) {mode[3] = 0x06; bound_tmp++;
									if (LS7_end_valid) {mode[4] = 0x07; bound_tmp++;
										if (LS8_end_valid) {mode[5] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[6] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[5] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid) {mode[4] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[5] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[4] = 0x09; bound_tmp++;}
										}
									}
								} else {
									if (LS7_end_valid) {mode[3] = 0x07; bound_tmp++;
										if (LS8_end_valid) {mode[4] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[5] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[4] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid) {mode[3] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[4] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[3] = 0x09; bound_tmp++;}
										}
									}
								}
							} else { // LS5: no
								if (LS6_end_valid) {mode[2] = 0x06; bound_tmp++;
									if (LS7_end_valid) {mode[3] = 0x07; bound_tmp++;
										if (LS8_end_valid) {mode[4] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[5] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[4] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid) {mode[3] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[4] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[3] = 0x09; bound_tmp++;}
										}
									}
								} else {
									if (LS7_end_valid) {mode[2] = 0x07; bound_tmp++;
										if (LS8_end_valid) {mode[3] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[4] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[3] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid) {mode[2] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[3] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[2] = 0x09; bound_tmp++;}
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
						if (LS4_end_valid) {mode[1] = 0x04; bound_tmp++;

							if (LS5_end_valid) {mode[2] = 0x05; bound_tmp++;
								if (LS6_end_valid) {mode[3] = 0x06; bound_tmp++;
									if (LS7_end_valid) {mode[4] = 0x07; bound_tmp++;
										if (LS8_end_valid) {mode[5] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[6] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[5] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid) {mode[4] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[5] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[4] = 0x09; bound_tmp++;}
										}
									}
								} else {
									if (LS7_end_valid) {mode[3] = 0x07; bound_tmp++;
										if (LS8_end_valid) {mode[4] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[5] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[4] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid) {mode[3] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[4] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[3] = 0x09; bound_tmp++;}
										}
									}
								}
							} else { // LS5: no
								if (LS6_end_valid) {mode[2] = 0x06; bound_tmp++;
									if (LS7_end_valid) {mode[3] = 0x07; bound_tmp++;
										if (LS8_end_valid) {mode[4] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[5] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[4] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid) {mode[3] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[4] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[3] = 0x09; bound_tmp++;}
										}
									}
								} else {
									if (LS7_end_valid) {mode[2] = 0x07; bound_tmp++;
										if (LS8_end_valid) {mode[3] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[4] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[3] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid) {mode[2] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[3] = 0x09; bound_tmp++;}
										}
										else {
											if (LS9_end_valid) {mode[2] = 0x09; bound_tmp++;}
										}
									}
								}
							}

						// LS1: no
						// LS2: yes 
						// LS3: no
						// LS4: no
						} else { 
							if (LS5_end_valid) {mode[1] = 0x05; bound_tmp++;
								if (LS6_end_valid) {mode[2] = 0x06; bound_tmp++;
									if (LS7_end_valid) {mode[3] = 0x07; bound_tmp++;
										if (LS8_end_valid) {mode[4] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[5] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[4] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid) {mode[3] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[4] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[3] = 0x09; bound_tmp++;}
										}
									}
								} else {
									if (LS7_end_valid) {mode[2] = 0x07; bound_tmp++;
										if (LS8_end_valid) {mode[3] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[4] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[3] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid) {mode[2] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[3] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[2] = 0x09; bound_tmp++;}
										}
									}
								}
							} else { // LS5: no
								if (LS6_end_valid) {mode[1] = 0x06; bound_tmp++;
									if (LS7_end_valid) {mode[2] = 0x07; bound_tmp++;
										if (LS8_end_valid) {mode[3] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[4] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[3] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid) {mode[2] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[3] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[2] = 0x09; bound_tmp++;}
										}
									}
								} else {
									if (LS7_end_valid) {mode[1] = 0x07; bound_tmp++;
										if (LS8_end_valid) {mode[2] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[3] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[2] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid) {mode[1] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[2] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[1] = 0x09; bound_tmp++;}
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
					if (LS3_end_valid) {mode[0] = 0x03; bound_tmp++;

						// LS1: no
						// LS2: no 
						// LS3: yes
						// LS4: yes
						if (LS4_end_valid) {mode[1] = 0x04; bound_tmp++;

							if (LS5_end_valid) {mode[2] = 0x05; bound_tmp++;
								if (LS6_end_valid) {mode[3] = 0x06; bound_tmp++;
									if (LS7_end_valid) {mode[4] = 0x07; bound_tmp++;
										if (LS8_end_valid) {mode[5] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[6] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[5] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid) {mode[4] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[5] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[4] = 0x09; bound_tmp++;}
										}
									}
								} else {
									if (LS7_end_valid) {mode[3] = 0x07; bound_tmp++;
										if (LS8_end_valid) {mode[4] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[5] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[4] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid) {mode[3] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[4] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[3] = 0x09; bound_tmp++;}
										}
									}
								}
							} else { // LS5: no
								if (LS6_end_valid) {mode[2] = 0x06; bound_tmp++;
									if (LS7_end_valid) {mode[3] = 0x07; bound_tmp++;
										if (LS8_end_valid) {mode[4] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[5] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[4] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid) {mode[3] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[4] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[3] = 0x09; bound_tmp++;}
										}
									}
								} else {
									if (LS7_end_valid) {mode[2] = 0x07; bound_tmp++;
										if (LS8_end_valid) {mode[3] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[4] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[3] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid) {mode[2] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[3] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[2] = 0x09; bound_tmp++;}
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
							if (LS5_end_valid) {mode[1] = 0x05; bound_tmp++;
								if (LS6_end_valid) {mode[2] = 0x06; bound_tmp++;
									if (LS7_end_valid) {mode[3] = 0x07; bound_tmp++;
										if (LS8_end_valid) {mode[4] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[5] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[4] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid) {mode[3] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[4] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[3] = 0x09; bound_tmp++;}
										}
									}
								} else {
									if (LS7_end_valid) {mode[2] = 0x07; bound_tmp++;
										if (LS8_end_valid) {mode[3] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[4] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[3] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid) {mode[2] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[3] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[2] = 0x09; bound_tmp++;}
										}
									}
								}
							} else { // LS5: no
								if (LS6_end_valid) {mode[1] = 0x06; bound_tmp++;
									if (LS7_end_valid) {mode[2] = 0x07; bound_tmp++;
										if (LS8_end_valid) {mode[3] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[4] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[3] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid) {mode[2] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[3] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[2] = 0x09; bound_tmp++;}
										}
									}
								} else {
									if (LS7_end_valid) {mode[1] = 0x07; bound_tmp++;
										if (LS8_end_valid) {mode[2] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[3] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[2] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid) {mode[1] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[2] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[1] = 0x09; bound_tmp++;}
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
						if (LS4_end_valid) {mode[0] = 0x04; bound_tmp++;

							if (LS5_end_valid) {mode[1] = 0x05; bound_tmp++;
								if (LS6_end_valid) {mode[2] = 0x06; bound_tmp++;
									if (LS7_end_valid) {mode[3] = 0x07; bound_tmp++;
										if (LS8_end_valid) {mode[4] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[5] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[4] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid) {mode[3] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[4] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[3] = 0x09; bound_tmp++;}
										}
									}
								} else {
									if (LS7_end_valid) {mode[2] = 0x07; bound_tmp++;
										if (LS8_end_valid) {mode[3] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[4] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[3] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid) {mode[2] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[3] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[2] = 0x09; bound_tmp++;}
										}
									}
								}
							} else { // LS5: no
								if (LS6_end_valid) {mode[1] = 0x06; bound_tmp++;
									if (LS7_end_valid) {mode[2] = 0x07; bound_tmp++;
										if (LS8_end_valid) {mode[3] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[4] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[3] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid) {mode[2] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[3] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[2] = 0x09; bound_tmp++;}
										}
									}
								} else {
									if (LS7_end_valid) {mode[1] = 0x07; bound_tmp++;
										if (LS8_end_valid) {mode[2] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[3] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[2] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid) {mode[1] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[2] = 0x09; bound_tmp++;}
										}
										else {
											if (LS9_end_valid) {mode[1] = 0x09; bound_tmp++;}
										}
									}
								}
							}

						// LS1: no
						// LS2: no 
						// LS3: no
						// LS4: no
						} else { 
							if (LS5_end_valid) {mode[0] = 0x05; bound_tmp++;
								if (LS6_end_valid) {mode[1] = 0x06; bound_tmp++;
									if (LS7_end_valid) {mode[2] = 0x07; bound_tmp++;
										if (LS8_end_valid) {mode[3] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[4] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[3] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid) {mode[2] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[3] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[2] = 0x09; bound_tmp++;}
										}
									}
								} else {
									if (LS7_end_valid) {mode[1] = 0x07; bound_tmp++;
										if (LS8_end_valid) {mode[2] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[3] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[2] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid) {mode[1] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[2] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[1] = 0x09; bound_tmp++;}
										}
									}
								}
							} else { // LS5: no
								if (LS6_end_valid) {mode[0] = 0x06; bound_tmp++;
									if (LS7_end_valid) {mode[1] = 0x07; bound_tmp++;
										if (LS8_end_valid) {mode[2] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[3] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[2] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid) {mode[1] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[2] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[1] = 0x09; bound_tmp++;}
										}
									}
								} else {
									if (LS7_end_valid) {mode[0] = 0x07; bound_tmp++;
										if (LS8_end_valid) {mode[1] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[2] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[1] = 0x09; bound_tmp++;}
										}
									} else {
										if (LS8_end_valid) {mode[0] = 0x08; bound_tmp++;
											if (LS9_end_valid) {mode[1] = 0x09; bound_tmp++;}
										} else {
											if (LS9_end_valid) {mode[0] = 0x09; bound_tmp++;}
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
#if 0
		char mode_tmp = Off_valid? 0x00: IC_valid? 'I': GG_valid? 'G': mode[j];
		char2 actmode = {active, mode_tmp};
		write_channel_intel(chan_IGL2Conform_actmode, actmode);
#endif
		char mode_tmp = Off_valid? 0x00: IC_valid? 'I': GG_valid? 'G': mode[j];
		write_channel_intel(chan_IGL2Conform_actmode, mode_tmp);

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


