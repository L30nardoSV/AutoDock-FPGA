#!/bin/bash

# This is created to automate the boring 
# process of setting AOC in celebdil
# DO NOT FORGET to run it using:
# >source init_aoc_esa.sh

echo ""
echo "==============================================="
echo "Setting up Altera OpenCL SDK & Compiler"
echo ""
echo "Run:          $ source init_aoc171_nalla510t.sh"
echo "or if Ubuntu: $ bash   init_aoc171_nalla510t.sh"
echo "==============================================="
echo ""

export LM_LICENSE_FILE=/opt/cad/keys/altera
echo "LM_LICENSE_FILE: "
echo $LM_LICENSE_FILE
echo " "

export ALTERAROOT=/opt/altera-17.1_pro/
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


export AOCL_BOARD_PACKAGE_ROOT=$INTELFPGAOCLSDKROOT/board/nalla_pcie
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
