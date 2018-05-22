COMMON_REPO := ../common_xilinx/

#Common Includes
include $(COMMON_REPO)/utility/boards.mk
include $(COMMON_REPO)/libs/xcl2/xcl2.mk
include $(COMMON_REPO)/libs/opencl/opencl.mk



# =============================
# Enable Kernels
# ============================= 
ENABLE_K1  = YES
ENABLE_K2  = YES
ENABLE_K3  = YES
ENABLE_K4  = YES

# Prng kernels

# bt prng float
ENABLE_K5  = NO

ENABLE_K6  = YES
ENABLE_K7  = YES

# bt prng ushort (check kernel36)
ENABLE_K8  = NO

# ls1 prng
ENABLE_K9  = NO

ENABLE_K10 = YES

# Replace single Krnl_Prng_Arbiter
# See kernels 31, 32, 33, 34
ENABLE_K11 = NO

# LS kernels
ENABLE_K12 = YES

# disable Krnl_LS_Arbiter
ENABLE_K13 = NO

ENABLE_K14 = YES
ENABLE_K15 = YES

# disable Krnl_LS2_Arbiter
ENABLE_K16 = NO

#ENABLE_K17 = YES
#ENABLE_K18 = YES
#ENABLE_K19 = YES

ENABLE_K20 = YES
ENABLE_K21 = YES

# disable Krnl_LS3_Arbiter
ENABLE_K22 = NO
#ENABLE_K23 = YES
#ENABLE_K24 = YES

# PRNGS in GA for LS2 and LS3

# ls2 & ls3 prng (ls1 is  K9)
# replacement is K35
ENABLE_K25 = NO
ENABLE_K26 = NO

ENABLE_K27 = YES

# IA Pipeline
ENABLE_K28 = NO
ENABLE_K29 = NO
ENABLE_K30 = NO

# BT, GG, LS_ushort, LS_float arbiters
ENABLE_K31 = NO
ENABLE_K32 = NO
ENABLE_K33 = NO
ENABLE_K34 = NO

# ls123 prng
ENABLE_K35 = YES

# bt ushort_float
ENABLE_K36 = YES

# prng ls4, ls5
ENABLE_K37 = YES
ENABLE_K38 = YES

# krnl_ls4, Krnl_ls5
ENABLE_K39 = YES
ENABLE_K40 = YES

# prng ls6, ls7, ls8, ls9
ENABLE_K41 = YES
ENABLE_K42 = YES
ENABLE_K43 = YES
ENABLE_K44 = YES

# krnl_ls6, Krnl_ls7, krnl_ls8, Krnl_ls9
ENABLE_K45 = YES
ENABLE_K46 = YES
ENABLE_K47 = YES
ENABLE_K48 = YES


ifeq ($(ENABLE_K1),YES)
	K1 =-DENABLE_KERNEL1
else
	K1 =
endif

ifeq ($(ENABLE_K2),YES)
	K2 =-DENABLE_KERNEL2
else
	K2 =
endif

ifeq ($(ENABLE_K3),YES)
	K3 =-DENABLE_KERNEL3
else
	K3 =
endif

ifeq ($(ENABLE_K4),YES)
	K4 =-DENABLE_KERNEL4
else
	K4 =
endif

ifeq ($(ENABLE_K5),YES)
	K5 =-DENABLE_KERNEL5
else
	K5 =
endif

ifeq ($(ENABLE_K6),YES)
	K6 =-DENABLE_KERNEL6
else
	K6 =
endif

ifeq ($(ENABLE_K7),YES)
	K7 =-DENABLE_KERNEL7
else
	K7 =
endif

ifeq ($(ENABLE_K8),YES)
	K8 =-DENABLE_KERNEL8
else
	K8 =
endif

ifeq ($(ENABLE_K9),YES)
	K9 =-DENABLE_KERNEL9
else
	K9 =
endif

ifeq ($(ENABLE_K10),YES)
	K10 =-DENABLE_KERNEL10
else
	K10 =
endif

ifeq ($(ENABLE_K11),YES)
	K11 =-DENABLE_KERNEL11
else
	K11 =
endif


ifeq ($(ENABLE_K12),YES)
	K12 =-DENABLE_KERNEL12
else
	K12 =
endif

ifeq ($(ENABLE_K13),YES)
	K13 =-DENABLE_KERNEL13
