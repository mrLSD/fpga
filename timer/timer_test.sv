`include "timer.sv"

module main();
	
reg clk;

timer reglight(clk, leds);

initial begin
	clk = 0;
	forever #1 clk = ~clk; 
end

initial #160 $finish; 

endmodule
