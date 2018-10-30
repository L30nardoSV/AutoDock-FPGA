# By Default report is set to none, so report will be generated
# 'estimate' for estimate report generation
# 'system' for system report generation
REPORT:=none
PROFILE ?= no

OTHER_FLAGS=

ifeq ($(TARGETS), sw_emu)
	OTHER_FLAGS=-DSW_EMU
endif

#ifeq ($(TARGETS), hw_emu)
#	OTHER_FLAGS=-DSW_EMU
#endif

# Default C++ Compiler Flags and xocc compiler flags
CXXFLAGS:=-Wall -O0 -g -std=c++14 $(OTHER_FLAGS)

# =============================
# Enable Kernels
# ============================= 
ENABLE_KRNL_GA       = YES
ENABLE_KRNL_CONFORM  = YES
ENABLE_KRNL_INTERE   = YES
ENABLE_KRNL_INTRAE   = YES

ENABLE_KRNL_PRNG_BT_USHORT_FLOAT = YES
ENABLE_KRNL_PRNG_GG_UCHAR        = YES
ENABLE_KRNL_PRNG_GG_FLOAT        = YES

ENABLE_KRNL_PRNG_LS123_USHORT    = YES
ENABLE_KRNL_PRNG_LS_FLOAT  	 = YES
ENABLE_KRNL_PRNG_LS2_FLOAT       = YES
ENABLE_KRNL_PRNG_LS3_FLOAT       = YES

ENABLE_KRNL_PRNG_LS4_FLOAT       = YES
ENABLE_KRNL_PRNG_LS5_FLOAT       = YES
ENABLE_KRNL_PRNG_LS6_FLOAT       = YES
ENABLE_KRNL_PRNG_LS7_FLOAT       = YES
ENABLE_KRNL_PRNG_LS8_FLOAT       = YES
ENABLE_KRNL_PRNG_LS9_FLOAT       = YES

ENABLE_KRNL_LS  = YES
ENABLE_KRNL_LS2 = YES
ENABLE_KRNL_LS3 = YES
ENABLE_KRNL_LS4 = YES
ENABLE_KRNL_LS5 = YES
ENABLE_KRNL_LS6 = YES
ENABLE_KRNL_LS7 = YES
ENABLE_KRNL_LS8 = YES
ENABLE_KRNL_LS9 = YES

ENABLE_K27 = YES

ifeq ($(ENABLE_KRNL_GA),YES)
	KRNL_GA =-DENABLE_KRNL_GA
else
	KRNL_GA =
endif

ifeq ($(ENABLE_KRNL_CONFORM),YES)
	KRNL_CONFORM =-DENABLE_KRNL_CONFORM
else
	KRNL_CONFORM =
endif

ifeq ($(ENABLE_KRNL_INTERE),YES)
	KRNL_INTERE =-DENABLE_KRNL_INTERE
else
	KRNL_INTERE =
endif

ifeq ($(ENABLE_KRNL_INTRAE),YES)
	KRNL_INTRAE =-DENABLE_KRNL_INTRAE
else
	KRNL_INTRAE =
endif

ifeq ($(ENABLE_KRNL_PRNG_BT_USHORT_FLOAT),YES)
	KRNL_PRNG_BT_USHORT_FLOAT =-DENABLE_KRNL_PRNG_BT_USHORT_FLOAT
else
	KRNL_PRNG_BT_USHORT_FLOAT =
endif

ifeq ($(ENABLE_KRNL_PRNG_GG_UCHAR),YES)
	KRNL_PRNG_GG_UCHAR =-DENABLE_KRNL_PRNG_GG_UCHAR
else
	KRNL_PRNG_GG_UCHAR =
endif

ifeq ($(ENABLE_KRNL_PRNG_GG_FLOAT),YES)
	KRNL_PRNG_GG_FLOAT =-DENABLE_KRNL_PRNG_GG_FLOAT
else
	KRNL_PRNG_GG_FLOAT =
endif

ifeq ($(ENABLE_KRNL_PRNG_LS123_USHORT),YES)
	KRNL_PRNG_LS123_USHORT =-DENABLE_KRNL_PRNG_LS123_USHORT
else
	KRNL_PRNG_LS123_USHORT =
endif

ifeq ($(ENABLE_KRNL_PRNG_LS_FLOAT),YES)
	KRNL_PRNG_LS_FLOAT =-DENABLE_KRNL_PRNG_LS_FLOAT
else
	KRNL_PRNG_LS_FLOAT =
endif

ifeq ($(ENABLE_KRNL_PRNG_LS2_FLOAT),YES)
	KRNL_PRNG_LS2_FLOAT =-DENABLE_KRNL_PRNG_LS2_FLOAT
else
	KRNL_PRNG_LS2_FLOAT =
endif

ifeq ($(ENABLE_KRNL_PRNG_LS3_FLOAT),YES)
	KRNL_PRNG_LS3_FLOAT =-DENABLE_KRNL_PRNG_LS3_FLOAT
