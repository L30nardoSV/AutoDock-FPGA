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
    

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

// altera message_off 10036
// altera message_off 10230
// altera message_off 10858
module hello_world_basic_block_0
	(
		input 		clock,
		input 		resetn,
		input [31:0] 		input_thread_id_from_which_to_print_message,
		input 		valid_in,
		output 		stall_out,
		input [31:0] 		input_global_id_0,
		output 		valid_out,
		input 		stall_in,
		input [31:0] 		workgroup_size,
		input 		start,
		output 		p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_enable,
		input [255:0] 		p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_readdata,
		input 		p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_readdatavalid,
		input 		p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_waitrequest,
		output [31:0] 		p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_address,
		output 		p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_read,
		output 		p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_write,
		input 		p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_writeack,
		output [255:0] 		p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_writedata,
		output [31:0] 		p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_byteenable,
		output [5:0] 		p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_burstcount,
		output 		avm_local_bb0_st_printf_data1_enable,
		input [511:0] 		avm_local_bb0_st_printf_data1_readdata,
		input 		avm_local_bb0_st_printf_data1_readdatavalid,
		input 		avm_local_bb0_st_printf_data1_waitrequest,
		output [30:0] 		avm_local_bb0_st_printf_data1_address,
		output 		avm_local_bb0_st_printf_data1_read,
		output 		avm_local_bb0_st_printf_data1_write,
		input 		avm_local_bb0_st_printf_data1_writeack,
		output [511:0] 		avm_local_bb0_st_printf_data1_writedata,
		output [63:0] 		avm_local_bb0_st_printf_data1_byteenable,
		output [4:0] 		avm_local_bb0_st_printf_data1_burstcount,
		output 		local_bb0_st_printf_data1_active,
		input 		clock2x
	);


// Values used for debugging.  These are swept away by synthesis.
wire _entry;
wire _exit;
 reg [31:0] _num_entry_NO_SHIFT_REG;
 reg [31:0] _num_exit_NO_SHIFT_REG;
wire [31:0] _num_live;

assign _entry = ((&valid_in) & ~((|stall_out)));
assign _exit = ((&valid_out) & ~((|stall_in)));
assign _num_live = (_num_entry_NO_SHIFT_REG - _num_exit_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		_num_entry_NO_SHIFT_REG <= 32'h0;
		_num_exit_NO_SHIFT_REG <= 32'h0;
	end
	else
	begin
		if (_entry)
		begin
			_num_entry_NO_SHIFT_REG <= (_num_entry_NO_SHIFT_REG + 2'h1);
		end
		if (_exit)
		begin
			_num_exit_NO_SHIFT_REG <= (_num_exit_NO_SHIFT_REG + 2'h1);
		end
	end
end



// This section defines the behaviour of the MERGE node
wire merge_node_stall_in_0;
 reg merge_node_valid_out_0_NO_SHIFT_REG;
wire merge_node_stall_in_1;
 reg merge_node_valid_out_1_NO_SHIFT_REG;
wire merge_node_stall_in_2;
 reg merge_node_valid_out_2_NO_SHIFT_REG;
wire merge_stalled_by_successors;
 reg merge_block_selector_NO_SHIFT_REG;
 reg merge_node_valid_in_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_global_id_0_staging_reg_NO_SHIFT_REG;
 reg [31:0] local_lvm_input_global_id_0_NO_SHIFT_REG;
 reg is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
 reg invariant_valid_NO_SHIFT_REG;

assign merge_stalled_by_successors = ((merge_node_stall_in_0 & merge_node_valid_out_0_NO_SHIFT_REG) | (merge_node_stall_in_1 & merge_node_valid_out_1_NO_SHIFT_REG) | (merge_node_stall_in_2 & merge_node_valid_out_2_NO_SHIFT_REG));
assign stall_out = merge_node_valid_in_staging_reg_NO_SHIFT_REG;

always @(*)
begin
	if ((merge_node_valid_in_staging_reg_NO_SHIFT_REG | valid_in))
	begin
		merge_block_selector_NO_SHIFT_REG = 1'b0;
		is_merge_data_to_local_regs_valid_NO_SHIFT_REG = 1'b1;
	end
	else
	begin
		merge_block_selector_NO_SHIFT_REG = 1'b0;
		is_merge_data_to_local_regs_valid_NO_SHIFT_REG = 1'b0;
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		input_global_id_0_staging_reg_NO_SHIFT_REG <= 'x;
		merge_node_valid_in_staging_reg_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (((merge_block_selector_NO_SHIFT_REG != 1'b0) | merge_stalled_by_successors))
		begin
			if (~(merge_node_valid_in_staging_reg_NO_SHIFT_REG))
			begin
				input_global_id_0_staging_reg_NO_SHIFT_REG <= input_global_id_0;
				merge_node_valid_in_staging_reg_NO_SHIFT_REG <= valid_in;
			end
		end
		else
		begin
			merge_node_valid_in_staging_reg_NO_SHIFT_REG <= 1'b0;
		end
	end
end

always @(posedge clock)
begin
	if (~(merge_stalled_by_successors))
	begin
		case (merge_block_selector_NO_SHIFT_REG)
			1'b0:
			begin
				if (merge_node_valid_in_staging_reg_NO_SHIFT_REG)
				begin
					local_lvm_input_global_id_0_NO_SHIFT_REG <= input_global_id_0_staging_reg_NO_SHIFT_REG;
				end
				else
				begin
					local_lvm_input_global_id_0_NO_SHIFT_REG <= input_global_id_0;
				end
			end

			default:
			begin
			end

		endcase
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		merge_node_valid_out_0_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_1_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_2_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (~(merge_stalled_by_successors))
		begin
			merge_node_valid_out_0_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_1_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_2_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
		end
		else
		begin
			if (~(merge_node_stall_in_0))
			begin
				merge_node_valid_out_0_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_1))
			begin
				merge_node_valid_out_1_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_2))
			begin
				merge_node_valid_out_2_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		invariant_valid_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		invariant_valid_NO_SHIFT_REG <= (~(start) & (invariant_valid_NO_SHIFT_REG | is_merge_data_to_local_regs_valid_NO_SHIFT_REG));
	end
end


// This section implements an unregistered operation.
// 
wire local_bb0_cmp_xor_valid_out_0;
wire local_bb0_cmp_xor_stall_in_0;
wire local_bb0_cmp_xor_valid_out_1;
wire local_bb0_cmp_xor_stall_in_1;
wire local_bb0_cmp_xor_inputs_ready;
wire local_bb0_cmp_xor_stall_local;
wire local_bb0_cmp_xor;
 reg local_bb0_cmp_xor_consumed_0_NO_SHIFT_REG;
 reg local_bb0_cmp_xor_consumed_1_NO_SHIFT_REG;

assign local_bb0_cmp_xor_inputs_ready = merge_node_valid_out_0_NO_SHIFT_REG;
assign local_bb0_cmp_xor = (local_lvm_input_global_id_0_NO_SHIFT_REG != input_thread_id_from_which_to_print_message);
assign local_bb0_cmp_xor_stall_local = ((local_bb0_cmp_xor_stall_in_0 & ~(local_bb0_cmp_xor_consumed_0_NO_SHIFT_REG)) | (local_bb0_cmp_xor_stall_in_1 & ~(local_bb0_cmp_xor_consumed_1_NO_SHIFT_REG)));
assign local_bb0_cmp_xor_valid_out_0 = (local_bb0_cmp_xor_inputs_ready & ~(local_bb0_cmp_xor_consumed_0_NO_SHIFT_REG));
assign local_bb0_cmp_xor_valid_out_1 = (local_bb0_cmp_xor_inputs_ready & ~(local_bb0_cmp_xor_consumed_1_NO_SHIFT_REG));
assign merge_node_stall_in_0 = (|local_bb0_cmp_xor_stall_local);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb0_cmp_xor_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb0_cmp_xor_consumed_1_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb0_cmp_xor_consumed_0_NO_SHIFT_REG <= (local_bb0_cmp_xor_inputs_ready & (local_bb0_cmp_xor_consumed_0_NO_SHIFT_REG | ~(local_bb0_cmp_xor_stall_in_0)) & local_bb0_cmp_xor_stall_local);
		local_bb0_cmp_xor_consumed_1_NO_SHIFT_REG <= (local_bb0_cmp_xor_inputs_ready & (local_bb0_cmp_xor_consumed_1_NO_SHIFT_REG | ~(local_bb0_cmp_xor_stall_in_1)) & local_bb0_cmp_xor_stall_local);
	end
end


// Register node:
//  * latency = 3
//  * capacity = 3
 logic rnode_1to4_input_global_id_0_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to4_input_global_id_0_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_1to4_input_global_id_0_0_NO_SHIFT_REG;
 logic rnode_1to4_input_global_id_0_0_reg_4_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_1to4_input_global_id_0_0_reg_4_NO_SHIFT_REG;
 logic rnode_1to4_input_global_id_0_0_valid_out_reg_4_NO_SHIFT_REG;
 logic rnode_1to4_input_global_id_0_0_stall_in_reg_4_NO_SHIFT_REG;
 logic rnode_1to4_input_global_id_0_0_stall_out_reg_4_NO_SHIFT_REG;

acl_data_fifo rnode_1to4_input_global_id_0_0_reg_4_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to4_input_global_id_0_0_reg_4_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to4_input_global_id_0_0_stall_in_reg_4_NO_SHIFT_REG),
	.valid_out(rnode_1to4_input_global_id_0_0_valid_out_reg_4_NO_SHIFT_REG),
	.stall_out(rnode_1to4_input_global_id_0_0_stall_out_reg_4_NO_SHIFT_REG),
	.data_in(local_lvm_input_global_id_0_NO_SHIFT_REG),
	.data_out(rnode_1to4_input_global_id_0_0_reg_4_NO_SHIFT_REG)
);

