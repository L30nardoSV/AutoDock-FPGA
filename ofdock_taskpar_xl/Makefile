COMMON_REPO := ../common_xilinx/

#Common Includes
include $(COMMON_REPO)/utility/boards.mk
include $(COMMON_REPO)/libs/xcl2/xcl2.mk
include $(COMMON_REPO)/libs/opencl/opencl.mk






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

# Boards in SDAccel installation path
# If several versions are present, e.g.: "vcu1525_5_0" and "vcu1525_5_1"
# Pay attention to which should be used
#BOARD:= xilinx:kcu1500:dynamic
#BOARD:= xilinx:vcu1525:dynamic

# Boards in external paths
BOARD:= /home/wimi/lvs/DSA_SDACCEL_VCU1525_5_1/xilinx_vcu1525_dynamic_5_1/xilinx_vcu1525_dynamic_5_1.xpfm
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
	cp ./xclbin/$(XCLBINS).sw_emu.*.xclbin .
	mv ./$(XCLBINS).sw_emu.*.xclbin ./$(XCLBINS).xclbin
	@echo $(newline)
	@echo "==============================================================================="
	@echo "INFO: sw emulation file created under: \"./xclbin/$(XCLBINS).sw_emu.*.xclbin\" "
	@echo "INFO: ... was copied and renamed as \"./$(XCLBINS).xclbin\"    	              "
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


sw-debug:
	XCL_EMULATION_MODE=sw_emu \
	xgdb -args ./$(EXES) \
	-ffile input/1stp/derived/1stp_protein.maps.fld \
	-lfile input/1stp/derived/1stp_ligand.pdbqt \
	-nrun 1 -nev 100 -lsit 10 -psize 10


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


# Project name
PROJECT_NAME := ofdock_taskpar_xl

COPY_DIR := copy_$(PROJECT_NAME)
COPY_DIR_DOCK := $(PROJECT_NAME)

# Make sure this remote-server alias exists (in ~/.ssh/config)
SERVER_BRIDGE := erebor:/scratch/
SERVER_EXEC   := saruman:~/ocladock_sdx17_4


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
	cp Makefile ../$(COPY_DIR)/$(COPY_DIR_DOCK)/
	cp defines.h ../$(COPY_DIR)/$(COPY_DIR_DOCK)/
	cp defines_fixedpt.h ../$(COPY_DIR)/$(COPY_DIR_DOCK)/
	cp defines_fixedpt_64.h ../$(COPY_DIR)/$(COPY_DIR_DOCK)/
	cp -r device/ ../$(COPY_DIR)/$(COPY_DIR_DOCK)/
	cp -r host/ ../$(COPY_DIR)/$(COPY_DIR_DOCK)/
	cp -r input/ ../$(COPY_DIR)/$(COPY_DIR_DOCK)/
	cp -r wrapcl/ ../$(COPY_DIR)/$(COPY_DIR_DOCK)/
	cp -r ../common ../$(COPY_DIR)/
	cp -r ../common_xilinx ../$(COPY_DIR)/
	cp ../conf_sdx174_saruman.sh ../$(COPY_DIR)/
	cd ../;	zip -r $(COPY_DIR).zip $(COPY_DIR)
	@echo $(newline)
	@echo "Transfer the \"$(COPY_DIR).zip\" file to $(SERVER_BRIDGE) server: "
	@echo " "
	cd ../ && scp $(COPY_DIR).zip $(SERVER_BRIDGE)
	@echo $(newline)
	@echo "===================================================="
	@echo "Files listed were transferred to $(SERVER_BRIDGE)   "
	@echo $(newline)
	@echo "Then, transfer files manually                       "
	@echo "from $(SERVER_BRIDGE) to $(SERVER_EXEC)             "
	@echo "===================================================="
	@echo $(newline)


clean-copy:
	rm -rf ../$(COPY_DIR)
	rm -f ../$(COPY_DIR).zip
	@echo $(newline)
	@echo "=================================================================="
	@echo "Previous \"$(COPY_DIR).zip\" and its folder were deleted          "
	@echo "=================================================================="
	@echo $(newline)


