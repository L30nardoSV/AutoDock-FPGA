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
    


// synopsys translate_off
`timescale 1 ps / 1 ps
// synopsys translate_on
module acl_fp_sincos_s5(clock, resetn, dataa, result_a, result_b, enable);
  input clock, resetn, enable;
  input [31:0] dataa;
  output [31:0] result_a; // sin
  output [31:0] result_b; // cos

  reg areset;
  
  initial
  begin
    #0 areset = 1'b1;
    #5 areset = 1'b0;
  end

  fp_sincos_s5 fused(
    .clk(clock),
    .areset(areset),
    .en(enable),
    .a(dataa),
    .s(result_a),
    .c(result_b));
    
endmodule
