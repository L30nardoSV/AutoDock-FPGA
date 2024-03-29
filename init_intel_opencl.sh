#!/bin/bash

# Automate the boring process of initializing Intel tools.
# Script must be sourced. It will automatically check it.

echo ""
echo "Setting up Intel OpenCL SDK & Compiler"
echo ""
echo "Run:          $ source init_intel_opencl.sh"
echo "or if Ubuntu: $ bash   init_intel_opencl.sh"
echo "Zsh:        : it might not work"

echo " "
echo "Verifying if script is being sourced"
if [[ ${BASH_SOURCE[0]} != $0 ]]; then
  echo "OK. Script is sourced"
else
  echo "Run \"source ${BASH_SOURCE[0]}\" instead!"
  echo "Terminating!" && exit 1
fi

echo " "
export LM_LICENSE_FILE=/opt/cad/keys/altera
echo "LM_LICENSE_FILE: "
echo -e '\t' $LM_LICENSE_FILE

echo " "
export ALTERAROOT=/opt/cad/altera/altera-19.4
echo "ALTERAROOT: "
echo -e '\t' $ALTERAROOT

echo " "
export ALTERAOCLSDKROOT=$ALTERAROOT/hld
echo "ALTERAOCLSDKROOT (used before v.17): "
echo -e '\t' $ALTERAOCLSDKROOT

echo " "
export INTELFPGAOCLSDKROOT=$ALTERAOCLSDKROOT
echo "INTELFPGAOCLSDKROOT (used from v.17 on): "
echo -e '\t' $INTELFPGAOCLSDKROOT

echo " "
export PATH=$INTELFPGAOCLSDKROOT/bin/:$PATH
echo "PATH: "
echo -e '\t' $PATH

echo " "
export AOCL_BOARD_PACKAGE_ROOT=$INTELFPGAOCLSDKROOT/board/a10_ref
echo "AOCL_BOARD_PACKAGE_ROOT: "
echo -e '\t' $AOCL_BOARD_PACKAGE_ROOT

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
