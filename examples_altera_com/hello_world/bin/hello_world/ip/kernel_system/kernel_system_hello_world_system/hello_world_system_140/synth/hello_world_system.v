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
    


/////////////////////////////////////////////////////////////////
// MODULE hello_world_system
/////////////////////////////////////////////////////////////////
module hello_world_system
(
   input logic clock,
   input logic clock2x,
   input logic resetn,
   // AVS avs_hello_world_cra
   input logic avs_hello_world_cra_enable,
   input logic avs_hello_world_cra_read,
   input logic avs_hello_world_cra_write,
   input logic [3:0] avs_hello_world_cra_address,
   input logic [63:0] avs_hello_world_cra_writedata,
   input logic [7:0] avs_hello_world_cra_byteenable,
   output logic [63:0] avs_hello_world_cra_readdata,
   output logic avs_hello_world_cra_readdatavalid,
   output logic kernel_irq,
   // AVM avm_memgmem0_DDR_port_0_0_rw
   output logic avm_memgmem0_DDR_port_0_0_rw_enable,
   output logic avm_memgmem0_DDR_port_0_0_rw_read,
   output logic avm_memgmem0_DDR_port_0_0_rw_write,
   output logic [4:0] avm_memgmem0_DDR_port_0_0_rw_burstcount,
   output logic [30:0] avm_memgmem0_DDR_port_0_0_rw_address,
   output logic [511:0] avm_memgmem0_DDR_port_0_0_rw_writedata,
   output logic [63:0] avm_memgmem0_DDR_port_0_0_rw_byteenable,
   input logic avm_memgmem0_DDR_port_0_0_rw_waitrequest,
   input logic [511:0] avm_memgmem0_DDR_port_0_0_rw_readdata,
   input logic avm_memgmem0_DDR_port_0_0_rw_readdatavalid,
   input logic avm_memgmem0_DDR_port_0_0_rw_writeack
);
   genvar __i;
   logic hello_world_start;
   logic [0:0] hello_world_start_chain;
   logic [0:0] hello_world_start_kernel_copy;
   logic [0:0] hello_world_start_task_fd;
   logic [0:0] hello_world_start_finish_element;
   logic hello_world_finish;
   logic [0:0] hello_world_finish_kernel_copy;
   logic [0:0] hello_world_finish_chain;
   logic [31:0] hello_world_global_size [2:0];
   logic [31:0] hello_world_num_groups [2:0];
   logic [31:0] hello_world_local_size [2:0];
   logic [31:0] hello_world_global_offset [2:0];
   logic [31:0] hello_world_work_dim;
   logic [31:0] hello_world_wg_size;
   logic [0:0] hello_world_wg_disp_stall_in;
   logic [0:0] hello_world_wg_disp_valid_out;
   logic hello_world_wg_disp_start_out;
   logic [31:0] hello_world_wg_disp_group_id_out [2:0];
   logic [31:0] hello_world_wg_disp_global_id_base_out [2:0];
   logic hello_world_wg_disp_dispatched_all_groups;
   logic [31:0] hello_world_global_id [1][2:0];
   logic [31:0] hello_world_local_id [1][2:0];
   logic [31:0] hello_world_group_id [1][2:0];
   logic [0:0] hello_world_pending_write;
   logic [0:0] hello_world_lsu_active;
   logic [0:0] hello_world_valid_in;
   logic [0:0] hello_world_valid_out;
   logic [0:0] hello_world_stall_in;
   logic [0:0] hello_world_stall_out;
   logic hello_world_cra_pending_write;
   logic hello_world_cra_lsu_active;
   logic hello_world_cra_valid_in;
   logic [127:0] hello_world_kernel_arguments;
   logic kernel_irqs;
   logic gmem0_DDR_global_avm_enable [1];
   logic gmem0_DDR_global_avm_read [1];
   logic gmem0_DDR_global_avm_write [1];
   logic [4:0] gmem0_DDR_global_avm_burstcount [1];
   logic [30:0] gmem0_DDR_global_avm_address [1];
   logic [511:0] gmem0_DDR_global_avm_writedata [1];
   logic [63:0] gmem0_DDR_global_avm_byteenable [1];
   logic gmem0_DDR_global_avm_waitrequest [1];
   logic [511:0] gmem0_DDR_global_avm_readdata [1];
   logic gmem0_DDR_global_avm_readdatavalid [1];
   logic gmem0_DDR_global_avm_writeack [1];
   logic counter_reset_hello_world;
   logic [63:0] counter_init_hello_world;
   logic [31:0] counter_limit_hello_world;
   logic [31:0] counter_size_hello_world;
   logic counter_full_hello_world;
   logic counter_resetn_hello_world;
   logic [31:0] counter_increment_hello_world;
   logic counter_resultvalid_hello_world;
   logic counter_stall_hello_world;
   logic [63:0] counter_result_hello_world;
   logic counter_enable_hello_world;
   logic printf_avm_hello_world_enable [1];
   logic printf_avm_hello_world_read [1];
   logic printf_avm_hello_world_write [1];
   logic [5:0] printf_avm_hello_world_burstcount [1];
   logic [31:0] printf_avm_hello_world_address [1];
   logic [255:0] printf_avm_hello_world_writedata [1];
   logic [31:0] printf_avm_hello_world_byteenable [1];
   logic printf_avm_hello_world_waitrequest [1];
   logic [255:0] printf_avm_hello_world_readdata [1];
   logic printf_avm_hello_world_readdatavalid [1];

   assign hello_world_start_chain[0] = hello_world_start;
   assign hello_world_finish_chain[0] = 1'b1;
   assign hello_world_cra_pending_write = |hello_world_pending_write;
   assign hello_world_cra_lsu_active = |hello_world_lsu_active;
   assign hello_world_cra_valid_in = |hello_world_valid_in;
   assign hello_world_stall_in = 0;
   // INST hello_world_workgroup_dispatcher of acl_work_group_dispatcher
   acl_work_group_dispatcher
   #(
      .WIDTH(32),
      .NUM_COPIES(1),
      .RUN_FOREVER(0)
   )
   hello_world_workgroup_dispatcher
   (
      .clock(clock),
      .resetn(resetn),
      .start(hello_world_start),
      .num_groups(hello_world_num_groups),
      .local_size(hello_world_local_size),
      .stall_in(hello_world_wg_disp_stall_in),
      .valid_out(hello_world_wg_disp_valid_out),
      .group_id_out(hello_world_wg_disp_group_id_out),
      .global_id_base_out(hello_world_wg_disp_global_id_base_out),
      .start_out(hello_world_wg_disp_start_out),
      .dispatched_all_groups(hello_world_wg_disp_dispatched_all_groups)
   );

   // INST hello_world_finish_detector of acl_kernel_finish_detector
   acl_kernel_finish_detector
   #(
      .NUM_COPIES(1),
      .WG_SIZE_W(32),
      .GLOBAL_ID_W(32),
      .TESSELLATION_SIZE(19)
   )
   hello_world_finish_detector
   (
      .clock(clock),
      .resetn(resetn),
      .start(hello_world_start),
      .wg_size(hello_world_wg_size),
      .wg_dispatch_valid_out(hello_world_wg_disp_valid_out),
      .wg_dispatch_stall_in(hello_world_wg_disp_stall_in),
      .dispatched_all_groups(hello_world_wg_disp_dispatched_all_groups),
      .kernel_copy_valid_out(hello_world_valid_out),
      .kernel_copy_stall_in(hello_world_stall_in),
      .pending_writes(hello_world_cra_pending_write),
      .finish(hello_world_finish)
   );

   // INST hello_world_cra_slave_inst of hello_world_function_cra_slave
   hello_world_function_cra_slave hello_world_cra_slave_inst
   (
      .clock(clock),
      .resetn(resetn),
      .start(hello_world_start),
      .finish(hello_world_finish),
      .global_offset_0(hello_world_global_offset[0]),
      .global_offset_1(hello_world_global_offset[1]),
      .global_offset_2(hello_world_global_offset[2]),
      .work_dim(hello_world_work_dim),
      .has_a_lsu_active(hello_world_cra_lsu_active),
      .has_a_write_pending(hello_world_cra_pending_write),
      .valid_in(hello_world_cra_valid_in),
      .global_size_0(hello_world_global_size[0]),
      .global_size_1(hello_world_global_size[1]),
      .global_size_2(hello_world_global_size[2]),
      .num_groups_0(hello_world_num_groups[0]),
      .num_groups_1(hello_world_num_groups[1]),
      .num_groups_2(hello_world_num_groups[2]),
      .local_size_0(hello_world_local_size[0]),
      .local_size_1(hello_world_local_size[1]),
      .local_size_2(hello_world_local_size[2]),
      .workgroup_size(hello_world_wg_size),
      .kernel_arguments(hello_world_kernel_arguments),
      .cra_irq(kernel_irqs),
      // AVS avs_cra
      .avs_cra_enable(avs_hello_world_cra_enable),
      .avs_cra_read(avs_hello_world_cra_read),
      .avs_cra_write(avs_hello_world_cra_write),
      .avs_cra_address(avs_hello_world_cra_address),
      .avs_cra_writedata(avs_hello_world_cra_writedata),
      .avs_cra_byteenable(avs_hello_world_cra_byteenable),
      .avs_cra_readdata(avs_hello_world_cra_readdata),
      .avs_cra_readdatavalid(avs_hello_world_cra_readdatavalid),
      .acl_counter_reset(counter_reset_hello_world),
      .acl_counter_init(counter_init_hello_world),
      .acl_counter_limit(counter_limit_hello_world),
      .acl_counter_size(counter_size_hello_world),
      .acl_counter_full(counter_full_hello_world)
   );

   // INST hello_world_id_iter_inst_0 of acl_id_iterator
   acl_id_iterator
   #(
      .WIDTH(32),
      .LOCAL_WIDTH_X(32),
      .LOCAL_WIDTH_Y(32),
      .LOCAL_WIDTH_Z(32),
      .ENABLE_TESSELLATION(1)
   )
   hello_world_id_iter_inst_0
   (
      .clock(clock),
      .resetn(resetn),
      .start(hello_world_wg_disp_start_out),
      .valid_in(hello_world_wg_disp_valid_out[0]),
      .stall_out(hello_world_wg_disp_stall_in[0]),
      .stall_in(hello_world_stall_out[0]),
      .valid_out(hello_world_valid_in[0]),
      .group_id_in(hello_world_wg_disp_group_id_out),
      .global_id_base_in(hello_world_wg_disp_global_id_base_out),
      .local_size(hello_world_local_size),
      .global_size(hello_world_global_size),
      .local_id(hello_world_local_id[0]),
      .global_id(hello_world_global_id[0]),
      .group_id(hello_world_group_id[0])
   );

   // INST hello_world_inst_0 of hello_world_top_wrapper_0
   hello_world_top_wrapper_0 hello_world_inst_0
   (
      .start(hello_world_start_kernel_copy[0]),
      .kernel_arguments(hello_world_kernel_arguments),
      .work_dim(hello_world_work_dim),
      .global_offset(hello_world_global_offset),
      .kernel_valid_out(hello_world_valid_out[0]),
      .has_a_write_pending(hello_world_pending_write[0]),
      .has_a_lsu_active(hello_world_lsu_active[0]),
      .global_id(hello_world_global_id[0]),
      .local_id(hello_world_local_id[0]),
      .group_id(hello_world_group_id[0]),
      .global_size(hello_world_global_size),
      .local_size(hello_world_local_size),
      .num_groups(hello_world_num_groups),
      .workgroup_size(hello_world_wg_size),
      .kernel_stall_out(hello_world_stall_out[0]),
      .kernel_valid_in(hello_world_valid_in[0]),
      .clock(clock),
      .resetn(resetn),
      .clock2x(clock2x),
      // AVM avm_local_bb0_st_printf_data1_inst0
      .avm_local_bb0_st_printf_data1_inst0_enable(gmem0_DDR_global_avm_enable[0]),
      .avm_local_bb0_st_printf_data1_inst0_read(gmem0_DDR_global_avm_read[0]),
      .avm_local_bb0_st_printf_data1_inst0_write(gmem0_DDR_global_avm_write[0]),
      .avm_local_bb0_st_printf_data1_inst0_burstcount(gmem0_DDR_global_avm_burstcount[0]),
      .avm_local_bb0_st_printf_data1_inst0_address(gmem0_DDR_global_avm_address[0]),
      .avm_local_bb0_st_printf_data1_inst0_writedata(gmem0_DDR_global_avm_writedata[0]),
      .avm_local_bb0_st_printf_data1_inst0_byteenable(gmem0_DDR_global_avm_byteenable[0]),
      .avm_local_bb0_st_printf_data1_inst0_waitrequest(gmem0_DDR_global_avm_waitrequest[0]),
      .avm_local_bb0_st_printf_data1_inst0_readdata(gmem0_DDR_global_avm_readdata[0]),
      .avm_local_bb0_st_printf_data1_inst0_readdatavalid(gmem0_DDR_global_avm_readdatavalid[0]),
      .avm_local_bb0_st_printf_data1_inst0_writeack(gmem0_DDR_global_avm_writeack[0]),
      // AVM p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_inst0
      .p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_inst0_enable(printf_avm_hello_world_enable[0]),
      .p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_inst0_read(printf_avm_hello_world_read[0]),
      .p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_inst0_write(printf_avm_hello_world_write[0]),
      .p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_inst0_burstcount(printf_avm_hello_world_burstcount[0]),
      .p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_inst0_address(printf_avm_hello_world_address[0]),
      .p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_inst0_writedata(printf_avm_hello_world_writedata[0]),
      .p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_inst0_byteenable(printf_avm_hello_world_byteenable[0]),
      .p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_inst0_waitrequest(printf_avm_hello_world_waitrequest[0]),
      .p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_inst0_readdata(printf_avm_hello_world_readdata[0]),
      .p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_inst0_readdatavalid(printf_avm_hello_world_readdatavalid[0])
   );

   // INST hello_world_start_elem_inst_0 of acl_start_signal_chain_element
   acl_start_signal_chain_element hello_world_start_elem_inst_0
   (
      .clock(clock),
      .resetn(resetn),
      .start_in(hello_world_start_chain[0]),
      .start_kernel(hello_world_start_kernel_copy[0]),
      .start_finish_detector(hello_world_start_task_fd[0]),
      .start_finish_chain_element(hello_world_start_finish_element[0]),
      .start_chain()
   );

   assign kernel_irq = |kernel_irqs;
   generate
   begin:gmem0_DDR_
      logic gmem0_DDR_icm_in_arb_request [1];
      logic gmem0_DDR_icm_in_arb_enable [1];
      logic gmem0_DDR_icm_in_arb_read [1];
      logic gmem0_DDR_icm_in_arb_write [1];
      logic [4:0] gmem0_DDR_icm_in_arb_burstcount [1];
      logic [24:0] gmem0_DDR_icm_in_arb_address [1];
      logic [511:0] gmem0_DDR_icm_in_arb_writedata [1];
      logic [63:0] gmem0_DDR_icm_in_arb_byteenable [1];
      logic gmem0_DDR_icm_in_arb_stall [1];
      logic gmem0_DDR_icm_in_wrp_ack [1];
      logic gmem0_DDR_icm_in_rrp_datavalid [1];
      logic [511:0] gmem0_DDR_icm_in_rrp_data [1];
      logic gmem0_DDR_icm_preroute_arb_request [1];
      logic gmem0_DDR_icm_preroute_arb_enable [1];
      logic gmem0_DDR_icm_preroute_arb_read [1];
      logic gmem0_DDR_icm_preroute_arb_write [1];
      logic [4:0] gmem0_DDR_icm_preroute_arb_burstcount [1];
      logic [24:0] gmem0_DDR_icm_preroute_arb_address [1];
      logic [511:0] gmem0_DDR_icm_preroute_arb_writedata [1];
      logic [63:0] gmem0_DDR_icm_preroute_arb_byteenable [1];
      logic gmem0_DDR_icm_preroute_arb_stall [1];
      logic gmem0_DDR_icm_preroute_wrp_ack [1];
      logic gmem0_DDR_icm_preroute_rrp_datavalid [1];
      logic [511:0] gmem0_DDR_icm_preroute_rrp_data [1];
      logic icm_groupgmem0_DDR_router_0_arb_request [1];
      logic icm_groupgmem0_DDR_router_0_arb_enable [1];
      logic icm_groupgmem0_DDR_router_0_arb_read [1];
      logic icm_groupgmem0_DDR_router_0_arb_write [1];
      logic [4:0] icm_groupgmem0_DDR_router_0_arb_burstcount [1];
      logic [24:0] icm_groupgmem0_DDR_router_0_arb_address [1];
      logic [511:0] icm_groupgmem0_DDR_router_0_arb_writedata [1];
      logic [63:0] icm_groupgmem0_DDR_router_0_arb_byteenable [1];
      logic icm_groupgmem0_DDR_router_0_arb_stall [1];
      logic icm_groupgmem0_DDR_router_0_wrp_ack [1];
      logic icm_groupgmem0_DDR_router_0_rrp_datavalid [1];
      logic [511:0] icm_groupgmem0_DDR_router_0_rrp_data [1];
      logic icm_out_0_rw_arb_request [1];
      logic icm_out_0_rw_arb_enable [1];
      logic icm_out_0_rw_arb_read [1];
      logic icm_out_0_rw_arb_write [1];
      logic [4:0] icm_out_0_rw_arb_burstcount [1];
      logic [24:0] icm_out_0_rw_arb_address [1];
      logic [511:0] icm_out_0_rw_arb_writedata [1];
      logic [63:0] icm_out_0_rw_arb_byteenable [1];
      logic icm_out_0_rw_arb_id [1];
      logic icm_out_0_rw_arb_stall [1];
      logic icm_out_0_rw_wrp_ack [1];
      logic icm_out_0_rw_rrp_datavalid [1];
      logic [511:0] icm_out_0_rw_rrp_data [1];
      logic icm_routedgmem0_DDR_port_0_0_rw_arb_request [1];
      logic icm_routedgmem0_DDR_port_0_0_rw_arb_enable [1];
      logic icm_routedgmem0_DDR_port_0_0_rw_arb_read [1];
      logic icm_routedgmem0_DDR_port_0_0_rw_arb_write [1];
      logic [4:0] icm_routedgmem0_DDR_port_0_0_rw_arb_burstcount [1];
      logic [24:0] icm_routedgmem0_DDR_port_0_0_rw_arb_address [1];
      logic [511:0] icm_routedgmem0_DDR_port_0_0_rw_arb_writedata [1];
      logic [63:0] icm_routedgmem0_DDR_port_0_0_rw_arb_byteenable [1];
      logic icm_routedgmem0_DDR_port_0_0_rw_arb_stall [1];
      logic icm_routedgmem0_DDR_port_0_0_rw_wrp_ack [1];
      logic icm_routedgmem0_DDR_port_0_0_rw_rrp_datavalid [1];
      logic [511:0] icm_routedgmem0_DDR_port_0_0_rw_rrp_data [1];

      for( __i = 0; __i < 1; __i = __i + 1 )
      begin:t
         // INST gmem0_DDR_avm_to_ic of acl_avm_to_ic
         acl_avm_to_ic
         #(
            .DATA_W(512),
            .WRITEDATA_W(512),
            .BURSTCOUNT_W(5),
            .ADDRESS_W(31),
            .BYTEENA_W(64)
         )
         gmem0_DDR_avm_to_ic
         (
            // AVM avm
            .avm_enable(gmem0_DDR_global_avm_enable[__i]),
            .avm_read(gmem0_DDR_global_avm_read[__i]),
            .avm_write(gmem0_DDR_global_avm_write[__i]),
            .avm_burstcount(gmem0_DDR_global_avm_burstcount[__i]),
            .avm_address(gmem0_DDR_global_avm_address[__i]),
            .avm_writedata(gmem0_DDR_global_avm_writedata[__i]),
            .avm_byteenable(gmem0_DDR_global_avm_byteenable[__i]),
            .avm_waitrequest(gmem0_DDR_global_avm_waitrequest[__i]),
            .avm_readdata(gmem0_DDR_global_avm_readdata[__i]),
            .avm_readdatavalid(gmem0_DDR_global_avm_readdatavalid[__i]),
            .avm_writeack(gmem0_DDR_global_avm_writeack[__i]),
            // ICM ic
            .ic_arb_request(gmem0_DDR_icm_in_arb_request[__i]),
            .ic_arb_enable(gmem0_DDR_icm_in_arb_enable[__i]),
            .ic_arb_read(gmem0_DDR_icm_in_arb_read[__i]),
            .ic_arb_write(gmem0_DDR_icm_in_arb_write[__i]),
            .ic_arb_burstcount(gmem0_DDR_icm_in_arb_burstcount[__i]),
            .ic_arb_address(gmem0_DDR_icm_in_arb_address[__i]),
            .ic_arb_writedata(gmem0_DDR_icm_in_arb_writedata[__i]),
            .ic_arb_byteenable(gmem0_DDR_icm_in_arb_byteenable[__i]),
            .ic_arb_stall(gmem0_DDR_icm_in_arb_stall[__i]),
            .ic_wrp_ack(gmem0_DDR_icm_in_wrp_ack[__i]),
            .ic_rrp_datavalid(gmem0_DDR_icm_in_rrp_datavalid[__i]),
            .ic_rrp_data(gmem0_DDR_icm_in_rrp_data[__i])
         );

      end

      assign icm_groupgmem0_DDR_router_0_arb_request[0] = gmem0_DDR_icm_in_arb_request[0];
      assign icm_groupgmem0_DDR_router_0_arb_enable[0] = gmem0_DDR_icm_in_arb_enable[0];
      assign icm_groupgmem0_DDR_router_0_arb_read[0] = gmem0_DDR_icm_in_arb_read[0];
      assign icm_groupgmem0_DDR_router_0_arb_write[0] = gmem0_DDR_icm_in_arb_write[0];
      assign icm_groupgmem0_DDR_router_0_arb_burstcount[0] = gmem0_DDR_icm_in_arb_burstcount[0];
      assign icm_groupgmem0_DDR_router_0_arb_address[0] = gmem0_DDR_icm_in_arb_address[0];
      assign icm_groupgmem0_DDR_router_0_arb_writedata[0] = gmem0_DDR_icm_in_arb_writedata[0];
      assign icm_groupgmem0_DDR_router_0_arb_byteenable[0] = gmem0_DDR_icm_in_arb_byteenable[0];
      assign gmem0_DDR_icm_in_arb_stall[0] = icm_groupgmem0_DDR_router_0_arb_stall[0];
      assign gmem0_DDR_icm_in_wrp_ack[0] = icm_groupgmem0_DDR_router_0_wrp_ack[0];
      assign gmem0_DDR_icm_in_rrp_datavalid[0] = icm_groupgmem0_DDR_router_0_rrp_datavalid[0];
      assign gmem0_DDR_icm_in_rrp_data[0] = icm_groupgmem0_DDR_router_0_rrp_data[0];
      // INST global_ic_preroutegmem0_DDR_router_0 of hello_world_system_interconnect_0
      hello_world_system_interconnect_0 global_ic_preroutegmem0_DDR_router_0
      (
         .clock(clock),
         .resetn(resetn),
         // ICM m
         .m_arb_request(icm_groupgmem0_DDR_router_0_arb_request),
         .m_arb_enable(icm_groupgmem0_DDR_router_0_arb_enable),
         .m_arb_read(icm_groupgmem0_DDR_router_0_arb_read),
         .m_arb_write(icm_groupgmem0_DDR_router_0_arb_write),
         .m_arb_burstcount(icm_groupgmem0_DDR_router_0_arb_burstcount),
         .m_arb_address(icm_groupgmem0_DDR_router_0_arb_address),
         .m_arb_writedata(icm_groupgmem0_DDR_router_0_arb_writedata),
         .m_arb_byteenable(icm_groupgmem0_DDR_router_0_arb_byteenable),
         .m_arb_stall(icm_groupgmem0_DDR_router_0_arb_stall),
         .m_wrp_ack(icm_groupgmem0_DDR_router_0_wrp_ack),
         .m_rrp_datavalid(icm_groupgmem0_DDR_router_0_rrp_datavalid),
         .m_rrp_data(icm_groupgmem0_DDR_router_0_rrp_data),
         // ICM mout
         .mout_arb_request(gmem0_DDR_icm_preroute_arb_request[0]),
         .mout_arb_enable(gmem0_DDR_icm_preroute_arb_enable[0]),
         .mout_arb_read(gmem0_DDR_icm_preroute_arb_read[0]),
         .mout_arb_write(gmem0_DDR_icm_preroute_arb_write[0]),
         .mout_arb_burstcount(gmem0_DDR_icm_preroute_arb_burstcount[0]),
         .mout_arb_address(gmem0_DDR_icm_preroute_arb_address[0]),
         .mout_arb_writedata(gmem0_DDR_icm_preroute_arb_writedata[0]),
         .mout_arb_byteenable(gmem0_DDR_icm_preroute_arb_byteenable[0]),
         .mout_arb_id(),
         .mout_arb_stall(gmem0_DDR_icm_preroute_arb_stall[0]),
         .mout_wrp_ack(gmem0_DDR_icm_preroute_wrp_ack[0]),
         .mout_rrp_datavalid(gmem0_DDR_icm_preroute_rrp_datavalid[0]),
         .mout_rrp_data(gmem0_DDR_icm_preroute_rrp_data[0])
      );

      for( __i = 0; __i < 1; __i = __i + 1 )
      begin:router
         logic b_arb_request [1];
         logic b_arb_enable [1];
         logic b_arb_read [1];
         logic b_arb_write [1];
         logic [4:0] b_arb_burstcount [1];
         logic [24:0] b_arb_address [1];
         logic [511:0] b_arb_writedata [1];
         logic [63:0] b_arb_byteenable [1];
         logic b_arb_stall [1];
         logic b_wrp_ack [1];
         logic b_rrp_datavalid [1];
         logic [511:0] b_rrp_data [1];
         logic bank_select;

         // INST router of acl_ic_mem_router
         acl_ic_mem_router
         #(
            .DATA_W(512),
            .BURSTCOUNT_W(5),
            .ADDRESS_W(25),
            .BYTEENA_W(64),
            .NUM_BANKS(1)
         )
         router
         (
            .clock(clock),
            .resetn(resetn),
            .bank_select(bank_select),
            // ICM m
            .m_arb_request(gmem0_DDR_icm_preroute_arb_request[__i]),
            .m_arb_enable(gmem0_DDR_icm_preroute_arb_enable[__i]),
            .m_arb_read(gmem0_DDR_icm_preroute_arb_read[__i]),
            .m_arb_write(gmem0_DDR_icm_preroute_arb_write[__i]),
            .m_arb_burstcount(gmem0_DDR_icm_preroute_arb_burstcount[__i]),
            .m_arb_address(gmem0_DDR_icm_preroute_arb_address[__i]),
            .m_arb_writedata(gmem0_DDR_icm_preroute_arb_writedata[__i]),
            .m_arb_byteenable(gmem0_DDR_icm_preroute_arb_byteenable[__i]),
            .m_arb_stall(gmem0_DDR_icm_preroute_arb_stall[__i]),
            .m_wrp_ack(gmem0_DDR_icm_preroute_wrp_ack[__i]),
            .m_rrp_datavalid(gmem0_DDR_icm_preroute_rrp_datavalid[__i]),
            .m_rrp_data(gmem0_DDR_icm_preroute_rrp_data[__i]),
            // ICM b
            .b_arb_request(b_arb_request),
            .b_arb_enable(b_arb_enable),
            .b_arb_read(b_arb_read),
            .b_arb_write(b_arb_write),
            .b_arb_burstcount(b_arb_burstcount),
            .b_arb_address(b_arb_address),
            .b_arb_writedata(b_arb_writedata),
            .b_arb_byteenable(b_arb_byteenable),
            .b_arb_stall(b_arb_stall),
            .b_wrp_ack(b_wrp_ack),
            .b_rrp_datavalid(b_rrp_datavalid),
            .b_rrp_data(b_rrp_data)
         );

         assign bank_select = 1'b1;
      end

      // INST global_icgmem0_DDR_port_0_0_rw of hello_world_system_interconnect_1
      hello_world_system_interconnect_1 global_icgmem0_DDR_port_0_0_rw
      (
         .clock(clock),
         .resetn(resetn),
         // ICM m
         .m_arb_request(icm_routedgmem0_DDR_port_0_0_rw_arb_request),
         .m_arb_enable(icm_routedgmem0_DDR_port_0_0_rw_arb_enable),
         .m_arb_read(icm_routedgmem0_DDR_port_0_0_rw_arb_read),
         .m_arb_write(icm_routedgmem0_DDR_port_0_0_rw_arb_write),
         .m_arb_burstcount(icm_routedgmem0_DDR_port_0_0_rw_arb_burstcount),
         .m_arb_address(icm_routedgmem0_DDR_port_0_0_rw_arb_address),
         .m_arb_writedata(icm_routedgmem0_DDR_port_0_0_rw_arb_writedata),
         .m_arb_byteenable(icm_routedgmem0_DDR_port_0_0_rw_arb_byteenable),
         .m_arb_stall(icm_routedgmem0_DDR_port_0_0_rw_arb_stall),
         .m_wrp_ack(icm_routedgmem0_DDR_port_0_0_rw_wrp_ack),
         .m_rrp_datavalid(icm_routedgmem0_DDR_port_0_0_rw_rrp_datavalid),
         .m_rrp_data(icm_routedgmem0_DDR_port_0_0_rw_rrp_data),
         // ICM mout
         .mout_arb_request(icm_out_0_rw_arb_request[0]),
         .mout_arb_enable(icm_out_0_rw_arb_enable[0]),
         .mout_arb_read(icm_out_0_rw_arb_read[0]),
         .mout_arb_write(icm_out_0_rw_arb_write[0]),
         .mout_arb_burstcount(icm_out_0_rw_arb_burstcount[0]),
         .mout_arb_address(icm_out_0_rw_arb_address[0]),
         .mout_arb_writedata(icm_out_0_rw_arb_writedata[0]),
         .mout_arb_byteenable(icm_out_0_rw_arb_byteenable[0]),
         .mout_arb_id(icm_out_0_rw_arb_id[0]),
         .mout_arb_stall(icm_out_0_rw_arb_stall[0]),
         .mout_wrp_ack(icm_out_0_rw_wrp_ack[0]),
         .mout_rrp_datavalid(icm_out_0_rw_rrp_datavalid[0]),
         .mout_rrp_data(icm_out_0_rw_rrp_data[0])
      );

      for( __i = 0; __i < 1; __i = __i + 1 )
      begin:mgmem0_DDR_port_0_0_rw
         assign icm_routedgmem0_DDR_port_0_0_rw_arb_request[__i] = router[__i].b_arb_request[0];
         assign icm_routedgmem0_DDR_port_0_0_rw_arb_enable[__i] = router[__i].b_arb_enable[0];
         assign icm_routedgmem0_DDR_port_0_0_rw_arb_read[__i] = router[__i].b_arb_read[0];
         assign icm_routedgmem0_DDR_port_0_0_rw_arb_write[__i] = router[__i].b_arb_write[0];
         assign icm_routedgmem0_DDR_port_0_0_rw_arb_burstcount[__i] = router[__i].b_arb_burstcount[0];
         assign icm_routedgmem0_DDR_port_0_0_rw_arb_address[__i] = router[__i].b_arb_address[0];
         assign icm_routedgmem0_DDR_port_0_0_rw_arb_writedata[__i] = router[__i].b_arb_writedata[0];
         assign icm_routedgmem0_DDR_port_0_0_rw_arb_byteenable[__i] = router[__i].b_arb_byteenable[0];
         assign router[__i].b_arb_stall[0] = icm_routedgmem0_DDR_port_0_0_rw_arb_stall[__i];
         assign router[__i].b_wrp_ack[0] = icm_routedgmem0_DDR_port_0_0_rw_wrp_ack[__i];
         assign router[__i].b_rrp_datavalid[0] = icm_routedgmem0_DDR_port_0_0_rw_rrp_datavalid[__i];
         assign router[__i].b_rrp_data[0] = icm_routedgmem0_DDR_port_0_0_rw_rrp_data[__i];
      end

      // INST global_out_ic_to_avmgmem0_DDR_port_0_0_rw of acl_ic_to_avm
      acl_ic_to_avm
      #(
         .DATA_W(512),
         .BURSTCOUNT_W(5),
         .ADDRESS_W(31),
         .BYTEENA_W(64),
         .LATENCY(0),
         .ID_W(1)
      )
      global_out_ic_to_avmgmem0_DDR_port_0_0_rw
      (
         // ICM ic
         .ic_arb_request(icm_out_0_rw_arb_request[0]),
         .ic_arb_enable(icm_out_0_rw_arb_enable[0]),
         .ic_arb_read(icm_out_0_rw_arb_read[0]),
         .ic_arb_write(icm_out_0_rw_arb_write[0]),
         .ic_arb_burstcount(icm_out_0_rw_arb_burstcount[0]),
         .ic_arb_address(icm_out_0_rw_arb_address[0]),
         .ic_arb_writedata(icm_out_0_rw_arb_writedata[0]),
         .ic_arb_byteenable(icm_out_0_rw_arb_byteenable[0]),
         .ic_arb_id(icm_out_0_rw_arb_id[0]),
         .ic_arb_stall(icm_out_0_rw_arb_stall[0]),
         .ic_wrp_ack(icm_out_0_rw_wrp_ack[0]),
         .ic_rrp_datavalid(icm_out_0_rw_rrp_datavalid[0]),
         .ic_rrp_data(icm_out_0_rw_rrp_data[0]),
         // AVM avm
         .avm_enable(avm_memgmem0_DDR_port_0_0_rw_enable),
         .avm_read(avm_memgmem0_DDR_port_0_0_rw_read),
         .avm_write(avm_memgmem0_DDR_port_0_0_rw_write),
         .avm_burstcount(avm_memgmem0_DDR_port_0_0_rw_burstcount),
         .avm_address(avm_memgmem0_DDR_port_0_0_rw_address),
         .avm_writedata(avm_memgmem0_DDR_port_0_0_rw_writedata),
         .avm_byteenable(avm_memgmem0_DDR_port_0_0_rw_byteenable),
         .avm_waitrequest(avm_memgmem0_DDR_port_0_0_rw_waitrequest),
         .avm_readdata(avm_memgmem0_DDR_port_0_0_rw_readdata),
         .avm_readdatavalid(avm_memgmem0_DDR_port_0_0_rw_readdatavalid),
         .avm_writeack(avm_memgmem0_DDR_port_0_0_rw_writeack),
         .clock(),
         .resetn()
      );

   end
   endgenerate

   assign counter_resetn_hello_world = (resetn & ~(hello_world_start));
   // INST hello_world_printf_counter of acl_printf_counter
   acl_printf_counter hello_world_printf_counter
   (
      .clock(clock),
      .resetn(counter_resetn_hello_world),
      .enable(counter_enable_hello_world),
      .i_counter_reset(counter_reset_hello_world),
      .i_increment(counter_increment_hello_world),
      .i_init(counter_init_hello_world),
      .i_limit(counter_limit_hello_world),
      .o_size(counter_size_hello_world),
      .o_resultvalid(counter_resultvalid_hello_world),
      .o_result(counter_result_hello_world),
      .o_full(counter_full_hello_world),
      .o_stall(counter_stall_hello_world)
   );

   generate
   begin:printf_system_hello_world
      logic p_icm_arb_in_arb_request [1];
      logic p_icm_arb_in_arb_enable [1];
      logic p_icm_arb_in_arb_read [1];
      logic p_icm_arb_in_arb_write [1];
      logic [5:0] p_icm_arb_in_arb_burstcount [1];
      logic [26:0] p_icm_arb_in_arb_address [1];
      logic [255:0] p_icm_arb_in_arb_writedata [1];
      logic [31:0] p_icm_arb_in_arb_byteenable [1];
      logic p_icm_arb_in_arb_stall [1];
      logic p_icm_arb_in_wrp_ack [1];
      logic p_icm_arb_in_rrp_datavalid [1];
      logic [255:0] p_icm_arb_in_rrp_data [1];
      logic p_icm_arb_out_arb_request [1];
      logic p_icm_arb_out_arb_enable [1];
      logic p_icm_arb_out_arb_read [1];
      logic p_icm_arb_out_arb_write [1];
      logic [5:0] p_icm_arb_out_arb_burstcount [1];
      logic [26:0] p_icm_arb_out_arb_address [1];
      logic [255:0] p_icm_arb_out_arb_writedata [1];
      logic [31:0] p_icm_arb_out_arb_byteenable [1];
      logic p_icm_arb_out_arb_stall [1];
      logic p_icm_arb_out_wrp_ack [1];
      logic p_icm_arb_out_rrp_datavalid [1];
      logic [255:0] p_icm_arb_out_rrp_data [1];

      for( __i = 0; __i < 1; __i = __i + 1 )
      begin:p
         // INST p_avm_to_ic of acl_avm_to_ic
         acl_avm_to_ic
         #(
            .DATA_W(256),
            .WRITEDATA_W(256),
            .BURSTCOUNT_W(6),
            .ADDRESS_W(32),
            .BYTEENA_W(32),
            .ADDR_SHIFT(0)
         )
         p_avm_to_ic
         (
            // AVM avm
            .avm_enable(printf_avm_hello_world_enable[__i]),
            .avm_read(printf_avm_hello_world_read[__i]),
            .avm_write(printf_avm_hello_world_write[__i]),
            .avm_burstcount(printf_avm_hello_world_burstcount[__i]),
            .avm_address(printf_avm_hello_world_address[__i]),
            .avm_writedata(printf_avm_hello_world_writedata[__i]),
            .avm_byteenable(printf_avm_hello_world_byteenable[__i]),
            .avm_waitrequest(printf_avm_hello_world_waitrequest[__i]),
            .avm_readdata(printf_avm_hello_world_readdata[__i]),
            .avm_readdatavalid(printf_avm_hello_world_readdatavalid[__i]),
            // ICM ic
            .ic_arb_request(p_icm_arb_in_arb_request[__i]),
            .ic_arb_enable(p_icm_arb_in_arb_enable[__i]),
            .ic_arb_read(p_icm_arb_in_arb_read[__i]),
            .ic_arb_write(p_icm_arb_in_arb_write[__i]),
            .ic_arb_burstcount(p_icm_arb_in_arb_burstcount[__i]),
            .ic_arb_address(p_icm_arb_in_arb_address[__i]),
            .ic_arb_writedata(p_icm_arb_in_arb_writedata[__i]),
            .ic_arb_byteenable(p_icm_arb_in_arb_byteenable[__i]),
            .ic_arb_stall(p_icm_arb_in_arb_stall[__i]),
            .ic_wrp_ack(p_icm_arb_in_wrp_ack[__i]),
            .ic_rrp_datavalid(p_icm_arb_in_rrp_datavalid[__i]),
            .ic_rrp_data(p_icm_arb_in_rrp_data[__i])
         );

      end

      // INST printf_ic_interconnect of hello_world_system_interconnect_2
      hello_world_system_interconnect_2 printf_ic_interconnect
      (
         .clock(clock),
         .resetn(resetn),
         // ICM m
         .m_arb_request(p_icm_arb_in_arb_request),
         .m_arb_enable(p_icm_arb_in_arb_enable),
         .m_arb_read(p_icm_arb_in_arb_read),
         .m_arb_write(p_icm_arb_in_arb_write),
         .m_arb_burstcount(p_icm_arb_in_arb_burstcount),
         .m_arb_address(p_icm_arb_in_arb_address),
         .m_arb_writedata(p_icm_arb_in_arb_writedata),
         .m_arb_byteenable(p_icm_arb_in_arb_byteenable),
         .m_arb_stall(p_icm_arb_in_arb_stall),
         .m_wrp_ack(p_icm_arb_in_wrp_ack),
         .m_rrp_datavalid(p_icm_arb_in_rrp_datavalid),
         .m_rrp_data(p_icm_arb_in_rrp_data),
         // ICM mout
         .mout_arb_request(p_icm_arb_out_arb_request[0]),
         .mout_arb_enable(p_icm_arb_out_arb_enable[0]),
         .mout_arb_read(p_icm_arb_out_arb_read[0]),
         .mout_arb_write(p_icm_arb_out_arb_write[0]),
         .mout_arb_burstcount(p_icm_arb_out_arb_burstcount[0]),
         .mout_arb_address(p_icm_arb_out_arb_address[0]),
         .mout_arb_writedata(p_icm_arb_out_arb_writedata[0]),
         .mout_arb_byteenable(p_icm_arb_out_arb_byteenable[0]),
         .mout_arb_id(),
         .mout_arb_stall(p_icm_arb_out_arb_stall[0]),
         .mout_wrp_ack(p_icm_arb_out_wrp_ack[0]),
         .mout_rrp_datavalid(p_icm_arb_out_rrp_datavalid[0]),
         .mout_rrp_data(p_icm_arb_out_rrp_data[0])
      );

      assign counter_increment_hello_world = p_icm_arb_out_arb_address[0];
      assign p_icm_arb_out_rrp_data[0] = counter_result_hello_world;
      assign counter_enable_hello_world = p_icm_arb_out_arb_read[0];
      assign p_icm_arb_out_rrp_datavalid[0] = counter_resultvalid_hello_world;
      assign p_icm_arb_out_arb_stall[0] = counter_stall_hello_world;
      assign p_icm_arb_out_wrp_ack[0] = 1'b1;
   end
   endgenerate

