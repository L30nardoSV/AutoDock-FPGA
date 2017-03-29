// synopsys translate_off
`timescale 1 ps / 1 ps
// synopsys translate_on
module acl_fp_sqrt_s5 (
	enable,
	clock,
	dataa,
	result);

	input	  enable;
	input	  clock;
	input	[31:0]  dataa;
	output	[31:0]  result;
  
  reg areset;
  initial
  begin
     #0 areset = 1'b1;
     #5 areset = 1'b0;
  end

	wire [31:0] sub_wire0;
	wire [31:0] result = sub_wire0[31:0];

	fp_sqrt_s5	inst(
				.clk(clock),
        .en(enable),
				.areset(areset),
				.a (dataa),
				.q (sub_wire0));

endmodule
