`include "fonts.sv"
import fonts::*;

module render_text(
	input reg vga_clk,
	input reg [9:0] x_coord,
	input reg [9:0] y_coord,
	output reg [2:0] h_dat
);

parameter int T1 = 3'd4;
parameter reg [0:7] FONT_16x32 [0:255] [0:63] = fonts::CyrKoiTerminus32x16;

parameter string txt [0:2] = '{
	"SystemVerilog: 17:30:01", 
	"Multiline text",
	"New test"
};


wire [9:0]charXPosition;
wire [9:0]charYPosition;
wire [9:0]bitXPosition;
wire [9:0]bitYPosition;
reg [0:15]bitMap;

assign charXPosition = (x_coord / 10'd16);
assign charYPosition = (y_coord / 10'd32); 
assign bitXPosition = (x_coord % 10'd16);
assign bitYPosition = (y_coord % 10'd32);

always @(posedge vga_clk)
begin
	h_dat <= 3'h0;
	
	if (charYPosition >= 6 &&
		charYPosition < $size(txt) + 6 &&
		charXPosition >= 2 
	) begin
		case (charYPosition-6)
			5'd0: bitMap <= (charXPosition < txt[0].len() + 2) ? {
					FONT_16x32[txt[0][charXPosition-2]] [2*bitYPosition], 
					FONT_16x32[txt[0][charXPosition-2]] [2*bitYPosition + 1]
				} : 32'd0;
			5'd1: bitMap <= (charXPosition < txt[1].len() + 2) ? {
					FONT_16x32[txt[1][charXPosition-2]] [2*bitYPosition], 
					FONT_16x32[txt[1][charXPosition-2]] [2*bitYPosition + 1]
				} : 32'd0;
			5'd2: bitMap <= (charXPosition < txt[2].len() + 2) ? {
					FONT_16x32[txt[2][charXPosition-2]] [2*bitYPosition], 
					FONT_16x32[txt[2][charXPosition-2]] [2*bitYPosition + 1]
				} : 32'd0;
			default: bitMap <= 32'd0;
		endcase
		
		if (bitMap[bitXPosition]) begin
			h_dat <= 3'h3;
		end
	end
end

endmodule
