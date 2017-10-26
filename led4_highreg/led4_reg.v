module led4_reg(
	input		clk, 
	input		rst, 
	input		direction,
	output reg [11:0] led
);
parameter BASE_LED_SEQUENCE = ~12'b001100110010;

reg [27:0] count;

always @(posedge clk or negedge rst)
begin
	if (!rst) begin
		count <= 0;
		led <= BASE_LED_SEQUENCE;
	end else begin
		count <= count + 1'b1;
		if (count[24] == 1) begin
			count <= 0;
			led <= {led[10:0], led[11]};
		end
	end
end

endmodule
