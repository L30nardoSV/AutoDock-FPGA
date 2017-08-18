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

# Target
TARGET := host
TARGET_DIR := bin

# Directories
#INC_DIRS := ../common/inc
INC_DIRS := ../common/inc wrapcl/inc host/inc ./
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
# Select OpenCL device type
# =============================
CPU_DEVICE=NO
GPU_DEVICE=NO
FPGA_DEVICE=NO

ifeq ($(CPU_DEVICE),YES)
	DEV =-DCPU_DEVICE

else ifeq ($(GPU_DEVICE),YES)
	DEV =-DGPU_DEVICE

else ifeq ($(FPGA_DEVICE),YES)
	DEV =-DFPGA_DEVICE
else 
	DEV =-DALL_DEVICE
endif

# =============================
# Print progress info
# =============================
PRINT_PROGRESS=YES

ifeq ($(PRINT_PROGRESS),YES)
	DOCK_PROG =-DPRINT_PROGRESS
else
	DOCK_PROG =
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
ENABLE_K1 = YES
ENABLE_K2 = YES
ENABLE_K3 = YES
ENABLE_K4 = YES
ENABLE_K5 = YES
ENABLE_K6 = YES
ENABLE_K7 = YES
ENABLE_K8 = YES

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

ENABLE_KERNELS = $(K1) $(K2) $(K3) $(K4) $(K5) $(K6) $(K7) $(K8)

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
			-o $(TARGET_DIR)/$(TARGET) $(DOCK_DEBUG_FLAG) $(DEV) $(DOCK_PROG) $(ENABLE_KERNELS) $(REP)
	@echo " "
	@echo "================================"
	@echo "INFO: host binary is under: bin/"
	@echo "================================"
	@echo " "





# Docking parameters
PDB  := 1stp
NRUN := 10
NEV  := 200000

# Device folder
# Device main kernel name
# Device main kernel source
DEV_DIRS := device
DEV_SRC  := $(DEV_DIRS)/Krnl_GA.cl
BOARD_HARP2 := bdw_fpga_v1.0

## Make it all: compilation (host & device) + run emulation
## Notice, it switches automatically to /bin folder
#emu: $(TARGET_DIR)/$(TARGET) keremu runemu

# Build kernel binary only for emulation
# Creates under bin: 
	# "docking" folder
	# docking.aoco
	# docking.aocx
keremu: $(DEV_SRC)
	aoc -march=emulator -v --board $(BOARD_HARP2) $(DEV_SRC) -o $(TARGET_DIR)/docking.aocx $(REP)
	@echo " "
	@echo "=========================================================="
	@echo "INFO: emulation files are under: bin/docking(.aoco)(.aocx)"
	@echo "=========================================================="
	@echo " "

# Run emulation
# Compilation (host & device) if not done previously
# The working directory is changed
# So .dlg file is written there
emu: $(TARGET_DIR)/$(TARGET) keremu
	cd $(TARGET_DIR) && \
	CL_CONTEXT_EMULATOR_DEVICE_ALTERA=1 ./$(TARGET) -ffile ../input/$(PDB)/derived/$(PDB)_protein.maps.fld -lfile ../input/$(PDB)/derived/$(PDB)_ligand.pdbqt -nev $(NEV) -nrun $(NRUN) -gfpop 1
	@echo " "
	@echo "========================================"
	@echo "INFO: log file is under: bin/docking.dlg"
	@echo "========================================"
	@echo " "


# Reports are generated
# Could be used in multistep compilation
# Creates under bin:
	# "docking" folder -> /reports/report.html, to see details
	# docking.aoco
	# No actual hardware is built (NO .aocx)
kerrpt: $(DEV_SRC)
	aoc --board $(BOARD_HARP2) $(DEV_SRC) -o $(TARGET_DIR)/docking.aoco $(REP) -c --report
	@echo " "
	@echo "============================================================="
	@echo "INFO: report files are under: bin/docking/reports/report.html"
	@echo "============================================================="
	@echo " "

# Build hw (FPGA bitstream)
# NOT integrated yet in a multistep compilation
# Creates under root folder:
	# "docking" folder
	# docking.aoco
	# docking.aocx
hw: 	
	aoc --board $(BOARD_HARP2) $(DEV_SRC) -o docking.aocx
	@echo " "
	@echo "================================="
	@echo "INFO: FPGA bitstream is under: ./"
	@echo "================================="
	@echo " "





$(TARGET_DIR) :
	$(ECHO)mkdir $(TARGET_DIR)
	
# Standard make targets
clean :
	$(ECHO)rm -f $(TARGET_DIR)/$(TARGET)
	$(ECHO)rm -f $(TARGET_DIR)/initpop.txt

.PHONY : all clean
