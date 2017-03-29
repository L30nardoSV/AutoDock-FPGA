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
    


// Full detector used in acl_stall_free_sink, implemented as a
// counter with increment and decrement signals

module acl_full_detector
#(
  parameter integer WIDTH = 5,
  parameter integer SCHEDULEII = 1,
  parameter integer ALWAYS_THROTTLE = 0
)
(
  input  logic clock,
  input  logic resetn,
  input  logic increment,
  input  logic decrement,
  output logic full,

  input logic inc_pipelined_thread,
  input logic dec_pipelined_thread,
  output logic throttle
);

 // Full detection
 reg [WIDTH-1:0] counter; 

 assign full = counter[WIDTH-1];

 always @(posedge clock or negedge resetn)
 begin
  if (!resetn)
  begin
    counter <= {(WIDTH){1'b0}};
  end
  else begin
    counter <= counter + increment - decrement;
  end
 end

 // Throttling
 reg[$clog2(SCHEDULEII):0] IIschedcount;
 reg[$clog2(SCHEDULEII):0] threads_count; 

 wire input_accepted;
 assign input_accepted = increment;

 always @(posedge clock or negedge resetn)
 begin
  if (!resetn) begin
    IIschedcount <= 0;
    threads_count <= 0;
  end else begin
    // do not increase the counter if a thread is exiting
    // increasing threads_count is already decreasing the window
    // increasing IIschedcount ends up accepting the next thread too early
    IIschedcount <= ((ALWAYS_THROTTLE == 0) && input_accepted && dec_pipelined_thread) ? IIschedcount : (IIschedcount == (SCHEDULEII - 1) ? 0 : (IIschedcount + 1));
    if (input_accepted) begin
      threads_count <= (ALWAYS_THROTTLE) ? (inc_pipelined_thread ? 2'b01 : threads_count) : (threads_count + inc_pipelined_thread - dec_pipelined_thread);
    end
  end
 end 

 // allow threads in a window of the II cycles
 // this prevents the next iteration from entering too early
 assign throttle = (IIschedcount >= (threads_count > 0 ? threads_count : 1));

endmodule