endmodule

/////////////////////////////////////////////////////////////////
// MODULE hello_world_top_wrapper_0
/////////////////////////////////////////////////////////////////
module hello_world_top_wrapper_0
(
   input logic start,
   input logic [127:0] kernel_arguments,
   input logic [31:0] work_dim,
   input logic [31:0] global_offset [2:0],
   output logic kernel_valid_out,
   output logic has_a_write_pending,
   output logic has_a_lsu_active,
   input logic [31:0] global_id [2:0],
   input logic [31:0] local_id [2:0],
   input logic [31:0] group_id [2:0],
   input logic [31:0] global_size [2:0],
   input logic [31:0] local_size [2:0],
   input logic [31:0] num_groups [2:0],
   input logic [31:0] workgroup_size,
   output logic kernel_stall_out,
   input logic kernel_valid_in,
   input logic clock,
   input logic resetn,
   input logic clock2x,
   // AVM avm_local_bb0_st_printf_data1_inst0
   output logic avm_local_bb0_st_printf_data1_inst0_enable,
   output logic avm_local_bb0_st_printf_data1_inst0_read,
   output logic avm_local_bb0_st_printf_data1_inst0_write,
   output logic [4:0] avm_local_bb0_st_printf_data1_inst0_burstcount,
   output logic [30:0] avm_local_bb0_st_printf_data1_inst0_address,
   output logic [511:0] avm_local_bb0_st_printf_data1_inst0_writedata,
   output logic [63:0] avm_local_bb0_st_printf_data1_inst0_byteenable,
   input logic avm_local_bb0_st_printf_data1_inst0_waitrequest,
   input logic [511:0] avm_local_bb0_st_printf_data1_inst0_readdata,
   input logic avm_local_bb0_st_printf_data1_inst0_readdatavalid,
   input logic avm_local_bb0_st_printf_data1_inst0_writeack,
   // AVM p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_inst0
   output logic p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_inst0_enable,
   output logic p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_inst0_read,
   output logic p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_inst0_write,
   output logic [5:0] p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_inst0_burstcount,
   output logic [31:0] p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_inst0_address,
   output logic [255:0] p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_inst0_writedata,
   output logic [31:0] p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_inst0_byteenable,
   input logic p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_inst0_waitrequest,
   input logic [255:0] p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_inst0_readdata,
   input logic p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_inst0_readdatavalid
);
   logic lmem_invalid_single_bit;

   // INST kernel of hello_world_function_wrapper
   hello_world_function_wrapper kernel
   (
      .local_router_hang(lmem_invalid_single_bit),
      .start(start),
      .kernel_arguments(kernel_arguments),
      .work_dim(work_dim),
      .global_offset_0(global_offset[0]),
      .global_offset_1(global_offset[1]),
      .global_offset_2(global_offset[2]),
      .kernel_valid_out(kernel_valid_out),
      .has_a_write_pending(has_a_write_pending),
      .has_a_lsu_active(has_a_lsu_active),
      .global_id_0(global_id[0]),
      .global_id_1(global_id[1]),
      .global_id_2(global_id[2]),
      .local_id_0(local_id[0]),
      .local_id_1(local_id[1]),
      .local_id_2(local_id[2]),
      .group_id_0(group_id[0]),
      .group_id_1(group_id[1]),
      .group_id_2(group_id[2]),
      .global_size_0(global_size[0]),
      .global_size_1(global_size[1]),
      .global_size_2(global_size[2]),
      .local_size_0(local_size[0]),
      .local_size_1(local_size[1]),
      .local_size_2(local_size[2]),
      .num_groups_0(num_groups[0]),
      .num_groups_1(num_groups[1]),
      .num_groups_2(num_groups[2]),
      .workgroup_size(workgroup_size),
      .kernel_stall_out(kernel_stall_out),
      .kernel_valid_in(kernel_valid_in),
      .clock(clock),
      .resetn(resetn),
      .clock2x(clock2x),
      // AVM avm_local_bb0_st_printf_data1_inst0
      .avm_local_bb0_st_printf_data1_inst0_enable(avm_local_bb0_st_printf_data1_inst0_enable),
      .avm_local_bb0_st_printf_data1_inst0_read(avm_local_bb0_st_printf_data1_inst0_read),
      .avm_local_bb0_st_printf_data1_inst0_write(avm_local_bb0_st_printf_data1_inst0_write),
      .avm_local_bb0_st_printf_data1_inst0_burstcount(avm_local_bb0_st_printf_data1_inst0_burstcount),
      .avm_local_bb0_st_printf_data1_inst0_address(avm_local_bb0_st_printf_data1_inst0_address),
      .avm_local_bb0_st_printf_data1_inst0_writedata(avm_local_bb0_st_printf_data1_inst0_writedata),
      .avm_local_bb0_st_printf_data1_inst0_byteenable(avm_local_bb0_st_printf_data1_inst0_byteenable),
      .avm_local_bb0_st_printf_data1_inst0_waitrequest(avm_local_bb0_st_printf_data1_inst0_waitrequest),
      .avm_local_bb0_st_printf_data1_inst0_readdata(avm_local_bb0_st_printf_data1_inst0_readdata),
      .avm_local_bb0_st_printf_data1_inst0_readdatavalid(avm_local_bb0_st_printf_data1_inst0_readdatavalid),
      .avm_local_bb0_st_printf_data1_inst0_writeack(avm_local_bb0_st_printf_data1_inst0_writeack),
      // AVM p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_inst0
      .p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_inst0_enable(p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_inst0_enable),
      .p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_inst0_read(p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_inst0_read),
      .p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_inst0_write(p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_inst0_write),
      .p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_inst0_burstcount(p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_inst0_burstcount),
      .p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_inst0_address(p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_inst0_address),
      .p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_inst0_writedata(p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_inst0_writedata),
      .p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_inst0_byteenable(p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_inst0_byteenable),
      .p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_inst0_waitrequest(p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_inst0_waitrequest),
      .p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_inst0_readdata(p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_inst0_readdata),
      .p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_inst0_readdatavalid(p_avm_local_bb0_printf_addr_acl_printf_p1i8_32_inst0_readdatavalid)
   );

   assign lmem_invalid_single_bit = 'b0;
