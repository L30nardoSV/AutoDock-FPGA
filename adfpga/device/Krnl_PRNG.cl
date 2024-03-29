// --------------------------------------------------------------------------
// PRNG generators are implemented as Linear Feedback Shift Registers (LFSR)
// All are 32-bit LFRS, feedback taps: 30, 20, 26, 25
// --------------------------------------------------------------------------

__kernel __attribute__ ((max_global_work_dim(0)))
void Krnl_Prng_BT_ushort_float (
	uint Host_seed1,
	uint Host_seed2,
	uint DockConst_pop_size) {

	uint2 lfsr;
	lfsr.x = Host_seed1;
	lfsr.y = Host_seed2;
	bool valid  = false;
	
	while(!valid) {	
		bool active = true;
		active = read_channel_nb_intel(chan_GA2PRNG_BT_ushort_float_off, &valid);

		uint   u_tmp[4]; // used as short in GA
		float  f_tmp[4];	

		// Loop index uint3_t covers up to 8 iterations (uint2_t ends up in deadlock)
		#pragma unroll
		for(uint3_t i=0; i<4; i++) {
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
			success = write_channel_nb_intel(chan_PRNG2GA_BT_ushort_float_prng, tmp);
		}
	} // End of while(!valid)
}

// --------------------------------------------------------------------------
// --------------------------------------------------------------------------

__kernel __attribute__ ((max_global_work_dim(0)))
void Krnl_Prng_GG_uchar (
	uint  Host_seed, 
	uchar DockConst_num_of_genes) {

	uint lfsr = Host_seed;
	bool valid = false;

	while(!valid) {
		bool active = true;
		active = read_channel_nb_intel(chan_GA2PRNG_GG_uchar_off, &valid);
		
		uchar tmp[2];

		// Loop index uint2_t covers up to 4 iterations (uint1_t ends up in deadlock)
		#pragma unroll
		for(uint2_t i=0; i<2; i++) {
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
			success = write_channel_nb_intel(chan_PRNG2GA_GG_uchar_prng, utmp);
		}
	} // End of while(active)
}

__kernel __attribute__ ((max_global_work_dim(0)))
void Krnl_Prng_GG_float (
	uint Host_seed,
	uchar DockConst_num_of_genes) {

	uint lfsr = Host_seed;
	bool valid = false;

	while(!valid) {
		bool active = true;
		active = read_channel_nb_intel(chan_GA2PRNG_GG_float_off, &valid);

		// Loop index uint6_t covers up to 64 genes (see defines.h)
		for(uint6_t i=0; i<DockConst_num_of_genes; i++) {
			float tmp;
			uchar lsb;
			lsb = lfsr & 0x01u;
			lfsr >>= 1;
			lfsr ^= (-lsb) & 0xA3000000u;
			tmp = (0.999999f/MAX_UINT)*lfsr;

			bool success = false;
			if(!valid) {
				success = write_channel_nb_intel(chan_PRNG2GA_GG_float_prng, tmp);
			}
		}
	} // End of while(active)
}

// --------------------------------------------------------------------------
// --------------------------------------------------------------------------

