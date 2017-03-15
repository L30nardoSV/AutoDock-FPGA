package require -exact qsys 14.0
set_module_property NAME Krnl_GA_system
set_module_property VERSION 14.0
set_module_property INTERNAL false
set_module_property GROUP Accelerators
set_module_property DISPLAY_NAME Krnl_GA_system
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true

add_interface clock_reset clock end
set_interface_property clock_reset ENABLED true
add_interface_port clock_reset clock clk Input 1
add_interface_port clock_reset resetn reset_n Input 1
add_interface clock_reset2x clock end
set_interface_property clock_reset2x ENABLED true
add_interface_port clock_reset2x clock2x clk Input 1

#### Slave interface avs_Krnl_Conform_cra
add_interface avs_Krnl_Conform_cra avalon end
set_interface_property avs_Krnl_Conform_cra ENABLED true
set_interface_property avs_Krnl_Conform_cra associatedClock clock_reset
set_interface_property avs_Krnl_Conform_cra addressAlignment DYNAMIC
set_interface_property avs_Krnl_Conform_cra burstOnBurstBoundariesOnly false
set_interface_property avs_Krnl_Conform_cra explicitAddressSpan 0
set_interface_property avs_Krnl_Conform_cra holdTime 0
set_interface_property avs_Krnl_Conform_cra isMemoryDevice false
set_interface_property avs_Krnl_Conform_cra isNonVolatileStorage false
set_interface_property avs_Krnl_Conform_cra linewrapBursts false
set_interface_property avs_Krnl_Conform_cra maximumPendingReadTransactions 1
set_interface_property avs_Krnl_Conform_cra printableDevice false
set_interface_property avs_Krnl_Conform_cra readLatency 0
set_interface_property avs_Krnl_Conform_cra readWaitTime 0
set_interface_property avs_Krnl_Conform_cra setupTime 0
set_interface_property avs_Krnl_Conform_cra timingUnits Cycles
set_interface_property avs_Krnl_Conform_cra writeWaitTime 0
set_interface_assignment avs_Krnl_Conform_cra hls.cosim.name {}
add_interface_port avs_Krnl_Conform_cra avs_Krnl_Conform_cra_read read input 1
add_interface_port avs_Krnl_Conform_cra avs_Krnl_Conform_cra_write write input 1
add_interface_port avs_Krnl_Conform_cra avs_Krnl_Conform_cra_address address input 4
add_interface_port avs_Krnl_Conform_cra avs_Krnl_Conform_cra_writedata writedata input 64
add_interface_port avs_Krnl_Conform_cra avs_Krnl_Conform_cra_byteenable byteenable input 8
add_interface_port avs_Krnl_Conform_cra avs_Krnl_Conform_cra_readdata readdata output 64
add_interface_port avs_Krnl_Conform_cra avs_Krnl_Conform_cra_readdatavalid readdatavalid output 1

#### Slave interface avs_Krnl_GA_cra
add_interface avs_Krnl_GA_cra avalon end
set_interface_property avs_Krnl_GA_cra ENABLED true
set_interface_property avs_Krnl_GA_cra associatedClock clock_reset
set_interface_property avs_Krnl_GA_cra addressAlignment DYNAMIC
set_interface_property avs_Krnl_GA_cra burstOnBurstBoundariesOnly false
set_interface_property avs_Krnl_GA_cra explicitAddressSpan 0
set_interface_property avs_Krnl_GA_cra holdTime 0
set_interface_property avs_Krnl_GA_cra isMemoryDevice false
set_interface_property avs_Krnl_GA_cra isNonVolatileStorage false
set_interface_property avs_Krnl_GA_cra linewrapBursts false
set_interface_property avs_Krnl_GA_cra maximumPendingReadTransactions 1
set_interface_property avs_Krnl_GA_cra printableDevice false
set_interface_property avs_Krnl_GA_cra readLatency 0
set_interface_property avs_Krnl_GA_cra readWaitTime 0
set_interface_property avs_Krnl_GA_cra setupTime 0
set_interface_property avs_Krnl_GA_cra timingUnits Cycles
set_interface_property avs_Krnl_GA_cra writeWaitTime 0
set_interface_assignment avs_Krnl_GA_cra hls.cosim.name {}
add_interface_port avs_Krnl_GA_cra avs_Krnl_GA_cra_read read input 1
add_interface_port avs_Krnl_GA_cra avs_Krnl_GA_cra_write write input 1
add_interface_port avs_Krnl_GA_cra avs_Krnl_GA_cra_address address input 5
add_interface_port avs_Krnl_GA_cra avs_Krnl_GA_cra_writedata writedata input 64
add_interface_port avs_Krnl_GA_cra avs_Krnl_GA_cra_byteenable byteenable input 8
add_interface_port avs_Krnl_GA_cra avs_Krnl_GA_cra_readdata readdata output 64
add_interface_port avs_Krnl_GA_cra avs_Krnl_GA_cra_readdatavalid readdatavalid output 1

#### Slave interface avs_Krnl_InterE_cra
add_interface avs_Krnl_InterE_cra avalon end
set_interface_property avs_Krnl_InterE_cra ENABLED true
set_interface_property avs_Krnl_InterE_cra associatedClock clock_reset
set_interface_property avs_Krnl_InterE_cra addressAlignment DYNAMIC
set_interface_property avs_Krnl_InterE_cra burstOnBurstBoundariesOnly false
set_interface_property avs_Krnl_InterE_cra explicitAddressSpan 0
set_interface_property avs_Krnl_InterE_cra holdTime 0
set_interface_property avs_Krnl_InterE_cra isMemoryDevice false
set_interface_property avs_Krnl_InterE_cra isNonVolatileStorage false
set_interface_property avs_Krnl_InterE_cra linewrapBursts false
set_interface_property avs_Krnl_InterE_cra maximumPendingReadTransactions 1
set_interface_property avs_Krnl_InterE_cra printableDevice false
set_interface_property avs_Krnl_InterE_cra readLatency 0
set_interface_property avs_Krnl_InterE_cra readWaitTime 0
set_interface_property avs_Krnl_InterE_cra setupTime 0
set_interface_property avs_Krnl_InterE_cra timingUnits Cycles
set_interface_property avs_Krnl_InterE_cra writeWaitTime 0
set_interface_assignment avs_Krnl_InterE_cra hls.cosim.name {}
add_interface_port avs_Krnl_InterE_cra avs_Krnl_InterE_cra_read read input 1
add_interface_port avs_Krnl_InterE_cra avs_Krnl_InterE_cra_write write input 1
add_interface_port avs_Krnl_InterE_cra avs_Krnl_InterE_cra_address address input 5
add_interface_port avs_Krnl_InterE_cra avs_Krnl_InterE_cra_writedata writedata input 64
add_interface_port avs_Krnl_InterE_cra avs_Krnl_InterE_cra_byteenable byteenable input 8
add_interface_port avs_Krnl_InterE_cra avs_Krnl_InterE_cra_readdata readdata output 64
add_interface_port avs_Krnl_InterE_cra avs_Krnl_InterE_cra_readdatavalid readdatavalid output 1