else
	KRNL_PRNG_LS3_FLOAT =
endif

ifeq ($(ENABLE_KRNL_PRNG_LS4_FLOAT),YES)
	KRNL_PRNG_LS4_FLOAT =-DENABLE_KRNL_PRNG_LS4_FLOAT
else
	KRNL_PRNG_LS4_FLOAT =
endif

ifeq ($(ENABLE_KRNL_PRNG_LS5_FLOAT),YES)
	KRNL_PRNG_LS5_FLOAT =-DENABLE_KRNL_PRNG_LS5_FLOAT
else
	KRNL_PRNG_LS5_FLOAT =
endif

ifeq ($(ENABLE_KRNL_PRNG_LS6_FLOAT),YES)
	KRNL_PRNG_LS6_FLOAT =-DENABLE_KRNL_PRNG_LS6_FLOAT
else
	KRNL_PRNG_LS6_FLOAT =
endif

ifeq ($(ENABLE_KRNL_PRNG_LS7_FLOAT),YES)
	KRNL_PRNG_LS7_FLOAT =-DENABLE_KRNL_PRNG_LS7_FLOAT
else
	KRNL_PRNG_LS7_FLOAT =
endif

ifeq ($(ENABLE_KRNL_PRNG_LS8_FLOAT),YES)
	KRNL_PRNG_LS8_FLOAT =-DENABLE_KRNL_PRNG_LS8_FLOAT
else
	KRNL_PRNG_LS8_FLOAT =
endif

ifeq ($(ENABLE_KRNL_PRNG_LS9_FLOAT),YES)
	KRNL_PRNG_LS9_FLOAT =-DENABLE_KRNL_PRNG_LS9_FLOAT
else
	KRNL_PRNG_LS9_FLOAT =
endif

ifeq ($(ENABLE_KRNL_LS),YES)
	KRNL_LS =-DENABLE_KRNL_LS
else
	KRNL_LS =
endif

ifeq ($(ENABLE_KRNL_LS2),YES)
	KRNL_LS2 =-DENABLE_KRNL_LS2
else
	KRNL_LS2 =
endif

ifeq ($(ENABLE_KRNL_LS3),YES)
	KRNL_LS3 =-DENABLE_KRNL_LS3
else
	KRNL_LS3 =
endif

ifeq ($(ENABLE_KRNL_LS4),YES)
	KRNL_LS4 =-DENABLE_KRNL_LS4
else
	KRNL_LS4 =
endif

ifeq ($(ENABLE_KRNL_LS5),YES)
	KRNL_LS5 =-DENABLE_KRNL_LS5
else
	KRNL_LS5 =
endif

ifeq ($(ENABLE_KRNL_LS6),YES)
	KRNL_LS6 =-DENABLE_KRNL_LS6
else
	KRNL_LS6 =
endif

ifeq ($(ENABLE_KRNL_LS7),YES)
	KRNL_LS7 =-DENABLE_KRNL_LS7
else
	KRNL_LS7 =
endif

ifeq ($(ENABLE_KRNL_LS8),YES)
	KRNL_LS8 =-DENABLE_KRNL_LS8
else
	KRNL_LS8 =
endif

ifeq ($(ENABLE_KRNL_LS9),YES)
	KRNL_LS9 =-DENABLE_KRNL_LS9
else
	KRNL_LS9 =
endif









ifeq ($(ENABLE_K27),YES)
	K27 =-DENABLE_KERNEL27
else
	K27 =
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

ENABLE_KERNELS = $(KRNL_GA) \
		 $(KRNL_CONFORM) \
		 $(KRNL_INTERE) \
		 $(KRNL_INTRAE) \
		 $(KRNL_PRNG_BT_USHORT_FLOAT) \
		 $(KRNL_PRNG_GG_UCHAR) \
		 $(KRNL_PRNG_GG_FLOAT) \
		 $(KRNL_PRNG_LS123_USHORT) \
	         $(KRNL_PRNG_LS_FLOAT)  \
		 $(KRNL_PRNG_LS2_FLOAT) \
		 $(KRNL_PRNG_LS3_FLOAT) \
		 $(KRNL_PRNG_LS4_FLOAT) \
		 $(KRNL_PRNG_LS5_FLOAT) \
		 $(KRNL_PRNG_LS6_FLOAT) \
		 $(KRNL_PRNG_LS7_FLOAT) \
		 $(KRNL_PRNG_LS8_FLOAT) \
		 $(KRNL_PRNG_LS9_FLOAT) \
		 $(KRNL_LS)  \
		 $(KRNL_LS2) \
		 $(KRNL_LS3) \
		 $(KRNL_LS4) \
		 $(KRNL_LS5) \
		 $(KRNL_LS6) \
		 $(KRNL_LS7) \
		 $(KRNL_LS8) \
		 $(KRNL_LS9) \
		 $(K27)

