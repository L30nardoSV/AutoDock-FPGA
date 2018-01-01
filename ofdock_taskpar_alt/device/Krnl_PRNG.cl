channel bool chan_Arbiter_BT_ushort_active;
channel bool chan_Arbiter_BT_float_active;

channel bool chan_Arbiter_GG_uchar_active;
channel bool chan_Arbiter_GG_float_active;

channel bool chan_Arbiter_LS_ushort_active;
channel bool chan_Arbiter_LS2_ushort_active;
channel bool chan_Arbiter_LS3_ushort_active;

channel bool chan_Arbiter_LS_float_active;
channel bool chan_Arbiter_LS2_float_active;
channel bool chan_Arbiter_LS3_float_active;

// --------------------------------------------------------------------------
// --------------------------------------------------------------------------
#if 0
__kernel __attribute__ ((max_global_work_dim(0)))
void Krnl_Prng_Arbiter(){

	bool active = true;

	while(active) {
		bool BT_valid        = false;
		bool GG_valid  	     = false;
		bool LS_ushort_valid = false;
		bool LS_float_valid  = false;
		bool LS2_float_valid = false;
		bool LS3_float_valid = false;
		bool Off_valid       = false;	

		bool BT_active;
		bool GG_active;
		bool LS_ushort_active;
		bool LS_float_active;
		bool LS2_float_active;
		bool LS3_float_active;
		bool Off_active;

		while(
		      (BT_valid        == false) &&
		      (GG_valid        == false) &&
		      (LS_ushort_valid == false) &&
		      (LS_float_valid  == false) &&
		      (LS2_float_valid == false) &&
		      (LS3_float_valid == false) &&
		      (Off_valid       == false) 
		){
			BT_active        = read_channel_nb_altera(chan_GA2PRNG_BT_active,         &BT_valid);
			GG_active        = read_channel_nb_altera(chan_GA2PRNG_GG_active,         &GG_valid);
			LS_ushort_active = read_channel_nb_altera(chan_GA2PRNG_LS_ushort_active,  &LS_ushort_valid);
			LS_float_active  = read_channel_nb_altera(chan_GA2PRNG_LS_float_active,   &LS_float_valid);
			LS2_float_active = read_channel_nb_altera(chan_GA2PRNG_LS2_float_active,  &LS2_float_valid);
			LS3_float_active = read_channel_nb_altera(chan_GA2PRNG_LS3_float_active,  &LS3_float_valid);
			Off_active       = read_channel_nb_altera(chan_GA2PRNG_Off_active,        &Off_valid);
		}

		active = (Off_valid) ? Off_active : true;
	
		if ((BT_valid == true) || (Off_valid == true)) {
			write_channel_altera(chan_Arbiter_BT_ushort_active, active);
			write_channel_altera(chan_Arbiter_BT_float_active,  active);
		}

		if ((GG_valid == true) || (Off_valid == true)) {
			write_channel_altera(chan_Arbiter_GG_uchar_active, active);
			write_channel_altera(chan_Arbiter_GG_float_active, active);
		}

 		if ((LS_ushort_valid == true) || (Off_valid == true)) {
			write_channel_altera(chan_Arbiter_LS_ushort_active,  active);
			write_channel_altera(chan_Arbiter_LS2_ushort_active, active);
			write_channel_altera(chan_Arbiter_LS3_ushort_active, active);
		}

		if ((LS_float_valid == true) || (Off_valid == true)) {
			write_channel_altera(chan_Arbiter_LS_float_active, active);
		}

		if ((LS2_float_valid == true) || (Off_valid == true)) {
			write_channel_altera(chan_Arbiter_LS2_float_active, active);
		}

		if ((LS3_float_valid == true) || (Off_valid == true)) {	
			write_channel_altera(chan_Arbiter_LS3_float_active, active);
		}

	} // End of while(active)
}
#endif
// --------------------------------------------------------------------------
// --------------------------------------------------------------------------