defparam rnode_1to4_input_global_id_0_0_reg_4_fifo.DEPTH = 4;
defparam rnode_1to4_input_global_id_0_0_reg_4_fifo.DATA_WIDTH = 32;
defparam rnode_1to4_input_global_id_0_0_reg_4_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to4_input_global_id_0_0_reg_4_fifo.IMPL = "ll_reg";

assign rnode_1to4_input_global_id_0_0_reg_4_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_2_NO_SHIFT_REG;
assign merge_node_stall_in_2 = rnode_1to4_input_global_id_0_0_stall_out_reg_4_NO_SHIFT_REG;
assign rnode_1to4_input_global_id_0_0_NO_SHIFT_REG = rnode_1to4_input_global_id_0_0_reg_4_NO_SHIFT_REG;
assign rnode_1to4_input_global_id_0_0_stall_in_reg_4_NO_SHIFT_REG = rnode_1to4_input_global_id_0_0_stall_in_NO_SHIFT_REG;
assign rnode_1to4_input_global_id_0_0_valid_out_NO_SHIFT_REG = rnode_1to4_input_global_id_0_0_valid_out_reg_4_NO_SHIFT_REG;

// This section implements a registered operation.
// 
wire local_bb0_printf_addr_acl_printf_p1i8_32_inputs_ready;
 reg local_bb0_printf_addr_acl_printf_p1i8_32_valid_out_NO_SHIFT_REG;
wire local_bb0_printf_addr_acl_printf_p1i8_32_stall_in;
wire local_bb0_printf_addr_acl_printf_p1i8_32_output_regs_ready;
wire local_bb0_printf_addr_acl_printf_p1i8_32_fu_stall_out;
wire local_bb0_printf_addr_acl_printf_p1i8_32_fu_valid_out;
 reg [63:0] local_bb0_printf_addr_acl_printf_p1i8_32_NO_SHIFT_REG;
wire [63:0] local_bb0_printf_addr_acl_printf_p1i8_32_res;
wire local_bb0_printf_addr_acl_printf_p1i8_32_causedstall;

