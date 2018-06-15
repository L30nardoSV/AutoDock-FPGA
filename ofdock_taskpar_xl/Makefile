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

# Docking parameters 
# that directly determine the execution time
# Following values are used only for emulation
# to have a short but still a representative test
PDB  := 1stp
NRUN := 5
NEV  := 800000 

kerswemu:
	make TARGETS=sw_emu all
	cp ./xclbin/$(XCLBINS).sw_emu.*.xclbin .
	mv ./$(XCLBINS).sw_emu.*.xclbin ./$(XCLBINS).xclbin
	@echo " "
	@echo "========================================================================"
	@echo "INFO: emulation file created under: ./xclbin/$(XCLBINS).sw_emu.*.xclbin "
	@echo "INFO: ... was copied and renamed as ./$(XCLBINS).xclbin    	       "
	@echo "========================================================================"
	@echo " "

kerhwemu:
	make TARGETS=hw_emu all	


# Run emulation
# Compilation (host & device) if not done previously
# The .dlg file is written in ./
# "exe" and "xclbin" are rules from "rules.mk"
swemu: kerswemu
	XCL_EMULATION_MODE=sw_emu ./$(EXES) -ffile input/$(PDB)/derived/$(PDB)_protein.maps.fld -lfile input/$(PDB)/derived/$(PDB)_ligand.pdbqt -nev $(NEV) -nrun $(NRUN)  -gfpop 1
	@echo " "
	@echo "======================================="
	@echo "INFO: log file is under: ./docking.dlg "
	@echo "======================================="
	@echo " "

# Build hw (FPGA bitstream)
# NOT integrated yet in a multistep compilation
hw: 	
	make TARGETS=hw all	
	@echo " "
	@echo "=========================================================================="
	@echo "INFO: FPGA bitstream is under: $(TARGET_DIR_HW)/$(KRNL_NAME)(.aoco)(.aocx)"
	@echo "=========================================================================="
	@echo " "


	
debug:
	XCL_EMULATION_MODE=sw_emu xgdb -args ./$(EXES) -ffile input/1stp/derived/1stp_protein.maps.fld -lfile input/1stp/derived/1stp_ligand.pdbqt -nrun 1 -nev 100 -lsit 10 -psize 10
