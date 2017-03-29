// kernel_system_altera_mm_interconnect_161_dqoemoq.v

// This file was auto-generated from altera_mm_interconnect_hw.tcl.  If you edit it your changes
// will probably be lost.
// 
// Generated using ACDS version 16.1 196

`timescale 1 ps / 1 ps
module kernel_system_altera_mm_interconnect_161_dqoemoq (
		input  wire [30:0]  calc_initpop_system_avm_memgmem0_DDR_port_0_0_rw_address,          //            calc_initpop_system_avm_memgmem0_DDR_port_0_0_rw.address
		output wire         calc_initpop_system_avm_memgmem0_DDR_port_0_0_rw_waitrequest,      //                                                            .waitrequest
		input  wire [4:0]   calc_initpop_system_avm_memgmem0_DDR_port_0_0_rw_burstcount,       //                                                            .burstcount
		input  wire [63:0]  calc_initpop_system_avm_memgmem0_DDR_port_0_0_rw_byteenable,       //                                                            .byteenable
		input  wire         calc_initpop_system_avm_memgmem0_DDR_port_0_0_rw_read,             //                                                            .read
		output wire [511:0] calc_initpop_system_avm_memgmem0_DDR_port_0_0_rw_readdata,         //                                                            .readdata
		output wire         calc_initpop_system_avm_memgmem0_DDR_port_0_0_rw_readdatavalid,    //                                                            .readdatavalid
		input  wire         calc_initpop_system_avm_memgmem0_DDR_port_0_0_rw_write,            //                                                            .write
		input  wire [511:0] calc_initpop_system_avm_memgmem0_DDR_port_0_0_rw_writedata,        //                                                            .writedata
		input  wire         calc_initpop_system_clock_reset_reset_reset_bridge_in_reset_reset, // calc_initpop_system_clock_reset_reset_reset_bridge_in_reset.reset
		input  wire         clk_1x_out_clk_clk,                                                //                                              clk_1x_out_clk.clk
		output wire [30:0]  kernel_mem0_s0_address,                                            //                                              kernel_mem0_s0.address
		output wire         kernel_mem0_s0_write,                                              //                                                            .write
		output wire         kernel_mem0_s0_read,                                               //                                                            .read
		input  wire [511:0] kernel_mem0_s0_readdata,                                           //                                                            .readdata
		output wire [511:0] kernel_mem0_s0_writedata,                                          //                                                            .writedata
		output wire [4:0]   kernel_mem0_s0_burstcount,                                         //                                                            .burstcount
		output wire [63:0]  kernel_mem0_s0_byteenable,                                         //                                                            .byteenable
		input  wire         kernel_mem0_s0_readdatavalid,                                      //                                                            .readdatavalid
		input  wire         kernel_mem0_s0_waitrequest,                                        //                                                            .waitrequest
		output wire         kernel_mem0_s0_debugaccess                                         //                                                            .debugaccess
	);

	wire          calc_initpop_system_avm_memgmem0_ddr_port_0_0_rw_translator_avalon_universal_master_0_waitrequest;   // kernel_mem0_s0_translator:uav_waitrequest -> calc_initpop_system_avm_memgmem0_DDR_port_0_0_rw_translator:uav_waitrequest
	wire  [511:0] calc_initpop_system_avm_memgmem0_ddr_port_0_0_rw_translator_avalon_universal_master_0_readdata;      // kernel_mem0_s0_translator:uav_readdata -> calc_initpop_system_avm_memgmem0_DDR_port_0_0_rw_translator:uav_readdata
	wire          calc_initpop_system_avm_memgmem0_ddr_port_0_0_rw_translator_avalon_universal_master_0_debugaccess;   // calc_initpop_system_avm_memgmem0_DDR_port_0_0_rw_translator:uav_debugaccess -> kernel_mem0_s0_translator:uav_debugaccess
	wire   [30:0] calc_initpop_system_avm_memgmem0_ddr_port_0_0_rw_translator_avalon_universal_master_0_address;       // calc_initpop_system_avm_memgmem0_DDR_port_0_0_rw_translator:uav_address -> kernel_mem0_s0_translator:uav_address
	wire          calc_initpop_system_avm_memgmem0_ddr_port_0_0_rw_translator_avalon_universal_master_0_read;          // calc_initpop_system_avm_memgmem0_DDR_port_0_0_rw_translator:uav_read -> kernel_mem0_s0_translator:uav_read
	wire   [63:0] calc_initpop_system_avm_memgmem0_ddr_port_0_0_rw_translator_avalon_universal_master_0_byteenable;    // calc_initpop_system_avm_memgmem0_DDR_port_0_0_rw_translator:uav_byteenable -> kernel_mem0_s0_translator:uav_byteenable
	wire          calc_initpop_system_avm_memgmem0_ddr_port_0_0_rw_translator_avalon_universal_master_0_readdatavalid; // kernel_mem0_s0_translator:uav_readdatavalid -> calc_initpop_system_avm_memgmem0_DDR_port_0_0_rw_translator:uav_readdatavalid
	wire          calc_initpop_system_avm_memgmem0_ddr_port_0_0_rw_translator_avalon_universal_master_0_lock;          // calc_initpop_system_avm_memgmem0_DDR_port_0_0_rw_translator:uav_lock -> kernel_mem0_s0_translator:uav_lock
	wire          calc_initpop_system_avm_memgmem0_ddr_port_0_0_rw_translator_avalon_universal_master_0_write;         // calc_initpop_system_avm_memgmem0_DDR_port_0_0_rw_translator:uav_write -> kernel_mem0_s0_translator:uav_write
	wire  [511:0] calc_initpop_system_avm_memgmem0_ddr_port_0_0_rw_translator_avalon_universal_master_0_writedata;     // calc_initpop_system_avm_memgmem0_DDR_port_0_0_rw_translator:uav_writedata -> kernel_mem0_s0_translator:uav_writedata
	wire   [10:0] calc_initpop_system_avm_memgmem0_ddr_port_0_0_rw_translator_avalon_universal_master_0_burstcount;    // calc_initpop_system_avm_memgmem0_DDR_port_0_0_rw_translator:uav_burstcount -> kernel_mem0_s0_translator:uav_burstcount

	altera_merlin_master_translator #(
		.AV_ADDRESS_W                (31),
		.AV_DATA_W                   (512),
		.AV_BURSTCOUNT_W             (5),
		.AV_BYTEENABLE_W             (64),
		.UAV_ADDRESS_W               (31),
		.UAV_BURSTCOUNT_W            (11),
		.USE_READ                    (1),
		.USE_WRITE                   (1),
		.USE_BEGINBURSTTRANSFER      (0),
		.USE_BEGINTRANSFER           (0),
		.USE_CHIPSELECT              (0),
		.USE_BURSTCOUNT              (1),
		.USE_READDATAVALID           (1),
		.USE_WAITREQUEST             (1),
		.USE_READRESPONSE            (0),
		.USE_WRITERESPONSE           (0),
		.AV_SYMBOLS_PER_WORD         (64),
		.AV_ADDRESS_SYMBOLS          (1),
		.AV_BURSTCOUNT_SYMBOLS       (0),
		.AV_CONSTANT_BURST_BEHAVIOR  (1),
		.UAV_CONSTANT_BURST_BEHAVIOR (1),
		.AV_LINEWRAPBURSTS           (0),
		.AV_REGISTERINCOMINGSIGNALS  (0)
	) calc_initpop_system_avm_memgmem0_ddr_port_0_0_rw_translator (
		.clk                    (clk_1x_out_clk_clk),                                                                                  //                       clk.clk
		.reset                  (calc_initpop_system_clock_reset_reset_reset_bridge_in_reset_reset),                                   //                     reset.reset
		.uav_address            (calc_initpop_system_avm_memgmem0_ddr_port_0_0_rw_translator_avalon_universal_master_0_address),       // avalon_universal_master_0.address
		.uav_burstcount         (calc_initpop_system_avm_memgmem0_ddr_port_0_0_rw_translator_avalon_universal_master_0_burstcount),    //                          .burstcount
		.uav_read               (calc_initpop_system_avm_memgmem0_ddr_port_0_0_rw_translator_avalon_universal_master_0_read),          //                          .read
		.uav_write              (calc_initpop_system_avm_memgmem0_ddr_port_0_0_rw_translator_avalon_universal_master_0_write),         //                          .write
		.uav_waitrequest        (calc_initpop_system_avm_memgmem0_ddr_port_0_0_rw_translator_avalon_universal_master_0_waitrequest),   //                          .waitrequest
		.uav_readdatavalid      (calc_initpop_system_avm_memgmem0_ddr_port_0_0_rw_translator_avalon_universal_master_0_readdatavalid), //                          .readdatavalid
		.uav_byteenable         (calc_initpop_system_avm_memgmem0_ddr_port_0_0_rw_translator_avalon_universal_master_0_byteenable),    //                          .byteenable
		.uav_readdata           (calc_initpop_system_avm_memgmem0_ddr_port_0_0_rw_translator_avalon_universal_master_0_readdata),      //                          .readdata
		.uav_writedata          (calc_initpop_system_avm_memgmem0_ddr_port_0_0_rw_translator_avalon_universal_master_0_writedata),     //                          .writedata
		.uav_lock               (calc_initpop_system_avm_memgmem0_ddr_port_0_0_rw_translator_avalon_universal_master_0_lock),          //                          .lock
		.uav_debugaccess        (calc_initpop_system_avm_memgmem0_ddr_port_0_0_rw_translator_avalon_universal_master_0_debugaccess),   //                          .debugaccess
		.av_address             (calc_initpop_system_avm_memgmem0_DDR_port_0_0_rw_address),                                            //      avalon_anti_master_0.address
		.av_waitrequest         (calc_initpop_system_avm_memgmem0_DDR_port_0_0_rw_waitrequest),                                        //                          .waitrequest
		.av_burstcount          (calc_initpop_system_avm_memgmem0_DDR_port_0_0_rw_burstcount),                                         //                          .burstcount
		.av_byteenable          (calc_initpop_system_avm_memgmem0_DDR_port_0_0_rw_byteenable),                                         //                          .byteenable
		.av_read                (calc_initpop_system_avm_memgmem0_DDR_port_0_0_rw_read),                                               //                          .read
		.av_readdata            (calc_initpop_system_avm_memgmem0_DDR_port_0_0_rw_readdata),                                           //                          .readdata
		.av_readdatavalid       (calc_initpop_system_avm_memgmem0_DDR_port_0_0_rw_readdatavalid),                                      //                          .readdatavalid
		.av_write               (calc_initpop_system_avm_memgmem0_DDR_port_0_0_rw_write),                                              //                          .write
		.av_writedata           (calc_initpop_system_avm_memgmem0_DDR_port_0_0_rw_writedata),                                          //                          .writedata
		.av_beginbursttransfer  (1'b0),                                                                                                //               (terminated)
		.av_begintransfer       (1'b0),                                                                                                //               (terminated)
		.av_chipselect          (1'b0),                                                                                                //               (terminated)
		.av_lock                (1'b0),                                                                                                //               (terminated)
		.av_debugaccess         (1'b0),                                                                                                //               (terminated)
		.uav_clken              (),                                                                                                    //               (terminated)
		.av_clken               (1'b1),                                                                                                //               (terminated)
		.uav_response           (2'b00),                                                                                               //               (terminated)
		.av_response            (),                                                                                                    //               (terminated)
		.uav_writeresponsevalid (1'b0),                                                                                                //               (terminated)
		.av_writeresponsevalid  ()                                                                                                     //               (terminated)
	);

	altera_merlin_slave_translator #(
		.AV_ADDRESS_W                   (31),
		.AV_DATA_W                      (512),
		.UAV_DATA_W                     (512),
		.AV_BURSTCOUNT_W                (5),
		.AV_BYTEENABLE_W                (64),
		.UAV_BYTEENABLE_W               (64),
		.UAV_ADDRESS_W                  (31),
		.UAV_BURSTCOUNT_W               (11),
		.AV_READLATENCY                 (0),
		.USE_READDATAVALID              (1),
		.USE_WAITREQUEST                (1),
		.USE_UAV_CLKEN                  (0),
		.USE_READRESPONSE               (0),
		.USE_WRITERESPONSE              (0),
		.AV_SYMBOLS_PER_WORD            (64),
		.AV_ADDRESS_SYMBOLS             (1),
		.AV_BURSTCOUNT_SYMBOLS          (0),
		.AV_CONSTANT_BURST_BEHAVIOR     (0),
		.UAV_CONSTANT_BURST_BEHAVIOR    (0),
		.AV_REQUIRE_UNALIGNED_ADDRESSES (0),
		.CHIPSELECT_THROUGH_READLATENCY (0),
		.AV_READ_WAIT_CYCLES            (0),
		.AV_WRITE_WAIT_CYCLES           (0),
		.AV_SETUP_WAIT_CYCLES           (0),
		.AV_DATA_HOLD_CYCLES            (0)
	) kernel_mem0_s0_translator (
		.clk                    (clk_1x_out_clk_clk),                                                                                  //                      clk.clk
		.reset                  (calc_initpop_system_clock_reset_reset_reset_bridge_in_reset_reset),                                   //                    reset.reset
		.uav_address            (calc_initpop_system_avm_memgmem0_ddr_port_0_0_rw_translator_avalon_universal_master_0_address),       // avalon_universal_slave_0.address
		.uav_burstcount         (calc_initpop_system_avm_memgmem0_ddr_port_0_0_rw_translator_avalon_universal_master_0_burstcount),    //                         .burstcount
		.uav_read               (calc_initpop_system_avm_memgmem0_ddr_port_0_0_rw_translator_avalon_universal_master_0_read),          //                         .read
		.uav_write              (calc_initpop_system_avm_memgmem0_ddr_port_0_0_rw_translator_avalon_universal_master_0_write),         //                         .write
		.uav_waitrequest        (calc_initpop_system_avm_memgmem0_ddr_port_0_0_rw_translator_avalon_universal_master_0_waitrequest),   //                         .waitrequest
		.uav_readdatavalid      (calc_initpop_system_avm_memgmem0_ddr_port_0_0_rw_translator_avalon_universal_master_0_readdatavalid), //                         .readdatavalid
		.uav_byteenable         (calc_initpop_system_avm_memgmem0_ddr_port_0_0_rw_translator_avalon_universal_master_0_byteenable),    //                         .byteenable
		.uav_readdata           (calc_initpop_system_avm_memgmem0_ddr_port_0_0_rw_translator_avalon_universal_master_0_readdata),      //                         .readdata
		.uav_writedata          (calc_initpop_system_avm_memgmem0_ddr_port_0_0_rw_translator_avalon_universal_master_0_writedata),     //                         .writedata
		.uav_lock               (calc_initpop_system_avm_memgmem0_ddr_port_0_0_rw_translator_avalon_universal_master_0_lock),          //                         .lock
		.uav_debugaccess        (calc_initpop_system_avm_memgmem0_ddr_port_0_0_rw_translator_avalon_universal_master_0_debugaccess),   //                         .debugaccess
		.av_address             (kernel_mem0_s0_address),                                                                              //      avalon_anti_slave_0.address
		.av_write               (kernel_mem0_s0_write),                                                                                //                         .write
		.av_read                (kernel_mem0_s0_read),                                                                                 //                         .read
		.av_readdata            (kernel_mem0_s0_readdata),                                                                             //                         .readdata
		.av_writedata           (kernel_mem0_s0_writedata),                                                                            //                         .writedata
		.av_burstcount          (kernel_mem0_s0_burstcount),                                                                           //                         .burstcount
		.av_byteenable          (kernel_mem0_s0_byteenable),                                                                           //                         .byteenable
		.av_readdatavalid       (kernel_mem0_s0_readdatavalid),                                                                        //                         .readdatavalid
		.av_waitrequest         (kernel_mem0_s0_waitrequest),                                                                          //                         .waitrequest
		.av_debugaccess         (kernel_mem0_s0_debugaccess),                                                                          //                         .debugaccess
		.av_begintransfer       (),                                                                                                    //              (terminated)
		.av_beginbursttransfer  (),                                                                                                    //              (terminated)
		.av_writebyteenable     (),                                                                                                    //              (terminated)
		.av_lock                (),                                                                                                    //              (terminated)
		.av_chipselect          (),                                                                                                    //              (terminated)
		.av_clken               (),                                                                                                    //              (terminated)
		.uav_clken              (1'b0),                                                                                                //              (terminated)
		.av_outputenable        (),                                                                                                    //              (terminated)
		.uav_response           (),                                                                                                    //              (terminated)
		.av_response            (2'b00),                                                                                               //              (terminated)
		.uav_writeresponsevalid (),                                                                                                    //              (terminated)
		.av_writeresponsevalid  (1'b0)                                                                                                 //              (terminated)
	);

endmodule