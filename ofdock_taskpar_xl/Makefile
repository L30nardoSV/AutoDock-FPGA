# All included makefiles refer to 
# the official SDAccel GitHub repository / aws_2017.4 branch.
# These are not modified at all. In case custom configuration is required, 
# the corresponding vars of these makefiles are modified from here.
COMMON_REPO := ../SDAccel_Examples

# Common Includes
include $(COMMON_REPO)/utility/boards.mk
include $(COMMON_REPO)/libs/xcl2/xcl2.mk
include $(COMMON_REPO)/libs/opencl/opencl.mk

# Added to fix the unnecessarily required pointer 
# to global memory in each kernel
OTHER_FLAGS=

ifeq ($(TARGETS), sw_emu)
	OTHER_FLAGS=-DSW_EMU
endif

# Enable Kernels
ENABLE_KERNELS = -DENABLE_KRNL_GA \
		 -DENABLE_KRNL_CONFORM \
		 -DENABLE_KRNL_INTERE \
		 -DENABLE_KRNL_INTRAE \
		 -DENABLE_KRNL_PRNG_BT_USHORT_FLOAT \
		 -DENABLE_KRNL_PRNG_GG_UCHAR \
		 -DENABLE_KRNL_PRNG_GG_FLOAT \
		 -DENABLE_KRNL_PRNG_LS123_USHORT \
	         -DENABLE_KRNL_PRNG_LS_FLOAT  \
		 -DENABLE_KRNL_PRNG_LS2_FLOAT \
		 -DENABLE_KRNL_PRNG_LS3_FLOAT \
		 -DENABLE_KRNL_PRNG_LS4_FLOAT \
		 -DENABLE_KRNL_PRNG_LS5_FLOAT \
		 -DENABLE_KRNL_PRNG_LS6_FLOAT \
		 -DENABLE_KRNL_PRNG_LS7_FLOAT \
		 -DENABLE_KRNL_PRNG_LS8_FLOAT \
		 -DENABLE_KRNL_PRNG_LS9_FLOAT \
		 -DENABLE_KRNL_LS  \
		 -DENABLE_KRNL_LS2 \
		 -DENABLE_KRNL_LS3 \
		 -DENABLE_KRNL_LS4 \
		 -DENABLE_KRNL_LS5 \
		 -DENABLE_KRNL_LS6 \
		 -DENABLE_KRNL_LS7 \
		 -DENABLE_KRNL_LS8 \
		 -DENABLE_KRNL_LS9 \
		 -DENABLE_KRNL_IGL_ARBITER

# Fixed-point
# FIxed-POint COform flag (FIPOCO)
FIXED_POINT_CONFORM=NO
FIXED_POINT_INTERE=NO
FIXED_POINT_INTRAE=NO
FIXED_POINT_ALL_LS=NO

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

ifeq ($(FIXED_POINT_ALL_LS), YES)
	FIPO_ALL_LS_FLAG=-DFIXED_POINT_LS1 -DFIXED_POINT_LS2 -DFIXED_POINT_LS3 -DFIXED_POINT_LS4 -DFIXED_POINT_LS5 -DFIXED_POINT_LS6 -DFIXED_POINT_LS7 -DFIXED_POINT_LS8 -DFIXED_POINT_LS9
else	
	FIPO_ALL_LS_FLAG=
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
	    $(FIPOLS9_FLAG)

# Other configs


# Overall custom configs
CONFIG_FLAG = $(FIPO_FLAG)

CXXFLAGS:=-Wall -O0 -g -std=c++14 $(OTHER_FLAGS)

# Host Application

