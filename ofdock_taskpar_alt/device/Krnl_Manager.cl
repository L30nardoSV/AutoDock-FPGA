__kernel
void Krnl_Manager(
             __global const float*           restrict GlobFgrids,
	     __global       float*           restrict GlobPopulationCurrent,
	     __global       float*           restrict GlobEnergyCurrent,
	     __global       float*           restrict GlobPopulationNext,
	     __global       float*           restrict GlobEnergyNext,
             __global       unsigned int*    restrict GlobPRNG,
	     __global const kernelconstant*  restrict KerConst,
	     __global const Dockparameters*  restrict DockConst)
{
	// --------------------------------------------------------------
	// Wait for enegies
	// --------------------------------------------------------------
	float InterE;
	float IntraE;
	char mode;
	uint cnt;

while(1) {
	mode = read_channel_altera(chan_GA2Manager_mode);
	cnt  = read_channel_altera(chan_GA2Manager_cnt);
	InterE = read_channel_altera(chan_Intere2Manager_intere);
	IntraE = read_channel_altera(chan_Intrae2Manager_intrae);

	// --------------------------------------------------------------


	switch (mode) {
		case 1:	GlobEnergyCurrent[cnt] = InterE + IntraE;
		break;
		case 2:	GlobEnergyCurrent[cnt] = InterE + IntraE;
		break;
		case 3:	GlobEnergyNext[cnt] = InterE + IntraE;
		break;
		default:
		break;
	}

} // End of while(1)

}
// --------------------------------------------------------------------------
// --------------------------------------------------------------------------