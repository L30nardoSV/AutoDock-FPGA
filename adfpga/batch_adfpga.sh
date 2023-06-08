# Check card connectivity
aocl diagnose
error_check

# Moving into project folder
cd $PROJECT_DIR

# Running project in Emulation mode
printf "\\n%s\\n" "Running in Emulation Mode:"
make emu NRUN=10 NEV=250000 NGEN=27000
error_check

# Running project in FPGA Hardware Mode
# (This takes approximately 3 hours for the original docking design)
printf "\\n%s\\n" "Running in FPGA Hardware Mode:"
printf "\\n"
date
printf "\\n"
make hw
printf "\\n"
date
printf "\\n"

# Availability of Acceleration cards
aoc -list-boards
error_check
# Get device name
aocl diagnose
error_check

# Converting to an unsigned .aocx file
printf "\\n%s\\n" "Converting to unsigned .aocx:"
printf "Y\\nY\\n" | source $AOCL_BOARD_PACKAGE_ROOT/linux64/libexec/sign_aocx.sh -H openssl_manager -i $PROJECT_DIR/bin_hw/Krnl_GA.aocx -r NULL -k NULL -o $PROJECT_DIR/bin_hw/Krnl_GA_unsigned.aocx
error_check

# Programmming PAC Card
printf "\\n%s\\n" "Programming FPGA device:"
aocl program acl0 $PROJECT_DIR/bin_hw/Krnl_GA_unsigned.aocx

# Running <make exe>
printf "\\n%s\\n" "Running on the FPGA device:"

printf "\\n"
date
printf "\\n"

printf "\\n%s\\n"
make exe PDB=3ptb NRUN=10 NEV=2500000 NGEN=27000

#printf "\\n%s\\n"
#make exe PDB=1stp NRUN=10 NEV=2500000 NGEN=27000

printf "\\n"
date
printf "\\n"

error_check

