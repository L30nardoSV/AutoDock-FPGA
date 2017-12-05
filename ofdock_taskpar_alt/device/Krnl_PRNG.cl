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
__kernel __attribute__ ((max_global_work_dim(0)))
void Krnl_Prng_Arbiter(){

	bool active = true;

while(active) {
/*
	bool BT_ushort_valid = false;
	bool BT_float_valid  = false;
*/
	bool BT_valid = false;

/*
	bool GG_uchar_valid  = false;
	bool GG_float_valid  = false;
*/
	bool GG_valid  = false;

	bool LS_ushort_valid = false;
	bool LS_float_valid  = false;
	bool LS2_float_valid  = false;
	bool LS3_float_valid  = false;
	bool Off_valid       = false;	

/*
	bool BT_ushort_active;
	bool BT_float_active;
*/
	bool BT_active;

/*
	bool GG_uchar_active;
	bool GG_float_active;
*/
	bool GG_active;

	bool LS_ushort_active;
	bool LS_float_active;
	bool LS2_float_active;
	bool LS3_float_active;
	bool Off_active;

	while(
/*
	      (BT_ushort_valid == false) &&
	      (BT_float_valid  == false) &&
*/
	      (BT_valid == false) &&
	
/*
	      (GG_uchar_valid  == false) &&
	      (GG_float_valid  == false) &&
*/
	      (GG_valid  == false) &&

	      (LS_ushort_valid == false) &&
	      (LS_float_valid  == false) &&
	      (LS2_float_valid == false) &&
	      (LS3_float_valid == false) &&
	      (Off_valid       == false) 
	){
/*
		BT_ushort_active = read_channel_nb_altera(chan_GA2PRNG_BT_ushort_active,  &BT_ushort_valid);
		BT_float_active  = read_channel_nb_altera(chan_GA2PRNG_BT_float_active,   &BT_float_valid);
*/
		BT_active = read_channel_nb_altera(chan_GA2PRNG_BT_active,  &BT_valid);

/*
		GG_uchar_active  = read_channel_nb_altera(chan_GA2PRNG_GG_uchar_active,   &GG_uchar_valid);
		GG_float_active  = read_channel_nb_altera(chan_GA2PRNG_GG_float_active,   &GG_float_valid);
*/
		GG_active  = read_channel_nb_altera(chan_GA2PRNG_GG_active,   &GG_valid);

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
		write_channel_altera(chan_Arbiter_LS_ushort_active, active);
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

// --------------------------------------------------------------------------
// --------------------------------------------------------------------------

__kernel __attribute__ ((max_global_work_dim(0)))
void Krnl_Prng_BT_ushort(const unsigned int seed, 
		         const unsigned int pop_size){

	uint lfsr = seed;
	bool active = true;

while(active) {
	//active  = read_channel_altera(chan_GA2PRNG_BT_ushort_active);
	active  = read_channel_altera(chan_Arbiter_BT_ushort_active);

	for(uchar i=0; i<4; i++) {
		ushort tmp;
		uchar lsb;
		lsb = lfsr & 0x01u;
		lfsr >>= 1;
		lfsr ^= (-lsb) & 0xA3000000u;
		tmp = (lfsr/MAX_UINT)*pop_size;

		if(active) {
			write_channel_altera(chan_PRNG2GA_BT_ushort_prng, tmp);
		}
	}
} // End of while(active)

}

__kernel __attribute__ ((max_global_work_dim(0)))
void Krnl_Prng_BT_float(const unsigned int seed){

	uint lfsr = seed;
	bool active = true;

while(active) {
	//active = read_channel_altera(chan_GA2PRNG_BT_float_active);
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
void Krnl_Prng_GG_uchar(const unsigned int seed, 
		        const unsigned int num_genes){

	uint lfsr = seed;
	bool active = true;

while(active) {
	//active = read_channel_altera(chan_GA2PRNG_GG_uchar_active);
	active = read_channel_altera(chan_Arbiter_GG_uchar_active);

	for(uchar i=0; i<2; i++) {
		uchar tmp;
		uchar lsb;
		lsb = lfsr & 0x01u;
		lfsr >>= 1;
		lfsr ^= (-lsb) & 0xA3000000u;
		tmp = (lfsr/MAX_UINT)*num_genes;

		if(active) {
			write_channel_altera(chan_PRNG2GA_GG_uchar_prng, tmp);
		}
	}
} // End of while(active)

}

__kernel __attribute__ ((max_global_work_dim(0)))
void Krnl_Prng_GG_float(const unsigned int seed,
		        const unsigned int num_genes){

	uint lfsr = seed;
	bool active = true;

while(active) {
	//active = read_channel_altera(chan_GA2PRNG_GG_float_active);
	active = read_channel_altera(chan_Arbiter_GG_float_active);

	for(uchar i=0; i<num_genes; i++) {
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
void Krnl_Prng_LS_ushort(const unsigned int seed, 
		         const unsigned int pop_size
/*
			 ,
			 const unsigned int num_of_lsentities
*/
			 ){

	uint lfsr = seed;
	bool active = true;

while(active) {
	//active  = read_channel_altera(chan_GA2PRNG_LS_ushort_active);
	active  = read_channel_altera(chan_Arbiter_LS_ushort_active);

	// num_of_lsentities is uint but it is often 6% of 300 ~ < 20 entities
	// so indexing with uchar is enough
/*	
	for(uchar i=0; i<num_of_lsentities; i++) {
*/
		ushort tmp;
		uchar lsb;
		lsb = lfsr & 0x01u;
		lfsr >>= 1;
		lfsr ^= (-lsb) & 0xA3000000u;
		tmp = (pop_size/MAX_UINT)*lfsr;

		if(active) {
			write_channel_altera(chan_PRNG2GA_LS_ushort_prng, tmp);
		}
/*
	}
*/
} // End of while(active)

}

__kernel __attribute__ ((max_global_work_dim(0)))
void Krnl_Prng_LS2_ushort(const unsigned int seed, 
		          const unsigned int pop_size
			 ){

	uint lfsr = seed;
	bool active = true;

	while(active) {
		active  = read_channel_altera(chan_Arbiter_LS2_ushort_active);

		ushort tmp;
		uchar lsb;
		lsb = lfsr & 0x01u;
		lfsr >>= 1;
		lfsr ^= (-lsb) & 0xA3000000u;
		tmp = (pop_size/MAX_UINT)*lfsr;

		if(active) {
			write_channel_altera(chan_PRNG2GA_LS2_ushort_prng, tmp);
		}
	} // End of while(active)
}

__kernel __attribute__ ((max_global_work_dim(0)))
void Krnl_Prng_LS3_ushort(const unsigned int seed, 
		          const unsigned int pop_size
			 ){

	uint lfsr = seed;
	bool active = true;

	while(active) {
		active  = read_channel_altera(chan_Arbiter_LS3_ushort_active);

		ushort tmp;
		uchar lsb;
		lsb = lfsr & 0x01u;
		lfsr >>= 1;
		lfsr ^= (-lsb) & 0xA3000000u;
		tmp = (pop_size/MAX_UINT)*lfsr;

		if(active) {
			write_channel_altera(chan_PRNG2GA_LS3_ushort_prng, tmp);
		}
	} // End of while(active)
}

// --------------------------------------------------------------------------
// --------------------------------------------------------------------------

__kernel __attribute__ ((max_global_work_dim(0)))
void Krnl_Prng_LS_float(const unsigned int seed,
		        const unsigned int num_genes
			){

	uint lfsr = seed;
	bool active = true;

while(active) {
	//active  = read_channel_altera(chan_GA2PRNG_LS_float_active);
	active  = read_channel_altera(chan_Arbiter_LS_float_active);
	
	for(uchar i=0; i<num_genes; i++) {
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
void Krnl_Prng_LS2_float(const unsigned int seed,
			 const unsigned int num_genes
			){

	uint lfsr = seed;
	bool active = true;

while(active) {
	//active  = read_channel_altera(chan_GA2PRNG_LS_float_active);
	active  = read_channel_altera(chan_Arbiter_LS2_float_active);
	
	for(uchar i=0; i<num_genes; i++) {
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
void Krnl_Prng_LS3_float(const unsigned int seed,
			 const unsigned int num_genes
			){

	uint lfsr = seed;
	bool active = true;

while(active) {
	//active  = read_channel_altera(chan_GA2PRNG_LS_float_active);
	active  = read_channel_altera(chan_Arbiter_LS3_float_active);
	
	for(uchar i=0; i<num_genes; i++) {
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