__kernel __attribute__ ((max_global_work_dim(0)))
void Krnl_Prng_BT_Arbiter(){
	bool active = true;
	
	while(active) {
		bool BT_valid  = false;
		bool Off_valid = false;
		bool BT_active;
		bool Off_active;

		while( (BT_valid == false) && (Off_valid == false) ){
			BT_active  = read_channel_nb_altera(chan_GA2PRNG_BT_active, &BT_valid);
			Off_active = read_channel_nb_altera(chan_GA2PRNG_BT_Off,    &Off_valid);
		}

		active = (Off_valid) ? Off_active : true;
	
		if ((BT_valid == true) || (Off_valid == true)) {
			write_channel_altera(chan_Arbiter_BT_ushort_active, active);
			write_channel_altera(chan_Arbiter_BT_float_active,  active);
		}
	} // End of while(active)
}

__kernel __attribute__ ((max_global_work_dim(0)))
void Krnl_Prng_GG_Arbiter(){
	bool active = true;
	
	while(active) {
		bool GG_valid  = false;
		bool Off_valid = false;
		bool GG_active;
		bool Off_active;

		while( (GG_valid == false) && (Off_valid == false) ){
			GG_active  = read_channel_nb_altera(chan_GA2PRNG_GG_active, &GG_valid);
			Off_active = read_channel_nb_altera(chan_GA2PRNG_GG_Off,    &Off_valid);
		}

		active = (Off_valid) ? Off_active : true;
	
		if ((GG_valid == true) || (Off_valid == true)) {
			write_channel_altera(chan_Arbiter_GG_uchar_active, active);
			write_channel_altera(chan_Arbiter_GG_float_active, active);
		}
	} // End of while(active)
}

__kernel __attribute__ ((max_global_work_dim(0)))
void Krnl_Prng_LS_ushort_Arbiter(){

	bool active = true;

	while(active) {
		bool LS_ushort_valid = false;
		bool Off_valid       = false;	
		bool LS_ushort_active;
		bool Off_active;

		while( (LS_ushort_valid == false) && (Off_valid == false) ){
			LS_ushort_active = read_channel_nb_altera(chan_GA2PRNG_LS_ushort_active,  &LS_ushort_valid);
			Off_active       = read_channel_nb_altera(chan_GA2PRNG_LS_ushort_Off,     &Off_valid);
		}

		active = (Off_valid) ? Off_active : true;
	
 		if ((LS_ushort_valid == true) || (Off_valid == true)) {
			write_channel_altera(chan_Arbiter_LS_ushort_active,  active);
			write_channel_altera(chan_Arbiter_LS2_ushort_active, active);
			write_channel_altera(chan_Arbiter_LS3_ushort_active, active);
		}
	} // End of while(active)
}

__kernel __attribute__ ((max_global_work_dim(0)))
void Krnl_Prng_LS_float_Arbiter(){

	bool active = true;

	while(active) {
		bool LS_float_valid  = false;
		bool LS2_float_valid = false;
		bool LS3_float_valid = false;
		bool Off_valid       = false;	

		bool LS_float_active;
		bool LS2_float_active;
		bool LS3_float_active;
		bool Off_active;

		while(
		      (LS_float_valid  == false) &&
		      (LS2_float_valid == false) &&
		      (LS3_float_valid == false) &&
		      (Off_valid       == false) 
		){
			LS_float_active  = read_channel_nb_altera(chan_GA2PRNG_LS_float_active,   &LS_float_valid);
			LS2_float_active = read_channel_nb_altera(chan_GA2PRNG_LS2_float_active,  &LS2_float_valid);
			LS3_float_active = read_channel_nb_altera(chan_GA2PRNG_LS3_float_active,  &LS3_float_valid);
			Off_active       = read_channel_nb_altera(chan_GA2PRNG_LS_float_Off,      &Off_valid);
		}

		active = (Off_valid) ? Off_active : true;
	
		if ((LS_float_valid == true) || (Off_valid == true)) {
			write_channel_altera(chan_Arbiter_LS_float_active, active);
		}

		if ((LS2_float_valid == true) || (Off_valid == true)) {
			write_channel_altera(chan_Arbiter_LS2_float_active, active);
		}

		if ((LS3_float_valid == true) || (Off_valid == true)) {	
			write_channel_altera(chan_Arbiter_LS3_float_active, active);
		}
	} // End of while(active)
}




