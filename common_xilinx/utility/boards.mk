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
ENABLE_K1  = YES
ENABLE_K2  = YES
ENABLE_K3  = YES
ENABLE_K4  = YES

# Prng kernels
ENABLE_K6  = YES
ENABLE_K7  = YES

# ls1 prng
ENABLE_K10 = YES

# Replace single Krnl_Prng_Arbiter
# See kernels 31, 32, 33, 34

# LS kernels
ENABLE_K12 = YES

# disable Krnl_LS_Arbiter
ENABLE_K14 = YES
ENABLE_K15 = YES

ENABLE_K20 = YES
ENABLE_K21 = YES

# PRNGS in GA for LS2 and LS3

ENABLE_K27 = YES

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

ifeq ($(ENABLE_K10),YES)
	K10 =-DENABLE_KERNEL10
else
	K10 =
endif

ifeq ($(ENABLE_K12),YES)
	K12 =-DENABLE_KERNEL12
else
	K12 =
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

ifeq ($(ENABLE_K27),YES)
	K27 =-DENABLE_KERNEL27
else
	K27 =
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
ENABLE_KERNELS = $(K1)  $(K2)  $(K3)  $(K4)         $(K6)  $(K7)                $(K10) \
		        $(K12)        $(K14) $(K15)                             $(K20) \
		 $(K21)                                    $(K27)                      \
		                             $(K35) $(K36) $(K37) $(K38) $(K39) $(K40) \
		 $(K41) $(K42) $(K43) $(K44) $(K45) $(K46) $(K47) $(K48)

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

