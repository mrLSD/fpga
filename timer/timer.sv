`include "const.sv"

module timer (
	input clk, rst,
	output reg [7:0] dataout,
	output led_bit
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
		/*
		case ( count[25:22] )
		  0:  dataout <= `NUMBER_1;  
		  1:  dataout <= `NUMBER_2;
		  2:  dataout <= `NUMBER_3; 
		  3: dataout<=8'b10110000;
		  4: dataout<=8'b10011001;
		  5: dataout<=8'b10010010;
		  6: dataout<=8'b10000010;
		  7: dataout<=8'b11111000;
		  8: dataout<=8'b10000000;
		  9: dataout<=8'b10010000;
		  10:dataout<=8'b10001000;
		  11:dataout<=8'b10000011;
		  12:dataout<=8'b11000110;
		  13:dataout<=8'b10100001;
		  14:dataout<=8'b10000110;
		  15:dataout<=8'b10001110; 
		endcase*/
	end
end

always @(count) begin
	
end


assign led_bit = 1'b0;

endmodule