__kernel __attribute__ ((max_global_work_dim(0)))
void Krnl_Prng_LS123_ushort (
	uint Host_seed1,
	uint Host_seed2, 
	uint Host_seed3,
	uint Host_seed4,
	uint Host_seed5, 
	uint Host_seed6, 
	uint Host_seed7,
	uint Host_seed8,
	uint Host_seed9, 
	uint DockConst_pop_size) {

	uint lfsr[LS_REPLICATION_FACTOR];
	lfsr[0] = Host_seed1;
	lfsr[1] = Host_seed2;
	lfsr[2] = Host_seed3;
	lfsr[3] = Host_seed4;
	lfsr[4] = Host_seed5;
	lfsr[5] = Host_seed6;
	lfsr[6] = Host_seed7;
	lfsr[7] = Host_seed8;
	lfsr[8] = Host_seed9;

	bool valid = false;

	while(!valid) {
		bool active = true;
		active  = read_channel_nb_intel(chan_GA2PRNG_LS123_ushort_off, &valid);

		ushort tmp[LS_REPLICATION_FACTOR];
		
		// Loop index uint4_t covers up to 16 replicas (see auxiliary.h)
		#pragma unroll
		for (uint4_t i=0; i<LS_REPLICATION_FACTOR; i++){
			uchar  lsb[LS_REPLICATION_FACTOR];
			lsb [i] = lfsr[i] & 0x01u;
			lfsr[i] >>= 1;
			lfsr[i] ^= (-lsb[i]) & 0xA3000000u;
			tmp [i] = (DockConst_pop_size/MAX_UINT)*lfsr[i];
		}

		// To avoid having same entities undergoing LS simultaneously
		if (
			(tmp[0] == tmp[1]) || (tmp[0] == tmp[2]) || (tmp[0] == tmp[3]) || (tmp[0] == tmp[4]) || (tmp[0] == tmp[5]) || (tmp[0] == tmp[6]) || (tmp[0] == tmp[7]) || (tmp[0] == tmp[8]) ||
 			(tmp[1] == tmp[2]) || (tmp[1] == tmp[3]) || (tmp[1] == tmp[4]) || (tmp[1] == tmp[5]) || (tmp[1] == tmp[6]) || (tmp[1] == tmp[7]) || (tmp[1] == tmp[8]) ||
			(tmp[2] == tmp[3]) || (tmp[2] == tmp[4]) || (tmp[2] == tmp[5]) || (tmp[2] == tmp[6]) || (tmp[2] == tmp[7]) || (tmp[2] == tmp[8]) ||
			(tmp[3] == tmp[4]) || (tmp[3] == tmp[5]) || (tmp[3] == tmp[6]) || (tmp[3] == tmp[7]) || (tmp[3] == tmp[8]) ||
			(tmp[4] == tmp[5]) || (tmp[4] == tmp[6]) || (tmp[4] == tmp[7]) || (tmp[4] == tmp[8]) ||
			(tmp[5] == tmp[6]) || (tmp[5] == tmp[7]) || (tmp[5] == tmp[8]) ||
			(tmp[6] == tmp[7]) || (tmp[6] == tmp[8]) ||
			(tmp[7] == tmp[8])
		) {
			tmp[1] = tmp[0] + 1;
			tmp[2] = tmp[1] + 2;
			tmp[3] = tmp[2] + 3;
			tmp[4] = tmp[3] + 4;
			tmp[5] = tmp[4] + 5;
			tmp[6] = tmp[5] + 6;
			tmp[7] = tmp[6] + 7;
			tmp[8] = tmp[7] + 8;
		}

		bool success = false;
		ushort16 tmp123;
		tmp123.s0 = tmp[0];
		tmp123.s1 = tmp[1];
		tmp123.s2 = tmp[2];
		tmp123.s3 = tmp[3];
		tmp123.s4 = tmp[4];
		tmp123.s5 = tmp[5];
		tmp123.s6 = tmp[6];
		tmp123.s7 = tmp[7];
		tmp123.s8 = tmp[8];

		if(!valid) {
			success = write_channel_nb_intel(chan_PRNG2GA_LS123_ushort_prng, tmp123);
		}

	} // End of while(active)
}

// --------------------------------------------------------------------------
// --------------------------------------------------------------------------

__kernel __attribute__ ((max_global_work_dim(0)))
void Krnl_Prng_LS_float (
	uint Host_seed,
	uchar DockConst_num_of_genes) {

	uint lfsr = Host_seed;
	bool valid = false;

	while(!valid) {
		bool active = true;
		active  = read_channel_nb_intel(chan_GA2PRNG_LS_float_off[0], &valid);
	
		// Loop index uint6_t covers up to 64 genes (see defines.h)
		for(uint6_t i=0; i<DockConst_num_of_genes; i++) {
			float tmp;
			uchar lsb;
			lsb = lfsr & 0x01u;
			lfsr >>= 1;
			lfsr ^= (-lsb) & 0xA3000000u;
			tmp = (0.999999f/MAX_UINT)*lfsr;
			bool success = false;

#ifdef FIXED_POINT_LS
			fixedpt fixpt_tmp = fixedpt_fromfloat(tmp);
			if(!valid) {
				success = write_channel_nb_intel(chan_PRNG2LS_float_prng[0], *(float*) &fixpt_tmp);
			}
#else
			if(!valid) {
				success = write_channel_nb_intel(chan_PRNG2LS_float_prng[0], tmp);
			}
#endif
		}
	} // End of while(active)
}

__kernel __attribute__ ((max_global_work_dim(0)))
void Krnl_Prng_LS2_float (
	uint Host_seed,
	uchar DockConst_num_of_genes) {

	uint lfsr = Host_seed;
	bool valid = false;

	while(!valid) {
		bool active = true;
		active  = read_channel_nb_intel(chan_GA2PRNG_LS_float_off[1], &valid);
	
		// Loop index uint6_t covers up to 64 genes (see defines.h)
		for(uint6_t i=0; i<DockConst_num_of_genes; i++) {
			float tmp;
			uchar lsb;
			lsb = lfsr & 0x01u;
			lfsr >>= 1;
			lfsr ^= (-lsb) & 0xA3000000u;
			tmp = (0.999999f/MAX_UINT)*lfsr;
			bool success = false;

#ifdef FIXED_POINT_LS
			fixedpt fixpt_tmp = fixedpt_fromfloat(tmp);
			if(!valid) {
				success = write_channel_nb_intel(chan_PRNG2LS_float_prng[1], *(float*) &fixpt_tmp);
			}
#else
			if(!valid) {
				success = write_channel_nb_intel(chan_PRNG2LS_float_prng[1], tmp);
			}
#endif
		}
	} // End of while(active)
}

