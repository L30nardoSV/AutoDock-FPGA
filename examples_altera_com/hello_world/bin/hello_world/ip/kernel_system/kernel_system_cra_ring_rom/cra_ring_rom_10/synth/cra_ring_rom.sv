// (C) 1992-2017 Intel Corporation.                            
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
    


module cra_ring_rom #(
  parameter integer RING_ADDR_W = 32,
  parameter integer DATA_W = 32,
  parameter integer ID_W = 3,
  parameter integer ROM_W = 4,
  parameter integer ROM_EXT_W = 0
)
(
  // clock/reset
  input logic clk,
  input logic rst_n,

  // avalon-master port
  output logic avm_read,
  output logic [ROM_W-1:0] avm_addr,
  input logic [DATA_W-1:0] avm_readdata,
  input logic avm_readdatavalid,

  // ring-in
  input logic ri_read,
  input logic ri_write,
  input logic [RING_ADDR_W+ID_W+ROM_EXT_W:0] ri_addr,
  input logic [DATA_W-1:0] ri_data,
  input logic [DATA_W/8-1:0] ri_byteena,
  input logic ri_datavalid,
  
  // ring-out
  output logic ro_read,
  output logic ro_write,
  output logic [RING_ADDR_W+ID_W-1:0] ro_addr,
  output logic [DATA_W-1:0] ro_data,
  output logic [DATA_W/8-1:0] ro_byteena,
  output logic ro_datavalid
);

wire rom_read;
assign rom_read = (ri_addr[RING_ADDR_W+ID_W+ROM_EXT_W] == 1);

// The avalon master connection
always@(posedge clk or negedge rst_n) begin
  if(rst_n == 1'b0) begin
    avm_read <= 1'b0;
    avm_addr <= 'x;
  end else begin
    avm_read <= ri_read && rom_read;
    avm_addr <= ri_addr[ROM_W-1:0]; // Throw away upper address bits
  end
end

// The ring output
always@(posedge clk or negedge rst_n) begin
  if(rst_n == 1'b0) begin
    ro_read <= 1'b0;
    ro_write <= 1'b0;
    ro_datavalid <= 1'b0;
    ro_addr <= 'x;
    ro_data <= 'x;
    ro_byteena <= 'x;
  end else begin
    ro_read <= ri_read && !rom_read;
    ro_write <= ri_write && !rom_read;
    ro_addr <= ri_addr[RING_ADDR_W+ID_W-1:0];
    ro_data <= avm_readdatavalid ? avm_readdata : ri_data;
    ro_byteena <= ri_byteena;
    ro_datavalid <= avm_readdatavalid | ri_datavalid;
  end
end
endmodule

