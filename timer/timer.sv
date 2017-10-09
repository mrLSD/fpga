module timer (
	input clk, rst,
	output reg [7:0] dataout,
	output led_bit
);

reg [25:0] count;

always @(posedge clk or negedge rst) begin
	if (!rst) begin
		count <= 0;
	end else begin
		count <= count + 1;
		case ( count[27:24] )
		  0: dataout<=8'b11000000;  
		  1: dataout<=8'b11111001;
		  2: dataout<=8'b10100100; 
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
		endcase
	end
end

assign led_bit = 1'b0;

endmodule