#!/bin/bash

echo "============================="
echo "Setting up Xilinx SDAccel SDK"
echo "============================="
echo ""

export LM_LICENSE_FILE=$LM_LICENSE_FILE:/opt/cad/keys/Xilinx_VC1525.lic
echo "LM_LICENSE_FILE: "
echo $LM_LICENSE_FILE
echo " "

export LM_LICENSE_FILE=$LM_LICENSE_FILE:/opt/cad/keys/Xilinx.lic
echo "LM_LICENSE_FILE: "
echo $LM_LICENSE_FILE
echo " "


source /opt/xilinx-2017.4/SDx/2017.4/settings64.sh

echo "Xilinx SDAccel version: "
sdx --version
echo " "


