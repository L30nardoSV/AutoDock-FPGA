# Copyright (C) 2013-2016 Altera Corporation, San Jose, California, USA. All rights reserved.
# Permission is hereby granted, free of charge, to any person obtaining a copy of this
# software and associated documentation files (the "Software"), to deal in the Software
# without restriction, including without limitation the rights to use, copy, modify, merge,
# publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to
# whom the Software is furnished to do so, subject to the following conditions:
# The above copyright notice and this permission notice shall be included in all copies or
# substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
# OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
# HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
# WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
# OTHER DEALINGS IN THE SOFTWARE.
# 
# This agreement shall be governed in all respects by the laws of the State of California and
# by the laws of the United States of America.
# This is a GNU Makefile.

# You must configure ALTERAOCLSDKROOT to point the root directory of the Intel(R) FPGA SDK for OpenCL(TM)
# software installation.
# See http://www.altera.com/literature/hb/opencl-sdk/aocl_getting_started.pdf 
# for more information on installing and configuring the Intel(R) FPGA SDK for OpenCL(TM).

VERBOSE = 1

ifeq ($(VERBOSE),1)
ECHO := 
else
ECHO := @
endif

# Where is the Intel(R) FPGA SDK for OpenCL(TM) software?
ifeq ($(wildcard $(ALTERAOCLSDKROOT)),)
$(error Set ALTERAOCLSDKROOT to the root directory of the Intel(R) FPGA SDK for OpenCL(TM) software installation)
endif
ifeq ($(wildcard $(ALTERAOCLSDKROOT)/host/include/CL/opencl.h),)
$(error Set ALTERAOCLSDKROOT to the root directory of the Intel(R) FPGA SDK for OpenCL(TM) software installation.)
endif

# OpenCL compile and link flags.
AOCL_COMPILE_CONFIG := $(shell aocl compile-config )
AOCL_LINK_CONFIG := $(shell aocl link-config )

#= defines a recursively-expanded variable
#:= defines a simply-expanded variable


# Compilation flags
ifeq ($(DEBUG),1)
CXXFLAGS += -g
else
CXXFLAGS += -O2
endif

# Compiler
CXX := g++

# Target name
TARGET := host

# Target folder for host & emulation binaries
TARGET_DIR := bin

# Target folder only for kernel report
TARGET_DIR_RPT := bin_rpt

# Target folder for FPGA binary
TARGET_DIR_HW := bin_hw

# Target folder for FPGA binary instrumented with performance counters
TARGET_DIR_HW_PROF := bin_hw_profile

# Directories
#INC_DIRS := ../common/inc
#INC_DIRS := ../common/inc wrapcl/inc host/inc ./
# Some extra software libraries provided along with the BSP
INC_DIRS := ../common/inc wrapcl/inc host/inc ./ $(AOCL_BOARD_PACKAGE_ROOT)/software/include/
LIB_DIRS := 

# Files
INCS := $(wildcard )

#SRCS := $(wildcard host/src/*.cpp ../common/src/AOCLUtils/*.cpp)

