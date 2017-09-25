`include "timer.sv"
`define DIGIT_LIMIT 2^15

module main();
	
reg clk, rst;
wire [7:0] number;
wire [5:0] digit_block;

timer t1(clk, rst, number, digit_block);

initial begin
	clk = 0;
	$monitor($time, "  %b", digit_block);
	forever #1 clk = ~clk; 
end

initial #8200 $finish; 

endmodule