acl_printf_buffer_address_generator printf_buffer_module_local_bb0_printf_addr_acl_printf_p1i8_32 (
	.clock(clock),
	.resetn(resetn),
	.enable(local_bb0_printf_addr_acl_printf_p1i8_32_inputs_ready),
	.o_stall(local_bb0_printf_addr_acl_printf_p1i8_32_fu_stall_out),
	.i_valid(local_bb0_printf_addr_acl_printf_p1i8_32_inputs_ready),
	.i_predicate(local_bb0_cmp_xor),
	.i_globalid0(local_lvm_input_global_id_0_NO_SHIFT_REG),
	.i_increment(32'h20),
	.i_stall(~(local_bb0_printf_addr_acl_printf_p1i8_32_output_regs_ready)),
	.o_valid(local_bb0_printf_addr_acl_printf_p1i8_32_fu_valid_out),
	.o_result(local_bb0_printf_addr_acl_printf_p1i8_32_res),
	.avm_read(p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_read),
	.avm_write(p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_write),
	.avm_burstcount(p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_burstcount),
	.avm_address(p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_address),
	.avm_writedata(p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_writedata),
	.avm_byteenable(p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_byteenable),
	.avm_waitrequest(p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_waitrequest),
	.avm_readdata(p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_readdata),
	.avm_readdatavalid(p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_readdatavalid),
	.avm_writeack(p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_writeack)
);


assign local_bb0_printf_addr_acl_printf_p1i8_32_inputs_ready = (merge_node_valid_out_1_NO_SHIFT_REG & local_bb0_cmp_xor_valid_out_0);
assign local_bb0_printf_addr_acl_printf_p1i8_32_output_regs_ready = (&(~(local_bb0_printf_addr_acl_printf_p1i8_32_valid_out_NO_SHIFT_REG) | ~(local_bb0_printf_addr_acl_printf_p1i8_32_stall_in)));
assign p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_enable = 1'b1;
assign merge_node_stall_in_1 = (local_bb0_printf_addr_acl_printf_p1i8_32_fu_stall_out | ~(local_bb0_printf_addr_acl_printf_p1i8_32_inputs_ready));
assign local_bb0_cmp_xor_stall_in_0 = (local_bb0_printf_addr_acl_printf_p1i8_32_fu_stall_out | ~(local_bb0_printf_addr_acl_printf_p1i8_32_inputs_ready));
assign local_bb0_printf_addr_acl_printf_p1i8_32_causedstall = (local_bb0_printf_addr_acl_printf_p1i8_32_inputs_ready && (local_bb0_printf_addr_acl_printf_p1i8_32_fu_stall_out && !(~(local_bb0_printf_addr_acl_printf_p1i8_32_output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb0_printf_addr_acl_printf_p1i8_32_NO_SHIFT_REG <= 'x;
		local_bb0_printf_addr_acl_printf_p1i8_32_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb0_printf_addr_acl_printf_p1i8_32_output_regs_ready)
		begin
			local_bb0_printf_addr_acl_printf_p1i8_32_NO_SHIFT_REG <= local_bb0_printf_addr_acl_printf_p1i8_32_res;
			local_bb0_printf_addr_acl_printf_p1i8_32_valid_out_NO_SHIFT_REG <= local_bb0_printf_addr_acl_printf_p1i8_32_fu_valid_out;
		end
		else
		begin
			if (~(local_bb0_printf_addr_acl_printf_p1i8_32_stall_in))
			begin
				local_bb0_printf_addr_acl_printf_p1i8_32_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 3
//  * capacity = 3
 logic rnode_1to4_bb0_cmp_xor_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to4_bb0_cmp_xor_0_stall_in_NO_SHIFT_REG;
 logic rnode_1to4_bb0_cmp_xor_0_NO_SHIFT_REG;
 logic rnode_1to4_bb0_cmp_xor_0_reg_4_inputs_ready_NO_SHIFT_REG;
 logic rnode_1to4_bb0_cmp_xor_0_reg_4_NO_SHIFT_REG;
 logic rnode_1to4_bb0_cmp_xor_0_valid_out_reg_4_NO_SHIFT_REG;
 logic rnode_1to4_bb0_cmp_xor_0_stall_in_reg_4_NO_SHIFT_REG;
 logic rnode_1to4_bb0_cmp_xor_0_stall_out_reg_4_NO_SHIFT_REG;

acl_data_fifo rnode_1to4_bb0_cmp_xor_0_reg_4_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to4_bb0_cmp_xor_0_reg_4_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to4_bb0_cmp_xor_0_stall_in_reg_4_NO_SHIFT_REG),
	.valid_out(rnode_1to4_bb0_cmp_xor_0_valid_out_reg_4_NO_SHIFT_REG),
	.stall_out(rnode_1to4_bb0_cmp_xor_0_stall_out_reg_4_NO_SHIFT_REG),
	.data_in(local_bb0_cmp_xor),
	.data_out(rnode_1to4_bb0_cmp_xor_0_reg_4_NO_SHIFT_REG)
);

defparam rnode_1to4_bb0_cmp_xor_0_reg_4_fifo.DEPTH = 4;
defparam rnode_1to4_bb0_cmp_xor_0_reg_4_fifo.DATA_WIDTH = 1;
defparam rnode_1to4_bb0_cmp_xor_0_reg_4_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to4_bb0_cmp_xor_0_reg_4_fifo.IMPL = "ll_reg";

assign rnode_1to4_bb0_cmp_xor_0_reg_4_inputs_ready_NO_SHIFT_REG = local_bb0_cmp_xor_valid_out_1;
assign local_bb0_cmp_xor_stall_in_1 = rnode_1to4_bb0_cmp_xor_0_stall_out_reg_4_NO_SHIFT_REG;
assign rnode_1to4_bb0_cmp_xor_0_NO_SHIFT_REG = rnode_1to4_bb0_cmp_xor_0_reg_4_NO_SHIFT_REG;
assign rnode_1to4_bb0_cmp_xor_0_stall_in_reg_4_NO_SHIFT_REG = rnode_1to4_bb0_cmp_xor_0_stall_in_NO_SHIFT_REG;
assign rnode_1to4_bb0_cmp_xor_0_valid_out_NO_SHIFT_REG = rnode_1to4_bb0_cmp_xor_0_valid_out_reg_4_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb0_printf_data1_valid_out;
wire local_bb0_printf_data1_stall_in;
wire local_bb0_printf_data1_inputs_ready;
wire local_bb0_printf_data1_stall_local;
wire [255:0] local_bb0_printf_data1;

assign local_bb0_printf_data1_inputs_ready = rnode_1to4_input_global_id_0_0_valid_out_NO_SHIFT_REG;
assign local_bb0_printf_data1[31:0] = 32'h0;
assign local_bb0_printf_data1[63:32] = rnode_1to4_input_global_id_0_0_NO_SHIFT_REG;
assign local_bb0_printf_data1[255:64] = 192'h0;
assign local_bb0_printf_data1_valid_out = local_bb0_printf_data1_inputs_ready;
assign local_bb0_printf_data1_stall_local = local_bb0_printf_data1_stall_in;
assign rnode_1to4_input_global_id_0_0_stall_in_NO_SHIFT_REG = (|local_bb0_printf_data1_stall_local);

// This section implements a staging register.
// 
wire rstag_4to4_bb0_printf_addr_acl_printf_p1i8_32_valid_out;
wire rstag_4to4_bb0_printf_addr_acl_printf_p1i8_32_stall_in;
wire rstag_4to4_bb0_printf_addr_acl_printf_p1i8_32_inputs_ready;
wire rstag_4to4_bb0_printf_addr_acl_printf_p1i8_32_stall_local;
 reg rstag_4to4_bb0_printf_addr_acl_printf_p1i8_32_staging_valid_NO_SHIFT_REG;
wire rstag_4to4_bb0_printf_addr_acl_printf_p1i8_32_combined_valid;
 reg [63:0] rstag_4to4_bb0_printf_addr_acl_printf_p1i8_32_staging_reg_NO_SHIFT_REG;
wire [63:0] rstag_4to4_bb0_printf_addr_acl_printf_p1i8_32;

assign rstag_4to4_bb0_printf_addr_acl_printf_p1i8_32_inputs_ready = local_bb0_printf_addr_acl_printf_p1i8_32_valid_out_NO_SHIFT_REG;
assign rstag_4to4_bb0_printf_addr_acl_printf_p1i8_32 = (rstag_4to4_bb0_printf_addr_acl_printf_p1i8_32_staging_valid_NO_SHIFT_REG ? rstag_4to4_bb0_printf_addr_acl_printf_p1i8_32_staging_reg_NO_SHIFT_REG : local_bb0_printf_addr_acl_printf_p1i8_32_NO_SHIFT_REG);
assign rstag_4to4_bb0_printf_addr_acl_printf_p1i8_32_combined_valid = (rstag_4to4_bb0_printf_addr_acl_printf_p1i8_32_staging_valid_NO_SHIFT_REG | rstag_4to4_bb0_printf_addr_acl_printf_p1i8_32_inputs_ready);
assign rstag_4to4_bb0_printf_addr_acl_printf_p1i8_32_valid_out = rstag_4to4_bb0_printf_addr_acl_printf_p1i8_32_combined_valid;
assign rstag_4to4_bb0_printf_addr_acl_printf_p1i8_32_stall_local = rstag_4to4_bb0_printf_addr_acl_printf_p1i8_32_stall_in;
assign local_bb0_printf_addr_acl_printf_p1i8_32_stall_in = (|rstag_4to4_bb0_printf_addr_acl_printf_p1i8_32_staging_valid_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rstag_4to4_bb0_printf_addr_acl_printf_p1i8_32_staging_valid_NO_SHIFT_REG <= 1'b0;
		rstag_4to4_bb0_printf_addr_acl_printf_p1i8_32_staging_reg_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (rstag_4to4_bb0_printf_addr_acl_printf_p1i8_32_stall_local)
		begin
			if (~(rstag_4to4_bb0_printf_addr_acl_printf_p1i8_32_staging_valid_NO_SHIFT_REG))
			begin
				rstag_4to4_bb0_printf_addr_acl_printf_p1i8_32_staging_valid_NO_SHIFT_REG <= rstag_4to4_bb0_printf_addr_acl_printf_p1i8_32_inputs_ready;
			end
		end
		else
		begin
			rstag_4to4_bb0_printf_addr_acl_printf_p1i8_32_staging_valid_NO_SHIFT_REG <= 1'b0;
		end
		if (~(rstag_4to4_bb0_printf_addr_acl_printf_p1i8_32_staging_valid_NO_SHIFT_REG))
		begin
			rstag_4to4_bb0_printf_addr_acl_printf_p1i8_32_staging_reg_NO_SHIFT_REG <= local_bb0_printf_addr_acl_printf_p1i8_32_NO_SHIFT_REG;
		end
	end
end


// This section implements an unregistered operation.
// 
wire local_bb0_var__valid_out;
wire local_bb0_var__stall_in;
wire local_bb0_var__inputs_ready;
wire local_bb0_var__stall_local;
wire [63:0] local_bb0_var_;

assign local_bb0_var__inputs_ready = rstag_4to4_bb0_printf_addr_acl_printf_p1i8_32_valid_out;
assign local_bb0_var_ = rstag_4to4_bb0_printf_addr_acl_printf_p1i8_32;
assign local_bb0_var__valid_out = local_bb0_var__inputs_ready;
assign local_bb0_var__stall_local = local_bb0_var__stall_in;
assign rstag_4to4_bb0_printf_addr_acl_printf_p1i8_32_stall_in = (|local_bb0_var__stall_local);

// This section implements a registered operation.
// 
wire local_bb0_st_printf_data1_inputs_ready;
 reg local_bb0_st_printf_data1_valid_out_NO_SHIFT_REG;
wire local_bb0_st_printf_data1_stall_in;
wire local_bb0_st_printf_data1_output_regs_ready;
wire local_bb0_st_printf_data1_fu_stall_out;
wire local_bb0_st_printf_data1_fu_valid_out;
wire local_bb0_st_printf_data1_causedstall;

lsu_top lsu_local_bb0_st_printf_data1 (
	.clock(clock),
	.clock2x(clock2x),
	.resetn(resetn),
	.flush(start),
	.stream_base_addr(),
	.stream_size(),
	.stream_reset(),
	.o_stall(local_bb0_st_printf_data1_fu_stall_out),
	.i_valid(local_bb0_st_printf_data1_inputs_ready),
	.i_address(local_bb0_var_),
	.i_writedata(local_bb0_printf_data1),
	.i_cmpdata(),
	.i_predicate(rnode_1to4_bb0_cmp_xor_0_NO_SHIFT_REG),
	.i_bitwiseor(64'h0),
	.i_byteenable(),
	.i_stall(~(local_bb0_st_printf_data1_output_regs_ready)),
	.o_valid(local_bb0_st_printf_data1_fu_valid_out),
	.o_readdata(),
	.o_input_fifo_depth(),
	.o_writeack(),
	.i_atomic_op(3'h0),
	.o_active(local_bb0_st_printf_data1_active),
	.avm_address(avm_local_bb0_st_printf_data1_address),
	.avm_read(avm_local_bb0_st_printf_data1_read),
	.avm_enable(avm_local_bb0_st_printf_data1_enable),
	.avm_readdata(avm_local_bb0_st_printf_data1_readdata),
	.avm_write(avm_local_bb0_st_printf_data1_write),
	.avm_writeack(avm_local_bb0_st_printf_data1_writeack),
	.avm_burstcount(avm_local_bb0_st_printf_data1_burstcount),
	.avm_writedata(avm_local_bb0_st_printf_data1_writedata),
	.avm_byteenable(avm_local_bb0_st_printf_data1_byteenable),
	.avm_waitrequest(avm_local_bb0_st_printf_data1_waitrequest),
	.avm_readdatavalid(avm_local_bb0_st_printf_data1_readdatavalid),
	.profile_bw(),
	.profile_bw_incr(),
	.profile_total_ivalid(),
	.profile_total_req(),
	.profile_i_stall_count(),
	.profile_o_stall_count(),
	.profile_avm_readwrite_count(),
	.profile_avm_burstcount_total(),
	.profile_avm_burstcount_total_incr(),
	.profile_req_cache_hit_count(),
	.profile_extra_unaligned_reqs(),
	.profile_avm_stall()
);

defparam lsu_local_bb0_st_printf_data1.AWIDTH = 31;
defparam lsu_local_bb0_st_printf_data1.WIDTH_BYTES = 32;
defparam lsu_local_bb0_st_printf_data1.MWIDTH_BYTES = 64;
defparam lsu_local_bb0_st_printf_data1.WRITEDATAWIDTH_BYTES = 64;
defparam lsu_local_bb0_st_printf_data1.ALIGNMENT_BYTES = 8;
defparam lsu_local_bb0_st_printf_data1.READ = 0;
defparam lsu_local_bb0_st_printf_data1.ATOMIC = 0;
defparam lsu_local_bb0_st_printf_data1.WIDTH = 256;
defparam lsu_local_bb0_st_printf_data1.MWIDTH = 512;
defparam lsu_local_bb0_st_printf_data1.ATOMIC_WIDTH = 3;
defparam lsu_local_bb0_st_printf_data1.BURSTCOUNT_WIDTH = 5;
defparam lsu_local_bb0_st_printf_data1.KERNEL_SIDE_MEM_LATENCY = 4;
defparam lsu_local_bb0_st_printf_data1.MEMORY_SIDE_MEM_LATENCY = 8;
defparam lsu_local_bb0_st_printf_data1.USE_WRITE_ACK = 0;
defparam lsu_local_bb0_st_printf_data1.ENABLE_BANKED_MEMORY = 0;
defparam lsu_local_bb0_st_printf_data1.ABITS_PER_LMEM_BANK = 0;
defparam lsu_local_bb0_st_printf_data1.NUMBER_BANKS = 1;
defparam lsu_local_bb0_st_printf_data1.LMEM_ADDR_PERMUTATION_STYLE = 0;
defparam lsu_local_bb0_st_printf_data1.INTENDED_DEVICE_FAMILY = "Arria 10";
defparam lsu_local_bb0_st_printf_data1.USEINPUTFIFO = 0;
defparam lsu_local_bb0_st_printf_data1.USECACHING = 0;
defparam lsu_local_bb0_st_printf_data1.USEOUTPUTFIFO = 1;
defparam lsu_local_bb0_st_printf_data1.FORCE_NOP_SUPPORT = 0;
defparam lsu_local_bb0_st_printf_data1.ADDRSPACE = 1;
defparam lsu_local_bb0_st_printf_data1.STYLE = "BURST-NON-ALIGNED";
defparam lsu_local_bb0_st_printf_data1.USE_BYTE_EN = 0;

assign local_bb0_st_printf_data1_inputs_ready = (local_bb0_printf_data1_valid_out & local_bb0_var__valid_out & rnode_1to4_bb0_cmp_xor_0_valid_out_NO_SHIFT_REG);
assign local_bb0_st_printf_data1_output_regs_ready = (&(~(local_bb0_st_printf_data1_valid_out_NO_SHIFT_REG) | ~(local_bb0_st_printf_data1_stall_in)));
assign local_bb0_printf_data1_stall_in = (local_bb0_st_printf_data1_fu_stall_out | ~(local_bb0_st_printf_data1_inputs_ready));
assign local_bb0_var__stall_in = (local_bb0_st_printf_data1_fu_stall_out | ~(local_bb0_st_printf_data1_inputs_ready));
assign rnode_1to4_bb0_cmp_xor_0_stall_in_NO_SHIFT_REG = (local_bb0_st_printf_data1_fu_stall_out | ~(local_bb0_st_printf_data1_inputs_ready));
assign local_bb0_st_printf_data1_causedstall = (local_bb0_st_printf_data1_inputs_ready && (local_bb0_st_printf_data1_fu_stall_out && !(~(local_bb0_st_printf_data1_output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb0_st_printf_data1_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb0_st_printf_data1_output_regs_ready)
		begin
			local_bb0_st_printf_data1_valid_out_NO_SHIFT_REG <= local_bb0_st_printf_data1_fu_valid_out;
		end
		else
		begin
			if (~(local_bb0_st_printf_data1_stall_in))
			begin
				local_bb0_st_printf_data1_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements a staging register.
// 
wire rstag_8to8_bb0_st_printf_data1_valid_out;
wire rstag_8to8_bb0_st_printf_data1_stall_in;
wire rstag_8to8_bb0_st_printf_data1_inputs_ready;
wire rstag_8to8_bb0_st_printf_data1_stall_local;
 reg rstag_8to8_bb0_st_printf_data1_staging_valid_NO_SHIFT_REG;
wire rstag_8to8_bb0_st_printf_data1_combined_valid;

assign rstag_8to8_bb0_st_printf_data1_inputs_ready = local_bb0_st_printf_data1_valid_out_NO_SHIFT_REG;
assign rstag_8to8_bb0_st_printf_data1_combined_valid = (rstag_8to8_bb0_st_printf_data1_staging_valid_NO_SHIFT_REG | rstag_8to8_bb0_st_printf_data1_inputs_ready);
assign rstag_8to8_bb0_st_printf_data1_valid_out = rstag_8to8_bb0_st_printf_data1_combined_valid;
assign rstag_8to8_bb0_st_printf_data1_stall_local = rstag_8to8_bb0_st_printf_data1_stall_in;
assign local_bb0_st_printf_data1_stall_in = (|rstag_8to8_bb0_st_printf_data1_staging_valid_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rstag_8to8_bb0_st_printf_data1_staging_valid_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (rstag_8to8_bb0_st_printf_data1_stall_local)
		begin
			if (~(rstag_8to8_bb0_st_printf_data1_staging_valid_NO_SHIFT_REG))
			begin
				rstag_8to8_bb0_st_printf_data1_staging_valid_NO_SHIFT_REG <= rstag_8to8_bb0_st_printf_data1_inputs_ready;
			end
		end
		else
		begin
			rstag_8to8_bb0_st_printf_data1_staging_valid_NO_SHIFT_REG <= 1'b0;
		end
	end
end


// This section describes the behaviour of the BRANCH node.
wire branch_var__inputs_ready;
wire branch_var__output_regs_ready;

assign branch_var__inputs_ready = rstag_8to8_bb0_st_printf_data1_valid_out;
assign branch_var__output_regs_ready = ~(stall_in);
assign rstag_8to8_bb0_st_printf_data1_stall_in = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign valid_out = branch_var__inputs_ready;

endmodule

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

// altera message_off 10036
// altera message_off 10230
// altera message_off 10858
module hello_world_function
	(
		input 		clock,
		input 		resetn,
		input [31:0] 		input_global_id_0,
		output 		stall_out,
		input 		valid_in,
		output 		valid_out,
		input 		stall_in,
		input [31:0] 		workgroup_size,
		output 		p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_enable,
		input [255:0] 		p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_readdata,
		input 		p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_readdatavalid,
		input 		p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_waitrequest,
		output [31:0] 		p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_address,
		output 		p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_read,
		output 		p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_write,
		input 		p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_writeack,
		output [255:0] 		p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_writedata,
		output [31:0] 		p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_byteenable,
		output [5:0] 		p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_burstcount,
		output 		avm_local_bb0_st_printf_data1_enable,
		input [511:0] 		avm_local_bb0_st_printf_data1_readdata,
		input 		avm_local_bb0_st_printf_data1_readdatavalid,
		input 		avm_local_bb0_st_printf_data1_waitrequest,
		output [30:0] 		avm_local_bb0_st_printf_data1_address,
		output 		avm_local_bb0_st_printf_data1_read,
		output 		avm_local_bb0_st_printf_data1_write,
		input 		avm_local_bb0_st_printf_data1_writeack,
		output [511:0] 		avm_local_bb0_st_printf_data1_writedata,
		output [63:0] 		avm_local_bb0_st_printf_data1_byteenable,
		output [4:0] 		avm_local_bb0_st_printf_data1_burstcount,
		input 		clock2x,
		input 		start,
		input [31:0] 		input_thread_id_from_which_to_print_message,
		output reg 		has_a_write_pending,
		output reg 		has_a_lsu_active
	);


wire [31:0] cur_cycle;
wire bb_0_stall_out;
wire bb_0_valid_out;
wire bb_0_local_bb0_st_printf_data1_active;
wire writes_pending;
wire lsus_active;

hello_world_basic_block_0 hello_world_basic_block_0 (
	.clock(clock),
	.resetn(resetn),
	.input_thread_id_from_which_to_print_message(input_thread_id_from_which_to_print_message),
	.valid_in(valid_in),
	.stall_out(bb_0_stall_out),
	.input_global_id_0(input_global_id_0),
	.valid_out(bb_0_valid_out),
	.stall_in(stall_in),
	.workgroup_size(workgroup_size),
	.start(start),
	.p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_enable(p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_enable),
	.p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_readdata(p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_readdata),
	.p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_readdatavalid(p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_readdatavalid),
	.p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_waitrequest(p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_waitrequest),
	.p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_address(p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_address),
	.p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_read(p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_read),
	.p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_write(p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_write),
	.p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_writeack(p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_writeack),
	.p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_writedata(p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_writedata),
	.p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_byteenable(p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_byteenable),
	.p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_burstcount(p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_burstcount),
	.avm_local_bb0_st_printf_data1_enable(avm_local_bb0_st_printf_data1_enable),
	.avm_local_bb0_st_printf_data1_readdata(avm_local_bb0_st_printf_data1_readdata),
	.avm_local_bb0_st_printf_data1_readdatavalid(avm_local_bb0_st_printf_data1_readdatavalid),
	.avm_local_bb0_st_printf_data1_waitrequest(avm_local_bb0_st_printf_data1_waitrequest),
	.avm_local_bb0_st_printf_data1_address(avm_local_bb0_st_printf_data1_address),
	.avm_local_bb0_st_printf_data1_read(avm_local_bb0_st_printf_data1_read),
	.avm_local_bb0_st_printf_data1_write(avm_local_bb0_st_printf_data1_write),
	.avm_local_bb0_st_printf_data1_writeack(avm_local_bb0_st_printf_data1_writeack),
	.avm_local_bb0_st_printf_data1_writedata(avm_local_bb0_st_printf_data1_writedata),
	.avm_local_bb0_st_printf_data1_byteenable(avm_local_bb0_st_printf_data1_byteenable),
	.avm_local_bb0_st_printf_data1_burstcount(avm_local_bb0_st_printf_data1_burstcount),
	.local_bb0_st_printf_data1_active(bb_0_local_bb0_st_printf_data1_active),
	.clock2x(clock2x)
);


hello_world_sys_cycle_time system_cycle_time_module (
	.clock(clock),
	.resetn(resetn),
	.cur_cycle(cur_cycle)
);


assign valid_out = bb_0_valid_out;
assign stall_out = bb_0_stall_out;
assign writes_pending = bb_0_local_bb0_st_printf_data1_active;
assign lsus_active = bb_0_local_bb0_st_printf_data1_active;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		has_a_write_pending <= 1'b0;
		has_a_lsu_active <= 1'b0;
	end
	else
	begin
		has_a_write_pending <= (|writes_pending);
		has_a_lsu_active <= (|lsus_active);
	end
end

endmodule

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

// altera message_off 10036
// altera message_off 10230
// altera message_off 10858
module hello_world_function_cra_slave
	(
		input 		clock,
		input 		resetn,
		output reg [127:0] 		kernel_arguments,
		output reg 		start,
		input 		finish,
		output reg [31:0] 		global_size_0,
		output reg [31:0] 		global_size_1,
		output reg [31:0] 		global_size_2,
		output reg [31:0] 		num_groups_0,
		output reg [31:0] 		num_groups_1,
		output reg [31:0] 		num_groups_2,
		output reg [31:0] 		local_size_0,
		output reg [31:0] 		local_size_1,
		output reg [31:0] 		local_size_2,
		output reg [31:0] 		global_offset_0,
		output reg [31:0] 		global_offset_1,
		output reg [31:0] 		global_offset_2,
		output reg [31:0] 		work_dim,
		output reg [31:0] 		workgroup_size,
		input 		has_a_lsu_active,
		input 		has_a_write_pending,
		input 		valid_in,
		output 		acl_counter_reset,
		output [63:0] 		acl_counter_init,
		output [31:0] 		acl_counter_limit,
		input [31:0] 		acl_counter_size,
		input 		acl_counter_full,
		input 		avs_cra_enable,
		input 		avs_cra_read,
		input 		avs_cra_write,
		input [3:0] 		avs_cra_address,
		input [63:0] 		avs_cra_writedata,
		input [7:0] 		avs_cra_byteenable,
		output reg [63:0] 		avs_cra_readdata,
		output reg 		avs_cra_readdatavalid,
		output 		cra_irq
	);


// This section of the wrapper implements an Avalon Slave Interface used to configure a kernel invocation.
// The few words words contain the status and the workgroup size registers.
// The remaining addressable space is reserved for kernel arguments.
 reg started_NO_SHIFT_REG;
 reg [31:0] status_NO_SHIFT_REG;
wire [63:0] acl_counter_init_signal;
wire [31:0] acl_counter_limit_signal;
 reg [63:0] profile_data_NO_SHIFT_REG;
 reg [31:0] profile_ctrl_NO_SHIFT_REG;
 reg [63:0] profile_start_cycle_NO_SHIFT_REG;
 reg [63:0] profile_stop_cycle_NO_SHIFT_REG;
 reg [63:0] cra_readdata_st1_NO_SHIFT_REG;
 reg [3:0] cra_addr_st1_NO_SHIFT_REG;
 reg cra_read_st1_NO_SHIFT_REG;
wire [63:0] bitenable;

assign acl_counter_init = acl_counter_init_signal;
assign acl_counter_limit = acl_counter_limit_signal;
assign bitenable[7:0] = (avs_cra_byteenable[0] ? 8'hFF : 8'h0);
assign bitenable[15:8] = (avs_cra_byteenable[1] ? 8'hFF : 8'h0);
assign bitenable[23:16] = (avs_cra_byteenable[2] ? 8'hFF : 8'h0);
assign bitenable[31:24] = (avs_cra_byteenable[3] ? 8'hFF : 8'h0);
assign bitenable[39:32] = (avs_cra_byteenable[4] ? 8'hFF : 8'h0);
assign bitenable[47:40] = (avs_cra_byteenable[5] ? 8'hFF : 8'h0);
assign bitenable[55:48] = (avs_cra_byteenable[6] ? 8'hFF : 8'h0);
assign bitenable[63:56] = (avs_cra_byteenable[7] ? 8'hFF : 8'h0);
assign cra_irq = (status_NO_SHIFT_REG[1] | status_NO_SHIFT_REG[3]);
assign acl_counter_reset = status_NO_SHIFT_REG[4];
assign acl_counter_init_signal = kernel_arguments[95:32];
assign acl_counter_limit_signal = kernel_arguments[127:96];

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		start <= 1'b0;
		started_NO_SHIFT_REG <= 1'b0;
		kernel_arguments <= 128'h0;
		status_NO_SHIFT_REG <= 32'h30000;
		profile_ctrl_NO_SHIFT_REG <= 32'h4;
		profile_start_cycle_NO_SHIFT_REG <= 64'h0;
		profile_stop_cycle_NO_SHIFT_REG <= 64'hFFFFFFFFFFFFFFFF;
		work_dim <= 32'h0;
		workgroup_size <= 32'h0;
		global_size_0 <= 32'h0;
		global_size_1 <= 32'h0;
		global_size_2 <= 32'h0;
		num_groups_0 <= 32'h0;
		num_groups_1 <= 32'h0;
		num_groups_2 <= 32'h0;
		local_size_0 <= 32'h0;
		local_size_1 <= 32'h0;
		local_size_2 <= 32'h0;
		global_offset_0 <= 32'h0;
		global_offset_1 <= 32'h0;
		global_offset_2 <= 32'h0;
	end
	else
	begin
		if (avs_cra_write)
		begin
			case (avs_cra_address)
				4'h0:
				begin
					status_NO_SHIFT_REG[31:16] <= 16'h3;
					status_NO_SHIFT_REG[15:0] <= ((status_NO_SHIFT_REG[15:0] & ~(bitenable[15:0])) | (avs_cra_writedata[15:0] & bitenable[15:0]));
				end

				4'h1:
				begin
					profile_ctrl_NO_SHIFT_REG <= ((profile_ctrl_NO_SHIFT_REG & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'h3:
				begin
					profile_start_cycle_NO_SHIFT_REG[31:0] <= ((profile_start_cycle_NO_SHIFT_REG[31:0] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					profile_start_cycle_NO_SHIFT_REG[63:32] <= ((profile_start_cycle_NO_SHIFT_REG[63:32] & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'h4:
				begin
					profile_stop_cycle_NO_SHIFT_REG[31:0] <= ((profile_stop_cycle_NO_SHIFT_REG[31:0] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					profile_stop_cycle_NO_SHIFT_REG[63:32] <= ((profile_stop_cycle_NO_SHIFT_REG[63:32] & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'h5:
				begin
					work_dim <= ((work_dim & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					workgroup_size <= ((workgroup_size & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'h6:
				begin
					global_size_0 <= ((global_size_0 & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					global_size_1 <= ((global_size_1 & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'h7:
				begin
					global_size_2 <= ((global_size_2 & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					num_groups_0 <= ((num_groups_0 & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'h8:
				begin
					num_groups_1 <= ((num_groups_1 & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					num_groups_2 <= ((num_groups_2 & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'h9:
				begin
					local_size_0 <= ((local_size_0 & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					local_size_1 <= ((local_size_1 & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'hA:
				begin
					local_size_2 <= ((local_size_2 & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					global_offset_0 <= ((global_offset_0 & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'hB:
				begin
					global_offset_1 <= ((global_offset_1 & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					global_offset_2 <= ((global_offset_2 & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'hC:
				begin
					kernel_arguments[31:0] <= ((kernel_arguments[31:0] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					kernel_arguments[63:32] <= ((kernel_arguments[63:32] & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'hD:
				begin
					kernel_arguments[95:64] <= ((kernel_arguments[95:64] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					kernel_arguments[127:96] <= ((kernel_arguments[127:96] & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				default:
				begin
				end

			endcase
		end
		else
		begin
			if (status_NO_SHIFT_REG[0])
			begin
				start <= 1'b1;
			end
			if (start)
			begin
				status_NO_SHIFT_REG[0] <= 1'b0;
				started_NO_SHIFT_REG <= 1'b1;
			end
			if (started_NO_SHIFT_REG)
			begin
				start <= 1'b0;
			end
			if (finish)
			begin
				status_NO_SHIFT_REG[1] <= 1'b1;
				started_NO_SHIFT_REG <= 1'b0;
			end
			if (acl_counter_full)
			begin
				status_NO_SHIFT_REG[3] <= 1'b1;
			end
			if (status_NO_SHIFT_REG[4])
			begin
				status_NO_SHIFT_REG[4] <= 1'b0;
			end
		end
		status_NO_SHIFT_REG[11] <= 1'b0;
		status_NO_SHIFT_REG[12] <= (|has_a_lsu_active);
		status_NO_SHIFT_REG[13] <= (|has_a_write_pending);
		status_NO_SHIFT_REG[14] <= (|valid_in);
		status_NO_SHIFT_REG[15] <= started_NO_SHIFT_REG;
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		cra_read_st1_NO_SHIFT_REG <= 1'b0;
		cra_addr_st1_NO_SHIFT_REG <= 4'h0;
		cra_readdata_st1_NO_SHIFT_REG <= 64'h0;
	end
	else
	begin
		cra_read_st1_NO_SHIFT_REG <= avs_cra_read;
		cra_addr_st1_NO_SHIFT_REG <= avs_cra_address;
		case (avs_cra_address)
			4'h0:
			begin
				cra_readdata_st1_NO_SHIFT_REG[31:0] <= status_NO_SHIFT_REG;
				cra_readdata_st1_NO_SHIFT_REG[63:32] <= acl_counter_size;
			end

			4'h1:
			begin
				cra_readdata_st1_NO_SHIFT_REG[31:0] <= 'x;
				cra_readdata_st1_NO_SHIFT_REG[63:32] <= 32'h0;
			end

			4'h2:
			begin
				cra_readdata_st1_NO_SHIFT_REG[63:0] <= 64'h0;
			end

			4'h3:
			begin
				cra_readdata_st1_NO_SHIFT_REG[63:0] <= 64'h0;
			end

			4'h4:
			begin
				cra_readdata_st1_NO_SHIFT_REG[63:0] <= 64'h0;
			end

			default:
			begin
				cra_readdata_st1_NO_SHIFT_REG <= status_NO_SHIFT_REG;
			end

		endcase
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		avs_cra_readdatavalid <= 1'b0;
		avs_cra_readdata <= 64'h0;
	end
	else
	begin
		avs_cra_readdatavalid <= cra_read_st1_NO_SHIFT_REG;
		case (cra_addr_st1_NO_SHIFT_REG)
			4'h2:
			begin
				avs_cra_readdata[63:0] <= profile_data_NO_SHIFT_REG;
			end

			default:
			begin
				avs_cra_readdata <= cra_readdata_st1_NO_SHIFT_REG;
			end

		endcase
	end
end


endmodule

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

// altera message_off 10036
// altera message_off 10230
// altera message_off 10858
module hello_world_function_wrapper
	(
		input 		clock,
		input 		resetn,
		input 		clock2x,
		input 		local_router_hang,
		output 		has_a_write_pending,
		output 		has_a_lsu_active,
		input [127:0] 		kernel_arguments,
		input 		start,
		input [31:0] 		global_offset_0,
		input [31:0] 		global_offset_1,
		input [31:0] 		global_offset_2,
		input [31:0] 		work_dim,
		output 		kernel_valid_out,
		input [31:0] 		workgroup_size,
		input [31:0] 		global_size_0,
		input [31:0] 		global_size_1,
		input [31:0] 		global_size_2,
		input [31:0] 		num_groups_0,
		input [31:0] 		num_groups_1,
		input [31:0] 		num_groups_2,
		input [31:0] 		local_size_0,
		input [31:0] 		local_size_1,
		input [31:0] 		local_size_2,
		input [31:0] 		local_id_0,
		input [31:0] 		local_id_1,
		input [31:0] 		local_id_2,
		input [31:0] 		global_id_0,
		input [31:0] 		global_id_1,
		input [31:0] 		global_id_2,
		input [31:0] 		group_id_0,
		input [31:0] 		group_id_1,
		input [31:0] 		group_id_2,
		output 		kernel_stall_out,
		input 		kernel_valid_in,
		output 		p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_inst0_enable,
		input [255:0] 		p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_inst0_readdata,
		input 		p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_inst0_readdatavalid,
		input 		p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_inst0_waitrequest,
		output [31:0] 		p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_inst0_address,
		output 		p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_inst0_read,
		output 		p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_inst0_write,
		input 		p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_inst0_writeack,
		output [255:0] 		p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_inst0_writedata,
		output [31:0] 		p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_inst0_byteenable,
		output [5:0] 		p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_inst0_burstcount,
		output 		avm_local_bb0_st_printf_data1_inst0_enable,
		input [511:0] 		avm_local_bb0_st_printf_data1_inst0_readdata,
		input 		avm_local_bb0_st_printf_data1_inst0_readdatavalid,
		input 		avm_local_bb0_st_printf_data1_inst0_waitrequest,
		output [30:0] 		avm_local_bb0_st_printf_data1_inst0_address,
		output 		avm_local_bb0_st_printf_data1_inst0_read,
		output 		avm_local_bb0_st_printf_data1_inst0_write,
		input 		avm_local_bb0_st_printf_data1_inst0_writeack,
		output [511:0] 		avm_local_bb0_st_printf_data1_inst0_writedata,
		output [63:0] 		avm_local_bb0_st_printf_data1_inst0_byteenable,
		output [4:0] 		avm_local_bb0_st_printf_data1_inst0_burstcount
	);

// Responsible for interfacing a kernel with the outside world.

// twoXclock_consumer uses clock2x, even if nobody inside the kernel does. Keeps interface to acl_iface consistent for all kernels.
 reg twoXclock_consumer_NO_SHIFT_REG /* synthesis  preserve  noprune  */;
wire stall_in;
wire stall_out;
wire valid_in;
wire valid_out;

assign kernel_valid_out = valid_out;
assign valid_in = kernel_valid_in;
assign kernel_stall_out = stall_out;
assign stall_in = 1'b0;

always @(posedge clock2x or negedge resetn)
begin
	if (~(resetn))
	begin
		twoXclock_consumer_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		twoXclock_consumer_NO_SHIFT_REG <= 1'b1;
	end
end



// This section instantiates a kernel function block
hello_world_function hello_world_function_inst0 (
	.clock(clock),
	.resetn(resetn),
	.input_global_id_0(global_id_0),
	.stall_out(stall_out),
	.valid_in(valid_in),
	.valid_out(valid_out),
	.stall_in(stall_in),
	.workgroup_size(workgroup_size),
	.p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_enable(p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_inst0_enable),
	.p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_readdata(p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_inst0_readdata),
	.p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_readdatavalid(p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_inst0_readdatavalid),
	.p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_waitrequest(p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_inst0_waitrequest),
	.p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_address(p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_inst0_address),
	.p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_read(p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_inst0_read),
	.p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_write(p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_inst0_write),
	.p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_writeack(p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_inst0_writeack),
	.p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_writedata(p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_inst0_writedata),
	.p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_byteenable(p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_inst0_byteenable),
	.p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_burstcount(p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_inst0_burstcount),
	.avm_local_bb0_st_printf_data1_enable(avm_local_bb0_st_printf_data1_inst0_enable),
	.avm_local_bb0_st_printf_data1_readdata(avm_local_bb0_st_printf_data1_inst0_readdata),
	.avm_local_bb0_st_printf_data1_readdatavalid(avm_local_bb0_st_printf_data1_inst0_readdatavalid),
	.avm_local_bb0_st_printf_data1_waitrequest(avm_local_bb0_st_printf_data1_inst0_waitrequest),
	.avm_local_bb0_st_printf_data1_address(avm_local_bb0_st_printf_data1_inst0_address),
	.avm_local_bb0_st_printf_data1_read(avm_local_bb0_st_printf_data1_inst0_read),
	.avm_local_bb0_st_printf_data1_write(avm_local_bb0_st_printf_data1_inst0_write),
	.avm_local_bb0_st_printf_data1_writeack(avm_local_bb0_st_printf_data1_inst0_writeack),
	.avm_local_bb0_st_printf_data1_writedata(avm_local_bb0_st_printf_data1_inst0_writedata),
	.avm_local_bb0_st_printf_data1_byteenable(avm_local_bb0_st_printf_data1_inst0_byteenable),
	.avm_local_bb0_st_printf_data1_burstcount(avm_local_bb0_st_printf_data1_inst0_burstcount),
	.clock2x(clock2x),
	.start(start),
	.input_thread_id_from_which_to_print_message(kernel_arguments[31:0]),
	.has_a_write_pending(has_a_write_pending),
	.has_a_lsu_active(has_a_lsu_active)
);



endmodule

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

// altera message_off 10036
// altera message_off 10230
// altera message_off 10858
module hello_world_sys_cycle_time
	(
		input 		clock,
		input 		resetn,
		output [31:0] 		cur_cycle
	);


 reg [31:0] cur_count_NO_SHIFT_REG;

assign cur_cycle = cur_count_NO_SHIFT_REG;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		cur_count_NO_SHIFT_REG <= 32'h0;
	end
	else
	begin
		cur_count_NO_SHIFT_REG <= (cur_count_NO_SHIFT_REG + 32'h1);
	end
end

endmodule

