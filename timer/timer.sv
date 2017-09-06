`include "const.sv"

module timer (clk, rst, number, digit_block);

input clk, rst;
output [7:0] number;
output [5:0] digit_block;

reg [7:0] number;
reg [5:0] digit_block = `DIGIT_BLOCK_1;
reg [`CLOCK_LIMIT:0] count = 0;
reg [5:0] hours, minutes, seconds = 0;
reg [3:0] position;

always @(posedge clk or negedge rst) begin
	if (!rst) begin
		count <= 0;
		seconds <= 0;
		minutes <= 0;
		hours <= 0;
	end else /*if (timer_enabled)*/ begin
		count <= count + 1'b1;
		if (count[`CLOCK_LIMIT:`CLOCK_LIMIT-2] == 6) begin
			count <= 0;						
			if (seconds == 59) begin
				seconds <= 0;
				if (minutes == 59) begin
					minutes <= 0;
					if (hours == 23)
						hours <= 0; 
					else
						hours <= hours + 1'b1;
				end else
					minutes <= minutes + 1'b1;
			end else
				seconds <= seconds + 1'b1;
		end 
	end
end

reg [20:0] digit_count = 0;

always @(posedge clk) begin
	if (digit_count == `DIGIT_COUNT_LIMIT) begin
		digit_count <= 0;
		digit_block = {digit_block[4:0], digit_block[5]};
		
		case (digit_block)
			`DIGIT_BLOCK_1: number <= mod10(seconds);
			`DIGIT_BLOCK_2: number <= div10(seconds);
			`DIGIT_BLOCK_3: number <= mod10(minutes);
			`DIGIT_BLOCK_4: number <= div10(minutes);
			`DIGIT_BLOCK_5: number <= mod10(hours);
			`DIGIT_BLOCK_6: number <= div10(hours);
			default: number <= `NUMBER_7;
		endcase
		
	end else
		digit_count <= digit_count + 1'b1;
 
end

// Calculate first part of number
// and return number bitmap
function[7:0] div10;
	input [5:0] a;
	div10 = mod10(a / 10);
endfunction	

// Calculate second part of number
// and return number bitmap
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
