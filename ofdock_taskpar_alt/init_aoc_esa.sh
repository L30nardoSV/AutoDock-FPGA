# This is created to automate the boring 
# process of setting AOC in celebdil
# DO NOT FORGET to run it using:
# >source init_aoc_esa.sh

echo "======================================="
echo "Setting up Altera OpenCL SDK & Compiler"
echo "======================================="
echo ""
export ALTERAOCLSDKROOT=/opt/cad/altera/altera-16.1/hld
echo "ALTERAOCLSDKROOT: "
echo $ALTERAOCLSDKROOT
echo " "
source /opt/cad/altera/altera-16.1/hld/init_opencl.sh
echo " "
export LM_LICENSE_FILE=/opt/cad/keys/altera
echo "LM_LICENSE_FILE: "
echo $LM_LICENSE_FILE
echo " "
export PATH=/opt/cad/altera/altera-16.1/quartus/bin/:$PATH
echo "PATH: "
echo $PATH
echo " "

echo "Altera OpenCL SDK version: "
aocl version
echo " "

echo "Altera OpenCL Compiler version: "
aoc --version
echo " "

#echo $AOCL_BOARD_PACKAGE_ROOT
echo "List of available boards "
aoc --list-boards 
echo " "

echo "Maybe we need to switch to another board?"
echo " "
export AOCL_BOARD_PACKAGE_ROOT=/opt/cad/altera/altera-16.1/hld/board/a10_ref

#echo $AOCL_BOARD_PACKAGE_ROOT
source /opt/cad/altera/altera-16.1/hld/init_opencl.sh
echo " "
echo "List of available boards "
aoc --list-boards
echo " "