# =============================
# Fixed-point
# =============================
# FIxed-POint COform flag (FIPOCO)
#FIXED_POINT_CONFORM=YES
FIXED_POINT_CONFORM=NO

FIXED_POINT_INTERE=NO
FIXED_POINT_INTRAE=NO

#FIXED_POINT_LS1=YES
#FIXED_POINT_LS2=YES
#FIXED_POINT_LS3=YES
#FIXED_POINT_LS4=YES
#FIXED_POINT_LS5=YES
#FIXED_POINT_LS6=YES
#FIXED_POINT_LS7=YES
#FIXED_POINT_LS8=YES
#FIXED_POINT_LS9=YES
FIXED_POINT_LS1=NO
FIXED_POINT_LS2=NO
FIXED_POINT_LS3=NO
FIXED_POINT_LS4=NO
FIXED_POINT_LS5=NO
FIXED_POINT_LS6=NO
FIXED_POINT_LS7=NO
FIXED_POINT_LS8=NO
FIXED_POINT_LS9=NO

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

# Definition of OTHER_FLAGS (moved to the top)

# Set manually the frequency to 200 MHz
# TODO: make it configurable from Makefile
# https://forums.xilinx.com/t5/SDAccel/SDAccel-asks-to-set-lower-frequency-by-specifying-kernel/td-p/799137
#OTHER_FLAGS+=--kernel_frequency 200

#https://www.xilinx.com/html_docs/xilinx2018_1/sdsoc_doc/nts1517252127891.html
#CLFLAGS:= --xp "param:compiler.preserveHlsOutput=1" --xp "param:compiler.generateExtraRunData=true" -s
#CLFLAGS:= --xp "param:compiler.version=31" --xp "param:compiler.preserveHlsOutput=1" --xp "param:compiler.generateExtraRunData=true" -s 
#CLFLAGS:= --xp "param:compiler.version=31" --xp "param:compiler.preserveHlsOutput=1" --xp "param:compiler.generateExtraRunData=true" -s -I./ -I../ -I./device
#CLFLAGS:= --xp "param:compiler.version=31" --xp "param:compiler.preserveHlsOutput=1" --xp "param:compiler.generateExtraRunData=true" -s -I./ -I../ -I./device $(REP) $(FIPO_FLAG)
CLFLAGS:= --xp "param:compiler.version=31" --xp "param:compiler.preserveHlsOutput=1" --xp "param:compiler.generateExtraRunData=true" -s -g -I./ -I../ -I./device $(REP) $(FIPO_FLAG) $(OTHER_FLAGS)


ifneq ($(REPORT),none)
CLFLAGS += --report $(REPORT)
endif 

ifeq ($(PROFILE),yes)
CLFLAGS += --profile_kernel data:all:all:all
endif

LDCLFLAGS:=$(CLFLAGS)

ifdef XILINX_SDX
XILINX_SDACCEL=${XILINX_SDX}
endif

ifndef XILINX_SDACCEL
$(error XILINX_SDX variable is not set, please set correctly and rerun)
endif

VIVADO=$(XILINX_VIVADO)/bin/vivado

# Use the Xilinx OpenCL compiler
CLC:=$(XILINX_SDACCEL)/bin/xocc
LDCLC:=$(CLC)
EMCONFIGUTIL := $(XILINX_SDACCEL)/bin/emconfigutil

# By default build for X86, this could also be set to POWER to build for power
ARCH:=X86

DEVICES:= xilinx:kcu1500:dynamic

ifeq ($(ARCH),POWER)
CXX:=$(XILINX_SDACCEL)/gnu/ppc64le/4.9.3/lnx64/bin/powerpc64le-linux-gnu-g++
else
CXX:=$(XILINX_SDACCEL)/bin/xcpp
endif

#if COMMON_REPO is not defined use the default value support existing Designs
COMMON_REPO ?= ../../

# By default build for hardware can be set to
#   hw_emu for hardware emulation
#   sw_emu for software emulation
#   or a collection of all or none of these
TARGETS:=hw

# By default only have one device in the system
NUM_DEVICES:=1

# sanitize_dsa - create a filesystem friendly name from dsa name
#   $(1) - name of dsa
COLON=:
PERIOD=.
UNDERSCORE=_
sanitize_dsa = $(strip $(subst $(PERIOD),$(UNDERSCORE),$(subst $(COLON),$(UNDERSCORE),$(1))))

device2dsa = $(if $(filter $(suffix $(1)),.xpfm),$(shell $(COMMON_REPO)/utility/parsexpmf.py $(1) dsa 2>/dev/null),$(1))
device2sandsa = $(call sanitize_dsa,$(call device2dsa,$(1)))
device2dep = $(if $(filter $(suffix $(1)),.xpfm),$(dir $(1))/$(shell $(COMMON_REPO)/utility/parsexpmf.py $(1) hw 2>/dev/null) $(1),)