hostbin_SRCS=$(wildcard ./host/src/*.cpp) \
		$(oclHelper_SRCS) \
		$(xcl2_SRCS)

hostbin_HDRS=$(wildcard ./host/inc/*.h) \
		$(xcl2_HDRS)

# -U__STRICT_ANSI__: to avoid: ‘cl_float3 {aka union cl_float4}’ has no member named ‘y’

hostbin_CXXFLAGS=   -I./host/inc/ \
		    -I. \
		    $(opencl_CXXFLAGS) $(xcl2_CXXFLAGS) $(oclHelper_CXXFLAGS) \
		    -std=c++0x \
		    -U__STRICT_ANSI__ \
		    $(ENABLE_KERNELS) \
	            $(CONFIG_FLAG)
   
hostbin_LDFLAGS=$(opencl_LDFLAGS) -lrt

EXES=hostbin

# Kernel
Krnl_GA_SRCS=./device/Krnl_GA.cl

# Custom configuration of vars within: boards.mk
CLFLAGS= --xp "param:compiler.version=31" \
	 --xp "param:compiler.preserveHlsOutput=1" \
	 --xp "param:compiler.generateExtraRunData=true" \
	 -s -g -I./ -I../ -I./device \
	 $(CONFIG_FLAG) \
	 $(OTHER_FLAGS)
LDCLFLAGS=$(CLFLAGS)

# Custom configuration of vars within: opencl.mk
opencl_LDFLAGS=-L$(OPENCL_LIB) -L$(SDA_LIB) -lxilinxopencl -pthread

#-------------------------------
# AWS only: apply the following 
# kernel compile & link configuration options

# Otherwise error during VPL
# "dr.bd.tcl" seems to be using a configuration for VCU1525
# instead for AWS VU9P

# Problem reported here:
# https://forums.xilinx.com/t5/SDAccel/Building-ERROR-VPL-17-55-set-property-expects-at-least-one/td-p/893221

# AWS reference guide
# https://github.com/aws/aws-fpga/blob/master/SDAccel/docs/On_Premises_Development_Steps.md
# aws-fpga/SDAccel/examples/aws/kernel_3ddr_bandwidth/Makefile

# https://www.xilinx.com/support/documentation/sw_manuals/xilinx2017_2/ug1023-sdaccel-user-guide.pdf
# Page 33 (could not find in the v2017.4)
# --max_memory_ports [all | <kernel_name>]
# Optional
# Sets the maximum memory port property 
# for all kernels or a given kernel

## Commented because it is example
## Choosing the "bandwidth" kernel for maximum memory port property 
# krnl_GA_CLFLAGS=--max_memory_ports bandwidth

## Commented because not all kernels in design need that
## Choosing the all kernels in design for maximum memory port property 
# Krnl_GA_CLFLAGS=--max_memory_ports all

## Ideal configuration, but results in routing error
#Krnl_GA_CLFLAGS=--max_memory_ports Krnl_GA \
#		--max_memory_ports Krnl_Conform \
#		--max_memory_ports Krnl_InterE \
#		--max_memory_ports Krnl_IntraE

#Krnl_GA_CLFLAGS=--max_memory_ports Krnl_GA

# https://www.xilinx.com/support/documentation/sw_manuals/xilinx2017_4/ug1023-sdaccel-user-guide.pdf
# Page 44
# --sp <kernel_inst_name>.<interface_name>:<bank>
# Valid DDR4 bank names are 
# bank0, bank1, bank2, and bank3 
# for platforms with 4 DDR banks.

## Commented because it is example
#krnl_GA_LDCLFLAGS+= --sp bandwidth_1.m_axi_gmem0:bank0 \
#		    --sp bandwidth_1.m_axi_gmem1:bank1 \
#		    --sp bandwidth_1.m_axi_gmem2:bank2	

## Ideal configuration, but results in routing error
# First two args of IntraE are the 2nd and 3rd of InterE (atom_charges & atom_types),
# Therefore they are mapped to the same DDR bank
#Krnl_GA_LDCLFLAGS+=--sp Krnl_GA_1.m_axi_gmem0:bank0 \
#		   --sp Krnl_GA_1.m_axi_gmem1:bank0 \
#		   --sp Krnl_GA_1.m_axi_gmem2:bank0 \
#		   --sp Krnl_GA_1.m_axi_gmem3:bank0 \
#		   --sp Krnl_Conform_1.m_axi_gmem0:bank1 \
#		   --sp Krnl_Conform_1.m_axi_gmem1:bank1 \
#		   --sp Krnl_Conform_1.m_axi_gmem2:bank1 \
#		   --sp Krnl_Conform_1.m_axi_gmem3:bank1 \
#		   --sp Krnl_Conform_1.m_axi_gmem4:bank1 \
#		   --sp Krnl_InterE_1.m_axi_gmem0:bank2 \
#		   --sp Krnl_InterE_1.m_axi_gmem1:bank2 \
#		   --sp Krnl_InterE_1.m_axi_gmem2:bank2 \
#		   --sp Krnl_IntraE_1.m_axi_gmem0:bank2	\
#		   --sp Krnl_IntraE_1.m_axi_gmem1:bank2	\
#		   --sp Krnl_IntraE_1.m_axi_gmem2:bank3	\
#		   --sp Krnl_IntraE_1.m_axi_gmem3:bank3	\
#		   --sp Krnl_IntraE_1.m_axi_gmem4:bank3	\
#		   --sp Krnl_IntraE_1.m_axi_gmem5:bank3	\
#		   --sp Krnl_IntraE_1.m_axi_gmem6:bank3	\
#		   --sp Krnl_IntraE_1.m_axi_gmem7:bank3	\
# 		   --sp Krnl_IntraE_1.m_axi_gmem8:bank3	\
#		   --sp Krnl_IntraE_1.m_axi_gmem9:bank3	\
#		   --sp Krnl_IntraE_1.m_axi_gmem10:bank3

#Krnl_GA_LDCLFLAGS+=--sp Krnl_GA_1.m_axi_gmem:bank0      \
#		   --sp Krnl_Conform_1.m_axi_gmem:bank1 \
#		   --sp Krnl_InterE_1.m_axi_gmem:bank2  \
#		   --sp Krnl_IntraE_1.m_axi_gmem:bank3

Krnl_GA_LDCLFLAGS+=--sp Krnl_GA_1.m_axi_gmem:bank0      \
		   --sp Krnl_Conform_1.m_axi_gmem:bank0 \
		   --sp Krnl_InterE_1.m_axi_gmem:bank1  \
		   --sp Krnl_IntraE_1.m_axi_gmem:bank1

##
# https://www.xilinx.com/support/documentation/sw_manuals/xilinx2017_4/ug1281-sdaccel-debugging-guide.pdf
# Page 32
# Instrumentation 1: Kernel Hangs due to AXI Violations
##

# Add Lightweight AXI Protocol Checker (lapc)
# <protocol:< compute_unit_name >:< interface_name >>
LAPC:=none

ifneq ($(LAPC),none)

## Commented because error was obtained:
## Number of axi protocol checkers requested must be between 1 and 63.
#Krnl_GA_LDCLFLAGS+=--dk protocol:all:all

## Warning obtained (not sure if because of configuration)
## # xbsak status --lapc
## Invalid codes read, skip decoding
Krnl_GA_LDCLFLAGS+=--dk protocol:Krnl_GA_1:m_axi_gmem0 \
		   --dk protocol:Krnl_GA_1:m_axi_gmem1 \
		   --dk protocol:Krnl_GA_1:m_axi_gmem2 \
		   --dk protocol:Krnl_GA_1:m_axi_gmem3 \
		   --dk protocol:Krnl_Conform_1:m_axi_gmem0 \
		   --dk protocol:Krnl_Conform_1:m_axi_gmem1 \
		   --dk protocol:Krnl_Conform_1:m_axi_gmem2 \
		   --dk protocol:Krnl_Conform_1:m_axi_gmem3 \
		   --dk protocol:Krnl_Conform_1:m_axi_gmem4 \
                   --dk protocol:Krnl_InterE_1:m_axi_gmem0 \
	 	   --dk protocol:Krnl_InterE_1:m_axi_gmem1 \
		   --dk protocol:Krnl_InterE_1:m_axi_gmem2 \
	           --dk protocol:Krnl_IntraE_1:m_axi_gmem0 \
		   --dk protocol:Krnl_IntraE_1:m_axi_gmem1 \
		   --dk protocol:Krnl_IntraE_1:m_axi_gmem2 \
	           --dk protocol:Krnl_IntraE_1:m_axi_gmem3 \
		   --dk protocol:Krnl_IntraE_1:m_axi_gmem4 \
		   --dk protocol:Krnl_IntraE_1:m_axi_gmem5 \
	           --dk protocol:Krnl_IntraE_1:m_axi_gmem6 \
		   --dk protocol:Krnl_IntraE_1:m_axi_gmem7 \
		   --dk protocol:Krnl_IntraE_1:m_axi_gmem8 \
	           --dk protocol:Krnl_IntraE_1:m_axi_gmem9 \
		   --dk protocol:Krnl_IntraE_1:m_axi_gmem10

## Commented because error was obtained:
## No interface pins matched 'get_bd_intf_pins -of /Krnl_Conform_1 -filter NAME=~m_axi_gmem'
## ERROR: caught error: Unable to find interface pin  for AXI protocol checker insertion
#Krnl_GA_LDCLFLAGS+=--dk protocol:Krnl_GA_1:m_axi_gmem \
#		   --dk protocol:Krnl_Conform_1:m_axi_gmem \
#                  --dk protocol:Krnl_InterE_1:m_axi_gmem \
#	           --dk protocol:Krnl_IntraE_1:m_axi_gmem
endif

## Adding Performance Monitors (spm) 
## enables the listing of detailed communication statistics (counters). 
## --profile_kernel data:<kernel_name|all>:<cu_name|all>:<interface_name|all>
SPM:=none

ifneq ($(SPM),none)
##--profile_kernel data:krnl1:cu1:m_axi_gmem0
##--profile_kernel data:krnl2:cu2:m_axi_gmem
Krnl_GA_LDCLFLAGS+=--profile_kernel data:Krnl_GA:Krnl_GA_1:all \
		   --profile_kernel data:Krnl_Conform:Krnl_Conform_1:all \
		   --profile_kernel data:Krnl_InterE:Krnl_InterE_1:all \
		   --profile_kernel data:Krnl_IntraE:Krnl_IntraE_1:all
endif

#-------------------------------




XOS=Krnl_GA

Krnl_GA_XOS=Krnl_GA

XCLBINS=Krnl_GA

# check
check_EXE=hostbin
check_XCLBINS=Krnl_GA
CHECKS=check

include $(COMMON_REPO)/utility/rules.mk

# Note that the definition of "newline" contains two blank lines.
# Using $(newline) will expand into only one newline.
define newline


endef

# Docking parameters 
# that directly determine the execution time
# Following values are used only for emulation
# to have a short but still a representative test
PDB  := 1stp
PSIZE:= 150
NRUN := 10
NEV  := 800000
NGEN := 27000
GFPOP:= 0

# Switching to the other SDAccel 2017.4 default platform
# As it is available in Xelera "saruman" server
#DEVICES:= xilinx:kcu1500:dynamic (in ../common_xilinx/utility/boards.mk)

# Boards in SDAccel installation path: /opt/cad/xilinx/SDx/2017.4/platforms/

# If several versions are present, e.g.: "vcu1525_5_0" and "vcu1525_5_1"
# Pay attention to which should be used
#BOARD:= xilinx:kcu1500:dynamic
#BOARD:= xilinx:vcu1525:dynamic

# Boards in external paths

# Cloned from https://github.com/aws/aws-fpga
# This corresponds to AWS Shell v04261818 
# https://github.com/aws/aws-fpga/blob/master/hdk/docs/AWS_Shell_RELEASE_NOTES.md
# IMPORTANT: source scripts to get the full DSA
# Because by default only the "sw" component is provided in GitHub
#BOARD:= /home/wimi/lvs/ocl_xilinx/aws-fpga/SDAccel/aws_platform/xilinx_aws-vu9p-f1-04261818_dynamic_5_0/xilinx_aws-vu9p-f1-04261818_dynamic_5_0.xpfm
BOARD:= /home/wimi/lvs/DSA_SDACCEL_AWS_VU9P/xilinx_aws-vu9p-f1-04261818_dynamic_5_0/xilinx_aws-vu9p-f1-04261818_dynamic_5_0.xpfm

# Copied from Xelera (saruman) SDAccel installation path
#BOARD:= /home/wimi/lvs/DSA_SDACCEL_AWS_VU9P/xilinx_aws-vu9p-f1_dynamic_5_0/xilinx_aws-vu9p-f1_dynamic_5_0.xpfm
#BOARD:= /home/wimi/lvs/DSA_SDACCEL_VCU1525_5_1/xilinx_vcu1525_dynamic_5_1/xilinx_vcu1525_dynamic_5_1.xpfm
#BOARD:= /opt/cad/xilinx/SDx/2017.1/platforms/xilinx_adm-pcie-7v3_1ddr_3_0/xilinx_adm-pcie-7v3_1ddr_3_0.xpfm

NDEVICES_EMU:=1


# Compile and generate report
kerrpt-sw:
	make clean
	@echo $(newline)
	make all REPORT=estimate TARGETS=sw_emu DEVICES=$(BOARD)
	@echo $(newline)
	cp ./xclbin/$(XCLBINS).sw_emu.*.xclbin .
	@echo $(newline)
	mv ./$(XCLBINS).sw_emu.*.xclbin ./$(XCLBINS).xclbin
	@echo $(newline)
	@echo "==============================================================================="
	@echo "INFO: sw emulation file created under: \"./xclbin/$(XCLBINS).sw_emu.*.xclbin\" "
	@echo "INFO: ... was copied and renamed as \"./$(XCLBINS).xclbin\"                    "
	@echo $(newline)
	@echo "INFO: a \"./system_estimate.xtxt\" report was generated!                       "
	@echo "==============================================================================="
	@echo $(newline)


# Compile for sw and hw emulation
kerswemu:
	make all TARGETS=sw_emu DEVICES=$(BOARD)
	@echo $(newline)
	@echo "==============================================================================="
	@echo "INFO: sw emulation file created under: \"./xclbin/$(XCLBINS).sw_emu.*.xclbin\" "
	@echo "==============================================================================="
	@echo $(newline)


kerhwemu:
	make all TARGETS=hw_emu	DEVICES=$(BOARD)
	cp ./xclbin/$(XCLBINS).hw_emu.*.xclbin .
	mv ./$(XCLBINS).hw_emu.*.xclbin ./$(XCLBINS).xclbin
	@echo $(newline)
	@echo "==============================================================================="
	@echo "INFO: hw emulation file created under: \"./xclbin/$(XCLBINS).hw_emu.*.xclbin\" "
	@echo "INFO: ... was copied and renamed as \"./$(XCLBINS).xclbin\"                    "
	@echo "==============================================================================="
	@echo $(newline)


# Run emulation
# Compilation (host & device) if not done previously
# The .dlg file is written in ./
# "exe" and "xclbin" are rules from "rules.mk"
# SDAccel 2017.4: User Guide UG1023, "Running Software and Hardware Emulation in XOCC Flow"
#emconfigutil --platform xilinx_vcu1525_dynamic_5_0 --nd 1
swemu: kerswemu
	emconfigutil --platform $(BOARD) --nd $(NDEVICES_EMU)
	XCL_EMULATION_MODE=sw_emu ./$(EXES) \
	-ffile input/$(PDB)/derived/$(PDB)_protein.maps.fld \
	-lfile input/$(PDB)/derived/$(PDB)_ligand.pdbqt \
	-psize $(PSIZE) -nrun $(NRUN) -nev $(NEV) -ngen $(NGEN) -gfpop 1
	@echo $(newline)
	@echo "===================================================================================="
	@echo "INFO: swemu log file is under: \"./docking.dlg\"                                    "
	@echo $(newline)
	@echo "INFO: profile and timeline trace report files are formatted for SDx GUI             "
	@echo "INFO: ... if reports not generated, verify that \"sdaccel.ini\" exists!             "
	@echo $(newline)
	sdx_analyze profile sdaccel_profile_summary.csv
	@echo $(newline)
	sdx_analyze trace sdaccel_timeline_trace.csv
	@echo $(newline)
	@echo "INFO: (1) open sdx, (2) select \"File->Open File\", (3) browse to *.xprf or *.wdb  "
	@echo "===================================================================================="
	@echo $(newline)

# Debug on software using Xilinx GDB
# Analyze hangs with the following gdb extensions:
# xprint queue [<cl_command_queue>]
# xprint event <cl_event>
# xprint mem [<cl_mem>]
# xprint kernel
# xprint all
swemudebug:
	xgdb --args \
	./$(EXES) \
	-ffile input/$(PDB)/derived/$(PDB)_protein.maps.fld \
	-lfile input/$(PDB)/derived/$(PDB)_ligand.pdbqt \
	-psize $(PSIZE) -nrun $(NRUN) -nev $(NEV) -ngen $(NGEN) -gfpop 1


hwemu: kerhwemu
	emconfigutil --platform $(BOARD) --nd $(NDEVICES_EMU)
	XCL_EMULATION_MODE=hw_emu ./$(EXES) \
	-ffile input/$(PDB)/derived/$(PDB)_protein.maps.fld \
	-lfile input/$(PDB)/derived/$(PDB)_ligand.pdbqt \
	-psize $(PSIZE) -nrun $(NRUN) -nev $(NEV) -ngen $(NGEN) -gfpop 1
	@echo $(newline)
	@echo "==========================================================================="
	@echo "INFO: hwemu log file is under: \"./docking.dlg\"                           "
	@echo $(newline)
	@echo "INFO: profile and timeline trace report files are formatted for SDx GUI    "
	@echo "INFO: ... if reports not generated, verify that \"sdaccel.ini\" exists!    "
	@echo $(newline)
	sdx_analyze profile sdaccel_profile_summary.csv
	@echo $(newline)
	sdx_analyze trace sdaccel_timeline_trace.csv
	@echo "==========================================================================="
	@echo $(newline)


# Build hw (FPGA bitstream)
# NOT integrated yet in a multistep compilation
hw: 	
	make all TARGETS=hw DEVICES=$(BOARD)
	@echo $(newline)
	@echo "========================================================================="
	@echo "INFO: FPGA bitstream is under: \"./xclbin/$(XCLBINS).hw.*.xclbin\"       " 
	@echo "========================================================================="
	@echo $(newline)


# Build instrumented hw (FPGA bitstream)
# NOT integrated yet in a multistep compilation
hw-instr: 	
	make all TARGETS=hw DEVICES=$(BOARD) LAPC=yes SPM=yes
	@echo $(newline)
	@echo "=============================================================================================="
	@echo "INFO: [instrumented] FPGA bitstream is under: \"./xclbin/$(XCLBINS).hw.*.xclbin\"             " 
	@echo "=============================================================================================="
	@echo $(newline)



# Execute on remote server
# Host-recompilation
# Copy of host to $(TARGET_DIR_HW)
# The working directory is changed
# So .dlg file is written in $(TARGET_DIR_HW)
eva: exe
	./$(EXES) \
	-ffile input/$(PDB)/derived/$(PDB)_protein.maps.fld \
	-lfile input/$(PDB)/derived/$(PDB)_ligand.pdbqt \
	-resnam docking_$(PDB)_$(NRUN) \
	-nrun $(NRUN) -gfpop $(GFPOP)
	@echo $(newline)
	@echo "==========================================================================="
	@echo "INFO: evaluation log file is under: \"./docking.dlg\"                      "
	@echo $(newline)
	@echo "INFO: profile and timeline trace report files are formatted for SDx GUI    "
	@echo "INFO: ... if reports not generated, verify that \"sdaccel.ini\" exists!    "
	@echo $(newline)
	sdx_analyze profile sdaccel_profile_summary.csv
	@echo $(newline)
	sdx_analyze trace sdaccel_timeline_trace.csv
	@echo "==========================================================================="
	@echo $(newline)


# Debug on hardware using Xilinx GDB
# Analyze hangs with the following gdb extensions:
# xprint queue [<cl_command_queue>]
# xprint event <cl_event>
# xprint mem [<cl_mem>]
# xprint kernel
# xprint all
evadebug:
	xgdb --args \
	./$(EXES) \
	-ffile input/$(PDB)/derived/$(PDB)_protein.maps.fld \
	-lfile input/$(PDB)/derived/$(PDB)_ligand.pdbqt \
	-resnam docking_debug_$(PDB)_$(NRUN) \
	-nrun $(NRUN) -gfpop $(GFPOP)


# Project name
PROJECT_NAME := ofdock_taskpar_xl

COPY_DIR := copy_$(PROJECT_NAME)
COPY_DIR_DOCK := $(PROJECT_NAME)

# Make sure this remote-server alias exists (in ~/.ssh/config)

## Xelera
#SERVER_BRIDGE := erebor:/scratch/
#SERVER_EXEC   := saruman:~/ocladock_sdx17_4

## AWS
SERVER_BRIDGE := eredmithrim:/home/lvs/ESA/AWS
SERVER_EXEC   := AWS

# Delete an existing folder if previously created
# Create a folder $(COPY_DIR) in the parent directory
# Copy binaries into $(COPY_DIR) folder, avoiding the (innecesary) compilation intermediate files
# Copy source files into $(COPY_DIR) as host is built in the remote $(SERVER)
# Create a zip file out of the $(COPY_DIR) folder
copy: clean-copy
	mkdir ../$(COPY_DIR)
	mkdir ../$(COPY_DIR)/$(COPY_DIR_DOCK)
	mkdir ../$(COPY_DIR)/$(COPY_DIR_DOCK)/xclbin
	cp ./xclbin/$(XCLBINS).hw.*.xclbin ../$(COPY_DIR)/$(COPY_DIR_DOCK)/xclbin/
	cp ./xclbin/$(XCLBINS).hw.*.xo ../$(COPY_DIR)/$(COPY_DIR_DOCK)/xclbin/
	cp ./xclbin/$(XCLBINS).hw.*.xclbin ../$(COPY_DIR)/$(COPY_DIR_DOCK)/
	mv ../$(COPY_DIR)/$(COPY_DIR_DOCK)/$(XCLBINS).hw.*.xclbin ../$(COPY_DIR)/$(COPY_DIR_DOCK)/$(XCLBINS).xclbin
	cp sdaccel.ini ../$(COPY_DIR)/$(COPY_DIR_DOCK)/
	cp Makefile ../$(COPY_DIR)/$(COPY_DIR_DOCK)/
	cp defines.h ../$(COPY_DIR)/$(COPY_DIR_DOCK)/
	cp defines_fixedpt.h ../$(COPY_DIR)/$(COPY_DIR_DOCK)/
	cp defines_fixedpt_64.h ../$(COPY_DIR)/$(COPY_DIR_DOCK)/
	cp -r device/ ../$(COPY_DIR)/$(COPY_DIR_DOCK)/
	cp -r host/ ../$(COPY_DIR)/$(COPY_DIR_DOCK)/
	#cp -r input/ ../$(COPY_DIR)/$(COPY_DIR_DOCK)/
	cp ../conf_sdx174_saruman.sh ../$(COPY_DIR)/
	cd ../;	zip -r $(COPY_DIR).zip $(COPY_DIR)
	@echo $(newline)
	@echo "Transfer the \"$(COPY_DIR).zip\" file to $(SERVER_BRIDGE) server: "
	@echo " "
	cd ../ && scp $(COPY_DIR).zip $(SERVER_BRIDGE)
	@echo $(newline)
	@echo "=================================================================="
	@echo "Files listed were transferred to $(SERVER_BRIDGE)                 "
	@echo $(newline)
	@echo "Then, create AFI and transfer files manually                      "
	@echo "from $(SERVER_BRIDGE) to $(SERVER_EXEC)                           "
	@echo "=================================================================="
	@echo $(newline)


clean-copy:
	rm -rf ../$(COPY_DIR)
	rm -f ../$(COPY_DIR).zip
	@echo $(newline)
	@echo "=================================================================="
	@echo "Previous \"$(COPY_DIR).zip\" and its folder were deleted          "
	@echo "=================================================================="
	@echo $(newline)


