// --------------------------------------------------------------------------
// PRNG generators are implemented as Linear Feedback Shift Registers (LFSR)
// All are 32-bit LFRS, feedback taps: 30, 20, 26, 25
// --------------------------------------------------------------------------
/*
__kernel __attribute__ ((max_global_work_dim(0)))
*/
__kernel __attribute__ ((reqd_work_group_size(1,1,1)))
void Krnl_Prng_BT_ushort_float(
			       unsigned int Host_seed1,
			       unsigned int Host_seed2,
			       unsigned int DockConst_pop_size

#if !defined(SW_EMU)
			      // IMPORTANT: enable this dummy global argument only for "hw" build.
			      // Check ../common_xilinx/utility/boards.mk
			      // https://forums.xilinx.com/t5/SDAccel/ERROR-KernelCheck-83-114-in-sdx-2017-4/td-p/818135
			      ,
			      __global int *dummy
#endif
){

	uint2 lfsr;
	lfsr.x = Host_seed1;
	lfsr.y = Host_seed2;
/*
	bool valid  = false;
*/
	int valid = 1;
	
/*
	while(!valid) {	
*/
	LOOP_WHILE_PRNG_BT_USHOT_FLOAT:
	while(valid != 0) {	
/*
		bool active = true;
*/
		int active;
/*
		active = read_channel_nb_altera(chan_Arbiter_BT_ushort_float_off, &valid);
*/
		valid = read_pipe(chan_Arbiter_BT_ushort_float_off, &active);

		uint   u_tmp[4]; // used as short in GA
		float  f_tmp[4];	

/*
		#pragma unroll
*/
		__attribute__((opencl_unroll_hint))
		LOOP_FOR_PRNG_BT_USHORT_FLOAT:
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
/*
		bool success = false;
*/
		int success = 1;
/*
		if(!valid) {
*/
		if(valid != 0) {
/*
			float8 tmp = {*(float*)&u_tmp[0], f_tmp[0],
				      *(float*)&u_tmp[1], f_tmp[1],
				      *(float*)&u_tmp[2], f_tmp[2],
				      *(float*)&u_tmp[3], f_tmp[3]};
*/
			// Check "Krnl_GA"
			// To surpass error in hw_emu
			float u_tmp_float_0 = u_tmp[0];
			float u_tmp_float_1 = u_tmp[1];
			float u_tmp_float_2 = u_tmp[2];
			float u_tmp_float_3 = u_tmp[3];

			float8 tmp = {u_tmp_float_0, f_tmp[0],
				      u_tmp_float_1, f_tmp[1],
				      u_tmp_float_2, f_tmp[2],
				      u_tmp_float_3, f_tmp[3]};

/*
			success = write_channel_nb_altera(chan_PRNG2GA_BT_ushort_float_prng, tmp);
*/

			success = write_pipe(chan_PRNG2GA_BT_ushort_float_prng, &tmp);
		}
	} /*// End of while(!valid)*/
	// End of while(valid == 0)
}

// --------------------------------------------------------------------------
// --------------------------------------------------------------------------
/*
__kernel __attribute__ ((max_global_work_dim(0)))
*/
__kernel __attribute__ ((reqd_work_group_size(1,1,1)))
void Krnl_Prng_GG_uchar(
			unsigned int  Host_seed, 
		        unsigned char DockConst_num_of_genes

#if !defined(SW_EMU)
			// IMPORTANT: enable this dummy global argument only for "hw" build.
			// Check ../common_xilinx/utility/boards.mk
		        // https://forums.xilinx.com/t5/SDAccel/ERROR-KernelCheck-83-114-in-sdx-2017-4/td-p/818135
			,
			__global int *dummy
#endif
){

	uint lfsr = Host_seed;
/*
	bool valid = false;
*/
	int valid = 1;

/*
	while(!valid) {
*/
	LOOP_WHILE_PRNG_GG_UCHAR:
	while(valid != 0) {
/*
		bool active = true;
*/
		int active;
/*
		active = read_channel_nb_altera(chan_Arbiter_GG_uchar_off, &valid);
*/
		valid = read_pipe(chan_Arbiter_GG_uchar_off, &active);		

		uchar tmp[2];

/*
		#pragma unroll
*/
		__attribute__((opencl_unroll_hint))
		LOOP_FOR_PRNG_GG_UCHAR:
		for(uchar i=0; i<2; i++) {
			uchar lsb;
			lsb = lfsr & 0x01u;
			lfsr >>= 1;
			lfsr ^= (-lsb) & 0xA3000000u;
			tmp[i] = (lfsr/MAX_UINT)*DockConst_num_of_genes;

		}
/*
		bool success = false;
*/
		int success = 1;

		uchar2 utmp;
		utmp.x = tmp[0];
		utmp.y = tmp[1];

/*
		if(!valid) {
*/
		if(valid != 0) {
/*
			success = write_channel_nb_altera(chan_PRNG2GA_GG_uchar_prng, utmp);
*/
			success = write_pipe(chan_PRNG2GA_GG_uchar_prng, &utmp);
		}
	} // End of while(active)
}

