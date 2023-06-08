function check_card_connectivity() {
    printf "\\n%s\\n" "Checking card connectivity:"
    aocl diagnose
    error_check
}

function move_into_project_folder() {
    printf "\\n%s\\n" "Moving into project folder:"
    cd $PROJECT_DIR
}

function build_and_run_adfpga_emu_mode() {
    printf "\\n%s\\n" "Building and running AutoDock-FPGA in Emulation Mode:"
    make emu NRUN=10 NEV=250000 NGEN=27000
    error_check
}

# This takes approximately 3 hours
function build_adfpga_hw_mode() {
    printf "\\n%s\\n" "Building AutoDock-FPGA in Hardware Mode:"
    printf "\\n"
    date
    printf "\\n"
    make hw
    printf "\\n"
    date
    printf "\\n"
}

function get_device_name() {
    printf "\\n%s\\n" "Getting device name:"
    aocl diagnose
    error_check
}

function check_card_availability() {
    printf "\\n%s\\n" "Checking card availability:"
    aoc -list-boards
    error_check
    get_device_name
}

function convert_to_unsigned_aocx() {
    printf "\\n%s\\n" "Converting to unsigned .aocx:"
    printf "Y\\nY\\n" | source $AOCL_BOARD_PACKAGE_ROOT/linux64/libexec/sign_aocx.sh -H openssl_manager -i $PROJECT_DIR/bin_hw/Krnl_GA.aocx -r NULL -k NULL -o $PROJECT_DIR/bin_hw/Krnl_GA_unsigned.aocx
    error_check
}

function program_fpga_device() {
    printf "\\n%s\\n" "Programming FPGA device:"
    if [ $BOARD == "pac_s10_dc" ]; then
        aocl program acl0 $PROJECT_DIR/bin_hw/Krnl_GA.aocx
    else
        aocl program acl0 $PROJECT_DIR/bin_hw/Krnl_GA_unsigned.aocx
    fi
}

function run_adfpga_hw_mode() {
    printf "\\n%s\\n" "Building AutoDock-FPGA in Hardware Mode:"

    printf "\\n"
    date
    printf "\\n"

    printf "\\n%s\\n"
    make exe PDB=3ptb NRUN=10 NEV=50000 NGEN=27000
    #make exe PDB=1stp NRUN=10 NEV=50000 NGEN=27000

    printf "\\n"
    date
    printf "\\n"
    error_check
}

function run_emu() {
    build_and_run_adfpga_emu_mode
}

function run_hw() {
    build_adfpga_hw_mode
    check_card_availability
    if [ $BOARD == "pac_s10_dc" ]; then
        printf "\\n%s\\n" "No conversion to unsigned .aocx"
    else
        convert_to_unsigned_aocx
    fi
    program_fpga_device
    run_adfpga_hw_mode
}

check_card_connectivity
move_into_project_folder
run_emu
run_hw
