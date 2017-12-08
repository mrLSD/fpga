`include "libs/keys.sv"

module main();

reg clk;
reg button;
wire key_press;

debouncer debouncer_instance (
	.clk(clk),
	.button(button),
	.key_press(key_press)
);

initial begin
	clk = 0;
	forever #1 clk = ~clk; 
end

initial begin
	clk = 0;
	#2 button = 0;
	forever #20 button = ~button;
end

initial #300 $finish; 

endmodule