/*
__kernel __attribute__ ((max_global_work_dim(0)))
*/
__kernel __attribute__ ((reqd_work_group_size(1,1,1)))
void Krnl_Prng_GG_float(
			unsigned int  Host_seed,
		        unsigned char DockConst_num_of_genes

#if !defined(SW_EMU)
			// IMPORTANT: enable this dummy global argument only for "hw" build.
			// Check ../common_xilinx/utility/boards.mk
		        // https://forums.xilinx.com/t5/SDAccel/ERROR-KernelCheck-83-114-in-sdx-2017-4/td-p/818135
		        ,
		        __global int *dummy
#endif
){

	uint lfsr = Host_seed;
/*
	bool valid = false;
*/
	int valid = 1;

/*
	while(!valid) {
*/
	LOOP_WHILE_PRNG_GG_FLOAT:
	while(valid != 0) {
/*
		bool active = true;
*/
		int active;
/*
		active = read_channel_nb_altera(chan_Arbiter_GG_float_off, &valid);
*/
		valid = read_pipe(chan_Arbiter_GG_float_off, &active);

		LOOP_FOR_PRNG_GG_FLOAT:
		for(uchar i=0; i<DockConst_num_of_genes; i++) {
			float tmp;
			uchar lsb;
			lsb = lfsr & 0x01u;
			lfsr >>= 1;
			lfsr ^= (-lsb) & 0xA3000000u;
			tmp = (0.999999f/MAX_UINT)*lfsr;

/*
			bool success = false;
*/
			int success = 1;
/*
			if(!valid) {
*/
			if(valid != 0) {
/*
				success = write_channel_nb_altera(chan_PRNG2GA_GG_float_prng, tmp);
*/
				success = write_pipe(chan_PRNG2GA_GG_float_prng, &tmp);
			}
		}
	} // End of while(active)
}

