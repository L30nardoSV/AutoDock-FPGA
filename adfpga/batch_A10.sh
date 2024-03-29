# Common folder setup
PROJECT_DIR=$HOME/Intel_Agilex/AutoDock-FPGA/adfpga
printf "\\n%s\\n" $HOME
printf "\\n%s\\n" $PROJECT_DIR

# Initial Setup
source /data/intel_fpga/devcloudLoginToolSetup.sh
tools_setup -t A10DS
export BOARD=pac_a10

# Common A10 and S10 workflow
source $PROJECT_DIR/batch_adfpga.sh

