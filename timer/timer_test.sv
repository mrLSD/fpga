`include "timer.sv"
/*
module reglight(clk, regled);
parameter BASE_LED_SEQUENCE = 12'b000011101101;
input clk;
output [11:0] regled;


reg [3:0] count;	
reg [11:0] regled;

initial begin
	count = 0;
	regled = 0;
	regled = ~regled;
	$monitor($time, " led = %b count = %d", regled, count);
end

always @(posedge clk) begin
	count = count + 1;
	if (count == 12) begin
		count = 0;
	end
end

always @(count)
begin
	case (count)
		0: regled <= BASE_LED_SEQUENCE;
		1,2,3,4: regled <= (regled << 1);

//		1: regled <= (BASE_LED_SEQUENCE << 1);
//		2: regled <= (BASE_LED_SEQUENCE << 2);
//		3: regled <= (BASE_LED_SEQUENCE << 3);
//		4: regled <= (BASE_LED_SEQUENCE << 4);

//		1:  regled <= 12'b000111011010;
//		2:  regled <= 12'b001110110100;
//		3:  regled <= 12'b011101101000;
//		4:  regled <= 12'b111011010000;
		5:  regled <= 12'b110110100001;
		6:  regled <= 12'b101101000011;
		7:  regled <= 12'b011010000111;
		8:  regled <= 12'b110100001110;
		9:  regled <= 12'b101000011101;
		10: regled <= 12'b010000111011;
		11: regled <= 12'b100001110110;
		default: regled <= 12'b000_111_111_111;
	endcase
end

endmodule
*/
module main();
	
reg clk;
wire [11:0] leds;

led4_reg reglight(clk, leds);

initial begin
	clk = 0;
	forever #1 clk = ~clk; 
end

initial #160_000_000 $finish; 

endmodule
