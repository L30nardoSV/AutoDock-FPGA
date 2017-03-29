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
    


load_package flow
load_package design

# Import base revision compile design
qexec "quartus_cdb top -c base --import_design --file base.qdb --overwrite"

# run BAK flow
qexec "quartus_fit top -c base"
qexec "quartus_asm top -c base"

# Export static partition of base revision compile
qexec "quartus_cdb top -c base --export_pr_static_block root_partition --snapshot final --file root_partition.qdb"
 
# Synthesize PR logic
qexec "quartus_syn top -c top_synth"

# Exporting the kernel from the top_synth compile
project_open top -revision top_synth
if {[catch {design::export_block root_partition -snapshot synthesized -file kernel.qdb} result]} {
  post_message -type error "Error! $result"
  exit 2
}
project_close

# Importing static partition from base revision compile
project_open top -revision top
if {[catch {design::import_block root_partition -file root_partition.qdb} result]} {
  post_message -type error "Error! $result"
  exit 2
}
project_close

# Importing the kernel from the top_synth compile
project_open top -revision top
if {[catch {design::import_block kernel -file kernel.qdb} result]} {
  post_message -type error "Error! $result"
  exit 2
}
project_close

# Replace base compile's PR logic with different PR logic
qexec "quartus_fit top -c top"
qexec "quartus_sta top -c top"

# Generate report, generate PLL configuration file, re-run STA
qexec "quartus_cdb -t scripts/post_flow_pr.tcl"

