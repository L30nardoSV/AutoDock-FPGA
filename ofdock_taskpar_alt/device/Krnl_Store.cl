__kernel __attribute__ ((max_global_work_dim(0)))
void Krnl_Store(
	     __global       float*           restrict GlobEnergyCurrent,
	     __global       float*           restrict GlobEnergyNext,
	     __constant     Dockparameters*  restrict DockConst
)
{
	// --------------------------------------------------------------
	// Wait for enegies
	// --------------------------------------------------------------
	float InterE;
	float IntraE;

	char active = 1;
	char mode   = 0;
	ushort cnt  = 0; 

 	char   active1, active2;
	char   mode1, mode2;
	ushort cnt1, cnt2;
	float LSenergy;

while(active) {
	InterE = read_channel_altera(chan_Intere2Store_intere);
	IntraE = read_channel_altera(chan_Intrae2Store_intrae);
	mem_fence(CLK_CHANNEL_MEM_FENCE);
	active1 = read_channel_altera(chan_Intere2Store_active);
	active2 = read_channel_altera(chan_Intrae2Store_active);
	mem_fence(CLK_CHANNEL_MEM_FENCE);
	mode1 = read_channel_altera(chan_Intere2Store_mode);
	mode2 = read_channel_altera(chan_Intrae2Store_mode);
	mem_fence(CLK_CHANNEL_MEM_FENCE);
	cnt1  = read_channel_altera(chan_Intere2Store_cnt);
	cnt2  = read_channel_altera(chan_Intrae2Store_cnt);

	// --------------------------------------------------------------
	
	if (active1 != active2) {
		#if defined (DEBUG_KRNL_STORE)
		printf("Store error: active are not equal!\n");
		#endif
	}
	else 			{
		active = active1;
	}

	if (mode1 != mode2)     {
		#if defined (DEBUG_KRNL_STORE)
		printf("Store error: mode are not equal!\n");
		#endif
	}
	else 			{
		mode = mode1;}

	if (cnt1  != cnt2)      {
		#if defined (DEBUG_KRNL_STORE)
		printf("Store error: mode are not equal!\n");
		#endif
	}
	else 			{
		cnt = cnt1;}

	#if defined (DEBUG_ACTIVE_KERNEL)
	if (active == 0) {printf("	%-20s: %s\n", "Krnl_Store", "must be disabled");}
	#endif
	
	switch (mode) {
		case 1:	// IC
			GlobEnergyCurrent[cnt] = InterE + IntraE;
			if (cnt == (DockConst->pop_size)-1) {
				write_channel_altera(chan_Store2IC_ack, 1);
			}
		break;

		case 2: // GG
			GlobEnergyNext[cnt] = InterE + IntraE;
			if ((cnt == (DockConst->pop_size)-1) || (active == 0)) {	
				write_channel_altera(chan_Store2GG_ack, 1);
			}
		break;

		case 3: // LS
			LSenergy = InterE + IntraE;
			write_channel_altera(chan_Store2LS_LSenergy, LSenergy);
		break;
	}

} // End of while(1)

#if defined (DEBUG_ACTIVE_KERNEL)
printf("	%-20s: %s\n", "Krnl_Store", "disabled");
#endif

}
// --------------------------------------------------------------------------
// --------------------------------------------------------------------------
