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
			`DIGIT_BLOCK_3: number <= `NUMBER_3;
			`DIGIT_BLOCK_4: number <= `NUMBER_4;
			`DIGIT_BLOCK_5: number <= `NUMBER_5;
			`DIGIT_BLOCK_6: number <= `NUMBER_6;
			default: number <= `NUMBER_7;
		endcase
		
	end else
		digit_count <= digit_count + 1'b1;
 
end

/*
always @(count) begin
	if (count % 5000 == 0) begin
		if (cnt >= 6)
			cnt <= 0;
		else
			cnt <= cnt +1;
	end
	case (cnt)
		0: digit_block <= 6'b111110;
		1: digit_block <= 6'b111101;
		3: digit_block <= 6'b111011;
		4: digit_block <= 6'b110111;
		5: digit_block <= 6'b101111;
		6: digit_block <= 6'b011111;
		default: digit_block <= 6'b011111;
	endcase
	//digit_block = {digit_block[4:0], digit_block[5]};
 
	case (digit_block)
		`DIGIT_BLOCK_1: number <= `NUMBER_1;
		`DIGIT_BLOCK_2: number <= `NUMBER_2;
		`DIGIT_BLOCK_3: number <= `NUMBER_3;
		`DIGIT_BLOCK_4: number <= `NUMBER_4;
		`DIGIT_BLOCK_5: number <= `NUMBER_5;
		`DIGIT_BLOCK_6: number <= `NUMBER_6;
		default: number <= `NUMBER_7;
	endcase
end

always @(digit_block) begin
	case (digit_block)
		6'b111110: number = `NUMBER_1;
		6'b111101: number = `NUMBER_2;
		6'b111011: number = `NUMBER_3;
		6'b110111: number = `NUMBER_4;
		6'b101111: number = `NUMBER_5;
		6'b011111: number = `NUMBER_6;
		default: number = `NUMBER_1;
	endcase	
end*/

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
