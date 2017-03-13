__kernel
void Krnl_Store(
             //__global const float*           restrict GlobFgrids,
	     //__global       float*           restrict GlobPopulationCurrent,
	     __global       float*           restrict GlobEnergyCurrent,
	     //__global       float*           restrict GlobPopulationNext,
	     __global       float*           restrict GlobEnergyNext
		//,
             //__global       unsigned int*    restrict GlobPRNG,
	     //__global const kernelconstant*  restrict KerConst,
	     //__global const Dockparameters*  restrict DockConst
	     )
{
	// --------------------------------------------------------------
	// Wait for enegies
	// --------------------------------------------------------------
	float InterE;
	float IntraE;

	char active = 1;
	char mode   = 0;
	uint cnt    = 0;  

 	char active1, active2;
	char mode1, mode2;
	uint cnt1, cnt2;

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
	
	if (active1 != active2) {printf("Store error: active are not equal!\n");}
	else 			{active = active1;}

	if (mode1 != mode2)     {printf("Store error: mode are not equal!\n");}
	else 			{mode = mode1;}

	if (cnt1  != cnt2)      {printf("Store error: mode are not equal!\n");}
	else 			{cnt = cnt1;}

	if (active == 0) {printf("	%-20s: %s\n", "Krnl_Store", "disabled");}

	switch (mode) {
///*
		case 0:	write_channel_altera(chan_Store2GA_ack, 1);	// Signal INI, GG or LS finished 
		break;
		case 1:	GlobEnergyCurrent[cnt] = InterE + IntraE;	// INI: Init energy calculation of pop
		break;
		case 2:	GlobEnergyNext[cnt] = InterE + IntraE;		// GG: Genetic Generation
		break;
		case 3:	LSenergy = InterE + IntraE;		// LS: Local Search
			write_channel_altera(chan_Store2GA_ack, 1);
			mem_fence(CLK_CHANNEL_MEM_FENCE);
			write_channel_altera(chan_Store2GA_LSenergy, LSenergy);
		break;
//*/


		case 4:							// Krnl_GA has finished execution!
		break;
	}

} // End of while(1)

}
// --------------------------------------------------------------------------
// --------------------------------------------------------------------------
