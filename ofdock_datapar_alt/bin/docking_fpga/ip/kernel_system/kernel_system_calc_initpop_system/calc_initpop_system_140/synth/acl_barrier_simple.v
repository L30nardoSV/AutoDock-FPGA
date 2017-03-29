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
    



//===----------------------------------------------------------------------===//
//
// Shift-Register implementation of a barrier
//
//===----------------------------------------------------------------------===//

module acl_barrier_simple (
        // The first parameters are exactly the same as the normal barrier just
        // for plugin compatibility
	clock,
	resetn,
	valid_entry,
	data_entry,
	stall_entry,
	valid_exit,
	data_exit,
	stall_exit,
  workgroup_size
);

parameter DATA_WIDTH=1024;
parameter DEPTH=256;  					// Assumed power of 2
parameter MAX_SIMULTANEOUS_WORKGROUPS=2;		// Assumed power of 2
parameter WORKGROUP_SIZE_BITS = 10;

localparam OCOUNT_BITS=WORKGROUP_SIZE_BITS+$clog2(MAX_SIMULTANEOUS_WORKGROUPS);

input  clock;
input  resetn;
input  valid_entry;
input  [DATA_WIDTH-1:0] data_entry;
output stall_entry;
output valid_exit;
output [DATA_WIDTH-1:0] data_exit;
input  stall_exit;
input [WORKGROUP_SIZE_BITS-1:0] workgroup_size;
 
   reg [WORKGROUP_SIZE_BITS-1:0] reg_workgroup_size;
   reg [WORKGROUP_SIZE_BITS-1:0] reg_workgroup_size_minus_1;

   reg [WORKGROUP_SIZE_BITS-1:0] i_count;
   reg [OCOUNT_BITS:0] o_count;
 
    (* altera_attribute = "-name auto_shift_register_recognition OFF" *) reg [1:0] reg_valid_entry;

   assign valid_exit = o_count[OCOUNT_BITS];
   assign stall_entry = 1'b0;

   wire output_accepted;
   assign output_accepted = valid_exit & !stall_exit;
   
   wire incr_valids;
   assign incr_valids = reg_valid_entry[1] & !stall_entry & (i_count == (reg_workgroup_size_minus_1));

   always @(posedge clock or negedge resetn)
   begin
    if (~(resetn))
    begin
       i_count <= {WORKGROUP_SIZE_BITS{1'b0}};
       o_count <= {OCOUNT_BITS{1'b0}};

       reg_workgroup_size <= 'x;
       reg_workgroup_size_minus_1 <= 'x;

       reg_valid_entry <= 2'b0;
    end
    else 
    begin
       if (incr_valids) i_count <= {WORKGROUP_SIZE_BITS{1'b0}}; 
       else if (reg_valid_entry[1] & !stall_entry) i_count <= i_count+1;

       o_count <= o_count - (incr_valids ? reg_workgroup_size : 0) + output_accepted;       

       reg_workgroup_size <= workgroup_size; 
       reg_workgroup_size_minus_1 <= reg_workgroup_size-1;

       reg_valid_entry <= {reg_valid_entry[0], valid_entry};
    end
  end

endmodule


// This is the same barrier as before, but it produces a stall out rather than
// setting it to zero.
module acl_barrier_simple_with_stallout (
        // The first parameters are exactly the same as the normal barrier just
        // for plugin compatibility
	clock,
	resetn,
	valid_entry,
	data_entry,
	stall_entry,
	valid_exit,
	data_exit,
	stall_exit,
  workgroup_size
);

parameter DATA_WIDTH=1024;
parameter DEPTH=256;  					      // Assumed power of 2
parameter WORKGROUP_SIZE_BITS = 10;

localparam OCOUNT_BITS=WORKGROUP_SIZE_BITS+1;

input  clock;
input  resetn;
input  valid_entry;
input  [DATA_WIDTH-1:0] data_entry;
output stall_entry;
output valid_exit;
output [DATA_WIDTH-1:0] data_exit;
input  stall_exit;
input [WORKGROUP_SIZE_BITS-1:0] workgroup_size;
 
   reg [WORKGROUP_SIZE_BITS-1:0] reg_workgroup_size;
   reg [WORKGROUP_SIZE_BITS-1:0] reg_workgroup_size_minus_1;

   reg [WORKGROUP_SIZE_BITS-1:0] i_count;
   reg [OCOUNT_BITS:0] o_count;
 
    (* altera_attribute = "-name auto_shift_register_recognition OFF" *) reg [1:0] reg_valid_entry;

   assign valid_exit = o_count[OCOUNT_BITS];
   assign stall_entry = (o_count[OCOUNT_BITS:OCOUNT_BITS-1] == 2'b10) & reg_valid_entry[1];

   wire output_accepted;
   assign output_accepted = valid_exit & !stall_exit;
   
   wire incr_valids;
   assign incr_valids = reg_valid_entry[1] & !stall_entry & (i_count == (reg_workgroup_size_minus_1));

   always @(posedge clock or negedge resetn)
   begin
     if (~(resetn))
     begin
       i_count <= {WORKGROUP_SIZE_BITS{1'b0}};
       o_count <= {OCOUNT_BITS{1'b0}};

       reg_workgroup_size <= 'x;
       reg_workgroup_size_minus_1 <= 'x;

       reg_valid_entry <= 2'b0;
     end
     else 
     begin
       if (incr_valids) i_count <= {WORKGROUP_SIZE_BITS{1'b0}}; 
       else if (reg_valid_entry[1] & !stall_entry) i_count <= i_count+1;

       o_count <= o_count - (incr_valids ? reg_workgroup_size : 0) + output_accepted;       

       reg_workgroup_size <= workgroup_size; 
       reg_workgroup_size_minus_1 <= reg_workgroup_size-1;
       
       if (~stall_entry)
         reg_valid_entry <= {reg_valid_entry[0], valid_entry};
     end
   end

endmodule
