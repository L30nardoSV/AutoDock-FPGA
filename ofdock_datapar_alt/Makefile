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

DEBUG=1

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

# Target folder for FPGA binary
TARGET_DIR_HW := bin_hw

# Target folder for FPGA binary instrumented with performance counters
TARGET_DIR_HW_PROF := bin_hw_profile

# Directories
#INC_DIRS := ../common/inc
INC_DIRS := ../common/inc opencl_lvs/inc host/inc ./
LIB_DIRS := 

# Files
INCS := $(wildcard )

#SRCS := $(wildcard host/src/*.cpp ../common/src/AOCLUtils/*.cpp)

#AOCL_SRCS:=$(../common/src/AOCLUtils/*.cpp)
#OCL_SRCS:=$(wildcard opencl_lvs/src/*.cpp)
#DOCK_SRCS:=$(wildcard host/src/*.cpp)
#SRCS := $(AOCL_SRCS) $(OCL_SRCS) $(DOCK_SRCS) 
# Do not separate them
# Compilation and linking are done in a single step
# Otherwise, undefined functions when make
# http://stackoverflow.com/questions/5559250/c-error-undefined-reference-to-function-but-it-is-defined
SRCS := $(wildcard ../common/src/AOCLUtils/*.cpp opencl_lvs/src/*.cpp host/src/*.cpp)

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

ENABLE_KERNELS = $(K1) $(K2) $(K3) $(K4)

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
			-o $(TARGET_DIR)/$(TARGET) $(DOCK_DEBUG_FLAG) $(DEV) $(DOCK_PROG) $(ENABLE_KERNELS)
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
DEV_SRC  := $(DEV_DIRS)/calc_initpop.cl
BOARD_HARP2 := bdw_fpga_v1.0


#keremu

#emu

#kerrpt


# Build hw (FPGA bitstream)
# NOT integrated yet in a multistep compilation
# Creates under bin_hw:
	# "docking" folder
	# docking.aoco
	# docking.aocx
hw: 	
	aoc --board $(BOARD_HARP2) $(DEV_SRC) -o $(TARGET_DIR_HW)/docking.aocx
	@echo " "
	@echo "==========================================================="
	@echo "INFO: FPGA bitstream is under: bin_hw/docking(.aoco)(.aocx)"
	@echo "==========================================================="
	@echo " "

# Build hw (FPGA bitstream) instrumented with performance counters
# NOT integrated yet in a multistep compilation
# Creates under bin_hw_profile
	# "docking" folder
	# docking.aoco
	# docking.aocx
hw_profile:
	aoc --profile --board $(BOARD_HARP2) $(DEV_SRC) -o $(TARGET_DIR_HW_PROF)/docking.aocx
	@echo " "
	@echo "================================================================================"
	@echo "INFO: instrumented FPGA bitstream is under: bin_hw_profile/docking(.aoco)(.aocx)"
	@echo "================================================================================"
	@echo " "


HARP2_DIR := copyharp2_datapar
HARP2_DIR_DOCK := ofdock_datapar_alt

# Delete an existing folder if previously created
# Create a folder $(HARP2_DIR) in the parent directory
# Copy binaries into $(HARP2_DIR) folder, avoiding the (innecesary) compilation intermediate files
# Copy source files into $(HARP2_DIR) as host is built in the HARP2 front-end
# Create a zip file out of the $(HARP2_DIR) folder
copyharp2: clean_copyharp2
	mkdir ../$(HARP2_DIR)
	mkdir ../$(HARP2_DIR)/$(HARP2_DIR_DOCK)
	mkdir ../$(HARP2_DIR)/$(HARP2_DIR_DOCK)/$(TARGET_DIR_HW)
	mkdir ../$(HARP2_DIR)/$(HARP2_DIR_DOCK)/$(TARGET_DIR_HW_PROF)
	cp $(TARGET_DIR_HW)/docking.* ../$(HARP2_DIR)/$(HARP2_DIR_DOCK)/$(TARGET_DIR_HW)/
	cp $(TARGET_DIR_HW_PROF)/docking.* ../$(HARP2_DIR)/$(HARP2_DIR_DOCK)/$(TARGET_DIR_HW_PROF)/
	cp Makefile ../$(HARP2_DIR)/$(HARP2_DIR_DOCK)/
	cp defines.h ../$(HARP2_DIR)/$(HARP2_DIR_DOCK)/
	cp -r device/ ../$(HARP2_DIR)/$(HARP2_DIR_DOCK)/
	cp -r host/ ../$(HARP2_DIR)/$(HARP2_DIR_DOCK)/
	cp -r input/ ../$(HARP2_DIR)/$(HARP2_DIR_DOCK)/
	cp -r wrapcl/ ../$(HARP2_DIR)/$(HARP2_DIR_DOCK)/
	cp -r ../common ../$(HARP2_DIR)/
	cd ../;	zip -r $(HARP2_DIR).zip $(HARP2_DIR)
	@echo "================================================================================"
	@echo "The next step is to transfer the .zip file to the HARP2 fron-end: "
	@echo "> cd .."
	@echo "> scp copyharp2.zip h2solis@fe-1.harp.pc2.uni-paderborn.de:~/ocladock/"
	@echo "================================================================================"
	@echo " "

clean_copyharp2:
	rm -r ../$(HARP2_DIR)


$(TARGET_DIR) :
	$(ECHO)mkdir $(TARGET_DIR)
	
# Standard make targets
clean :
	$(ECHO)rm -f $(TARGET_DIR)/$(TARGET)

.PHONY : all clean
