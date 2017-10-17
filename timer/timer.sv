module timer (
	input clk, rst
);

always @(posedge clk or negedge rst) begin
	if (!rst) begin
	end else begin
	end
end

endmodule