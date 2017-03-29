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
    


// The start signal chain element forwards the start signal received 
// from the previous chain element to the kernel copy it serves as well as
// the corresponding task copy finish detector and finish chain element.

module acl_start_signal_chain_element
(
	input clock,
	input resetn,

	input start_in,
	output reg start_kernel,
	output reg start_finish_detector,
	output reg start_finish_chain_element,
	output reg start_chain
);

	always @ (posedge clock)
	begin
		start_chain <= start_in;
	end

	always @ (posedge clock or negedge resetn)
	begin
		if (~resetn)
		begin
			start_kernel <= 1'b0;
			start_finish_detector <= 1'b0;
			start_finish_chain_element <= 1'b0;
		end
		else
		begin
			start_kernel <= start_chain;
			start_finish_detector <= start_chain;
			start_finish_chain_element <= start_chain;
		end
	end


endmodule
