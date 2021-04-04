# Copyright 2020 Intel Corporation
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
# documentation files (the "Software"), to deal in the Software without restriction, including without limitation
# the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software,
# and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
# The above copyright notice and this permission notice shall be included in all copies or substantial portions
# of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED
# TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
# CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
# DEALINGS IN THE SOFTWARE.

#############################################################################################################
# The following flow assumes A10_OPENCL_AFU directory doesn't exist and sample design hasn't been copied over
# Arria 10 Devstack version 1.2.1
# **Adjust commands to your own needs.**
#############################################################################################################

# Initial Setup
source /data/intel_fpga/devcloudLoginToolSetup.sh
tools_setup -t A10DS
    ## Job will exit if directory already exists; no overwrite. No error message.
    ##[ ! -d ~/A10_OPENCL_AFU/v1.2.1 ] && mkdir -p ~/A10_OPENCL_AFU/v1.2.1 || exit 0

    # Copy Over sample design
    #cp -r /opt/intelFPGA_pro/quartus_19.2.0b57/hld/examples_aoc/hello_world A10_OPENCL_AFU/v1.2.1
    #cp -r /opt/intelFPGA_pro/quartus_19.2.0b57/hld/examples_aoc/common A10_OPENCL_AFU/v1.2.1
    #cd A10_OPENCL_AFU/v1.2.1

# Check Arria 10 PAC card connectivity
aocl diagnose
error_check

# Running project in Emulation mode
    #cd hello_world
printf "\\n%s\\n" "Running in Emulation Mode:"
make emu
    ## Run host code for version 1.2.1
    #./bin/host -emulator
error_check

