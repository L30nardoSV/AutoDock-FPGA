// --------------------------------------------------------------------------
// --------------------------------------------------------------------------

__kernel __attribute__ ((max_global_work_dim(0)))
void Krnl_Prng_BT_ushort_float(unsigned int Host_seed1,
			       unsigned int Host_seed2,
			       unsigned int DockConst_pop_size){

	uint2 lfsr;
	lfsr.x = Host_seed1;
	lfsr.y = Host_seed2;

	bool valid  = false;
	
	while(!valid) {	
		bool active = true;
		active = read_channel_nb_altera(chan_Arbiter_BT_ushort_float_off, &valid);

		uint   u_tmp[4]; // used as short in GA
		float  f_tmp[4];	

		#pragma unroll
		for(uchar i=0; i<4; i++) {
			uchar2 lsb;

			lsb.x = lfsr.x & 0x01u;
			lsb.y = lfsr.y & 0x01u;

			lfsr.x >>= 1;
			lfsr.y >>= 1;

			lfsr.x ^= (-lsb.x) & 0xA3000000u;
			lfsr.y ^= (-lsb.y) & 0xA3000000u;

			u_tmp[i] = (lfsr.x/MAX_UINT)*DockConst_pop_size;
			f_tmp[i] = (0.999999f/MAX_UINT)*lfsr.y;
		}

		bool success = false;
		if(!valid) {
			float8 tmp = {*(float*)&u_tmp[0], f_tmp[0],
				      *(float*)&u_tmp[1], f_tmp[1],
				      *(float*)&u_tmp[2], f_tmp[2],
				      *(float*)&u_tmp[3], f_tmp[3]};
			success = write_channel_nb_altera(chan_PRNG2GA_BT_ushort_float_prng, tmp);
		}
	} // End of while(!valid)
}

// --------------------------------------------------------------------------
// --------------------------------------------------------------------------

__kernel __attribute__ ((max_global_work_dim(0)))
void Krnl_Prng_GG_uchar(unsigned int  Host_seed, 
		        unsigned char DockConst_num_of_genes){

	uint lfsr = Host_seed;
	bool valid = false;

	while(!valid) {
		bool active = true;
		active = read_channel_nb_altera(chan_Arbiter_GG_uchar_off, &valid);
		
		uchar tmp[2];

		#pragma unroll
		for(uchar i=0; i<2; i++) {
			uchar lsb;
			lsb = lfsr & 0x01u;
			lfsr >>= 1;
			lfsr ^= (-lsb) & 0xA3000000u;
			tmp[i] = (lfsr/MAX_UINT)*DockConst_num_of_genes;

		}

		bool success = false;
		uchar2 utmp;
		utmp.x = tmp[0];
		utmp.y = tmp[1];

		if(!valid) {
			success = write_channel_nb_altera(chan_PRNG2GA_GG_uchar_prng, utmp);
		}
	} // End of while(active)
}

__kernel __attribute__ ((max_global_work_dim(0)))
void Krnl_Prng_GG_float(unsigned int  Host_seed,
		        unsigned char DockConst_num_of_genes){

	uint lfsr = Host_seed;
	bool valid = false;

	while(!valid) {
		bool active = true;
		active = read_channel_nb_altera(chan_Arbiter_GG_float_off, &valid);

		for(uchar i=0; i<DockConst_num_of_genes; i++) {
			float tmp;
			uchar lsb;
			lsb = lfsr & 0x01u;
			lfsr >>= 1;
			lfsr ^= (-lsb) & 0xA3000000u;
			tmp = (0.999999f/MAX_UINT)*lfsr;

			bool success = false;
			if(!valid) {
				success = write_channel_nb_altera(chan_PRNG2GA_GG_float_prng, tmp);
			}
		}
	} // End of while(active)
}

// --------------------------------------------------------------------------
// --------------------------------------------------------------------------