#### Slave interface avs_Krnl_IntraE_cra
add_interface avs_Krnl_IntraE_cra avalon end
set_interface_property avs_Krnl_IntraE_cra ENABLED true
set_interface_property avs_Krnl_IntraE_cra associatedClock clock_reset
set_interface_property avs_Krnl_IntraE_cra addressAlignment DYNAMIC
set_interface_property avs_Krnl_IntraE_cra burstOnBurstBoundariesOnly false
set_interface_property avs_Krnl_IntraE_cra explicitAddressSpan 0
set_interface_property avs_Krnl_IntraE_cra holdTime 0
set_interface_property avs_Krnl_IntraE_cra isMemoryDevice false
set_interface_property avs_Krnl_IntraE_cra isNonVolatileStorage false
set_interface_property avs_Krnl_IntraE_cra linewrapBursts false
set_interface_property avs_Krnl_IntraE_cra maximumPendingReadTransactions 1
set_interface_property avs_Krnl_IntraE_cra printableDevice false
set_interface_property avs_Krnl_IntraE_cra readLatency 0
set_interface_property avs_Krnl_IntraE_cra readWaitTime 0
set_interface_property avs_Krnl_IntraE_cra setupTime 0
set_interface_property avs_Krnl_IntraE_cra timingUnits Cycles
set_interface_property avs_Krnl_IntraE_cra writeWaitTime 0
set_interface_assignment avs_Krnl_IntraE_cra hls.cosim.name {}
add_interface_port avs_Krnl_IntraE_cra avs_Krnl_IntraE_cra_read read input 1
add_interface_port avs_Krnl_IntraE_cra avs_Krnl_IntraE_cra_write write input 1
add_interface_port avs_Krnl_IntraE_cra avs_Krnl_IntraE_cra_address address input 4
add_interface_port avs_Krnl_IntraE_cra avs_Krnl_IntraE_cra_writedata writedata input 64
add_interface_port avs_Krnl_IntraE_cra avs_Krnl_IntraE_cra_byteenable byteenable input 8
add_interface_port avs_Krnl_IntraE_cra avs_Krnl_IntraE_cra_readdata readdata output 64
add_interface_port avs_Krnl_IntraE_cra avs_Krnl_IntraE_cra_readdatavalid readdatavalid output 1

#### Slave interface avs_Krnl_Store_cra
add_interface avs_Krnl_Store_cra avalon end
set_interface_property avs_Krnl_Store_cra ENABLED true
set_interface_property avs_Krnl_Store_cra associatedClock clock_reset
set_interface_property avs_Krnl_Store_cra addressAlignment DYNAMIC
set_interface_property avs_Krnl_Store_cra burstOnBurstBoundariesOnly false
set_interface_property avs_Krnl_Store_cra explicitAddressSpan 0
set_interface_property avs_Krnl_Store_cra holdTime 0
set_interface_property avs_Krnl_Store_cra isMemoryDevice false
set_interface_property avs_Krnl_Store_cra isNonVolatileStorage false
set_interface_property avs_Krnl_Store_cra linewrapBursts false
set_interface_property avs_Krnl_Store_cra maximumPendingReadTransactions 1
set_interface_property avs_Krnl_Store_cra printableDevice false
set_interface_property avs_Krnl_Store_cra readLatency 0
set_interface_property avs_Krnl_Store_cra readWaitTime 0
set_interface_property avs_Krnl_Store_cra setupTime 0
set_interface_property avs_Krnl_Store_cra timingUnits Cycles
set_interface_property avs_Krnl_Store_cra writeWaitTime 0
set_interface_assignment avs_Krnl_Store_cra hls.cosim.name {}
add_interface_port avs_Krnl_Store_cra avs_Krnl_Store_cra_read read input 1
add_interface_port avs_Krnl_Store_cra avs_Krnl_Store_cra_write write input 1
add_interface_port avs_Krnl_Store_cra avs_Krnl_Store_cra_address address input 4
add_interface_port avs_Krnl_Store_cra avs_Krnl_Store_cra_writedata writedata input 64
add_interface_port avs_Krnl_Store_cra avs_Krnl_Store_cra_byteenable byteenable input 8
add_interface_port avs_Krnl_Store_cra avs_Krnl_Store_cra_readdata readdata output 64
add_interface_port avs_Krnl_Store_cra avs_Krnl_Store_cra_readdatavalid readdatavalid output 1

#### IRQ interfaces kernel_irq
add_interface kernel_irq interrupt end
set_interface_property kernel_irq ENABLED true
set_interface_property kernel_irq associatedClock clock_reset
add_interface_port kernel_irq kernel_irq irq output 1