else
	K13 =
endif


ifeq ($(ENABLE_K14),YES)
	K14 =-DENABLE_KERNEL14
else
	K14 =
endif

ifeq ($(ENABLE_K15),YES)
	K15 =-DENABLE_KERNEL15
else
	K15 =
endif

ifeq ($(ENABLE_K16),YES)
	K16 =-DENABLE_KERNEL16
else
	K16 =
endif

ifeq ($(ENABLE_K17),YES)
	K17 =-DENABLE_KERNEL17
else
	K17 =
endif

ifeq ($(ENABLE_K18),YES)
	K18 =-DENABLE_KERNEL18
else
	K18 =
endif

ifeq ($(ENABLE_K19),YES)
	K19 =-DENABLE_KERNEL19
else
	K19 =
endif





ifeq ($(ENABLE_K20),YES)
	K20 =-DENABLE_KERNEL20
else
	K20 =
endif

ifeq ($(ENABLE_K21),YES)
	K21 =-DENABLE_KERNEL21
else
	K21 =
endif

ifeq ($(ENABLE_K22),YES)
	K22 =-DENABLE_KERNEL22
else
	K22 =
endif

ifeq ($(ENABLE_K23),YES)
	K23 =-DENABLE_KERNEL23
else
	K23 =
endif

ifeq ($(ENABLE_K24),YES)
	K24 =-DENABLE_KERNEL24
else
	K24 =
endif

ifeq ($(ENABLE_K25),YES)
	K25 =-DENABLE_KERNEL25
else
	K25 =
endif

ifeq ($(ENABLE_K26),YES)
	K26 =-DENABLE_KERNEL26
else
	K26 =
endif

ifeq ($(ENABLE_K27),YES)
	K27 =-DENABLE_KERNEL27
else
	K27 =
endif

ifeq ($(ENABLE_K28),YES)
	K28 =-DENABLE_KERNEL28
else
	K28 =
endif

ifeq ($(ENABLE_K29),YES)
	K29 =-DENABLE_KERNEL29
else
	K29 =
endif

ifeq ($(ENABLE_K30),YES)
	K30 =-DENABLE_KERNEL30
else
	K30 =
endif

ifeq ($(ENABLE_K31),YES)
	K31 =-DENABLE_KERNEL31
else
	K31 =
endif

ifeq ($(ENABLE_K32),YES)
	K32 =-DENABLE_KERNEL32
else
	K32 =
endif

ifeq ($(ENABLE_K33),YES)
	K33 =-DENABLE_KERNEL33
else
	K33 =
endif

ifeq ($(ENABLE_K34),YES)
	K34 =-DENABLE_KERNEL34
else
	K34 =
endif

ifeq ($(ENABLE_K35),YES)
	K35 =-DENABLE_KERNEL35
else
	K35 =
endif

ifeq ($(ENABLE_K36),YES)
	K36 =-DENABLE_KERNEL36
else
	K36 =
endif

ifeq ($(ENABLE_K37),YES)
	K37 =-DENABLE_KERNEL37
else
	K37 =
endif

ifeq ($(ENABLE_K38),YES)
	K38 =-DENABLE_KERNEL38
else
	K38 =
endif

ifeq ($(ENABLE_K39),YES)
	K39 =-DENABLE_KERNEL39
else
	K39 =
endif

ifeq ($(ENABLE_K40),YES)
	K40 =-DENABLE_KERNEL40
else
	K40 =
endif





ifeq ($(ENABLE_K41),YES)
	K41 =-DENABLE_KERNEL41
else
	K41 =
endif

ifeq ($(ENABLE_K42),YES)
	K42 =-DENABLE_KERNEL42
else
	K42 =
endif

ifeq ($(ENABLE_K43),YES)
	K43 =-DENABLE_KERNEL43
else
	K43 =
endif

ifeq ($(ENABLE_K44),YES)
	K44 =-DENABLE_KERNEL44
else
	K44 =
endif

ifeq ($(ENABLE_K45),YES)
	K45 =-DENABLE_KERNEL45
else
	K45 =
endif

ifeq ($(ENABLE_K46),YES)
	K46 =-DENABLE_KERNEL46
else
	K46 =
endif

ifeq ($(ENABLE_K47),YES)
	K47 =-DENABLE_KERNEL47
else
	K47 =
endif

