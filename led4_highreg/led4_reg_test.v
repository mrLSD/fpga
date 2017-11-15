module reglighn(
	input clk, 
	output [11:0] led
);

parameter BASE_LED_SEQUENCE = 12'b000011101101;

reg [3:0] count;	
reg [11:0] led;

initial begin
	count = 0;
	led = 0;
	led = ~led;
        $monitor($time, " led = %b count = %d", led, count);
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
		0: led <= BASE_LED_SEQUENCE;
		1,2,3,4: led <= (led << 1);
/*
		1: led <= (BASE_LED_SEQUENCE << 1);
		2: led <= (BASE_LED_SEQUENCE << 2);
		3: led <= (BASE_LED_SEQUENCE << 3);
		4: led <= (BASE_LED_SEQUENCE << 4);
*/
//		1:  led <= 12'b000111011010;
//		2:  led <= 12'b001110110100;
//		3:  led <= 12'b011101101000;
//		4:  led <= 12'b111011010000;
		5:  led <= 12'b110110100001;
		6:  led <= 12'b101101000011;
		7:  led <= 12'b011010000111;
		8:  led <= 12'b110100001110;
		9:  led <= 12'b101000011101;
		10: led <= 12'b010000111011;
		11: led <= 12'b100001110110;
		default: led <= 12'b000_111_111_111;
	endcase
end

endmodule

module main();
	
reg clk;
wire [11:0] led;

reglighn reglighn(clk, led);

initial begin
	clk = 0;
//	$monitor($time, " led = %b", led);
	forever #5 clk = ~clk; 
end

initial #150 $finish; 

endmodule
