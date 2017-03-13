# (C) 1992-2016 Intel Corporation.                            
# Intel, the Intel logo, Intel, MegaCore, NIOS II, Quartus and TalkBack words    
# and logos are trademarks of Intel Corporation or its subsidiaries in the U.S.  
# and/or other countries. Other marks and brands may be claimed as the property  
# of others. See Trademarks on intel.com for full list of Intel trademarks or    
# the Trademarks & Brands Names Database (if Intel) or See www.Intel.com/legal (if Altera) 
# Your use of Intel Corporation's design tools, logic functions and other        
# software and tools, and its AMPP partner logic functions, and any output       
# files any of the foregoing (including device programming or simulation         
# files), and any associated documentation or information are expressly subject  
# to the terms and conditions of the Altera Program License Subscription         
# Agreement, Intel MegaCore Function License Agreement, or other applicable      
# license agreement, including, without limitation, that your use is for the     
# sole purpose of programming logic devices manufactured by Intel and sold by    
# Intel or its authorized distributors.  Please refer to the applicable          
# agreement for further details.                                                 
    


post_message "Running pre-flow script"

# get project name
set project_name top
post_message "Project name: $project_name"

# get revision name (from ACL_QSH_COMPILE_CMD environment variable)
if {[catch {set compile_cmd $::env(ACL_QSH_COMPILE_CMD)} result]} {
  set revision_name top
} else {
  post_message "Compile command: $compile_cmd"
  regexp {quartus_sh --flow compile top -c (.*)$} $compile_cmd matchVar revision_name
}

post_message "Project name: $project_name"
post_message "Revision name: $revision_name"

# get device part name
project_open $project_name -revision $revision_name
set part_name [get_global_assignment -name DEVICE]
post_message "Device part name is $part_name"
project_close

# Make sure OpenCL SDK installation exists
post_message "Checking for OpenCL SDK installation, environment should have ALTERAOCLSDKROOT defined"
if {[catch {set sdk_root $::env(ALTERAOCLSDKROOT)} result]} {
  post_message -type error "OpenCL SDK installation not found.  Make sure ALTERAOCLSDKROOT is correctly set"
  post_message -type error "Terminating pre-flow script"
  exit 2
} else {
  post_message "ALTERAOCLSDKROOT=$::env(ALTERAOCLSDKROOT)"
}

# Create and embed unique base revision compile ID into static region (board.qsys).
# The generated hash is written to board.qsys with qsys-script.
# board.qsys, acl_ddr4_a10.qsys and acl_ddr4_a10_core.qsys are only added to "opencl_bsp_ip.qsf" file
# for "flat" and "base" revision compiles.
# These files are not required in "top" revision compiles which import the post-fit netlist from a previous "base"
# revision compile.
if {[string match $revision_name "base"]} {
  post_message "Compiling base revision -> creating and embedding unique base revision compile ID!"

  # Create unique base revision compile ID
  ########################################
  # The unique ID is constructed by using 
  # a) a high-resolution counter (clicks)
  # b) the current working directory
  #
  # 1. both are written into a file (hash_temp.txt)
  # 2. 'aocl hash hash_temp.txt' produces the md5 hash
  # 3. the md5 hash is truncated to the 32 MSBs
  # 4. the final unique ID is the 31 LSBs of this truncated hash
  #    (to match QSys component unsigned int representation)

  # get high resolution counter value
  set time_in_clicks [clock clicks]

  # current current working directory
  set current_work_dir [pwd]

  # write both out to temporary file
  set hash_temp_filename "hash_temp.txt"
  set hash_temp_file [open $hash_temp_filename w]
  puts $hash_temp_file $time_in_clicks
  puts $hash_temp_file $current_work_dir
  close $hash_temp_file

  # use 'aocl hash' to get the md5 hash value
  if {[catch {exec aocl hash hash_temp.txt} result] == 0} { 
    set result_step2 [string range $result 0 7]
    set result_step3 [expr 0x$result_step2]
    set base_id [expr {$result_step3 & 0x7FFFFFFF }]
  } else { 
    post_message "Error running 'aocl hash'"
    exit -1
  } 

  # delete temporary file
  file delete -force $hash_temp_filename 

  # writing out hash to pr_base_id.txt
  set pr_base_id_filename "pr_base_id.txt"
  set pr_base_id_file [open $pr_base_id_filename w]
  puts $pr_base_id_file $base_id
  close $pr_base_id_file

  # updating board.qsys pr_base_id component to include hash
  qexec "qsys-script --quartus-project=$project_name --rev=opencl_bsp_ip --system-file=board.qsys --cmd=\"package require -exact qsys 16.1;set_validation_property AUTOMATIC_VALIDATION false;load_component pr_base_id;set_component_parameter_value \"VERSION_ID\" \"$base_id\";save_component;save_system board.qsys\""

  post_message "Generating board.qsys:"
  post_message "    qsys-generate -syn --family=\"Arria 10\" --part=$part_name board.qsys"
  qexec "qsys-generate -syn --family=\"Arria 10\" --part=$part_name board.qsys"

  # adding board.qsys and corresponding .ip parameterization files to opencl_bsp_ip.qsf
  qexec "qsys-archive --quartus-project=$project_name --rev=opencl_bsp_ip board.qsys"

} elseif {[string match $revision_name "flat"]} {

  post_message "Generating board.qsys:"
  post_message "    qsys-generate -syn --family=\"Arria 10\" --part=$part_name board.qsys"
  qexec "qsys-generate -syn --family=\"Arria 10\" --part=$part_name board.qsys"

  # adding board.qsys and corresponding .ip parameterization files to opencl_bsp_ip.qsf
  qexec "qsys-archive --quartus-project=$project_name --rev=opencl_bsp_ip board.qsys"

} elseif {[string match $revision_name "top"]} {
  post_message "Compiling top revision -> nothing to be done with board.qsys"
}

# generate kernel_system.qsys 
# and add Qsys Pro generated files to "opencl_bsp_ip.qsf"
post_message "Generating kernel_system.qsys:"
post_message "    qsys-generate -syn --family=\"Arria 10\" --part=$part_name kernel_system.qsys"
qexec "qsys-generate -syn --family=\"Arria 10\" --part=$part_name kernel_system.qsys"
qexec "qsys-archive --quartus-project=$project_name --rev=opencl_bsp_ip kernel_system.qsys"

