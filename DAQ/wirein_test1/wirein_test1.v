module wirein_test1
(
	input      hi_in,
	output     hi_out,
	inout      hi_inout,
	output     hi_muxsel,
	input			clock,
	input			clock2
);

wire [7:0]  hi_in;
wire [1:0]  hi_out;
wire [15:0] hi_inout;
wire        hi_muxsel;
//wire [7:0]  led;

assign      hi_muxsel=1'b0;
// Opal Kelly Module Interface Connections
wire        ti_clk;
wire [30:0] ok1;
wire [16:0] ok2;

// Endpoint connections:
wire [15:0]  ep00wire;
wire reset;
wire [15:0]  ep01wire;
wire enable;
wire [15:0]  ep02wire;
wire reset_transfer;


wire [15:0]  epA3pipe;
wire         epA3read;
wire         epA3_blockSTROBE;
wire         epA3_ready;

wire [6:0] data_out;

assign reset = ep00wire[0];
assign enable = ep01wire[0];
assign reset_transfer = ep02wire[0];

ramp test (
	.reset	(reset),
	.enable	(enable),
	.data_out	(data_out),
	.clock	(clock)
);

CIC_data_transferFIFO transfer (
	.reset (reset),
	.write_clk (clock),
	.read_clk (clock2),
	.data_in ({9'd0, data_out}),
	.ep_read (epA3read),
	.data_out (epA3pipe),
	.ep_ready  (epA3_ready)
);

okHost okHI(
	.hi_in(hi_in), .hi_out(hi_out), .hi_inout(hi_inout), .ti_clk(ti_clk),
	.ok1(ok1), .ok2(ok2));

okWireIn     ep00 (.ok1(ok1),                          .ep_addr(8'h00), .ep_dataout(ep00wire));
okWireIn     ep01 (.ok1(ok1),                          .ep_addr(8'h01), .ep_dataout(ep01wire));
okWireIn     ep02 (.ok1(ok1),                          .ep_addr(8'h02), .ep_dataout(ep02wire));



// okBTPipeOut pipeOutA3 (.ok1(ok1), .ok2(ok2) .ep_addr(8’ha3), .ep_datain(epA3pipe), .ep_read(epA3read), .ep_blockstrobe(epA3strobe), .ep_ready(epA3ready)); 
// okBTPipeOut pipeOutA3 (.ok1(ok1), .ok2(ok2), .ep_addr(8'h00), .ep_datain(ep00pipe), .ep_read(ep00read), .ep_blockstrobe(ep00strobe), .ep_ready(ep00ready)); 
okBTPipeOut  BTpipeOutA3 (.ok1(ok1), .ok2(ok2), .ep_addr(8'ha3), .ep_datain(epA3pipe), .ep_read(epA3read),  .ep_blockstrobe(epA3_blockSTROBE), .ep_ready(epA3_ready));

endmodule