#### Master interface avm_memgmem0_DDR_port_0_0_rw with base address 0
add_interface avm_memgmem0_DDR_port_0_0_rw avalon start
set_interface_property avm_memgmem0_DDR_port_0_0_rw ENABLED true
set_interface_property avm_memgmem0_DDR_port_0_0_rw associatedClock clock_reset
set_interface_property avm_memgmem0_DDR_port_0_0_rw burstOnBurstBoundariesOnly false
set_interface_property avm_memgmem0_DDR_port_0_0_rw doStreamReads false
set_interface_property avm_memgmem0_DDR_port_0_0_rw doStreamWrites false
set_interface_property avm_memgmem0_DDR_port_0_0_rw linewrapBursts false
set_interface_property avm_memgmem0_DDR_port_0_0_rw readWaitTime 0
add_interface_port avm_memgmem0_DDR_port_0_0_rw avm_memgmem0_DDR_port_0_0_rw_address address output 31
add_interface_port avm_memgmem0_DDR_port_0_0_rw avm_memgmem0_DDR_port_0_0_rw_read read output 1
add_interface_port avm_memgmem0_DDR_port_0_0_rw avm_memgmem0_DDR_port_0_0_rw_write write output 1
add_interface_port avm_memgmem0_DDR_port_0_0_rw avm_memgmem0_DDR_port_0_0_rw_writedata writedata output 512
add_interface_port avm_memgmem0_DDR_port_0_0_rw avm_memgmem0_DDR_port_0_0_rw_byteenable byteenable output 64
add_interface_port avm_memgmem0_DDR_port_0_0_rw avm_memgmem0_DDR_port_0_0_rw_readdata readdata input 512
add_interface_port avm_memgmem0_DDR_port_0_0_rw avm_memgmem0_DDR_port_0_0_rw_burstcount burstcount output 5
add_interface_port avm_memgmem0_DDR_port_0_0_rw avm_memgmem0_DDR_port_0_0_rw_waitrequest waitrequest input 1
add_interface_port avm_memgmem0_DDR_port_0_0_rw avm_memgmem0_DDR_port_0_0_rw_readdatavalid readdatavalid input 1

