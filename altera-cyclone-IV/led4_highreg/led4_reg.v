module led4_reg(
	input		clk, 
	input		rst, 
	input		direction,
	output reg [11:0] led
);
parameter BASE_LED_SEQUENCE = ~12'b001100110010;

reg [27:0] count;
reg direct;

always @(posedge clk or negedge rst)
begin
	if (!rst) begin
		count <= 0;
		led <= BASE_LED_SEQUENCE;
	end else begin
		count <= count + 1'b1;
		if (count[24] == 1) begin
			count <= 0;
			if (direct == 0) 
				led <= {led[10:0], led[11]};
			else
				led <= {led[0], led[11:1]};
		end
	end
end

always @(negedge rst or negedge direction) begin
	//direct <= !direction ? ~direct : (!rst ? 0: direct);
	if (!rst) 
		direct <= 0; 
	else if (!direction) begin
		direct <= ~direct;
	end
end

endmodule
