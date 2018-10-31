#!/bin/bash

echo "============================="
echo "Setting up Xilinx SDAccel SDK"
echo "============================="
echo ""

export SDX174_LOCAL_INITFILE=/opt/cad/xilinx/sdx/SDx/2017.4/settings64.sh
echo "Initialization file: " $SDX174_LOCAL_INITFILE
echo " "
source $SDX174_LOCAL_INITFILE

echo "Xilinx SDAccel version: "
sdx --version
echo " "