add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL Krnl_GA_system
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
add_fileset_file acl_work_group_dispatcher.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_work_group_dispatcher.v TOP_LEVEL_FILE
add_fileset_file acl_id_iterator.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_id_iterator.v TOP_LEVEL_FILE
add_fileset_file acl_work_item_iterator.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_work_item_iterator.v TOP_LEVEL_FILE
add_fileset_file acl_multistage_adder.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_multistage_adder.v TOP_LEVEL_FILE
add_fileset_file acl_start_signal_chain_element.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_start_signal_chain_element.v TOP_LEVEL_FILE
add_fileset_file acl_finish_signal_chain_element.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_finish_signal_chain_element.v TOP_LEVEL_FILE
add_fileset_file acl_task_copy_finish_detector.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_task_copy_finish_detector.v TOP_LEVEL_FILE
add_fileset_file acl_kernel_finish_detector.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_kernel_finish_detector.v TOP_LEVEL_FILE
add_fileset_file acl_multistage_accumulator.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_multistage_accumulator.v TOP_LEVEL_FILE
add_fileset_file acl_fifo.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_fifo.v TOP_LEVEL_FILE
add_fileset_file acl_shift_register.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_shift_register.v TOP_LEVEL_FILE
add_fileset_file lsu_top.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/lsu_top.v TOP_LEVEL_FILE
add_fileset_file acl_staging_reg.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_staging_reg.v TOP_LEVEL_FILE
add_fileset_file acl_ll_fifo.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_ll_fifo.v TOP_LEVEL_FILE
add_fileset_file lsu_pipelined.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/lsu_pipelined.v TOP_LEVEL_FILE
add_fileset_file lsu_enabled.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/lsu_enabled.v TOP_LEVEL_FILE
add_fileset_file lsu_basic_coalescer.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/lsu_basic_coalescer.v TOP_LEVEL_FILE
add_fileset_file lsu_simple.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/lsu_simple.v TOP_LEVEL_FILE
add_fileset_file acl_data_fifo.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_data_fifo.v TOP_LEVEL_FILE
add_fileset_file lsu_streaming.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/lsu_streaming.v TOP_LEVEL_FILE
add_fileset_file lsu_burst_master.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/lsu_burst_master.v TOP_LEVEL_FILE
add_fileset_file lsu_bursting_load_stores.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/lsu_bursting_load_stores.v TOP_LEVEL_FILE
add_fileset_file lsu_non_aligned_write.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/lsu_non_aligned_write.v TOP_LEVEL_FILE
add_fileset_file lsu_read_cache.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/lsu_read_cache.v TOP_LEVEL_FILE
add_fileset_file lsu_atomic.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/lsu_atomic.v TOP_LEVEL_FILE
add_fileset_file lsu_prefetch_block.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/lsu_prefetch_block.v TOP_LEVEL_FILE
add_fileset_file lsu_wide_wrapper.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/lsu_wide_wrapper.v TOP_LEVEL_FILE
add_fileset_file lsu_streaming_prefetch.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/lsu_streaming_prefetch.v TOP_LEVEL_FILE
add_fileset_file lsu_permute_address.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/lsu_permute_address.v TOP_LEVEL_FILE
add_fileset_file acl_aligned_burst_coalesced_lsu.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_aligned_burst_coalesced_lsu.v TOP_LEVEL_FILE
add_fileset_file acl_push.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_push.v TOP_LEVEL_FILE
add_fileset_file acl_token_fifo_counter.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_token_fifo_counter.v TOP_LEVEL_FILE
add_fileset_file acl_ll_ram_fifo.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_ll_ram_fifo.v TOP_LEVEL_FILE
add_fileset_file acl_valid_fifo_counter.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_valid_fifo_counter.v TOP_LEVEL_FILE
add_fileset_file acl_pipeline.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_pipeline.v TOP_LEVEL_FILE
add_fileset_file st_top.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/st_top.v TOP_LEVEL_FILE
add_fileset_file acl_pop.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_pop.v TOP_LEVEL_FILE
add_fileset_file acl_enable_sink.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_enable_sink.v TOP_LEVEL_FILE
add_fileset_file acl_printf_buffer_address_generator.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_printf_buffer_address_generator.v TOP_LEVEL_FILE
add_fileset_file acl_full_detector.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_full_detector.v TOP_LEVEL_FILE
add_fileset_file acl_stall_free_sink.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_stall_free_sink.v TOP_LEVEL_FILE
add_fileset_file acl_fp_mul_a10.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_fp_mul_a10.v TOP_LEVEL_FILE
add_fileset_file acl_fp_sincos_s5.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_fp_sincos_s5.v TOP_LEVEL_FILE
add_fileset_file dspba_library_package.vhd VHDL PATH $::env(ALTERAOCLSDKROOT)/ip/dspba_library_package.vhd TOP_LEVEL_FILE
add_fileset_file dspba_library.vhd VHDL PATH $::env(ALTERAOCLSDKROOT)/ip/dspba_library.vhd TOP_LEVEL_FILE
add_fileset_file fp_sincos_s5.vhd VHDL PATH $::env(ALTERAOCLSDKROOT)/ip/fp_sincos_s5.vhd TOP_LEVEL_FILE
add_fileset_file fp_sincos_s5_memoryC0_uid394_tableGensinPiZ_lutmem.hex HEX PATH $::env(ALTERAOCLSDKROOT)/ip/fp_sincos_s5_memoryC0_uid394_tableGensinPiZ_lutmem.hex TOP_LEVEL_FILE
add_fileset_file fp_sincos_s5_memoryC0_uid400_tableGencosPiZ_lutmem.hex HEX PATH $::env(ALTERAOCLSDKROOT)/ip/fp_sincos_s5_memoryC0_uid400_tableGencosPiZ_lutmem.hex TOP_LEVEL_FILE
add_fileset_file fp_sincos_s5_memoryC1_uid396_tableGensinPiZ_lutmem.hex HEX PATH $::env(ALTERAOCLSDKROOT)/ip/fp_sincos_s5_memoryC1_uid396_tableGensinPiZ_lutmem.hex TOP_LEVEL_FILE
add_fileset_file fp_sincos_s5_memoryC1_uid402_tableGencosPiZ_lutmem.hex HEX PATH $::env(ALTERAOCLSDKROOT)/ip/fp_sincos_s5_memoryC1_uid402_tableGencosPiZ_lutmem.hex TOP_LEVEL_FILE
add_fileset_file fp_sincos_s5_memoryC2_uid398_tableGensinPiZ_lutmem.hex HEX PATH $::env(ALTERAOCLSDKROOT)/ip/fp_sincos_s5_memoryC2_uid398_tableGensinPiZ_lutmem.hex TOP_LEVEL_FILE
add_fileset_file fp_sincos_s5_memoryC2_uid404_tableGencosPiZ_lutmem.hex HEX PATH $::env(ALTERAOCLSDKROOT)/ip/fp_sincos_s5_memoryC2_uid404_tableGencosPiZ_lutmem.hex TOP_LEVEL_FILE
add_fileset_file fp_sincos_s5_rrTable_uid194_rrx_uid34_fpSinCosXTest_lutmem.hex HEX PATH $::env(ALTERAOCLSDKROOT)/ip/fp_sincos_s5_rrTable_uid194_rrx_uid34_fpSinCosXTest_lutmem.hex TOP_LEVEL_FILE
add_fileset_file fp_sincos_s5_rrTable_uid195_rrx_uid34_fpSinCosXTest_lutmem.hex HEX PATH $::env(ALTERAOCLSDKROOT)/ip/fp_sincos_s5_rrTable_uid195_rrx_uid34_fpSinCosXTest_lutmem.hex TOP_LEVEL_FILE
add_fileset_file acl_fp_dot2_a10.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_fp_dot2_a10.v TOP_LEVEL_FILE
add_fileset_file acl_fp_mdot2_a10.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_fp_mdot2_a10.v TOP_LEVEL_FILE
add_fileset_file acl_fp_multadd_a10.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_fp_multadd_a10.v TOP_LEVEL_FILE
add_fileset_file acl_fp_sub_a10.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_fp_sub_a10.v TOP_LEVEL_FILE
add_fileset_file acl_fp_add_a10.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_fp_add_a10.v TOP_LEVEL_FILE
add_fileset_file acl_loop_limiter.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_loop_limiter.v TOP_LEVEL_FILE
add_fileset_file acl_work_group_limiter.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_work_group_limiter.v TOP_LEVEL_FILE
add_fileset_file acl_toggle_detect.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_toggle_detect.v TOP_LEVEL_FILE
add_fileset_file acl_debug_mem.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_debug_mem.v TOP_LEVEL_FILE
add_fileset_file acl_printf_counter.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_printf_counter.v TOP_LEVEL_FILE
add_fileset_file Krnl_GA.v SYSTEM_VERILOG PATH Krnl_GA.v TOP_LEVEL_FILE
add_fileset_file Krnl_GA_system.v SYSTEM_VERILOG PATH Krnl_GA_system.v TOP_LEVEL_FILE
add_fileset_file acl_fp_uitofp.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_fp_uitofp.v TOP_LEVEL_FILE
add_fileset_file acl_int_mult.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_int_mult.v TOP_LEVEL_FILE
add_fileset_file sv_mult27.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/sv_mult27.v TOP_LEVEL_FILE
add_fileset_file acl_merge_node_priority_encoder_workgroup.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_merge_node_priority_encoder_workgroup.v TOP_LEVEL_FILE
add_fileset_file acl_fp_cmp.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_fp_cmp.v TOP_LEVEL_FILE
add_fileset_file acl_fp_fptoui.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_fp_fptoui.v TOP_LEVEL_FILE
add_fileset_file acl_embedded_workgroup_issuer.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_embedded_workgroup_issuer.v TOP_LEVEL_FILE
add_fileset_file acl_embedded_workgroup_issuer_complex.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_embedded_workgroup_issuer_complex.v TOP_LEVEL_FILE
add_fileset_file acl_embedded_workgroup_issuer_fifo.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_embedded_workgroup_issuer_fifo.v TOP_LEVEL_FILE
add_fileset_file acl_barrier.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_barrier.v TOP_LEVEL_FILE
add_fileset_file acl_barrier_simple.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_barrier_simple.v TOP_LEVEL_FILE
add_fileset_file acl_fifo_reorder.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_fifo_reorder.v TOP_LEVEL_FILE
add_fileset_file acl_fp_sitofp.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_fp_sitofp.v TOP_LEVEL_FILE
add_fileset_file acl_fp_floor.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_fp_floor.v TOP_LEVEL_FILE
add_fileset_file acl_fp_ceil.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_fp_ceil.v TOP_LEVEL_FILE
add_fileset_file acl_fp_convert_with_rounding.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_fp_convert_with_rounding.v TOP_LEVEL_FILE
add_fileset_file acl_fp_accum_a10.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_fp_accum_a10.v TOP_LEVEL_FILE
add_fileset_file acl_fp_sqrt_s5.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_fp_sqrt_s5.v TOP_LEVEL_FILE
add_fileset_file fp_sqrt_s5.vhd VHDL PATH $::env(ALTERAOCLSDKROOT)/ip/fp_sqrt_s5.vhd TOP_LEVEL_FILE
add_fileset_file fp_sqrt_s5_memoryC0_uid59_sqrtTableGenerator_lutmem.hex HEX PATH $::env(ALTERAOCLSDKROOT)/ip/fp_sqrt_s5_memoryC0_uid59_sqrtTableGenerator_lutmem.hex TOP_LEVEL_FILE
add_fileset_file fp_sqrt_s5_memoryC1_uid60_sqrtTableGenerator_lutmem.hex HEX PATH $::env(ALTERAOCLSDKROOT)/ip/fp_sqrt_s5_memoryC1_uid60_sqrtTableGenerator_lutmem.hex TOP_LEVEL_FILE
add_fileset_file fp_sqrt_s5_memoryC2_uid61_sqrtTableGenerator_lutmem.hex HEX PATH $::env(ALTERAOCLSDKROOT)/ip/fp_sqrt_s5_memoryC2_uid61_sqrtTableGenerator_lutmem.hex TOP_LEVEL_FILE
add_fileset_file acl_fp_exp_a10_top.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_fp_exp_a10_top.v TOP_LEVEL_FILE
add_fileset_file acl_fp_exp_a10.vhd VHDL PATH $::env(ALTERAOCLSDKROOT)/ip/acl_fp_exp_a10.vhd TOP_LEVEL_FILE
add_fileset_file acl_fp_exp_a10_450.vhd VHDL PATH $::env(ALTERAOCLSDKROOT)/ip/acl_fp_exp_a10_450.vhd TOP_LEVEL_FILE
add_fileset_file acl_fp_exp_a10_450_floatTable_eA_uid96_fpExpETest_lutmem.hex HEX PATH $::env(ALTERAOCLSDKROOT)/ip/acl_fp_exp_a10_450_floatTable_eA_uid96_fpExpETest_lutmem.hex TOP_LEVEL_FILE
add_fileset_file acl_fp_exp_a10_450_floatTable_kPPreZHigh_uid62_fpExpETest_lutmem.hex HEX PATH $::env(ALTERAOCLSDKROOT)/ip/acl_fp_exp_a10_450_floatTable_kPPreZHigh_uid62_fpExpETest_lutmem.hex TOP_LEVEL_FILE
add_fileset_file acl_fp_exp_a10_450_floatTable_kPPreZLow_uid65_fpExpETest_lutmem.hex HEX PATH $::env(ALTERAOCLSDKROOT)/ip/acl_fp_exp_a10_450_floatTable_kPPreZLow_uid65_fpExpETest_lutmem.hex TOP_LEVEL_FILE
add_fileset_file acl_fp_exp_a10_floatTable_eA_uid96_fpExpETest_lutmem.hex HEX PATH $::env(ALTERAOCLSDKROOT)/ip/acl_fp_exp_a10_floatTable_eA_uid96_fpExpETest_lutmem.hex TOP_LEVEL_FILE
add_fileset_file acl_fp_exp_a10_floatTable_kPPreZHigh_uid62_fpExpETest_lutmem.hex HEX PATH $::env(ALTERAOCLSDKROOT)/ip/acl_fp_exp_a10_floatTable_kPPreZHigh_uid62_fpExpETest_lutmem.hex TOP_LEVEL_FILE
add_fileset_file acl_fp_exp_a10_floatTable_kPPreZLow_uid65_fpExpETest_lutmem.hex HEX PATH $::env(ALTERAOCLSDKROOT)/ip/acl_fp_exp_a10_floatTable_kPPreZLow_uid65_fpExpETest_lutmem.hex TOP_LEVEL_FILE
add_fileset_file acl_fp_div_s5.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_fp_div_s5.v TOP_LEVEL_FILE
add_fileset_file acl_fp_div_s5.hex HEX PATH $::env(ALTERAOCLSDKROOT)/ip/acl_fp_div_s5.hex TOP_LEVEL_FILE
add_fileset_file acl_arb2.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_arb2.v TOP_LEVEL_FILE
add_fileset_file acl_arb_intf.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_arb_intf.v TOP_LEVEL_FILE
add_fileset_file acl_avm_to_ic.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_avm_to_ic.v TOP_LEVEL_FILE
add_fileset_file acl_ic_intf.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_ic_intf.v TOP_LEVEL_FILE
add_fileset_file acl_ic_master_endpoint.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_ic_master_endpoint.v TOP_LEVEL_FILE
add_fileset_file acl_ic_slave_endpoint.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_ic_slave_endpoint.v TOP_LEVEL_FILE
add_fileset_file acl_ic_slave_rrp.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_ic_slave_rrp.v TOP_LEVEL_FILE
add_fileset_file acl_ic_slave_wrp.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_ic_slave_wrp.v TOP_LEVEL_FILE
add_fileset_file acl_ic_rrp_reg.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_ic_rrp_reg.v TOP_LEVEL_FILE
add_fileset_file acl_ic_wrp_reg.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_ic_wrp_reg.v TOP_LEVEL_FILE
add_fileset_file acl_ic_to_avm.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_ic_to_avm.v TOP_LEVEL_FILE
add_fileset_file acl_atomics_nostall.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_atomics_nostall.v TOP_LEVEL_FILE
add_fileset_file acl_atomics_arb_stall.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_atomics_arb_stall.v TOP_LEVEL_FILE
add_fileset_file lsu_ic_top.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/lsu_ic_top.v TOP_LEVEL_FILE
add_fileset_file acl_mem2x.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_mem2x.v TOP_LEVEL_FILE
add_fileset_file acl_mem_staging_reg.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_mem_staging_reg.v TOP_LEVEL_FILE
add_fileset_file acl_address_to_bankaddress.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_address_to_bankaddress.v TOP_LEVEL_FILE
add_fileset_file acl_ic_local_mem_router.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_ic_local_mem_router.v TOP_LEVEL_FILE
add_fileset_file acl_ic_local_mem_router_terminator.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_ic_local_mem_router_terminator.v TOP_LEVEL_FILE
add_fileset_file acl_mem1x.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_mem1x.v TOP_LEVEL_FILE
add_fileset_file acl_channel_fifo.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_channel_fifo.v TOP_LEVEL_FILE


