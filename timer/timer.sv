`include "const.sv"

module timer (
	input clk, rst,
	output reg [7:0] number,	
	output reg [5:0] digit_block
);

reg [`CLOCK_LIMIT:0] count = 1'b0;
reg [5:0] hours, minutes, seconds = 1'b0;
reg timer_enabled = 1'b0;

always @(posedge clk or negedge rst) begin
	if (!rst) begin
		count <= 0;
//		timer_enabled <= 0;
		seconds <= 0;
		minutes <= 0;
		hours <= 0;
	end else /*if (timer_enabled)*/ begin
		count <= count + 1'b1;
		if (count[`CLOCK_LIMIT:`CLOCK_LIMIT-2] == 6) begin
			count <= 0;
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
	if (count[15:12] == 0)
		digit_block <= 6'b111110;
	else
		digit_block <= {digit_block[4:0], digit_block[5]};
end

always @(seconds) begin
	case (seconds)
		1: number <= `NUMBER_1;
		2: number <= `NUMBER_2;
		3: number <= `NUMBER_3;
		4: number <= `NUMBER_4;
		5: number <= `NUMBER_5;
		6: number <= `NUMBER_6;
		7: number <= `NUMBER_7;
		8: number <= `NUMBER_8;
		9: number <= `NUMBER_9;
		default: number <= `NUMBER_0;
	endcase
end

function[7:0] div10;
	input [5:0] a;
	div10 = mod10(a / 10);
endfunction	

function[7:0] mod10;
	input [5:0] a;
	case (a % 10)
		1:  mod10 = `NUMBER_1;
		2:  mod10 = `NUMBER_2;
		3:  mod10 = `NUMBER_3;
		4:  mod10 = `NUMBER_4;
		5:  mod10 = `NUMBER_5;
		6:  mod10 = `NUMBER_6;
		7:  mod10 = `NUMBER_7;
		8:  mod10 = `NUMBER_8;
		9:  mod10 = `NUMBER_9;
		default: mod10 = `NUMBER_0;
	endcase
endfunction

endmodule
