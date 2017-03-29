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
    


// This module implements FP exponent function in single precision
// for Arria10. It selects between 325 MHz and 450 MHz implementations,
// based on the supplied parameter.

// synopsys translate_off
`timescale 1 ps / 1 ps
// synopsys translate_on
module acl_fp_exp_a10_top (
	enable,
	clock,
	dataa,
	result);

	input	  enable;
	input	  clock;
	input	[31:0]  dataa;
	output	[31:0]  result;
  
  parameter FREQUENCY = 250;

	wire [31:0] sub_wire0;
	wire [31:0] result = sub_wire0[31:0];

  reg areset;
  initial
  begin
    #0 areset = 1'b1;
    #5 areset = 1'b0;
  end
  
  generate 
    if (FREQUENCY <= 280)
    begin
      acl_fp_exp_a10 inst(
        .a(dataa),
        .q(sub_wire0),
        .en(enable),
        .clk(clock),
        .areset(areset)
        );
    end
    else
    begin
      acl_fp_exp_a10_450 inst(
        .a(dataa),
        .q(sub_wire0),
        .en(enable),
        .clk(clock),
        .areset(areset)
        );    
    end
  endgenerate

endmodule
