module led4_reg(
	input		clk, 
	input		rst, 
	output reg [11:0] led
);
parameter BASE_LED_SEQUENCE = 12'b000011101101;

reg [11:0] led_value;
reg [3:0] circle_count;
reg [27:0] count;

always @(posedge clk or negedge rst)
begin
	if (!rst) begin
		count <= 0;
		circle_count <= 0;
	end else begin
		count <= count + 1'b1;
		if (count[24] == 1) begin	
			count <= 1'b0;
			circle_count <= circle_count + 1'b1;
		end

		if (circle_count == 12)
			circle_count <= 0;		
	end
end

always @(led) begin
	led_value <= led;
end

always @(circle_count or led_value)
begin
	case (circle_count)
		0: led <= BASE_LED_SEQUENCE;
		1,2,3,4: led <= (led_value << 1);
		5:  led <= 12'b110110100001;
		6:  led <= 12'b101101000011;
		7:  led <= 12'b011010000111;
		8:  led <= 12'b110100001110;
		9:  led <= 12'b101000011101;
		10: led <= 12'b010000111011;
		11: led <= 12'b100001110110;
		default: led <= 12'b000_000_000_000;
	endcase
end

endmodule