// --------------------------------------------------------------------------
// --------------------------------------------------------------------------

__kernel __attribute__ ((max_global_work_dim(0)))
void Krnl_Prng_BT_ushort(unsigned int Host_seed, 
		         unsigned int DockConst_pop_size){

	uint lfsr = Host_seed;
	bool active = true;

	while(active) {
		active  = read_channel_altera(chan_Arbiter_BT_ushort_active);

		for(uchar i=0; i<4; i++) {
			ushort tmp;
			uchar lsb;
			lsb = lfsr & 0x01u;
			lfsr >>= 1;
			lfsr ^= (-lsb) & 0xA3000000u;
			tmp = (lfsr/MAX_UINT)*DockConst_pop_size;

			if(active) {
				write_channel_altera(chan_PRNG2GA_BT_ushort_prng, tmp);
			}
		}
	} // End of while(active)
}

__kernel __attribute__ ((max_global_work_dim(0)))
void Krnl_Prng_BT_float(unsigned int Host_seed){

	uint lfsr = Host_seed;
	bool active = true;

	while(active) {
		active = read_channel_altera(chan_Arbiter_BT_float_active);

		for(uchar i=0; i<4; i++) {
			float tmp;	
			uchar lsb;
			lsb = lfsr & 0x01u;
			lfsr >>= 1;
			lfsr ^= (-lsb) & 0xA3000000u;
			tmp = (0.999999f/MAX_UINT)*lfsr;

			if(active) {
				write_channel_altera(chan_PRNG2GA_BT_float_prng, tmp);
			}
		}
	} // End of while(active)
}

// --------------------------------------------------------------------------
// --------------------------------------------------------------------------

__kernel __attribute__ ((max_global_work_dim(0)))
void Krnl_Prng_GG_uchar(unsigned int  Host_seed, 
		        unsigned char DockConst_num_of_genes){

	uint lfsr = Host_seed;
	bool active = true;

	while(active) {
		active = read_channel_altera(chan_Arbiter_GG_uchar_active);

		for(uchar i=0; i<2; i++) {
			uchar tmp;
			uchar lsb;
			lsb = lfsr & 0x01u;
			lfsr >>= 1;
			lfsr ^= (-lsb) & 0xA3000000u;
			tmp = (lfsr/MAX_UINT)*DockConst_num_of_genes;

			if(active) {
				write_channel_altera(chan_PRNG2GA_GG_uchar_prng, tmp);
			}
		}
	} // End of while(active)
}

__kernel __attribute__ ((max_global_work_dim(0)))
void Krnl_Prng_GG_float(unsigned int  Host_seed,
		        unsigned char DockConst_num_of_genes){

	uint lfsr = Host_seed;
	bool active = true;

	while(active) {
		active = read_channel_altera(chan_Arbiter_GG_float_active);

		for(uchar i=0; i<DockConst_num_of_genes; i++) {
			float tmp;
			uchar lsb;
			lsb = lfsr & 0x01u;
			lfsr >>= 1;
			lfsr ^= (-lsb) & 0xA3000000u;
			tmp = (0.999999f/MAX_UINT)*lfsr;

			if(active) {
				write_channel_altera(chan_PRNG2GA_GG_float_prng, tmp);
			}
		}
	} // End of while(active)
}

// --------------------------------------------------------------------------
// --------------------------------------------------------------------------
__kernel __attribute__ ((max_global_work_dim(0)))
void Krnl_Prng_LS_ushort(unsigned int Host_seed, 
		         unsigned int DockConst_pop_size){

	uint lfsr = Host_seed;
	bool active = true;

	while(active) {
		active  = read_channel_altera(chan_Arbiter_LS_ushort_active);
		ushort tmp;
		uchar lsb;
		lsb = lfsr & 0x01u;
		lfsr >>= 1;
		lfsr ^= (-lsb) & 0xA3000000u;
		tmp = (DockConst_pop_size/MAX_UINT)*lfsr;

		if(active) {
			write_channel_altera(chan_PRNG2GA_LS_ushort_prng, tmp);
		}
	} // End of while(active)
}

