# This is created to automate the boring 
# process of setting AOC in celebdil
# DO NOT FORGET to run it using:
# >source init_aoc_esa.sh

echo "======================================="
echo "Setting up Altera OpenCL SDK & Compiler"
echo "======================================="
echo ""

export LM_LICENSE_FILE=/opt/cad/keys/altera
echo "LM_LICENSE_FILE: "
echo $LM_LICENSE_FILE
echo " "

export PATH=/opt/altera-16.0_pro/quartus/bin/:$PATH
echo "PATH: "
echo $PATH
echo " "


export ALTERAOCLSDKROOT=/opt/altera-16.0_pro/hld
echo "ALTERAOCLSDKROOT: "
echo $ALTERAOCLSDKROOT
echo " "

export AOCL_BOARD_PACKAGE_ROOT=/opt/altera-16.0_pro/hld/board/Proc10A_16.0.2
echo "AOCL_BOARD_PACKAGE_ROOT: "
echo $AOCL_BOARD_PACKAGE_ROOT
echo " "

source $ALTERAOCLSDKROOT/init_opencl.sh
echo " "
echo "List of available boards "
aoc --list-boards
echo " "

echo "Altera OpenCL SDK version: "
aocl version
echo " "

echo "Altera OpenCL Compiler version: "
aoc --version
echo " "
