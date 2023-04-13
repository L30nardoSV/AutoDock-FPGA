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

# Execute it from head node (not compute note!)
# $ devcloud_login -b A10PAC 1.2.1 A10_v1.2.1_opencl_batch.sh
#
# Including prompt paths:
# u71100@login-2:~/copy_adfpga/adfpga$ devcloud_login -b A10PAC 1.2.1 A10_v1.2.1_opencl_batch.sh

# Initial Setup
source /data/intel_fpga/devcloudLoginToolSetup.sh
tools_setup -t A10DS

# Check Arria 10 PAC card connectivity
aocl diagnose
error_check

# Moving into project folder
cd ${pwd}

# Running project in Emulation mode
printf "\\n%s\\n" "Running in Emulation Mode:"
make emu NRUN=10 NEV=250000 NGEN=27000
error_check

# Running project in FPGA Hardware Mode
# (this takes approximately 3 hours for the original docking design)
printf "\\n%s\\n" "Running in FPGA Hardware Mode:"
printf "\\n"
date
printf "\\n"
make hw
printf "\\n"
date
printf "\\n"

# Availability of Acceleration cards
aoc -list-boards
error_check
# Get device name
aocl diagnose
error_check

# Converting to an unsigned .aocx file
printf "\\n%s\\n" "Converting to unsigned .aocx:"
printf "Y\\nY\\n" | source $AOCL_BOARD_PACKAGE_ROOT/linux64/libexec/sign_aocx.sh -H openssl_manager -i ${pwd}/bin_hw/Krnl_GA.aocx -r NULL -k NULL -o ${pwd}/bin_hw/Krnl_GA_unsigned.aocx
error_check

# Programmming PAC Card
printf "\\n%s\\n" "Programming FPGA device:"
aocl program acl0 ${pwd}/bin_hw/Krnl_GA_unsigned.aocx

# Running <make exe>
printf "\\n%s\\n" "Running on the FPGA device:"

printf "\\n"
date
printf "\\n"

printf "\\n%s\\n"
make exe PDB=3ptb NRUN=10 NEV=2500000 NGEN=27000

#printf "\\n%s\\n"
#make exe PDB=1stp NRUN=10 NEV=2500000 NGEN=27000

printf "\\n"
date
printf "\\n"

error_check

