PROJECT_DIR=$HOME/Intel_Agilex/AutoDock-FPGA/adfpga
echo $HOME
echo $PROJECT_DIR
printf "\\n"

# Initial Setup
source /data/intel_fpga/devcloudLoginToolSetup.sh
tools_setup -t S10DS

# Common A10 and S10 workflow
source $PROJECT_DIR/adfpga_batch.sh
export BOARD=pac_s10_dc