__kernel __attribute__ ((max_global_work_dim(0)))
void Krnl_Prng_LS2_ushort(unsigned int Host_seed, 
		          unsigned int DockConst_pop_size){

	uint lfsr = Host_seed;
	bool active = true;

	while(active) {
		active  = read_channel_altera(chan_Arbiter_LS2_ushort_active);

		ushort tmp;
		uchar lsb;
		lsb = lfsr & 0x01u;
		lfsr >>= 1;
		lfsr ^= (-lsb) & 0xA3000000u;
		tmp = (DockConst_pop_size/MAX_UINT)*lfsr;

		if(active) {
			write_channel_altera(chan_PRNG2GA_LS2_ushort_prng, tmp);
		}
	} // End of while(active)
}

__kernel __attribute__ ((max_global_work_dim(0)))
void Krnl_Prng_LS3_ushort(unsigned int Host_seed, 
		          unsigned int DockConst_pop_size){

	uint lfsr = Host_seed;
	bool active = true;

	while(active) {
		active  = read_channel_altera(chan_Arbiter_LS3_ushort_active);

		ushort tmp;
		uchar lsb;
		lsb = lfsr & 0x01u;
		lfsr >>= 1;
		lfsr ^= (-lsb) & 0xA3000000u;
		tmp = (DockConst_pop_size/MAX_UINT)*lfsr;

		if(active) {
			write_channel_altera(chan_PRNG2GA_LS3_ushort_prng, tmp);
		}
	} // End of while(active)
}

// --------------------------------------------------------------------------
// --------------------------------------------------------------------------

__kernel __attribute__ ((max_global_work_dim(0)))
void Krnl_Prng_LS_float(unsigned int  Host_seed,
		        unsigned char DockConst_num_of_genes){

	uint lfsr = Host_seed;
	bool active = true;

	while(active) {
		active  = read_channel_altera(chan_Arbiter_LS_float_active);
	
		for(uchar i=0; i<DockConst_num_of_genes; i++) {
			float tmp;
			uchar lsb;
			lsb = lfsr & 0x01u;
			lfsr >>= 1;
			lfsr ^= (-lsb) & 0xA3000000u;
			tmp = (0.999999f/MAX_UINT)*lfsr;
	
			if(active) {
				write_channel_altera(chan_PRNG2GA_LS_float_prng, tmp);
			}
		}
	} // End of while(active)
}

__kernel __attribute__ ((max_global_work_dim(0)))
void Krnl_Prng_LS2_float(unsigned int  Host_seed,
			 unsigned char DockConst_num_of_genes){

	uint lfsr = Host_seed;
	bool active = true;

	while(active) {
		active  = read_channel_altera(chan_Arbiter_LS2_float_active);
	
		for(uchar i=0; i<DockConst_num_of_genes; i++) {
			float tmp;
			uchar lsb;
			lsb = lfsr & 0x01u;
			lfsr >>= 1;
			lfsr ^= (-lsb) & 0xA3000000u;
			tmp = (0.999999f/MAX_UINT)*lfsr;
	
			if(active) {
				write_channel_altera(chan_PRNG2GA_LS2_float_prng, tmp);
			}
		}
	} // End of while(active)
}

__kernel __attribute__ ((max_global_work_dim(0)))
void Krnl_Prng_LS3_float(unsigned int  Host_seed,
			 unsigned char DockConst_num_of_genes){

	uint lfsr = Host_seed;
	bool active = true;

	while(active) {
		active  = read_channel_altera(chan_Arbiter_LS3_float_active);
	
		for(uchar i=0; i<DockConst_num_of_genes; i++) {
			float tmp;
			uchar lsb;
			lsb = lfsr & 0x01u;
			lfsr >>= 1;
			lfsr ^= (-lsb) & 0xA3000000u;
			tmp = (0.999999f/MAX_UINT)*lfsr;
	
			if(active) {
				write_channel_altera(chan_PRNG2GA_LS3_float_prng, tmp);
			}
		}
	} // End of while(active)
}
// --------------------------------------------------------------------------
// --------------------------------------------------------------------------     
