`timescale 1ns/100ps
module clock;

	reg reset;
	reg enable;
	wire [6:0] data_out;
	reg clock;
	


ramp test (
	.reset	(reset),
	.enable	(enable),
	.data_out	(data_out),
	.clock	(clock)
);

initial
begin
	reset = 0;
	clock = 0;
	enable = 0;
#1 reset = 1;
#1 reset = 0;
#5	enable = 1;
end

always
	#5 clock = !clock;
	
endmodule
