`include "const.sv"

module timer (
	input clk, rst,
	output reg [7:0] number,	
	output reg [5:0] digit_block
);

reg [24:0] count = 1'b0;
reg [5:0] hours, minutes, seconds = 1'b0;
reg timer_enabled = 1'b0;

always @(posedge clk or negedge rst) begin
	if (!rst) begin
		count <= 0;
		timer_enabled <= 0;
		seconds <= 0;
		minutes <= 0;
		hours <= 0;
	end else if (timer_enabled) begin
		count <= count + 1'b1;
		if (count == 25_000_000) begin
			seconds <= seconds + 1'b1;
			if (seconds == 60) begin
				seconds <= 0;
				minutes <= minutes + 1'b1;
				if (minutes == 60) begin
					minutes <= 0;
					hours <= hours + 1'b1;
					if (hours == 24)
						hours <= 0; 
				end 
			end 
		end 
	end
end

always @(count) begin
	if (count[16:13] == 0)
		digit_block <= 6'b111110;
	else
		digit_block <= {digit_block[4:0], digit_block[5]};
end

always @(seconds) begin
	number <= `NUMBER_7;
end

endmodule