endmodule

/////////////////////////////////////////////////////////////////
// MODULE hello_world_system_interconnect_0
/////////////////////////////////////////////////////////////////
module hello_world_system_interconnect_0
(
   input logic clock,
   input logic resetn,
   // ICM m
   input logic m_arb_request [1],
   input logic m_arb_enable [1],
   input logic m_arb_read [1],
   input logic m_arb_write [1],
   input logic [4:0] m_arb_burstcount [1],
   input logic [24:0] m_arb_address [1],
   input logic [511:0] m_arb_writedata [1],
   input logic [63:0] m_arb_byteenable [1],
   output logic m_arb_stall [1],
   output logic m_wrp_ack [1],
   output logic m_rrp_datavalid [1],
   output logic [511:0] m_rrp_data [1],
   // ICM mout
   output logic mout_arb_request,
   output logic mout_arb_enable,
   output logic mout_arb_read,
   output logic mout_arb_write,
   output logic [4:0] mout_arb_burstcount,
   output logic [24:0] mout_arb_address,
   output logic [511:0] mout_arb_writedata,
   output logic [63:0] mout_arb_byteenable,
   output logic mout_arb_id,
   input logic mout_arb_stall,
   input logic mout_wrp_ack,
   input logic mout_rrp_datavalid,
   input logic [511:0] mout_rrp_data
);
   genvar __i;
   generate
      for( __i = 0; __i < 1; __i = __i + 1 )
      begin:m
         logic id;
         acl_ic_master_intf
         #(
            .DATA_W(512),
            .BURSTCOUNT_W(5),
            .ADDRESS_W(25),
            .BYTEENA_W(64),
            .ID_W(1)
         ) m_intf();
         acl_arb_intf
         #(
            .DATA_W(512),
            .BURSTCOUNT_W(5),
            .ADDRESS_W(25),
            .BYTEENA_W(64),
            .ID_W(1)
         ) arb_intf();
         acl_ic_wrp_intf
         #(
            .ID_W(1)
         ) wrp_intf();
         acl_ic_rrp_intf
         #(
            .DATA_W(512),
            .ID_W(1)
         ) rrp_intf();

         assign id = __i;
         // INST m_endp of acl_ic_master_endpoint
         acl_ic_master_endpoint
         #(
            .DATA_W(512),
            .BURSTCOUNT_W(5),
            .ADDRESS_W(25),
            .BYTEENA_W(64),
            .ID_W(1),
            .TOTAL_NUM_MASTERS(1),
            .ID(__i)
         )
         m_endp
         (
            .clock(clock),
            .resetn(resetn),
            .m_intf(m_intf),
            .arb_intf(arb_intf),
            .wrp_intf(wrp_intf),
            .rrp_intf(rrp_intf)
         );

         assign m_intf.arb.req.request = m_arb_request[__i];
         assign m_intf.arb.req.enable = m_arb_enable[__i];
         assign m_intf.arb.req.read = m_arb_read[__i];
         assign m_intf.arb.req.write = m_arb_write[__i];
         assign m_intf.arb.req.burstcount = m_arb_burstcount[__i];
         assign m_intf.arb.req.address = m_arb_address[__i];
         assign m_intf.arb.req.writedata = m_arb_writedata[__i];
         assign m_intf.arb.req.byteenable = m_arb_byteenable[__i];
         assign m_arb_stall[__i] = m_intf.arb.stall;
         assign m_wrp_ack[__i] = m_intf.wrp.ack;
         assign m_rrp_datavalid[__i] = m_intf.rrp.datavalid;
         assign m_rrp_data[__i] = m_intf.rrp.data;
         assign m_intf.arb.req.id = id;
      end

   endgenerate

   generate
   begin:s
      acl_arb_intf
      #(
         .DATA_W(512),
         .BURSTCOUNT_W(5),
         .ADDRESS_W(25),
         .BYTEENA_W(64),
         .ID_W(1)
      ) in_arb_intf();
      acl_arb_intf
      #(
         .DATA_W(512),
         .BURSTCOUNT_W(5),
         .ADDRESS_W(25),
         .BYTEENA_W(64),
         .ID_W(1)
      ) out_arb_intf();
      acl_ic_wrp_intf
      #(
         .ID_W(1)
      ) wrp_intf();
      acl_ic_rrp_intf
      #(
         .DATA_W(512),
         .ID_W(1)
      ) rrp_intf();

      // INST s_endp of acl_ic_slave_endpoint
      acl_ic_slave_endpoint
      #(
         .DATA_W(512),
         .BURSTCOUNT_W(5),
         .ADDRESS_W(25),
         .BYTEENA_W(64),
         .ID_W(1),
         .NUM_MASTERS(1),
         .PIPELINE_RETURN_PATHS(1),
         .WRP_FIFO_DEPTH(64),
         .RRP_FIFO_DEPTH(64),
         .RRP_USE_LL_FIFO(1),
         .SLAVE_FIXED_LATENCY(0),
         .SEPARATE_READ_WRITE_STALLS(0)
      )
      s_endp
      (
         .clock(clock),
         .resetn(resetn),
         .m_intf(in_arb_intf),
         .s_intf(out_arb_intf),
         .s_readdatavalid(mout_rrp_datavalid),
         .s_readdata(mout_rrp_data),
         .s_writeack(mout_wrp_ack),
         .wrp_intf(wrp_intf),
         .rrp_intf(rrp_intf)
      );

   end
   endgenerate

   generate
   begin:wrp
      assign m[0].wrp_intf.ack = s.wrp_intf.ack;
      assign m[0].wrp_intf.id = s.wrp_intf.id;
   end
   endgenerate

   generate
   begin:rrp
   end
   endgenerate

   assign mout_arb_request = s.out_arb_intf.req.request;
   assign mout_arb_enable = s.out_arb_intf.req.enable;
   assign mout_arb_read = s.out_arb_intf.req.read;
   assign mout_arb_write = s.out_arb_intf.req.write;
   assign mout_arb_burstcount = s.out_arb_intf.req.burstcount;
   assign mout_arb_address = s.out_arb_intf.req.address;
   assign mout_arb_writedata = s.out_arb_intf.req.writedata;
   assign mout_arb_byteenable = s.out_arb_intf.req.byteenable;
   assign mout_arb_id = s.out_arb_intf.req.id;
   assign s.out_arb_intf.stall = mout_arb_stall;
   assign s.in_arb_intf.req = m[0].arb_intf.req;
   assign m[0].arb_intf.stall = s.in_arb_intf.stall;