add_fileset SIM_VERILOG SIM_VERILOG "" ""
set_fileset_property SIM_VERILOG TOP_LEVEL Krnl_GA_system
add_fileset_file acl_work_group_dispatcher.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_work_group_dispatcher.v TOP_LEVEL_FILE
add_fileset_file acl_id_iterator.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_id_iterator.v TOP_LEVEL_FILE
add_fileset_file acl_work_item_iterator.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_work_item_iterator.v TOP_LEVEL_FILE
add_fileset_file acl_multistage_adder.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_multistage_adder.v TOP_LEVEL_FILE
add_fileset_file acl_start_signal_chain_element.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_start_signal_chain_element.v TOP_LEVEL_FILE
add_fileset_file acl_finish_signal_chain_element.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_finish_signal_chain_element.v TOP_LEVEL_FILE
add_fileset_file acl_task_copy_finish_detector.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_task_copy_finish_detector.v TOP_LEVEL_FILE
add_fileset_file acl_kernel_finish_detector.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_kernel_finish_detector.v TOP_LEVEL_FILE
add_fileset_file acl_multistage_accumulator.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_multistage_accumulator.v TOP_LEVEL_FILE
add_fileset_file acl_fifo.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_fifo.v TOP_LEVEL_FILE
add_fileset_file acl_shift_register.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_shift_register.v TOP_LEVEL_FILE
add_fileset_file lsu_top.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/lsu_top.v TOP_LEVEL_FILE
add_fileset_file acl_staging_reg.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_staging_reg.v TOP_LEVEL_FILE
add_fileset_file acl_ll_fifo.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_ll_fifo.v TOP_LEVEL_FILE
add_fileset_file lsu_pipelined.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/lsu_pipelined.v TOP_LEVEL_FILE
add_fileset_file lsu_enabled.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/lsu_enabled.v TOP_LEVEL_FILE
add_fileset_file lsu_basic_coalescer.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/lsu_basic_coalescer.v TOP_LEVEL_FILE
add_fileset_file lsu_simple.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/lsu_simple.v TOP_LEVEL_FILE
add_fileset_file acl_data_fifo.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_data_fifo.v TOP_LEVEL_FILE
add_fileset_file lsu_streaming.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/lsu_streaming.v TOP_LEVEL_FILE
add_fileset_file lsu_burst_master.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/lsu_burst_master.v TOP_LEVEL_FILE
add_fileset_file lsu_bursting_load_stores.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/lsu_bursting_load_stores.v TOP_LEVEL_FILE
add_fileset_file lsu_non_aligned_write.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/lsu_non_aligned_write.v TOP_LEVEL_FILE
add_fileset_file lsu_read_cache.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/lsu_read_cache.v TOP_LEVEL_FILE
add_fileset_file lsu_atomic.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/lsu_atomic.v TOP_LEVEL_FILE
add_fileset_file lsu_prefetch_block.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/lsu_prefetch_block.v TOP_LEVEL_FILE
add_fileset_file lsu_wide_wrapper.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/lsu_wide_wrapper.v TOP_LEVEL_FILE
add_fileset_file lsu_streaming_prefetch.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/lsu_streaming_prefetch.v TOP_LEVEL_FILE
add_fileset_file lsu_permute_address.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/lsu_permute_address.v TOP_LEVEL_FILE
add_fileset_file acl_aligned_burst_coalesced_lsu.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_aligned_burst_coalesced_lsu.v TOP_LEVEL_FILE
add_fileset_file acl_push.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_push.v TOP_LEVEL_FILE
add_fileset_file acl_token_fifo_counter.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_token_fifo_counter.v TOP_LEVEL_FILE
add_fileset_file acl_ll_ram_fifo.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_ll_ram_fifo.v TOP_LEVEL_FILE
add_fileset_file acl_valid_fifo_counter.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_valid_fifo_counter.v TOP_LEVEL_FILE
add_fileset_file acl_pipeline.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_pipeline.v TOP_LEVEL_FILE
add_fileset_file st_top.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/st_top.v TOP_LEVEL_FILE
add_fileset_file acl_pop.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_pop.v TOP_LEVEL_FILE
add_fileset_file acl_enable_sink.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_enable_sink.v TOP_LEVEL_FILE
add_fileset_file acl_printf_buffer_address_generator.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_printf_buffer_address_generator.v TOP_LEVEL_FILE
add_fileset_file acl_full_detector.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_full_detector.v TOP_LEVEL_FILE
add_fileset_file acl_stall_free_sink.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_stall_free_sink.v TOP_LEVEL_FILE
add_fileset_file acl_fp_mul_a10.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_fp_mul_a10.v TOP_LEVEL_FILE
add_fileset_file acl_fp_sincos_s5.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_fp_sincos_s5.v TOP_LEVEL_FILE
add_fileset_file dspba_library_package.vhd VHDL PATH $::env(ALTERAOCLSDKROOT)/ip/dspba_library_package.vhd TOP_LEVEL_FILE
add_fileset_file dspba_library.vhd VHDL PATH $::env(ALTERAOCLSDKROOT)/ip/dspba_library.vhd TOP_LEVEL_FILE
add_fileset_file fp_sincos_s5.vhd VHDL PATH $::env(ALTERAOCLSDKROOT)/ip/fp_sincos_s5.vhd TOP_LEVEL_FILE
add_fileset_file fp_sincos_s5_memoryC0_uid394_tableGensinPiZ_lutmem.hex HEX PATH $::env(ALTERAOCLSDKROOT)/ip/fp_sincos_s5_memoryC0_uid394_tableGensinPiZ_lutmem.hex TOP_LEVEL_FILE
add_fileset_file fp_sincos_s5_memoryC0_uid400_tableGencosPiZ_lutmem.hex HEX PATH $::env(ALTERAOCLSDKROOT)/ip/fp_sincos_s5_memoryC0_uid400_tableGencosPiZ_lutmem.hex TOP_LEVEL_FILE
add_fileset_file fp_sincos_s5_memoryC1_uid396_tableGensinPiZ_lutmem.hex HEX PATH $::env(ALTERAOCLSDKROOT)/ip/fp_sincos_s5_memoryC1_uid396_tableGensinPiZ_lutmem.hex TOP_LEVEL_FILE
add_fileset_file fp_sincos_s5_memoryC1_uid402_tableGencosPiZ_lutmem.hex HEX PATH $::env(ALTERAOCLSDKROOT)/ip/fp_sincos_s5_memoryC1_uid402_tableGencosPiZ_lutmem.hex TOP_LEVEL_FILE
add_fileset_file fp_sincos_s5_memoryC2_uid398_tableGensinPiZ_lutmem.hex HEX PATH $::env(ALTERAOCLSDKROOT)/ip/fp_sincos_s5_memoryC2_uid398_tableGensinPiZ_lutmem.hex TOP_LEVEL_FILE
add_fileset_file fp_sincos_s5_memoryC2_uid404_tableGencosPiZ_lutmem.hex HEX PATH $::env(ALTERAOCLSDKROOT)/ip/fp_sincos_s5_memoryC2_uid404_tableGencosPiZ_lutmem.hex TOP_LEVEL_FILE
add_fileset_file fp_sincos_s5_rrTable_uid194_rrx_uid34_fpSinCosXTest_lutmem.hex HEX PATH $::env(ALTERAOCLSDKROOT)/ip/fp_sincos_s5_rrTable_uid194_rrx_uid34_fpSinCosXTest_lutmem.hex TOP_LEVEL_FILE
add_fileset_file fp_sincos_s5_rrTable_uid195_rrx_uid34_fpSinCosXTest_lutmem.hex HEX PATH $::env(ALTERAOCLSDKROOT)/ip/fp_sincos_s5_rrTable_uid195_rrx_uid34_fpSinCosXTest_lutmem.hex TOP_LEVEL_FILE
add_fileset_file acl_fp_dot2_a10.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_fp_dot2_a10.v TOP_LEVEL_FILE
add_fileset_file acl_fp_mdot2_a10.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_fp_mdot2_a10.v TOP_LEVEL_FILE
add_fileset_file acl_fp_multadd_a10.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_fp_multadd_a10.v TOP_LEVEL_FILE
add_fileset_file acl_fp_sub_a10.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_fp_sub_a10.v TOP_LEVEL_FILE
add_fileset_file acl_fp_add_a10.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_fp_add_a10.v TOP_LEVEL_FILE
add_fileset_file acl_loop_limiter.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_loop_limiter.v TOP_LEVEL_FILE
add_fileset_file acl_work_group_limiter.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_work_group_limiter.v TOP_LEVEL_FILE
add_fileset_file acl_toggle_detect.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_toggle_detect.v TOP_LEVEL_FILE
add_fileset_file acl_debug_mem.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_debug_mem.v TOP_LEVEL_FILE
add_fileset_file acl_printf_counter.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_printf_counter.v TOP_LEVEL_FILE
add_fileset_file Krnl_GA.v SYSTEM_VERILOG PATH Krnl_GA.v TOP_LEVEL_FILE
add_fileset_file Krnl_GA_system.v SYSTEM_VERILOG PATH Krnl_GA_system.v TOP_LEVEL_FILE
add_fileset_file acl_fp_uitofp.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_fp_uitofp.v TOP_LEVEL_FILE
add_fileset_file acl_int_mult.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_int_mult.v TOP_LEVEL_FILE
add_fileset_file sv_mult27.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/sv_mult27.v TOP_LEVEL_FILE
add_fileset_file acl_merge_node_priority_encoder_workgroup.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_merge_node_priority_encoder_workgroup.v TOP_LEVEL_FILE
add_fileset_file acl_fp_cmp.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_fp_cmp.v TOP_LEVEL_FILE
add_fileset_file acl_fp_fptoui.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_fp_fptoui.v TOP_LEVEL_FILE
add_fileset_file acl_embedded_workgroup_issuer.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_embedded_workgroup_issuer.v TOP_LEVEL_FILE
add_fileset_file acl_embedded_workgroup_issuer_complex.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_embedded_workgroup_issuer_complex.v TOP_LEVEL_FILE
add_fileset_file acl_embedded_workgroup_issuer_fifo.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_embedded_workgroup_issuer_fifo.v TOP_LEVEL_FILE
add_fileset_file acl_barrier.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_barrier.v TOP_LEVEL_FILE
add_fileset_file acl_barrier_simple.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_barrier_simple.v TOP_LEVEL_FILE
add_fileset_file acl_fifo_reorder.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_fifo_reorder.v TOP_LEVEL_FILE
add_fileset_file acl_fp_sitofp.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_fp_sitofp.v TOP_LEVEL_FILE
add_fileset_file acl_fp_floor.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_fp_floor.v TOP_LEVEL_FILE
add_fileset_file acl_fp_ceil.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_fp_ceil.v TOP_LEVEL_FILE
add_fileset_file acl_fp_convert_with_rounding.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_fp_convert_with_rounding.v TOP_LEVEL_FILE
add_fileset_file acl_fp_accum_a10.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_fp_accum_a10.v TOP_LEVEL_FILE
add_fileset_file acl_fp_sqrt_s5.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_fp_sqrt_s5.v TOP_LEVEL_FILE
add_fileset_file fp_sqrt_s5.vhd VHDL PATH $::env(ALTERAOCLSDKROOT)/ip/fp_sqrt_s5.vhd TOP_LEVEL_FILE
add_fileset_file fp_sqrt_s5_memoryC0_uid59_sqrtTableGenerator_lutmem.hex HEX PATH $::env(ALTERAOCLSDKROOT)/ip/fp_sqrt_s5_memoryC0_uid59_sqrtTableGenerator_lutmem.hex TOP_LEVEL_FILE
add_fileset_file fp_sqrt_s5_memoryC1_uid60_sqrtTableGenerator_lutmem.hex HEX PATH $::env(ALTERAOCLSDKROOT)/ip/fp_sqrt_s5_memoryC1_uid60_sqrtTableGenerator_lutmem.hex TOP_LEVEL_FILE
add_fileset_file fp_sqrt_s5_memoryC2_uid61_sqrtTableGenerator_lutmem.hex HEX PATH $::env(ALTERAOCLSDKROOT)/ip/fp_sqrt_s5_memoryC2_uid61_sqrtTableGenerator_lutmem.hex TOP_LEVEL_FILE
add_fileset_file acl_fp_exp_a10_top.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_fp_exp_a10_top.v TOP_LEVEL_FILE
add_fileset_file acl_fp_exp_a10.vhd VHDL PATH $::env(ALTERAOCLSDKROOT)/ip/acl_fp_exp_a10.vhd TOP_LEVEL_FILE
add_fileset_file acl_fp_exp_a10_450.vhd VHDL PATH $::env(ALTERAOCLSDKROOT)/ip/acl_fp_exp_a10_450.vhd TOP_LEVEL_FILE
add_fileset_file acl_fp_exp_a10_450_floatTable_eA_uid96_fpExpETest_lutmem.hex HEX PATH $::env(ALTERAOCLSDKROOT)/ip/acl_fp_exp_a10_450_floatTable_eA_uid96_fpExpETest_lutmem.hex TOP_LEVEL_FILE
add_fileset_file acl_fp_exp_a10_450_floatTable_kPPreZHigh_uid62_fpExpETest_lutmem.hex HEX PATH $::env(ALTERAOCLSDKROOT)/ip/acl_fp_exp_a10_450_floatTable_kPPreZHigh_uid62_fpExpETest_lutmem.hex TOP_LEVEL_FILE
add_fileset_file acl_fp_exp_a10_450_floatTable_kPPreZLow_uid65_fpExpETest_lutmem.hex HEX PATH $::env(ALTERAOCLSDKROOT)/ip/acl_fp_exp_a10_450_floatTable_kPPreZLow_uid65_fpExpETest_lutmem.hex TOP_LEVEL_FILE
add_fileset_file acl_fp_exp_a10_floatTable_eA_uid96_fpExpETest_lutmem.hex HEX PATH $::env(ALTERAOCLSDKROOT)/ip/acl_fp_exp_a10_floatTable_eA_uid96_fpExpETest_lutmem.hex TOP_LEVEL_FILE
add_fileset_file acl_fp_exp_a10_floatTable_kPPreZHigh_uid62_fpExpETest_lutmem.hex HEX PATH $::env(ALTERAOCLSDKROOT)/ip/acl_fp_exp_a10_floatTable_kPPreZHigh_uid62_fpExpETest_lutmem.hex TOP_LEVEL_FILE
add_fileset_file acl_fp_exp_a10_floatTable_kPPreZLow_uid65_fpExpETest_lutmem.hex HEX PATH $::env(ALTERAOCLSDKROOT)/ip/acl_fp_exp_a10_floatTable_kPPreZLow_uid65_fpExpETest_lutmem.hex TOP_LEVEL_FILE
add_fileset_file acl_fp_div_s5.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_fp_div_s5.v TOP_LEVEL_FILE
add_fileset_file acl_fp_div_s5.hex HEX PATH $::env(ALTERAOCLSDKROOT)/ip/acl_fp_div_s5.hex TOP_LEVEL_FILE
add_fileset_file acl_arb2.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_arb2.v TOP_LEVEL_FILE
add_fileset_file acl_arb_intf.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_arb_intf.v TOP_LEVEL_FILE
add_fileset_file acl_avm_to_ic.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_avm_to_ic.v TOP_LEVEL_FILE
add_fileset_file acl_ic_intf.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_ic_intf.v TOP_LEVEL_FILE
add_fileset_file acl_ic_master_endpoint.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_ic_master_endpoint.v TOP_LEVEL_FILE
add_fileset_file acl_ic_slave_endpoint.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_ic_slave_endpoint.v TOP_LEVEL_FILE
add_fileset_file acl_ic_slave_rrp.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_ic_slave_rrp.v TOP_LEVEL_FILE
add_fileset_file acl_ic_slave_wrp.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_ic_slave_wrp.v TOP_LEVEL_FILE
add_fileset_file acl_ic_rrp_reg.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_ic_rrp_reg.v TOP_LEVEL_FILE
add_fileset_file acl_ic_wrp_reg.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_ic_wrp_reg.v TOP_LEVEL_FILE
add_fileset_file acl_ic_to_avm.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_ic_to_avm.v TOP_LEVEL_FILE
add_fileset_file acl_atomics_nostall.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_atomics_nostall.v TOP_LEVEL_FILE
add_fileset_file acl_atomics_arb_stall.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_atomics_arb_stall.v TOP_LEVEL_FILE
add_fileset_file lsu_ic_top.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/lsu_ic_top.v TOP_LEVEL_FILE
add_fileset_file acl_mem2x.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_mem2x.v TOP_LEVEL_FILE
add_fileset_file acl_mem_staging_reg.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_mem_staging_reg.v TOP_LEVEL_FILE
add_fileset_file acl_address_to_bankaddress.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_address_to_bankaddress.v TOP_LEVEL_FILE
add_fileset_file acl_ic_local_mem_router.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_ic_local_mem_router.v TOP_LEVEL_FILE
add_fileset_file acl_ic_local_mem_router_terminator.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_ic_local_mem_router_terminator.v TOP_LEVEL_FILE
add_fileset_file acl_mem1x.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_mem1x.v TOP_LEVEL_FILE
add_fileset_file acl_channel_fifo.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_channel_fifo.v TOP_LEVEL_FILE
