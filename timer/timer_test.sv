`include "timer.sv"

module main();

function[7:0] mod10;
	input [5:0] a;
	mod10 = div10(a / 10);
endfunction	

function[7:0] div10;
	input [5:0] a;
	case (a % 10)
		1:  div10 = `NUMBER_1;
		2:  div10 = `NUMBER_2;
		3:  div10 = `NUMBER_3;
		4:  div10 = `NUMBER_4;
		5:  div10 = `NUMBER_5;
		6:  div10 = `NUMBER_6;
		7:  div10 = `NUMBER_7;
		8:  div10 = `NUMBER_8;
		9:  div10 = `NUMBER_9;
		default: div10 = `NUMBER_0;
	endcase
endfunction
	
reg clk, rst;
wire [7:0] number;
wire [5:0] digit_block;

timer t1(clk, rst, number, digit_block);

initial begin
	clk = 0;
	$display("div: %d", ((10400000 % 100000) == 0));
	
	$display("div 50: %b", div10(50));
	$display("div 51: %b", div10(51));
	$display("div 5:  %b", div10(5));
	$display("mod 51:  %b", mod10(51));
	$monitor($time, "  %b", digit_block);
	forever #1 clk = ~clk; 
end

initial #8200 $finish; 

endmodule
