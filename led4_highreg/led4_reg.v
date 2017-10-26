module led4_reg(clk, led);
parameter BASE_LED_SEQUENCE = 12'b000011101101;
input clk;
output [11:0] led;

reg [11:0] led;
reg [3:0] circle_count;

initial begin
	led = 0;
	count = 0;
	circle_count = 0;
	led <= ~led;
	$monitor($time, " led = %b count = %d", led, circle_count);
end

reg [27:0] count;

always @(posedge clk)
begin
	count <= count + 1;
	if (count[23] == 1) begin	
		count <= 0;
		circle_count <= circle_count + 1;
	end

	if (circle_count == 12)
		circle_count <= 0;		
end

always @(circle_count)
begin
	case (circle_count)
		0: led <= BASE_LED_SEQUENCE;
		1,2,3,4: led <= (led << 1);
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