#AOCL_SRCS:=$(../common/src/AOCLUtils/*.cpp)
#OCL_SRCS:=$(wildcard wrapcl/src/*.cpp)
#DOCK_SRCS:=$(wildcard host/src/*.cpp)
#SRCS := $(AOCL_SRCS) $(OCL_SRCS) $(DOCK_SRCS) 
# Do not separate them
# Compilation and linking are done in a single step
# Otherwise, undefined functions when make
# http://stackoverflow.com/questions/5559250/c-error-undefined-reference-to-function-but-it-is-defined
SRCS := $(wildcard ../common/src/AOCLUtils/*.cpp wrapcl/src/*.cpp host/src/*.cpp)

LIBS := rt pthread

# =============================
# Print progress info
# =============================
PRINT_OCLINFO=NO

ifeq ($(PRINT_OCLINFO),YES)
	PRINT_OCL =-DPRINT_OCLINFO
else
	PRINT_OCL =
endif

# =============================
# Print docking debug info
# =============================
DOCK_DEBUG=NO

ifeq ($(DOCK_DEBUG),YES)
	DOCK_DEBUG_FLAG =-DDOCK_DEBUG
else
	DOCK_DEBUG_FLAG =
endif

# =============================
# Enable Kernels
# =============================
K15 =-DENABLE_KERNEL15
K20 =-DENABLE_KERNEL20
K21 =-DENABLE_KERNEL21
K27 =-DENABLE_KERNEL27
K35 =-DENABLE_KERNEL35
K36 =-DENABLE_KERNEL36
K37 =-DENABLE_KERNEL37
K38 =-DENABLE_KERNEL38
K39 =-DENABLE_KERNEL39
K40 =-DENABLE_KERNEL40
K41 =-DENABLE_KERNEL41
K42 =-DENABLE_KERNEL42
K43 =-DENABLE_KERNEL43
K44 =-DENABLE_KERNEL44
K45 =-DENABLE_KERNEL45
K46 =-DENABLE_KERNEL46
K47 =-DENABLE_KERNEL47
K48 =-DENABLE_KERNEL48

ENABLE_KERNELS = $(K15) $(K16) $(K17) $(K18) $(K19) $(K20) \
		 $(K21) $(K22) $(K23) $(K24) $(K25) $(K26) $(K27) $(K28) $(K29) $(K30) \
		 $(K31) $(K32) $(K33) $(K34) $(K35) $(K36) $(K37) $(K38) $(K39) $(K40) \
		 $(K41) $(K42) $(K43) $(K44) $(K45) $(K46) $(K47) $(K48)

# =============================
# Reproduce result (remove randomness)
# =============================
REPRO=NO

ifeq ($(REPRO), YES)
	REP=-DREPRO
else	
	REP=
endif

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
	    $(FIPOIE_FLAG) $(FIPOIA_FLAG) \
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

# =============================
# AOC flags
# =============================

# customized __constant memory size
# default: 16 KB
# custom: 12KB = 12288 Bytes
CUSTOMSIZE_CONSTMEM = YES

# relax the order of fp operations: -fp-relaxed
# reduce fp rounding operations: -fpc
RELAXED_REDUCED_FLOATINGPOINT = YES

ifeq ($(CUSTOMSIZE_CONSTMEM), YES)
	CUSTOMSIZE_CONSTMEM_FLAG=-const-cache-bytes=12288
else	
	CUSTOMSIZE_CONSTMEM_FLAG=
endif

ifeq ($(RELAXED_REDUCED_FLOATINGPOINT), YES)
	RELAXED_REDUCED_FLOATINGPOINT_FLAG=-fp-relaxed -fpc
else	
	RELAXED_REDUCED_FLOATINGPOINT_FLAG=
endif


AOC_FLAG = $(CUSTOMSIZE_CONSTMEM_FLAG) $(RELAXED_REDUCED_FLOATINGPOINT_FLAG)

# =============================

# Note that the definition of "newline" contains two blank lines.
# Using $(newline) will expand into only one newline.
define newline


endef

# Make it all!
all : $(TARGET_DIR)/$(TARGET)

# Host executable target.
#$(TARGET_DIR)/$(TARGET) : Makefile $(SRCS) $(INCS) $(TARGET_DIR)
#	$(ECHO)$(CXX) $(CPPFLAGS) $(CXXFLAGS) -fPIC $(foreach D,$(INC_DIRS),-I$D) \
#			$(AOCL_COMPILE_CONFIG) $(SRCS) $(AOCL_LINK_CONFIG) \
#			$(foreach D,$(LIB_DIRS),-L$D) \
#			$(foreach L,$(LIBS),-l$L) \
#			-o $(TARGET_DIR)/$(TARGET)

$(TARGET_DIR)/$(TARGET) : Makefile $(SRCS) $(INCS) $(TARGET_DIR)
	$(ECHO)$(CXX) $(CPPFLAGS) $(CXXFLAGS) -fPIC $(foreach D,$(INC_DIRS),-I$D) \
			$(AOCL_COMPILE_CONFIG) $(SRCS) $(AOCL_LINK_CONFIG) \
			$(foreach D,$(LIB_DIRS),-L$D) \
			$(foreach L,$(LIBS),-l$L) \
			-o $(TARGET_DIR)/$(TARGET) $(DOCK_DEBUG_FLAG) $(PRINT_OCL) $(ENABLE_KERNELS) $(REP) $(FIPO_FLAG)
	@echo $(newline)
	@echo "========================================================"
	@echo "INFO: host binary is under: \"$(TARGET_DIR)/$(TARGET)\" "
	@echo "========================================================"
	@echo $(newline)

# Docking parameters 
# that directly determine the execution time
# Following values are used only for emulation
# to have a short but still a representative test
PDB  := 1stp
PSIZE:= 150
NRUN := 10
NEV  := 50000
NGEN := 27000
GFPOP:= 0

# Project name
PROJECT_NAME := adfpga

# Device folder
# Device main kernel name
# Device main kernel source
# Target board
DEV_DIRS := device
KRNL_NAME:= Krnl_GA
DEV_SRC  := $(DEV_DIRS)/$(KRNL_NAME).cl
#BOARD    := Proc10A_X115
#BOARD    := p510t_sch_ax115
#BOARD    := p520_max_sg280l
#BOARD    := a10gx	# Use locally
BOARD    := pac_a10	# DevCloud

## Make it all: compilation (host & device) + run emulation
## Notice, it switches automatically to /bin folder
#emu: $(TARGET_DIR)/$(TARGET) keremu runemu

# Build kernel binary only for emulation
# Add "-g" to support kernel debug
# Creates under bin: 
# $(KRNL_NAME) folder
# $(KRNL_NAME).aoco
# $(KRNL_NAME).aocx
keremu: $(DEV_SRC)
	aoc -v -g \
	-march=emulator -legacy-emulator -emulator-channel-depth-model=strict \
	-board=$(BOARD) \
	$(DEV_SRC) \
	-o $(TARGET_DIR)/$(KRNL_NAME).aocx \
	$(REP) $(FIPO_FLAG) $(AOC_FLAG)
	@echo $(newline)
	@echo "=============================================================================="
	@echo "INFO: emulation files are under: \"$(TARGET_DIR)/$(KRNL_NAME)(.aoco)(.aocx)\" "
	@echo "=============================================================================="
	@echo $(newline)

# Run emulation
# Compilation (host & device) if not done previously
# The working directory is changed
# So .dlg file is written in $(TARGET_DIR)
emu: $(TARGET_DIR)/$(TARGET) keremu
	cd $(TARGET_DIR) && \
	CL_CONTEXT_EMULATOR_DEVICE_INTELFPGA=1 ./$(TARGET) \
	-ffile ../input/$(PDB)/derived/$(PDB)_protein.maps.fld \
	-lfile ../input/$(PDB)/derived/$(PDB)_ligand.pdbqt \
	-psize $(PSIZE) -nrun $(NRUN) -nev $(NEV) -ngen $(NGEN) -gfpop 1 \
	-resnam $(PDB)-"`date +"%Y-%m-%d-%H:%M"`"
	@echo $(newline)
	@echo "======================================================="
	@echo "INFO: log file is under: \"$(TARGET_DIR)/$(PDB)-<...>.dlg\" "
	@echo "======================================================="
	@echo $(newline)


# Intermediate C compilation
# Could be used in multistep compilation
intc: $(DEV_SRC)
	aoc -v -g \
	-c \
	-board=$(BOARD) \
	$(DEV_SRC) \
	-o $(TARGET_DIR_RPT)/$(KRNL_NAME).aoco \
	$(REP) $(FIPO_FLAG) $(AOC_FLAG) \
	-report
	@echo $(newline)
	@echo "====================================================================================="
	@echo "INFO: output files are under: \"$(TARGET_DIR_RPT)/$(KRNL_NAME).aoco\" "
	@echo "====================================================================================="
	@echo $(newline)

# Intermediate RTL compilation
# Could be used in multistep compilation
intrtl: $(DEV_SRC)
	aoc -v -g \
	-rtl \
	-board=$(BOARD) \
	$(DEV_SRC) \
	-o $(TARGET_DIR_RPT)/$(KRNL_NAME).aocr \
	$(REP) $(FIPO_FLAG) $(AOC_FLAG) \
	-report
	@echo $(newline)
	@echo "====================================================================================="
	@echo "INFO: report files are under: \"$(TARGET_DIR_RPT)/$(KRNL_NAME).aocr\" "
	@echo "====================================================================================="
	@echo $(newline)

kerrpt: intc intrtl
	@echo $(newline)
	@echo "====================================================================================="
	@echo "INFO: output files are under: \"$(TARGET_DIR_RPT)/$(KRNL_NAME)/reports/report.html\" "
	@echo $(newline)
	@echo "INFO: suggested steps for report analysis in local machine: "
	@echo "Devcloud: \"~/copy_adfpga/adfpga$$ zip -r reports.zip bin_rpt/Krnl_GA/reports/ \" "
	@echo "Local machine: \"scp devcloud:/home/u71100/copy_adfpga/adfpga/reports.zip . \" "
	@echo "====================================================================================="
	@echo $(newline)

# Build hw (FPGA bitstream)
# NOT integrated yet in a multistep compilation
# Creates under bin_hw:
# $(KRNL_NAME) folder
# $(KRNL_NAME).aoco
# $(KRNL_NAME).aocx
hw: 	
	aoc -board=$(BOARD) $(DEV_SRC) -o $(TARGET_DIR_HW)/$(KRNL_NAME).aocx $(FIPO_FLAG) $(AOC_FLAG)
	@echo $(newline)
	@echo "==============================================================================="
	@echo "INFO: FPGA bitstream is under: \"$(TARGET_DIR_HW)/$(KRNL_NAME)(.aoco)(.aocx)\" "
	@echo "==============================================================================="
	@echo $(newline)

hw-he:
	aoc -high-effort -board=$(BOARD) $(DEV_SRC) -o $(TARGET_DIR_HW)/$(KRNL_NAME).aocx $(FIPO_FLAG) $(AOC_FLAG)
	@echo $(newline)
	@echo "==============================================================================="
	@echo "INFO: FPGA bitstream is under: \"$(TARGET_DIR_HW)/$(KRNL_NAME)(.aoco)(.aocx)\" "
	@echo "==============================================================================="
	@echo $(newline)

# Build hw (FPGA bitstream) instrumented with performance counters
# NOT integrated yet in a multistep compilation
# Creates under bin_hw_profile
# $(KRNL_NAME) folder
# $(KRNL_NAME).aoco
# $(KRNL_NAME).aocx
hw-prof:
	aoc -profile -board=$(BOARD) $(DEV_SRC) -o $(TARGET_DIR_HW_PROF)/$(KRNL_NAME).aocx $(FIPO_FLAG) $(AOC_FLAG)
	@echo $(newline)
	@echo "================================================================================================="
	@echo "INFO: instrumented FPGA bitstream is under: \"$(TARGET_DIR_HW_PROF)/$(KRNL_NAME)(.aoco)(.aocx)\" "
	@echo "================================================================================================="
	@echo $(newline)

# Execute on remote server
# Host-recompilation
# Copy of host to $(TARGET_DIR_HW)
# The working directory is changed
# So .dlg file is written in $(TARGET_DIR_HW).
#
# For DevCloud, make sure binary was loaded as
# indicated in A10_v1.2.1_opencl_batch.sh
exe: $(TARGET_DIR)/$(TARGET)
	cp $(TARGET_DIR)/$(TARGET) $(TARGET_DIR_HW)/ && \
	cd $(TARGET_DIR_HW) && \
	./$(TARGET) \
	-ffile ../input/$(PDB)/derived/$(PDB)_protein.maps.fld \
	-lfile ../input/$(PDB)/derived/$(PDB)_ligand.pdbqt \
	-psize $(PSIZE) -nrun $(NRUN) -nev $(NEV) -ngen $(NGEN) -gfpop $(GFPOP) \
	-resnam $(PDB)-"`date +"%Y-%m-%d-%H:%M"`"
	@echo $(newline)
	@echo "========================================================================="
	@echo "INFO: log file is under: \"$(TARGET_DIR_HW)/$(PDB)-<...>.dlg\" "
	@echo "========================================================================="
	@echo $(newline)


# Execute and profile on remote server
# Host-recompilation
# Copy of host to $(TARGET_DIR_HW_PROF)
# The working directory is changed
# So .dlg file is written in $(TARGET_DIR_HW_PROF)
exe-prof: $(TARGET_DIR)/$(TARGET)
	cp $(TARGET_DIR)/$(TARGET) $(TARGET_DIR_HW_PROF)/ && \
	cd $(TARGET_DIR_HW_PROF) && \
	./$(TARGET) \
	-ffile ../input/$(PDB)/derived/$(PDB)_protein.maps.fld \
	-lfile ../input/$(PDB)/derived/$(PDB)_ligand.pdbqt \
	-psize $(PSIZE) -nrun $(NRUN) -nev $(NEV) -ngen $(NGEN) -gfpop $(GFPOP) \
	-resnam $(PDB)-"`date +"%Y-%m-%d-%H:%M"`"
	@echo $(newline)
	@echo "=============================================================================="
	@echo "INFO: log file is under: \"$(TARGET_DIR_HW_PROF)/$(PDB)-<...>.dlg\" "
	@echo "=============================================================================="
	@echo $(newline)

COPY_DIR := copy_$(PROJECT_NAME)
COPY_DIR_DOCK := $(PROJECT_NAME)

# Make sure this remote-server alias exists (in ~/.ssh/config)
SERVER_DEVCLOUD := devcloud
HOME_DEVCLOUD := /home/u71100

# Delete an existing folder if previously created
# Create a folder $(COPY_DIR) in the parent directory
# Copy source files into $(COPY_DIR) as host is built in the remote $(SERVER_DEVCLOUD)
# Create a zip file out of the $(COPY_DIR) folder
copy: clean-copy
	mkdir ../$(COPY_DIR)
	mkdir ../$(COPY_DIR)/$(COPY_DIR_DOCK)
	mkdir ../$(COPY_DIR)/$(COPY_DIR_DOCK)/$(TARGET_DIR_HW)
	mkdir ../$(COPY_DIR)/$(COPY_DIR_DOCK)/$(TARGET_DIR_HW_PROF)
	cp A10_v1.2.1_opencl_batch.sh ../$(COPY_DIR)/$(COPY_DIR_DOCK)/
	cp Makefile ../$(COPY_DIR)/$(COPY_DIR_DOCK)/
	cp defines.h ../$(COPY_DIR)/$(COPY_DIR_DOCK)/
	cp defines_fixedpt.h ../$(COPY_DIR)/$(COPY_DIR_DOCK)/
	cp defines_fixedpt_64.h ../$(COPY_DIR)/$(COPY_DIR_DOCK)/
	cp -r device/ ../$(COPY_DIR)/$(COPY_DIR_DOCK)/
	cp -r host/ ../$(COPY_DIR)/$(COPY_DIR_DOCK)/
	cp -r input/ ../$(COPY_DIR)/$(COPY_DIR_DOCK)/
	cp -r wrapcl/ ../$(COPY_DIR)/$(COPY_DIR_DOCK)/
	cp -r ../common ../$(COPY_DIR)/
	cd ../;	zip -r $(COPY_DIR).zip $(COPY_DIR)
	@echo $(newline)
	@echo "Transfer the $(COPY_DIR).zip file to $(SERVER_DEVCLOUD) server: "
	@echo $(newline)
	cd ../ && scp $(COPY_DIR).zip $(SERVER_DEVCLOUD):$(HOME_DEVCLOUD)
	@echo $(newline)
	@echo "=========================================================="
	@echo "Files listed were transferred to $(SERVER_DEVCLOUD):$(HOME_DEVCLOUD)"
	@echo "=========================================================="
	@echo $(newline)

clean-copy:
	rm -rf ../$(COPY_DIR)
	rm -f ../$(COPY_DIR).zip

$(TARGET_DIR) :
	$(ECHO)mkdir $(TARGET_DIR)
	
# Standard make targets
clean :
	$(ECHO)rm -f  $(TARGET_DIR)/$(TARGET)
	$(ECHO)rm -rf $(TARGET_DIR)/$(KRNL_NAME)
	$(ECHO)rm -f  $(TARGET_DIR)/$(KRNL_NAME).aocx
	$(ECHO)rm -f  $(TARGET_DIR)/$(KRNL_NAME).aoco
	$(ECHO)rm -f  $(TARGET_DIR)/initpop.txt
	$(ECHO)rm -f  $(TARGET_DIR)/docking.*
	$(ECHO)rm -f  $(TARGET_DIR)/final_population_*
	@echo $(newline)

.PHONY : all clean