ifeq ($(ENABLE_K48),YES)
	K48 =-DENABLE_KERNEL48
else
	K48 =
endif

# =============================
# Reproduce result (remove randomness)
# =============================
REPRO=NO

ifeq ($(REPRO), YES)
	REP=-DREPRO
else	
	REP=
endif
ENABLE_KERNELS = $(K1)  $(K2)  $(K3)  $(K4)  $(K5)  $(K6)  $(K7)  $(K8)  $(K9)  $(K10) \
		 $(K11) $(K12) $(K13) $(K14) $(K15) $(K16) $(K17) $(K18) $(K19) $(K20) \
		 $(K21) $(K22) $(K23) $(K24) $(K25) $(K26) $(K27) $(K28) $(K29) $(K30) \
		 $(K31) $(K32) $(K33) $(K34) $(K35) $(K36) $(K37) $(K38) $(K39) $(K40) \
		 $(K41) $(K42) $(K43) $(K44) $(K45) $(K46) $(K47) $(K48)

# =============================
# Fixed-point
# =============================
# FIxed-POint COform flag (FIPOCO)
FIXED_POINT_CONFORM=YES
#FIXED_POINT_CONFORM=NO

FIXED_POINT_INTERE=NO
FIXED_POINT_INTRAE=NO

FIXED_POINT_LS1=YES
FIXED_POINT_LS2=YES
FIXED_POINT_LS3=YES
FIXED_POINT_LS4=YES
FIXED_POINT_LS5=YES
FIXED_POINT_LS6=YES
FIXED_POINT_LS7=YES
FIXED_POINT_LS8=YES
FIXED_POINT_LS9=YES
#FIXED_POINT_LS1=NO
#FIXED_POINT_LS2=NO
#FIXED_POINT_LS3=NO
#FIXED_POINT_LS4=NO
#FIXED_POINT_LS5=NO
#FIXED_POINT_LS6=NO
#FIXED_POINT_LS7=NO
#FIXED_POINT_LS8=NO
#FIXED_POINT_LS9=NO

SINGLE_COPY_POP_ENE=YES

SEPARATE_FGRID_INTERE=NO

ifeq ($(FIXED_POINT_CONFORM), YES)
	FIPOCO_FLAG=-DFIXED_POINT_CONFORM
else	
	FIPOCO_FLAG=
endif

ifeq ($(FIXED_POINT_INTERE), YES)
	FIPOIE_FLAG=-DFIXED_POINT_INTERE
else	
	FIPOIE_FLAG=
endif

ifeq ($(FIXED_POINT_INTRAE), YES)
	FIPOIA_FLAG=-DFIXED_POINT_INTRAE
else	
	FIPOIA_FLAG=
endif

ifeq ($(FIXED_POINT_LS1), YES)
	FIPOLS1_FLAG=-DFIXED_POINT_LS1
else	
	FIPOLS1_FLAG=
endif

ifeq ($(FIXED_POINT_LS2), YES)
	FIPOLS2_FLAG=-DFIXED_POINT_LS2
else	
	FIPOLS2_FLAG=
endif

ifeq ($(FIXED_POINT_LS3), YES)
	FIPOLS3_FLAG=-DFIXED_POINT_LS3
else	
	FIPOLS3_FLAG=
endif

ifeq ($(FIXED_POINT_LS4), YES)
	FIPOLS4_FLAG=-DFIXED_POINT_LS4
else	
	FIPOLS4_FLAG=
endif

ifeq ($(FIXED_POINT_LS5), YES)
	FIPOLS5_FLAG=-DFIXED_POINT_LS5
else	
	FIPOLS5_FLAG=
endif



ifeq ($(FIXED_POINT_LS6), YES)
	FIPOLS6_FLAG=-DFIXED_POINT_LS6
else	
	FIPOLS6_FLAG=
endif

ifeq ($(FIXED_POINT_LS7), YES)
	FIPOLS7_FLAG=-DFIXED_POINT_LS7
else	
	FIPOLS7_FLAG=
endif

ifeq ($(FIXED_POINT_LS8), YES)
	FIPOLS8_FLAG=-DFIXED_POINT_LS8
else	
	FIPOLS8_FLAG=
endif

ifeq ($(FIXED_POINT_LS9), YES)
	FIPOLS9_FLAG=-DFIXED_POINT_LS9
else	
	FIPOLS9_FLAG=
