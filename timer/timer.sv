`include "const.sv"
`include "libs/keys.sv"

module timer (
	input wire 		clk, rst, key_pause, key_program,
	output wire 	[2:0] info_led,
	output reg		[2:0] program_led, 
	output reg 		[7:0] number,
	output reg 		[5:0] digit_block
);

reg [25:0] count = 0;
reg [5:0] hours, minutes, seconds = 0;
reg pause = 0;
reg press_kp = 0;
wire keypress_pause;

initial begin
	digit_block <= `DIGIT_BLOCK_1;
end

debouncer debouncer_keypause (
	.clk(clk),
	.button(key_pause),
	.key_press(keypress_pause)
);

// Main CLK loop
always @(posedge clk or negedge rst) begin
	if (!rst) begin
		count <= 0;
		seconds <= 0;
		minutes <= 0;
		hours <= 0;
	end else if (!pause) begin
		count <= count + 1'b1;
		if (count == `CLOCK_TIME_LIMIT) begin
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

assign info_led = {rst, keypress_pause, 1'b1};

reg [24:0] program_led_counter = 0;

always @(posedge clk) begin
	if (press_kp) begin
		program_led_counter <= program_led_counter + 1'b1;
		if (program_led_counter[24] == 1) begin
			program_led_counter <= 0;
			//program_led <= 3'b000;
			if (program_led == 3'b111)
				program_led <= 3'b110;
			else
				program_led <= {program_led[1:0], program_led[2]};
		end 
	end else
		program_led <= 3'b111; 
end

// Key press handlers
always @(negedge rst or negedge keypress_pause) begin
	if (!rst)
		pause <= 0;
	else if (!keypress_pause)
		pause <= ~pause;
end

reg [20:0] digit_count = 0;

always @(posedge clk) begin
	if (digit_count == `DIGIT_COUNT_LIMIT) begin
		digit_count <= 0;
		// Circle shifting
		digit_block = {digit_block[4:0], digit_block[5]};
		
		case (digit_block)
			`DIGIT_BLOCK_1: number <= mod10(seconds);
			`DIGIT_BLOCK_2: number <= div10(seconds);
			`DIGIT_BLOCK_3: number <= add_dot(mod10(minutes));
			`DIGIT_BLOCK_4: number <= div10(minutes);
			`DIGIT_BLOCK_5: number <= add_dot(mod10(hours));
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

function[7:0] add_dot;
	input [7:0] number;
	add_dot = {1'b0, number[6:0]};
endfunction

endmodule
