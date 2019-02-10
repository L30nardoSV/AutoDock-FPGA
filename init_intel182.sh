#!/bin/bash

# This is created to automate the boring 
# process of setting AOC in celebdil
# DO NOT FORGET to run it using:
# >source init_aoc_esa.sh

echo ""
echo "==============================================="
echo "Setting up Altera OpenCL SDK & Compiler"
echo ""
echo "Run:          $ source init_aoc181.sh"
echo "or if Ubuntu: $ bash   init_aoc181.sh"
echo "==============================================="
echo ""

export LM_LICENSE_FILE=/opt/cad/keys/altera
echo "LM_LICENSE_FILE: "
echo $LM_LICENSE_FILE
echo " "

export ALTERAROOT=/opt/cad/altera/altera-18.1
echo "ALTERAROOT: "
echo $ALTERAROOT
echo " "

export ALTERAOCLSDKROOT=$ALTERAROOT/hld
echo "ALTERAOCLSDKROOT (used before v.17): "
echo $ALTERAOCLSDKROOT
echo " "

export INTELFPGAOCLSDKROOT=$ALTERAOCLSDKROOT
echo "INTELFPGAOCLSDKROOT (used from v.17 on): "
echo $INTELFPGAOCLSDKROOT
echo " "

export PATH=$INTELFPGAOCLSDKROOT/bin/:$PATH
echo "PATH: "
echo $PATH
echo " "

#export AOCL_BOARD_PACKAGE_ROOT=~/BSP_AOC_NALLA510T/nalla_pcie
export AOCL_BOARD_PACKAGE_ROOT=~/BSP_AOC_NALLA520/nalla_pcie
#export AOCL_BOARD_PACKAGE_ROOT=$INTELFPGAOCLSDKROOT/board/s10_ref
echo "AOCL_BOARD_PACKAGE_ROOT: "
echo $AOCL_BOARD_PACKAGE_ROOT
echo " "

source $INTELFPGAOCLSDKROOT/init_opencl.sh
echo " "
echo "List of available boards "
aoc -list-boards
echo " "

echo "Altera OpenCL SDK version: "
aocl version
echo " "

echo "Altera OpenCL Compiler version: "
aoc -version
echo " "