__kernel __attribute__ ((max_global_work_dim(0)))
void Krnl_Prng_LS123_ushort(unsigned int Host_seed1,
			    unsigned int Host_seed2, 
			    unsigned int Host_seed3, 
		            unsigned int DockConst_pop_size){

	uint3 lfsr;
 	lfsr.x = Host_seed1;
	lfsr.y = Host_seed2;
	lfsr.z = Host_seed3;

	bool valid = false;

	while(!valid) {
		bool active = true;
		active  = read_channel_nb_altera(chan_Arbiter_LS123_ushort_off, &valid);

		ushort3 tmp;
		uchar3 lsb;
	
		lsb.x = lfsr.x & 0x01u;
		lsb.y = lfsr.y & 0x01u;
		lsb.z = lfsr.z & 0x01u;

		lfsr.x >>= 1;
		lfsr.y >>= 1;
		lfsr.z >>= 1;

		lfsr.x ^= (-lsb.x) & 0xA3000000u;
		lfsr.y ^= (-lsb.y) & 0xA3000000u;
		lfsr.z ^= (-lsb.z) & 0xA3000000u;

		tmp.x = (DockConst_pop_size/MAX_UINT)*lfsr.x;
		tmp.y = (DockConst_pop_size/MAX_UINT)*lfsr.y;
		tmp.z = (DockConst_pop_size/MAX_UINT)*lfsr.z;

		bool success = false;
		if(!valid) {
			success = write_channel_nb_altera(chan_PRNG2GA_LS123_ushort_prng, tmp);
		}
	} // End of while(active)
}

// --------------------------------------------------------------------------
// --------------------------------------------------------------------------

__kernel __attribute__ ((max_global_work_dim(0)))
void Krnl_Prng_LS_float(unsigned int  Host_seed,
		        unsigned char DockConst_num_of_genes){

	uint lfsr = Host_seed;
	bool valid = false;

	while(!valid) {
		bool active = true;
		active  = read_channel_nb_altera(chan_Arbiter_LS_float_off, &valid);
	
		for(uchar i=0; i<DockConst_num_of_genes; i++) {
			float tmp;
			uchar lsb;
			lsb = lfsr & 0x01u;
			lfsr >>= 1;
			lfsr ^= (-lsb) & 0xA3000000u;
			tmp = (0.999999f/MAX_UINT)*lfsr;
			bool success = false;

			#if defined (FIXED_POINT_LS1)
			fixedpt fixpt_tmp = fixedpt_fromfloat(tmp);
			if(!valid) {
				success = write_channel_nb_altera(chan_PRNG2GA_LS_float_prng, *(float*) &fixpt_tmp);
			}
			#else
			if(!valid) {
				success = write_channel_nb_altera(chan_PRNG2GA_LS_float_prng, tmp);
			}
			#endif
		}
	} // End of while(active)
}

__kernel __attribute__ ((max_global_work_dim(0)))
void Krnl_Prng_LS2_float(unsigned int  Host_seed,
			 unsigned char DockConst_num_of_genes){

	uint lfsr = Host_seed;
	bool valid = false;

	while(!valid) {
		bool active = true;
		active  = read_channel_nb_altera(chan_Arbiter_LS2_float_off, &valid);
	
		for(uchar i=0; i<DockConst_num_of_genes; i++) {
			float tmp;
			uchar lsb;
			lsb = lfsr & 0x01u;
			lfsr >>= 1;
			lfsr ^= (-lsb) & 0xA3000000u;
			tmp = (0.999999f/MAX_UINT)*lfsr;
			bool success = false;

			#if defined (FIXED_POINT_LS2)
			fixedpt fixpt_tmp = fixedpt_fromfloat(tmp);
			if(!valid) {
				success = write_channel_nb_altera(chan_PRNG2GA_LS2_float_prng, *(float*) &fixpt_tmp);
			}
			#else
			if(!valid) {
				success = write_channel_nb_altera(chan_PRNG2GA_LS2_float_prng, tmp);
			}
			#endif
		}
	} // End of while(active)
}

__kernel __attribute__ ((max_global_work_dim(0)))
void Krnl_Prng_LS3_float(unsigned int  Host_seed,
			 unsigned char DockConst_num_of_genes){

	uint lfsr = Host_seed;
	bool valid = false;

	while(!valid) {
		bool active = true;
		active  = read_channel_nb_altera(chan_Arbiter_LS3_float_off, &valid);
	
		for(uchar i=0; i<DockConst_num_of_genes; i++) {
			float tmp;
			uchar lsb;
			lsb = lfsr & 0x01u;
			lfsr >>= 1;
			lfsr ^= (-lsb) & 0xA3000000u;
			tmp = (0.999999f/MAX_UINT)*lfsr;
			bool success = false;

			#if defined (FIXED_POINT_LS3)
			fixedpt fixpt_tmp = fixedpt_fromfloat(tmp);
			if(!valid) {
				success = write_channel_nb_altera(chan_PRNG2GA_LS3_float_prng, *(float*) &fixpt_tmp);
			}

			#else
			if(!valid) {
				success = write_channel_nb_altera(chan_PRNG2GA_LS3_float_prng, tmp);
			}
			#endif
		}
	} // End of while(active)
}
// --------------------------------------------------------------------------
// --------------------------------------------------------------------------     