endif



ifeq ($(SINGLE_COPY_POP_ENE), YES)
	COPYPOPENE_FLAG=-DSINGLE_COPY_POP_ENE
else	
	COPYPOPENE_FLAG=
endif

ifeq ($(SEPARATE_FGRID_INTERE), YES)
	SEP_FGRID_FLAG=-DSEPARATE_FGRID_INTERE
else	
	SEP_FGRID_FLAG=
endif

FIPO_FLAG = $(FIPOCO_FLAG) \
	    $(FIPOIE_FLAG) \
	    $(FIPOIA_FLAG) \
	    $(FIPOLS1_FLAG) \
	    $(FIPOLS2_FLAG) \
	    $(FIPOLS3_FLAG) \
	    $(FIPOLS4_FLAG) \
	    $(FIPOLS5_FLAG) \
	    $(FIPOLS6_FLAG) \
	    $(FIPOLS7_FLAG) \
	    $(FIPOLS8_FLAG) \
	    $(FIPOLS9_FLAG) \
	    $(COPYPOPENE_FLAG) $(SEP_FGRID_FLAG) 


# Host Application

#helloworld_SRCS=./src/host.cpp $(oclHelper_SRCS) $(xcl2_SRCS)
#helloworld_HDRS=$(xcl2_HDRS)

#helloworld_SRCS=$(wildcard ../common/src/AOCLUtils/*.cpp wrapcl/src/*.cpp host/src/*.cpp) \
#		$(oclHelper_SRCS) \
#		$(xcl2_SRCS)

#helloworld_HDRS=$(wildcard ./host/inc/*.h) \
#		$(xcl2_HDRS)

hostbin_SRCS=$(wildcard ../common/src/AOCLUtils/*.cpp wrapcl/src/*.cpp host/src/*.cpp) \
		$(oclHelper_SRCS) \
		$(xcl2_SRCS)

hostbin_HDRS=$(wildcard ./host/inc/*.h) \
		$(xcl2_HDRS)

# -U__STRICT_ANSI__: to avoid: ‘cl_float3 {aka union cl_float4}’ has no member named ‘y’


#helloworld_CXXFLAGS=-I../common/inc/ \
#		    -I./host/inc/ \
#		    -I. \
#		    -I./wrapcl/inc/ \
#		    $(opencl_CXXFLAGS) $(xcl2_CXXFLAGS) $(oclHelper_CXXFLAGS) \
#		    -std=c++0x \
#		    -U__STRICT_ANSI__ \
#		    $(ENABLE_KERNELS) \
#		    $(REP) \
#		    $(FIPO_FLAG)

hostbin_CXXFLAGS=-I../common/inc/ \
		    -I./host/inc/ \
		    -I. \
		    -I./wrapcl/inc/ \
		    $(opencl_CXXFLAGS) $(xcl2_CXXFLAGS) $(oclHelper_CXXFLAGS) \
		    -std=c++0x \
		    -U__STRICT_ANSI__ \
		    $(ENABLE_KERNELS) \
		    $(REP) \
		    $(FIPO_FLAG)
		    
#helloworld_LDFLAGS=$(opencl_LDFLAGS)
#hostbin_LDFLAGS=$(opencl_LDFLAGS)
hostbin_LDFLAGS=$(opencl_LDFLAGS) -lrt

#EXES=helloworld
EXES=hostbin

# Kernel
#vector_addition_SRCS=./src/vector_addition.cl
#vector_addition_SRCS=./device/Krnl_GA.cl
Krnl_GA_SRCS=./device/Krnl_GA.cl

#XOS=vector_addition
XOS=Krnl_GA

#vector_addition_XOS=vector_addition
Krnl_GA_XOS=Krnl_GA

#XCLBINS=vector_addition
XCLBINS=Krnl_GA

# check
#check_EXE=helloworld
check_EXE=hostbin
#check_XCLBINS=vector_addition
check_XCLBINS=Krnl_GA

CHECKS=check

include $(COMMON_REPO)/utility/rules.mk

# Automate test
# "exe" and "xclbin" are rules from "rules.mk"
emu: 
	XCL_EMULATION_MODE=sw_emu ./hostbin -ffile input/1stp/derived/1stp_protein.maps.fld -lfile input/1stp/derived/1stp_ligand.pdbqt -nrun 1 -nev 100 -lsit 10
	