__kernel __attribute__ ((max_global_work_dim(0)))
void Krnl_Prng_LS3_float (
	uint Host_seed,
	uchar DockConst_num_of_genes) {

	uint lfsr = Host_seed;
	bool valid = false;

	while(!valid) {
		bool active = true;
		active  = read_channel_nb_intel(chan_GA2PRNG_LS_float_off[2], &valid);
	
		// Loop index uint6_t covers up to 64 genes (see defines.h)
		for(uint6_t i=0; i<DockConst_num_of_genes; i++) {
			float tmp;
			uchar lsb;
			lsb = lfsr & 0x01u;
			lfsr >>= 1;
			lfsr ^= (-lsb) & 0xA3000000u;
			tmp = (0.999999f/MAX_UINT)*lfsr;
			bool success = false;

#ifdef FIXED_POINT_LS
			fixedpt fixpt_tmp = fixedpt_fromfloat(tmp);
			if(!valid) {
				success = write_channel_nb_intel(chan_PRNG2LS_float_prng[2], *(float*) &fixpt_tmp);
			}
#else
			if(!valid) {
				success = write_channel_nb_intel(chan_PRNG2LS_float_prng[2], tmp);
			}
#endif
		}
	} // End of while(active)
}

__kernel __attribute__ ((max_global_work_dim(0)))
void Krnl_Prng_LS4_float (
	uint Host_seed,
	uchar DockConst_num_of_genes) {

	uint lfsr = Host_seed;
	bool valid = false;

	while(!valid) {
		bool active = true;
		active  = read_channel_nb_intel(chan_GA2PRNG_LS_float_off[3], &valid);
	
		// Loop index uint6_t covers up to 64 genes (see defines.h)
		for(uint6_t i=0; i<DockConst_num_of_genes; i++) {
			float tmp;
			uchar lsb;
			lsb = lfsr & 0x01u;
			lfsr >>= 1;
			lfsr ^= (-lsb) & 0xA3000000u;
			tmp = (0.999999f/MAX_UINT)*lfsr;
			bool success = false;

#ifdef FIXED_POINT_LS
			fixedpt fixpt_tmp = fixedpt_fromfloat(tmp);
			if(!valid) {
				success = write_channel_nb_intel(chan_PRNG2LS_float_prng[3], *(float*) &fixpt_tmp);
			}
#else
			if(!valid) {
				success = write_channel_nb_intel(chan_PRNG2LS_float_prng[3], tmp);
			}
#endif
		}
	} // End of while(active)
}

__kernel __attribute__ ((max_global_work_dim(0)))
void Krnl_Prng_LS5_float (
	uint Host_seed,
	uchar DockConst_num_of_genes) {

	uint lfsr = Host_seed;
	bool valid = false;

	while(!valid) {
		bool active = true;
		active  = read_channel_nb_intel(chan_GA2PRNG_LS_float_off[4], &valid);
	
		// Loop index uint6_t covers up to 64 genes (see defines.h)
		for(uint6_t i=0; i<DockConst_num_of_genes; i++) {
			float tmp;
			uchar lsb;
			lsb = lfsr & 0x01u;
			lfsr >>= 1;
			lfsr ^= (-lsb) & 0xA3000000u;
			tmp = (0.999999f/MAX_UINT)*lfsr;
			bool success = false;

#ifdef FIXED_POINT_LS
			fixedpt fixpt_tmp = fixedpt_fromfloat(tmp);
			if(!valid) {
				success = write_channel_nb_intel(chan_PRNG2LS_float_prng[4], *(float*) &fixpt_tmp);
			}
#else
			if(!valid) {
				success = write_channel_nb_intel(chan_PRNG2LS_float_prng[4], tmp);
			}
#endif
		}
	} // End of while(active)
}