endmodule

/////////////////////////////////////////////////////////////////
// MODULE hello_world_system_interconnect_1
/////////////////////////////////////////////////////////////////
module hello_world_system_interconnect_1
(
   input logic clock,
   input logic resetn,
   // ICM m
   input logic m_arb_request [1],
   input logic m_arb_enable [1],
   input logic m_arb_read [1],
   input logic m_arb_write [1],
   input logic [4:0] m_arb_burstcount [1],
   input logic [24:0] m_arb_address [1],
   input logic [511:0] m_arb_writedata [1],
   input logic [63:0] m_arb_byteenable [1],
   output logic m_arb_stall [1],
   output logic m_wrp_ack [1],
   output logic m_rrp_datavalid [1],
   output logic [511:0] m_rrp_data [1],
   // ICM mout
   output logic mout_arb_request,
   output logic mout_arb_enable,
   output logic mout_arb_read,
   output logic mout_arb_write,
   output logic [4:0] mout_arb_burstcount,
   output logic [24:0] mout_arb_address,
   output logic [511:0] mout_arb_writedata,
   output logic [63:0] mout_arb_byteenable,
   output logic mout_arb_id,
   input logic mout_arb_stall,
   input logic mout_wrp_ack,
   input logic mout_rrp_datavalid,
   input logic [511:0] mout_rrp_data
);
   genvar __i;
   generate
      for( __i = 0; __i < 1; __i = __i + 1 )
      begin:m
         logic id;
         acl_ic_master_intf
         #(
            .DATA_W(512),
            .BURSTCOUNT_W(5),
            .ADDRESS_W(25),
            .BYTEENA_W(64),
            .ID_W(1)
         ) m_intf();
         acl_arb_intf
         #(
            .DATA_W(512),
            .BURSTCOUNT_W(5),
            .ADDRESS_W(25),
            .BYTEENA_W(64),
            .ID_W(1)
         ) arb_intf();
         acl_ic_wrp_intf
         #(
            .ID_W(1)
         ) wrp_intf();
         acl_ic_rrp_intf
         #(
            .DATA_W(512),
            .ID_W(1)
         ) rrp_intf();

         assign id = __i;
         // INST m_endp of acl_ic_master_endpoint
         acl_ic_master_endpoint
         #(
            .DATA_W(512),
            .BURSTCOUNT_W(5),
            .ADDRESS_W(25),
            .BYTEENA_W(64),
            .ID_W(1),
            .TOTAL_NUM_MASTERS(1),
            .ID(__i)
         )
         m_endp
         (
            .clock(clock),
            .resetn(resetn),
            .m_intf(m_intf),
            .arb_intf(arb_intf),
            .wrp_intf(wrp_intf),
            .rrp_intf(rrp_intf)
         );

         assign m_intf.arb.req.request = m_arb_request[__i];
         assign m_intf.arb.req.enable = m_arb_enable[__i];
         assign m_intf.arb.req.read = m_arb_read[__i];
         assign m_intf.arb.req.write = m_arb_write[__i];
         assign m_intf.arb.req.burstcount = m_arb_burstcount[__i];
         assign m_intf.arb.req.address = m_arb_address[__i];
         assign m_intf.arb.req.writedata = m_arb_writedata[__i];
         assign m_intf.arb.req.byteenable = m_arb_byteenable[__i];
         assign m_arb_stall[__i] = m_intf.arb.stall;
         assign m_wrp_ack[__i] = m_intf.wrp.ack;
         assign m_rrp_datavalid[__i] = m_intf.rrp.datavalid;
         assign m_rrp_data[__i] = m_intf.rrp.data;
         assign m_intf.arb.req.id = id;
      end

   endgenerate

   generate
   begin:s
      acl_arb_intf
      #(
         .DATA_W(512),
         .BURSTCOUNT_W(5),
         .ADDRESS_W(25),
         .BYTEENA_W(64),
         .ID_W(1)
      ) in_arb_intf();
      acl_arb_intf
      #(
         .DATA_W(512),
         .BURSTCOUNT_W(5),
         .ADDRESS_W(25),
         .BYTEENA_W(64),
         .ID_W(1)
      ) out_arb_intf();
      acl_ic_wrp_intf
      #(
         .ID_W(1)
      ) wrp_intf();
      acl_ic_rrp_intf
      #(
         .DATA_W(512),
         .ID_W(1)
      ) rrp_intf();

      // INST s_endp of acl_ic_slave_endpoint
      acl_ic_slave_endpoint
      #(
         .DATA_W(512),
         .BURSTCOUNT_W(5),
         .ADDRESS_W(25),
         .BYTEENA_W(64),
         .ID_W(1),
         .NUM_MASTERS(1),
         .PIPELINE_RETURN_PATHS(1),
         .WRP_FIFO_DEPTH(0),
         .RRP_FIFO_DEPTH(64),
         .RRP_USE_LL_FIFO(1),
         .SLAVE_FIXED_LATENCY(0),
         .SEPARATE_READ_WRITE_STALLS(0)
      )
      s_endp
      (
         .clock(clock),
         .resetn(resetn),
         .m_intf(in_arb_intf),
         .s_intf(out_arb_intf),
         .s_readdatavalid(mout_rrp_datavalid),
         .s_readdata(mout_rrp_data),
         .s_writeack(mout_wrp_ack),
         .wrp_intf(wrp_intf),
         .rrp_intf(rrp_intf)
      );

   end
   endgenerate

   generate
   begin:wrp
      assign m[0].wrp_intf.ack = s.wrp_intf.ack;
      assign m[0].wrp_intf.id = s.wrp_intf.id;
   end
   endgenerate

   generate
   begin:rrp
      assign m[0].rrp_intf.datavalid = s.rrp_intf.datavalid;
      assign m[0].rrp_intf.data = s.rrp_intf.data;
      assign m[0].rrp_intf.id = s.rrp_intf.id;
   end
   endgenerate

   generate
      for( __i = 0; __i < 2; __i = __i + 1 )
      begin:dp
         acl_arb_intf
         #(
            .DATA_W(512),
            .BURSTCOUNT_W(5),
            .ADDRESS_W(25),
            .BYTEENA_W(64),
            .ID_W(1)
         ) in_intf();
         acl_arb_intf
         #(
            .DATA_W(512),
            .BURSTCOUNT_W(5),
            .ADDRESS_W(25),
            .BYTEENA_W(64),
            .ID_W(1)
         ) out_intf();

         // INST dp of acl_arb_pipeline_reg
         acl_arb_pipeline_reg
         #(
            .DATA_W(512),
            .BURSTCOUNT_W(5),
            .ADDRESS_W(25),
            .BYTEENA_W(64),
            .ID_W(1)
         )
         dp
         (
            .clock(clock),
            .resetn(resetn),
            .in_intf(in_intf),
            .out_intf(out_intf)
         );

      end

   endgenerate

   generate
      for( __i = 0; __i < 1; __i = __i + 1 )
      begin:sp
         acl_arb_intf
         #(
            .DATA_W(512),
            .BURSTCOUNT_W(5),
            .ADDRESS_W(25),
            .BYTEENA_W(64),
            .ID_W(1)
         ) in_intf();
         acl_arb_intf
         #(
            .DATA_W(512),
            .BURSTCOUNT_W(5),
            .ADDRESS_W(25),
            .BYTEENA_W(64),
            .ID_W(1)
         ) out_intf();

         // INST sp of acl_arb_staging_reg
         acl_arb_staging_reg
         #(
            .DATA_W(512),
            .BURSTCOUNT_W(5),
            .ADDRESS_W(25),
            .BYTEENA_W(64),
            .ID_W(1)
         )
         sp
         (
            .clock(clock),
            .resetn(resetn),
            .in_intf(in_intf),
            .out_intf(out_intf)
         );

      end

   endgenerate

   assign mout_arb_request = dp[0].out_intf.req.request;
   assign mout_arb_enable = dp[0].out_intf.req.enable;
   assign mout_arb_read = dp[0].out_intf.req.read;
   assign mout_arb_write = dp[0].out_intf.req.write;
   assign mout_arb_burstcount = dp[0].out_intf.req.burstcount;
   assign mout_arb_address = dp[0].out_intf.req.address;
   assign mout_arb_writedata = dp[0].out_intf.req.writedata;
   assign mout_arb_byteenable = dp[0].out_intf.req.byteenable;
   assign mout_arb_id = dp[0].out_intf.req.id;
   assign dp[0].out_intf.stall = mout_arb_stall;
   assign dp[0].in_intf.req = sp[0].out_intf.req;
   assign sp[0].out_intf.stall = dp[0].in_intf.stall;
   assign sp[0].in_intf.req = s.out_arb_intf.req;
   assign s.out_arb_intf.stall = sp[0].in_intf.stall;
   assign s.in_arb_intf.req = dp[1].out_intf.req;
   assign dp[1].out_intf.stall = s.in_arb_intf.stall;
   assign dp[1].in_intf.req = m[0].arb_intf.req;
   assign m[0].arb_intf.stall = dp[1].in_intf.stall;
