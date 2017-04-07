# (C) 1992-2017 Intel Corporation.                            
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
    


##############################################################################
##############################       MAIN        #############################
##############################################################################

post_message "Running post-flow script"

set project_name UNKNOWN
set revision_name UNKNOWN

if { [llength $quartus(args) ] == 0 } {
  # If this script is run manually, just compile the default revision
  set qpf_files [glob -nocomplain *.qpf]

  if {[llength $qpf_files] == 0} {
    error "No QSF detected"
  } elseif {[llength $qpf_files] > 1} {
    post_message "Warning: More than one QSF detected. Picking the first one."
  }
  set qpf_file [lindex $qpf_files 0]
  set project_name [string range $qpf_file 0 [expr [string first . $qpf_file] - 1]]
  set revision_name [get_current_revision $project_name]
} else {
  set project_name [lindex $quartus(args) 1]
  set revision_name [lindex $quartus(args) 2]
}

post_message "Project name: $project_name"
post_message "Revision name: $revision_name"

# Make sure OpenCL SDK installation exists
post_message "Checking for OpenCL SDK installation, environment should have ALTERAOCLSDKROOT defined"
if {[catch {set sdk_root $::env(ALTERAOCLSDKROOT)} result]} {
  post_message -type error "OpenCL SDK installation not found.  Make sure ALTERAOCLSDKROOT is correctly set"
  post_message -type error "Terminating post-flow script"
  exit 2
} else {
  post_message "ALTERAOCLSDKROOT=$::env(ALTERAOCLSDKROOT)"
}

if {[string match $revision_name "base"]} {
  post_message "Compiling base revision -> exporting the base revision compile database to QDB archive base.qdb!"
  qexec "quartus_cdb $project_name -c $revision_name --export_design --snapshot final --file $revision_name.qdb"
}

# run PR checks script
source $::env(ALTERAOCLSDKROOT)/ip/board/bsp/pr_checks_a10.tcl

# run adjust PLL script 
source $::env(ALTERAOCLSDKROOT)/ip/board/bsp/adjust_plls_a10.tcl

# export SDC constraints in base revision compile only
post_message "Exporting SDC constraints"
if {[string match $revision_name "base"]} {
  post_message "Compiling base revision -> exporting SDC constraints to base.sdc!"
  qexec "quartus_sta top -c base --report_script=scripts/base_write_sdc.tcl" 
} else {
  post_message "Compiling top or flat revision -> nothing to be done here!"
}

# create partial reconfiguration files (for top revision)
post_message "Creating partial reconfiguration files"
if {[string match $revision_name "base"]} {
  post_message "Compiling base revision -> PR file generation not available for this revision!"
} elseif {[string match $revision_name "top"]} {
  post_message "Compiling top revision -> generating PR files"

  post_message "Running quartus_cpf for .rbf"
  set pmsffile [glob -nocomplain top.*.pmsf]
  qexec "quartus_cpf -c $pmsffile top.rbf"

} elseif {[string match $revision_name "flat"]} {
  post_message "Compiling flat revision -> PR file generation not available for this revision!"
}

# create fpga.bin
post_message "Running create_fpga_bin_pr.tcl script"
if {[string match $revision_name "base"]} {
  post_message "Compiling base revision -> adding only base.sof to fpga.bin!"
  qexec "quartus_cdb -t scripts/create_fpga_bin_pr.tcl base.sof"
} elseif {[string match $revision_name "top"]} {
  post_message "Compiling top revision -> adding top.sof, top.rbf and pr_base_id.txt to fpga.bin!"
  qexec "quartus_cdb -t scripts/create_fpga_bin_pr.tcl top.sof top.rbf pr_base_id.txt"
} elseif {[string match $revision_name "flat"]} {
  post_message "Compiling flat revision -> adding only flat.sof to fpga.bin!"
  qexec "quartus_cdb -t scripts/create_fpga_bin_pr.tcl flat.sof"
} 

