// (C) 1992-2016 Intel Corporation.                            
// Intel, the Intel logo, Intel, MegaCore, NIOS II, Quartus and TalkBack words    
// and logos are trademarks of Intel Corporation or its subsidiaries in the U.S.  
// and/or other countries. Other marks and brands may be claimed as the property  
// of others. See Trademarks on intel.com for full list of Intel trademarks or    
// the Trademarks & Brands Names Database (if Intel) or See www.Intel.com/legal (if Altera) 
// Your use of Intel Corporation's design tools, logic functions and other        
// software and tools, and its AMPP partner logic functions, and any output       
// files any of the foregoing (including device programming or simulation         
// files), and any associated documentation or information are expressly subject  
// to the terms and conditions of the Altera Program License Subscription         
// Agreement, Intel MegaCore Function License Agreement, or other applicable      
// license agreement, including, without limitation, that your use is for the     
// sole purpose of programming logic devices manufactured by Intel and sold by    
// Intel or its authorized distributors.  Please refer to the applicable          
// agreement for further details.                                                 
    


module acl_ic_rrp_reg
(
  input logic clock,
  input logic resetn,

  acl_ic_rrp_intf rrp_in,
  (* dont_merge, altera_attribute = "-name auto_shift_register_recognition OFF" *) acl_ic_rrp_intf rrp_out
);
  always @(posedge clock or negedge resetn)
    if( ~resetn ) begin
      rrp_out.datavalid <= 1'b0;
      rrp_out.id <= 'x;
      rrp_out.data <= 'x;
    end
    else begin
      rrp_out.datavalid <= rrp_in.datavalid;
      rrp_out.id <= rrp_in.id;
      rrp_out.data <= rrp_in.data;
    end
endmodule