// --------------------------------------------------------------------------
// --------------------------------------------------------------------------
/*
__kernel __attribute__ ((max_global_work_dim(0)))
*/
__kernel __attribute__ ((reqd_work_group_size(1,1,1)))
void Krnl_Prng_LS123_ushort(
			    unsigned int Host_seed1,
			    unsigned int Host_seed2, 
			    unsigned int Host_seed3,
			    unsigned int Host_seed4,
			    unsigned int Host_seed5, 
			    unsigned int Host_seed6, 
			    unsigned int Host_seed7,
			    unsigned int Host_seed8,
			    unsigned int Host_seed9, 
		            unsigned int DockConst_pop_size

#if !defined(SW_EMU)
			    // IMPORTANT: enable this dummy global argument only for "hw" build.
			    // Check ../common_xilinx/utility/boards.mk
		            // https://forums.xilinx.com/t5/SDAccel/ERROR-KernelCheck-83-114-in-sdx-2017-4/td-p/818135
			    ,
			    __global int *dummy
#endif
){


	uint lfsr[9];
	lfsr[0] = Host_seed1;
	lfsr[1] = Host_seed2;
	lfsr[2] = Host_seed3;
	lfsr[3] = Host_seed4;
	lfsr[4] = Host_seed5;
	lfsr[5] = Host_seed6;
	lfsr[6] = Host_seed7;
	lfsr[7] = Host_seed8;
	lfsr[8] = Host_seed9;

/*
	bool valid = false;
*/
	int valid = 1;

/*
	while(!valid) {
*/
	LOOP_WHILE_PRNG_LS123_USHORT:
	while(valid != 0) {
/*
		bool active = true;
*/
		int active;
/*
		active  = read_channel_nb_altera(chan_Arbiter_LS123_ushort_off, &valid);
*/
		valid  = read_pipe(chan_Arbiter_LS123_ushort_off, &active);

		ushort tmp[9];
		
/*
		#pragma unroll
*/
		__attribute__((opencl_unroll_hint))
		LOOP_FOR_PRNG_LS123_USHORT:
		for (uint i=0; i<9; i++){
			uchar  lsb[9];
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

/*
		bool success = false;
*/
		int success = 1;

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

/*
		if(!valid) {
*/
		if(valid != 0) {
/*
			success = write_channel_nb_altera(chan_PRNG2GA_LS123_ushort_prng, tmp123);
*/
			success = write_pipe(chan_PRNG2GA_LS123_ushort_prng, &tmp123);
		}

	} // End of while(active)
}

// --------------------------------------------------------------------------
// --------------------------------------------------------------------------
/*
__kernel __attribute__ ((max_global_work_dim(0)))
*/
__kernel __attribute__ ((reqd_work_group_size(1,1,1)))
void Krnl_Prng_LS_float(
			unsigned int  Host_seed,
		        unsigned char DockConst_num_of_genes

#if !defined(SW_EMU)
			// IMPORTANT: enable this dummy global argument only for "hw" build.
			// Check ../common_xilinx/utility/boards.mk
 		        // https://forums.xilinx.com/t5/SDAccel/ERROR-KernelCheck-83-114-in-sdx-2017-4/td-p/818135
			,
			__global int *dummy
#endif
){

	uint lfsr = Host_seed;
/*
	bool valid = false;
*/
	int valid = 1;

/*
	while(!valid) {
*/
	LOOP_WHILE_PRNG_LS_FLOAT:
	while(valid != 0) {
/*
		bool active = true;
*/
		int active;
/*
		active  = read_channel_nb_altera(chan_Arbiter_LS_float_off, &valid);
*/
		valid  = read_pipe(chan_Arbiter_LS_float_off, &active);
	
		LOOP_FOR_PRNG_LS_FLOAT:
		for(uchar i=0; i<DockConst_num_of_genes; i++) {
			float tmp;
			uchar lsb;
			lsb = lfsr & 0x01u;
			lfsr >>= 1;
			lfsr ^= (-lsb) & 0xA3000000u;
			tmp = (0.999999f/MAX_UINT)*lfsr;
/*
			bool success = false;
*/
			int success = 1;

			#if defined (FIXED_POINT_LS1)
			fixedpt fixpt_tmp = fixedpt_fromfloat(tmp);
/*
			if(!valid) {
*/
			if(valid != 0) {
/*
				success = write_channel_nb_altera(chan_PRNG2GA_LS_float_prng, *(float*) &fixpt_tmp);
*/
				success = write_pipe(chan_PRNG2GA_LS_float_prng, (float*) &fixpt_tmp);
			}
			#else
/*
			if(!valid) {
*/
			if(valid != 0) {
/*
				success = write_channel_nb_altera(chan_PRNG2GA_LS_float_prng, tmp);
*/
				success = write_pipe(chan_PRNG2GA_LS_float_prng, &tmp);
			}
			#endif
		}
	} // End of while(active)
}

/*
__kernel __attribute__ ((max_global_work_dim(0)))
*/
__kernel __attribute__ ((reqd_work_group_size(1,1,1)))
void Krnl_Prng_LS2_float(
			 unsigned int  Host_seed,
			 unsigned char DockConst_num_of_genes

#if !defined(SW_EMU)
			 // IMPORTANT: enable this dummy global argument only for "hw" build.
			 // Check ../common_xilinx/utility/boards.mk
 		         // https://forums.xilinx.com/t5/SDAccel/ERROR-KernelCheck-83-114-in-sdx-2017-4/td-p/818135
		         , 
         		 __global int *dummy
#endif
){

	uint lfsr = Host_seed;
/*
	bool valid = false;
*/
	int valid = 1;

/*
	while(!valid) {
*/
	LOOP_WHILE_PRNG_LS2_FLOAT:
	while(valid != 0) {
/*
		bool active = true;
*/
		int active;
/*
		active  = read_channel_nb_altera(chan_Arbiter_LS2_float_off, &valid);
*/
		valid  = read_pipe(chan_Arbiter_LS2_float_off, &active);
	
		LOOP_FOR_PRNG_LS2_FLOAT:
		for(uchar i=0; i<DockConst_num_of_genes; i++) {
			float tmp;
			uchar lsb;
			lsb = lfsr & 0x01u;
			lfsr >>= 1;
			lfsr ^= (-lsb) & 0xA3000000u;
			tmp = (0.999999f/MAX_UINT)*lfsr;
/*
			bool success = false;
*/
			int success = 1;

			#if defined (FIXED_POINT_LS2)
			fixedpt fixpt_tmp = fixedpt_fromfloat(tmp);
/*
			if(!valid) {
*/
			if(valid != 0) {
/*
				success = write_channel_nb_altera(chan_PRNG2GA_LS2_float_prng, *(float*) &fixpt_tmp);
*/
				success = write_pipe(chan_PRNG2GA_LS2_float_prng, (float*) &fixpt_tmp);
			}
			#else
/*
			if(!valid) {
*/
			if(valid != 0) {
/*
				success = write_channel_nb_altera(chan_PRNG2GA_LS2_float_prng, tmp);
*/
				success = write_pipe(chan_PRNG2GA_LS2_float_prng, &tmp);
			}
			#endif
		}
	} // End of while(active)
}

/*
__kernel __attribute__ ((max_global_work_dim(0)))
*/
__kernel __attribute__ ((reqd_work_group_size(1,1,1)))
void Krnl_Prng_LS3_float(
			 unsigned int  Host_seed,
			 unsigned char DockConst_num_of_genes

#if !defined(SW_EMU)
			 // IMPORTANT: enable this dummy global argument only for "hw" build.
			 // Check ../common_xilinx/utility/boards.mk
 		         // https://forums.xilinx.com/t5/SDAccel/ERROR-KernelCheck-83-114-in-sdx-2017-4/td-p/818135
		         , 
         		 __global int *dummy
#endif
){

	uint lfsr = Host_seed;
/*
	bool valid = false;
*/
	int valid = 1;

/*
	while(!valid) {
*/
	LOOP_WHILE_PRNG_LS3_FLOAT:
	while(valid != 0) {
/*
		bool active = true;
*/
		int active;
/*
		active  = read_channel_nb_altera(chan_Arbiter_LS3_float_off, &valid);
*/
		valid  = read_pipe(chan_Arbiter_LS3_float_off, &active);
	
		LOOP_FOR_PRNG_LS3_FLOAT:
		for(uchar i=0; i<DockConst_num_of_genes; i++) {
			float tmp;
			uchar lsb;
			lsb = lfsr & 0x01u;
			lfsr >>= 1;
			lfsr ^= (-lsb) & 0xA3000000u;
			tmp = (0.999999f/MAX_UINT)*lfsr;
/*
			bool success = false;
*/
			int success = 1;

			#if defined (FIXED_POINT_LS3)
			fixedpt fixpt_tmp = fixedpt_fromfloat(tmp);
/*
			if(!valid) {
*/
			if(valid != 0) {
/*
				success = write_channel_nb_altera(chan_PRNG2GA_LS3_float_prng, *(float*) &fixpt_tmp);
*/
				success = write_pipe(chan_PRNG2GA_LS3_float_prng, (float*) &fixpt_tmp);
			}

			#else
/*
			if(!valid) {
*/
			if(valid != 0) {
/*
				success = write_channel_nb_altera(chan_PRNG2GA_LS3_float_prng, tmp);
*/
				success = write_pipe(chan_PRNG2GA_LS3_float_prng, &tmp);
			}
			#endif
		}
	} // End of while(active)
}

/*
__kernel __attribute__ ((max_global_work_dim(0)))
*/
__kernel __attribute__ ((reqd_work_group_size(1,1,1)))
void Krnl_Prng_LS4_float(
			 unsigned int  Host_seed,
			 unsigned char DockConst_num_of_genes

#if !defined(SW_EMU)
			 // IMPORTANT: enable this dummy global argument only for "hw" build.
			 // Check ../common_xilinx/utility/boards.mk
 		         // https://forums.xilinx.com/t5/SDAccel/ERROR-KernelCheck-83-114-in-sdx-2017-4/td-p/818135
		         , 
         		 __global int *dummy
#endif
){

	uint lfsr = Host_seed;
/*
	bool valid = false;
*/
	int valid = 1;

/*
	while(!valid) {
*/
	LOOP_WHILE_PRNG_LS4_FLOAT:
	while(valid != 0) {
/*
		bool active = true;
*/
		int active;
/*
		active  = read_channel_nb_altera(chan_Arbiter_LS4_float_off, &valid);
*/
		valid  = read_pipe(chan_Arbiter_LS4_float_off, &active);
	
		LOOP_FOR_PRNG_LS4_FLOAT:
		for(uchar i=0; i<DockConst_num_of_genes; i++) {
			float tmp;
			uchar lsb;
			lsb = lfsr & 0x01u;
			lfsr >>= 1;
			lfsr ^= (-lsb) & 0xA3000000u;
			tmp = (0.999999f/MAX_UINT)*lfsr;
/*
			bool success = false;
*/
			int success = 1;

			#if defined (FIXED_POINT_LS4)
			fixedpt fixpt_tmp = fixedpt_fromfloat(tmp);
/*
			if(!valid) {
*/
			if(valid != 0) {
/*
				success = write_channel_nb_altera(chan_PRNG2GA_LS4_float_prng, *(float*) &fixpt_tmp);
*/
				success = write_pipe(chan_PRNG2GA_LS4_float_prng, (float*) &fixpt_tmp);
			}
			#else
/*
			if(!valid) {
*/
			if(valid != 0) {
/*
				success = write_channel_nb_altera(chan_PRNG2GA_LS4_float_prng, tmp);
*/
				success = write_pipe(chan_PRNG2GA_LS4_float_prng, &tmp);
			}
			#endif
		}
	} // End of while(active)
}

/*
__kernel __attribute__ ((max_global_work_dim(0)))
*/
__kernel __attribute__ ((reqd_work_group_size(1,1,1)))
void Krnl_Prng_LS5_float(
			 unsigned int  Host_seed,
			 unsigned char DockConst_num_of_genes

#if !defined(SW_EMU)
			 // IMPORTANT: enable this dummy global argument only for "hw" build.
			 // Check ../common_xilinx/utility/boards.mk
 		         // https://forums.xilinx.com/t5/SDAccel/ERROR-KernelCheck-83-114-in-sdx-2017-4/td-p/818135
		         , 
         		 __global int *dummy
#endif
){

	uint lfsr = Host_seed;
/*
	bool valid = false;
*/
	int valid = 1;

/*
	while(!valid) {
*/
	LOOP_WHILE_PRNG_LS5_FLOAT:
	while(valid != 0) {
/*
		bool active = true;
*/
		int active;
/*
		active  = read_channel_nb_altera(chan_Arbiter_LS5_float_off, &valid);
*/
		valid  = read_pipe(chan_Arbiter_LS5_float_off, &active);
	
		LOOP_FOR_PRNG_LS5_FLOAT:
		for(uchar i=0; i<DockConst_num_of_genes; i++) {
			float tmp;
			uchar lsb;
			lsb = lfsr & 0x01u;
			lfsr >>= 1;
			lfsr ^= (-lsb) & 0xA3000000u;
			tmp = (0.999999f/MAX_UINT)*lfsr;
/*
			bool success = false;
*/
			int success = 1;

			#if defined (FIXED_POINT_LS5)
			fixedpt fixpt_tmp = fixedpt_fromfloat(tmp);
/*
			if(!valid) {
*/
			if(valid != 0) {
/*
				success = write_channel_nb_altera(chan_PRNG2GA_LS5_float_prng, *(float*) &fixpt_tmp);
*/
				success = write_pipe(chan_PRNG2GA_LS5_float_prng, (float*) &fixpt_tmp);
			}
			#else
/*
			if(!valid) {
*/
			if(valid != 0) {
/*
				success = write_channel_nb_altera(chan_PRNG2GA_LS5_float_prng, tmp);
*/
				success = write_pipe(chan_PRNG2GA_LS5_float_prng, &tmp);
			}
			#endif
		}
	} // End of while(active)
}

/*
__kernel __attribute__ ((max_global_work_dim(0)))
*/
__kernel __attribute__ ((reqd_work_group_size(1,1,1)))
void Krnl_Prng_LS6_float(
			 unsigned int  Host_seed,
			 unsigned char DockConst_num_of_genes

#if !defined(SW_EMU)
			 // IMPORTANT: enable this dummy global argument only for "hw" build.
			 // Check ../common_xilinx/utility/boards.mk
 		         // https://forums.xilinx.com/t5/SDAccel/ERROR-KernelCheck-83-114-in-sdx-2017-4/td-p/818135
		         , 
         		 __global int *dummy
#endif
){

	uint lfsr = Host_seed;
/*
	bool valid = false;
*/
	int valid = 1;

/*
	while(!valid) {
*/
	LOOP_WHILE_PRNG_LS6_FLOAT:
	while(valid != 0) {
/*
		bool active = true;
*/
		int active;
/*
		active  = read_channel_nb_altera(chan_Arbiter_LS6_float_off, &valid);
*/
		valid  = read_pipe(chan_Arbiter_LS6_float_off, &active);
	
		LOOP_FOR_PRNG_LS6_FLOAT:
		for(uchar i=0; i<DockConst_num_of_genes; i++) {
			float tmp;
			uchar lsb;
			lsb = lfsr & 0x01u;
			lfsr >>= 1;
			lfsr ^= (-lsb) & 0xA3000000u;
			tmp = (0.999999f/MAX_UINT)*lfsr;
/*
			bool success = false;
*/
			int success = 1;

			#if defined (FIXED_POINT_LS6)
			fixedpt fixpt_tmp = fixedpt_fromfloat(tmp);
/*
			if(!valid) {
*/
			if(valid != 0) {
/*
				success = write_channel_nb_altera(chan_PRNG2GA_LS6_float_prng, *(float*) &fixpt_tmp);
*/
				success = write_pipe(chan_PRNG2GA_LS6_float_prng, (float*) &fixpt_tmp);
			}
			#else
/*
			if(!valid) {
*/
			if(valid != 0) {
/*
				success = write_channel_nb_altera(chan_PRNG2GA_LS6_float_prng, tmp);
*/
				success = write_pipe(chan_PRNG2GA_LS6_float_prng, &tmp);
			}
			#endif
		}
	} // End of while(active)
}

/*
__kernel __attribute__ ((max_global_work_dim(0)))
*/
__kernel __attribute__ ((reqd_work_group_size(1,1,1)))
void Krnl_Prng_LS7_float(
			 unsigned int  Host_seed,
			 unsigned char DockConst_num_of_genes

#if !defined(SW_EMU)
			 // IMPORTANT: enable this dummy global argument only for "hw" build.
			 // Check ../common_xilinx/utility/boards.mk
 		         // https://forums.xilinx.com/t5/SDAccel/ERROR-KernelCheck-83-114-in-sdx-2017-4/td-p/818135
		         , 
         		 __global int *dummy
#endif
){

	uint lfsr = Host_seed;
/*
	bool valid = false;
*/
	int valid = 1;

/*
	while(!valid) {
*/
	LOOP_WHILE_PRNG_LS7_FLOAT:
	while(valid != 0) {
/*
		bool active = true;
*/
		int active;
/*
		active  = read_channel_nb_altera(chan_Arbiter_LS7_float_off, &valid);
*/
		valid  = read_pipe(chan_Arbiter_LS7_float_off, &active);
	
		LOOP_FOR_PRNG_LS7_FLOAT:
		for(uchar i=0; i<DockConst_num_of_genes; i++) {
			float tmp;
			uchar lsb;
			lsb = lfsr & 0x01u;
			lfsr >>= 1;
			lfsr ^= (-lsb) & 0xA3000000u;
			tmp = (0.999999f/MAX_UINT)*lfsr;
/*
			bool success = false;
*/
			int success = 1;

			#if defined (FIXED_POINT_LS7)
			fixedpt fixpt_tmp = fixedpt_fromfloat(tmp);
/*
			if(!valid) {
*/
			if(valid != 0) {
/*
				success = write_channel_nb_altera(chan_PRNG2GA_LS7_float_prng, *(float*) &fixpt_tmp);
*/
				success = write_pipe(chan_PRNG2GA_LS7_float_prng, (float*) &fixpt_tmp);
			}
			#else
/*
			if(!valid) {
*/
			if(valid != 0) {
/*
				success = write_channel_nb_altera(chan_PRNG2GA_LS7_float_prng, tmp);
*/
				success = write_pipe(chan_PRNG2GA_LS7_float_prng, &tmp);
			}
			#endif
		}
	} // End of while(active)
}

/*
__kernel __attribute__ ((max_global_work_dim(0)))
*/
__kernel __attribute__ ((reqd_work_group_size(1,1,1)))
void Krnl_Prng_LS8_float(
			 unsigned int  Host_seed,
			 unsigned char DockConst_num_of_genes

#if !defined(SW_EMU)
			 // IMPORTANT: enable this dummy global argument only for "hw" build.
			 // Check ../common_xilinx/utility/boards.mk
 		         // https://forums.xilinx.com/t5/SDAccel/ERROR-KernelCheck-83-114-in-sdx-2017-4/td-p/818135
		         , 
         		 __global int *dummy
#endif
){

	uint lfsr = Host_seed;
/*
	bool valid = false;
*/
	int valid = 1;

/*
	while(!valid) {
*/
	LOOP_WHILE_PRNG_LS8_FLOAT:
	while(valid != 0) {
/*
		bool active = true;
*/
		int active;
/*
		active  = read_channel_nb_altera(chan_Arbiter_LS8_float_off, &valid);
*/
		valid  = read_pipe(chan_Arbiter_LS8_float_off, &active);
	
		LOOP_FOR_PRNG_LS8_FLOAT:
		for(uchar i=0; i<DockConst_num_of_genes; i++) {
			float tmp;
			uchar lsb;
			lsb = lfsr & 0x01u;
			lfsr >>= 1;
			lfsr ^= (-lsb) & 0xA3000000u;
			tmp = (0.999999f/MAX_UINT)*lfsr;
/*
			bool success = false;
*/
			int success = 1;

			#if defined (FIXED_POINT_LS8)
			fixedpt fixpt_tmp = fixedpt_fromfloat(tmp);
/*
			if(!valid) {
*/
			if(valid != 0) {
/*
				success = write_channel_nb_altera(chan_PRNG2GA_LS8_float_prng, *(float*) &fixpt_tmp);
*/
				success = write_pipe(chan_PRNG2GA_LS8_float_prng, (float*) &fixpt_tmp);
			}
			#else
/*
			if(!valid) {
*/
			if(valid != 0) {
/*
				success = write_channel_nb_altera(chan_PRNG2GA_LS8_float_prng, tmp);
*/
				success = write_pipe(chan_PRNG2GA_LS8_float_prng, &tmp);
			}
			#endif
		}
	} // End of while(active)
}

/*
__kernel __attribute__ ((max_global_work_dim(0)))
*/
__kernel __attribute__ ((reqd_work_group_size(1,1,1)))
void Krnl_Prng_LS9_float(
			 unsigned int  Host_seed,
			 unsigned char DockConst_num_of_genes

#if !defined(SW_EMU)
			 // IMPORTANT: enable this dummy global argument only for "hw" build.
			 // Check ../common_xilinx/utility/boards.mk
 		         // https://forums.xilinx.com/t5/SDAccel/ERROR-KernelCheck-83-114-in-sdx-2017-4/td-p/818135
		         , 
         		 __global int *dummy
#endif
){

	uint lfsr = Host_seed;
/*
	bool valid = false;
*/
	int valid = 1;

/*
	while(!valid) {
*/
	LOOP_WHILE_PRNG_LS9_FLOAT:
	while(valid != 0) {
/*
		bool active = true;
*/
		int active;
/*
		active  = read_channel_nb_altera(chan_Arbiter_LS9_float_off, &valid);
*/
		valid  = read_pipe(chan_Arbiter_LS9_float_off, &active);
	
		LOOP_FOR_PRNG_LS9_FLOAT:
		for(uchar i=0; i<DockConst_num_of_genes; i++) {
			float tmp;
			uchar lsb;
			lsb = lfsr & 0x01u;
			lfsr >>= 1;
			lfsr ^= (-lsb) & 0xA3000000u;
			tmp = (0.999999f/MAX_UINT)*lfsr;
/*
			bool success = false;
*/
			int success = 1;

			#if defined (FIXED_POINT_LS9)
			fixedpt fixpt_tmp = fixedpt_fromfloat(tmp);
/*
			if(!valid) {
*/
			if(valid != 0) {
/*
				success = write_channel_nb_altera(chan_PRNG2GA_LS9_float_prng, *(float*) &fixpt_tmp);
*/
				success = write_pipe(chan_PRNG2GA_LS9_float_prng, (float*) &fixpt_tmp);
			}
			#else
/*
			if(!valid) {
*/
			if(valid != 0) {
/*
				success = write_channel_nb_altera(chan_PRNG2GA_LS9_float_prng, tmp);
*/
				success = write_pipe(chan_PRNG2GA_LS9_float_prng, &tmp);
			}
			#endif
		}
	} // End of while(active)
}
// --------------------------------------------------------------------------
// --------------------------------------------------------------------------     