__kernel __attribute__ ((max_global_work_dim(0)))
void Krnl_Prng_LS6_float (
	uint Host_seed,
	uchar DockConst_num_of_genes) {

	uint lfsr = Host_seed;
	bool valid = false;

	while(!valid) {
		bool active = true;
		active  = read_channel_nb_intel(chan_GA2PRNG_LS_float_off[5], &valid);
	
		// Loop index uint6_t covers up to 64 genes (see defines.h)
		for(uint6_t i=0; i<DockConst_num_of_genes; i++) {
			float tmp;
			uchar lsb;
			lsb = lfsr & 0x01u;
			lfsr >>= 1;
			lfsr ^= (-lsb) & 0xA3000000u;
			tmp = (0.999999f/MAX_UINT)*lfsr;
			bool success = false;

#ifdef FIXED_POINT_LS
			fixedpt fixpt_tmp = fixedpt_fromfloat(tmp);
			if(!valid) {
				success = write_channel_nb_intel(chan_PRNG2LS_float_prng[5], *(float*) &fixpt_tmp);
			}
#else
			if(!valid) {
				success = write_channel_nb_intel(chan_PRNG2LS_float_prng[5], tmp);
			}
#endif
		}
	} // End of while(active)
}

__kernel __attribute__ ((max_global_work_dim(0)))
void Krnl_Prng_LS7_float (
	uint Host_seed,
	uchar DockConst_num_of_genes) {

	uint lfsr = Host_seed;
	bool valid = false;

	while(!valid) {
		bool active = true;
		active  = read_channel_nb_intel(chan_GA2PRNG_LS_float_off[6], &valid);
	
		// Loop index uint6_t covers up to 64 genes (see defines.h)
		for(uint6_t i=0; i<DockConst_num_of_genes; i++) {
			float tmp;
			uchar lsb;
			lsb = lfsr & 0x01u;
			lfsr >>= 1;
			lfsr ^= (-lsb) & 0xA3000000u;
			tmp = (0.999999f/MAX_UINT)*lfsr;
			bool success = false;

#ifdef FIXED_POINT_LS
			fixedpt fixpt_tmp = fixedpt_fromfloat(tmp);
			if(!valid) {
				success = write_channel_nb_intel(chan_PRNG2LS_float_prng[6], *(float*) &fixpt_tmp);
			}
#else
			if(!valid) {
				success = write_channel_nb_intel(chan_PRNG2LS_float_prng[6], tmp);
			}
#endif
		}
	} // End of while(active)
}

__kernel __attribute__ ((max_global_work_dim(0)))
void Krnl_Prng_LS8_float (
	uint Host_seed,
	uchar DockConst_num_of_genes) {

	uint lfsr = Host_seed;
	bool valid = false;

	while(!valid) {
		bool active = true;
		active  = read_channel_nb_intel(chan_GA2PRNG_LS_float_off[7], &valid);
	
		// Loop index uint6_t covers up to 64 genes (see defines.h)
		for(uint6_t i=0; i<DockConst_num_of_genes; i++) {
			float tmp;
			uchar lsb;
			lsb = lfsr & 0x01u;
			lfsr >>= 1;
			lfsr ^= (-lsb) & 0xA3000000u;
			tmp = (0.999999f/MAX_UINT)*lfsr;
			bool success = false;

#ifdef FIXED_POINT_LS
			fixedpt fixpt_tmp = fixedpt_fromfloat(tmp);
			if(!valid) {
				success = write_channel_nb_intel(chan_PRNG2LS_float_prng[7], *(float*) &fixpt_tmp);
			}
#else
			if(!valid) {
				success = write_channel_nb_intel(chan_PRNG2LS_float_prng[7], tmp);
			}
#endif
		}
	} // End of while(active)
}

__kernel __attribute__ ((max_global_work_dim(0)))
void Krnl_Prng_LS9_float (
	uint Host_seed,
	uchar DockConst_num_of_genes) {

	uint lfsr = Host_seed;
	bool valid = false;

	while(!valid) {
		bool active = true;
		active  = read_channel_nb_intel(chan_GA2PRNG_LS_float_off[8], &valid);
	
		// Loop index uint6_t covers up to 64 genes (see defines.h)
		for(uint6_t i=0; i<DockConst_num_of_genes; i++) {
			float tmp;
			uchar lsb;
			lsb = lfsr & 0x01u;
			lfsr >>= 1;
			lfsr ^= (-lsb) & 0xA3000000u;
			tmp = (0.999999f/MAX_UINT)*lfsr;
			bool success = false;

#ifdef FIXED_POINT_LS
			fixedpt fixpt_tmp = fixedpt_fromfloat(tmp);
			if(!valid) {
				success = write_channel_nb_intel(chan_PRNG2LS_float_prng[8], *(float*) &fixpt_tmp);
			}
#else
			if(!valid) {
				success = write_channel_nb_intel(chan_PRNG2LS_float_prng[8], tmp);
			}
#endif
		}
	} // End of while(active)
}