endmodule

/////////////////////////////////////////////////////////////////
// MODULE hello_world_system_interconnect_2
/////////////////////////////////////////////////////////////////
module hello_world_system_interconnect_2
(
   input logic clock,
   input logic resetn,
   // ICM m
   input logic m_arb_request [1],
   input logic m_arb_enable [1],
   input logic m_arb_read [1],
   input logic m_arb_write [1],
   input logic [5:0] m_arb_burstcount [1],
   input logic [26:0] m_arb_address [1],
   input logic [255:0] m_arb_writedata [1],
   input logic [31:0] m_arb_byteenable [1],
   output logic m_arb_stall [1],
   output logic m_wrp_ack [1],
   output logic m_rrp_datavalid [1],
   output logic [255:0] m_rrp_data [1],
   // ICM mout
   output logic mout_arb_request,
   output logic mout_arb_enable,
   output logic mout_arb_read,
   output logic mout_arb_write,
   output logic [5:0] mout_arb_burstcount,
   output logic [26:0] mout_arb_address,
   output logic [255:0] mout_arb_writedata,
   output logic [31:0] mout_arb_byteenable,
   output logic mout_arb_id,
   input logic mout_arb_stall,
   input logic mout_wrp_ack,
   input logic mout_rrp_datavalid,
   input logic [255:0] mout_rrp_data
);
   genvar __i;
   generate
      for( __i = 0; __i < 1; __i = __i + 1 )
      begin:m
         logic id;
         acl_ic_master_intf
         #(
            .DATA_W(256),
            .BURSTCOUNT_W(6),
            .ADDRESS_W(27),
            .BYTEENA_W(32),
            .ID_W(1)
         ) m_intf();
         acl_arb_intf
         #(
            .DATA_W(256),
            .BURSTCOUNT_W(6),
            .ADDRESS_W(27),
            .BYTEENA_W(32),
            .ID_W(1)
         ) arb_intf();
         acl_ic_wrp_intf
         #(
            .ID_W(1)
         ) wrp_intf();
         acl_ic_rrp_intf
         #(
            .DATA_W(256),
            .ID_W(1)
         ) rrp_intf();

         assign id = __i;
         // INST m_endp of acl_ic_master_endpoint
         acl_ic_master_endpoint
         #(
            .DATA_W(256),
            .BURSTCOUNT_W(6),
            .ADDRESS_W(27),
            .BYTEENA_W(32),
            .ID_W(1),
            .TOTAL_NUM_MASTERS(1),
            .ID(__i)
         )
         m_endp
         (
            .clock(clock),
            .resetn(resetn),
            .m_intf(m_intf),
            .arb_intf(arb_intf),
            .wrp_intf(wrp_intf),
            .rrp_intf(rrp_intf)
         );

         assign m_intf.arb.req.request = m_arb_request[__i];
         assign m_intf.arb.req.enable = m_arb_enable[__i];
         assign m_intf.arb.req.read = m_arb_read[__i];
         assign m_intf.arb.req.write = m_arb_write[__i];
         assign m_intf.arb.req.burstcount = m_arb_burstcount[__i];
         assign m_intf.arb.req.address = m_arb_address[__i];
         assign m_intf.arb.req.writedata = m_arb_writedata[__i];
         assign m_intf.arb.req.byteenable = m_arb_byteenable[__i];
         assign m_arb_stall[__i] = m_intf.arb.stall;
         assign m_wrp_ack[__i] = m_intf.wrp.ack;
         assign m_rrp_datavalid[__i] = m_intf.rrp.datavalid;
         assign m_rrp_data[__i] = m_intf.rrp.data;
         assign m_intf.arb.req.id = id;
      end

   endgenerate

   generate
   begin:s
      acl_arb_intf
      #(
         .DATA_W(256),
         .BURSTCOUNT_W(6),
         .ADDRESS_W(27),
         .BYTEENA_W(32),
         .ID_W(1)
      ) in_arb_intf();
      acl_arb_intf
      #(
         .DATA_W(256),
         .BURSTCOUNT_W(6),
         .ADDRESS_W(27),
         .BYTEENA_W(32),
         .ID_W(1)
      ) out_arb_intf();
      acl_ic_wrp_intf
      #(
         .ID_W(1)
      ) wrp_intf();
      acl_ic_rrp_intf
      #(
         .DATA_W(256),
         .ID_W(1)
      ) rrp_intf();

      // INST s_endp of acl_ic_slave_endpoint
      acl_ic_slave_endpoint
      #(
         .DATA_W(256),
         .BURSTCOUNT_W(6),
         .ADDRESS_W(27),
         .BYTEENA_W(32),
         .ID_W(1),
         .NUM_MASTERS(1),
         .PIPELINE_RETURN_PATHS(1),
         .WRP_FIFO_DEPTH(64),
         .RRP_FIFO_DEPTH(64),
         .RRP_USE_LL_FIFO(1),
         .SLAVE_FIXED_LATENCY(0),
         .SEPARATE_READ_WRITE_STALLS(0)
      )
      s_endp
      (
         .clock(clock),
         .resetn(resetn),
         .m_intf(in_arb_intf),
         .s_intf(out_arb_intf),
         .s_readdatavalid(mout_rrp_datavalid),
         .s_readdata(mout_rrp_data),
         .s_writeack(mout_wrp_ack),
         .wrp_intf(wrp_intf),
         .rrp_intf(rrp_intf)
      );

   end
   endgenerate

   generate
   begin:wrp
   end
   endgenerate

   generate
   begin:rrp
      assign m[0].rrp_intf.datavalid = s.rrp_intf.datavalid;
      assign m[0].rrp_intf.data = s.rrp_intf.data;
      assign m[0].rrp_intf.id = s.rrp_intf.id;
   end
   endgenerate

   assign mout_arb_request = s.out_arb_intf.req.request;
   assign mout_arb_enable = s.out_arb_intf.req.enable;
   assign mout_arb_read = s.out_arb_intf.req.read;
   assign mout_arb_write = s.out_arb_intf.req.write;
   assign mout_arb_burstcount = s.out_arb_intf.req.burstcount;
   assign mout_arb_address = s.out_arb_intf.req.address;
   assign mout_arb_writedata = s.out_arb_intf.req.writedata;
   assign mout_arb_byteenable = s.out_arb_intf.req.byteenable;
   assign mout_arb_id = s.out_arb_intf.req.id;
   assign s.out_arb_intf.stall = mout_arb_stall;
   assign s.in_arb_intf.req = m[0].arb_intf.req;
   assign m[0].arb_intf.stall = s.in_arb_intf.stall;
endmodule

