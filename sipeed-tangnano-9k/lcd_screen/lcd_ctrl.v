module lcd_ctrl
(
    input  wire			clk,		// LCD_CTL clock
    input  wire			rst_n, 		// Sync reset
    input  wire	[23:0]	lcd_data,   // lcd data
        
    // LCD interface
    output wire			lcd_hs,	   	// lcd horizontal sync
    output wire			lcd_vs,	   	// lcd vertical sync
    output wire			lcd_de,		// lcd display enable; 1:Display Enable Signal;0: Disable Ddsplay
    output wire         lcd_clk,    // lcd clk
    output wire	[23:0]	lcd_rgb,	// lcd display data

	// User interface
	output wire	[11:0]	lcd_xpos,	// lcd horizontal coordinate
	output wire	[11:0]	lcd_ypos	// lcd vertical coordinate
);

`define _800_480

`ifdef _800_480
	parameter H_SYNC = 0; // 10 // 0
	parameter H_BACK = 182; // 46 // 182
	parameter H_DISP = 800;
	parameter H_FRONT = 210;
	parameter H_TOTAL = H_DISP + H_BACK + H_FRONT + H_SYNC;
			
	parameter V_SYNC = 0;  // 4  // 0 
	parameter V_BACK = 0; // 23 // 0
	parameter V_DISP = 480;
	parameter V_FRONT = 45; // 13 // 45
	parameter V_TOTAL = V_DISP + V_BACK + V_FRONT + V_SYNC;
`endif

`ifdef _480_272
	parameter H_SYNC = 4	;
	parameter H_BACK = 23	;
	parameter H_DISP = 480	;
	parameter H_FRONT = 13	;
	parameter H_TOTAL = 520 ;
			
	parameter V_SYNC = 4	;
	parameter V_BACK = 15	;
	parameter V_DISP = 272	;
	parameter V_FRONT = 9	;
	parameter V_TOTAL = 300 ;
`endif

localparam	H_AHEAD = 12'd1;

reg [11:0]  pixel_count;     // horizontal (pixel) counter
reg [11:0]  line_count;      // vertical (lines) counter
wire        lcd_request;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        pixel_count <=  12'b0;    
        line_count  <=  12'b0;
    end
    else if (pixel_count == H_TOTAL - 1) begin
        pixel_count <= 12'b0;
        if (line_count < V_TOTAL - 1)
            line_count  <= line_count + 1'b1;
        else   
            line_count  <= 12'b0;
    end
    else
        pixel_count <= pixel_count + 1'b1;
end

// assign  lcd_hs = ((pixel_count >= 1) && (pixel_count <= (H_TOTAL - H_FRONT))) ? 1'b0 : 1'b1;
// assign  lcd_vs = ((line_count  >= 5) && (line_count <= (V_TOTAL - 0)))  ? 1'b0 : 1'b1;
// assign  lcd_de = ((pixel_count >= H_BACK) &&
//            (pixel_count <= H_TOTAL - H_FRONT) &&
//            (line_count >= V_BACK ) &&
//            (line_count <= V_TOTAL - H_FRONT - 1))
//            ? 1'b1 : 1'b0;

// Line over flag
assign  lcd_hs = (pixel_count <= H_SYNC - 1'b1) ? 1'b0 : 1'b1;
// Frame over flag
assign  lcd_vs = (line_count <= V_SYNC - 1'b1) ? 1'b0 : 1'b1;
// Control Display - display enable signal
assign  lcd_de  = (pixel_count >= H_SYNC + H_BACK  && pixel_count < H_SYNC + H_BACK + H_DISP) &&
                (line_count >= V_SYNC + V_BACK  && line_count < V_SYNC + V_BACK + V_DISP) 
                ? 1'b1 : 1'b0;

assign  lcd_rgb = lcd_de ? lcd_data : 24'h000000;	

assign  lcd_request	= ((pixel_count >= H_SYNC + H_BACK - H_AHEAD) && 
                    (pixel_count < H_SYNC + H_BACK + H_DISP - H_AHEAD)) && 
                    ((line_count >= V_SYNC + V_BACK) && 
                    (line_count < V_SYNC + V_BACK + V_DISP))
                    ? 1'b1 : 1'b0;
// LCD xpos & ypos
assign  lcd_xpos = lcd_request ? (pixel_count - (H_SYNC + H_BACK - H_AHEAD)) : 12'd0;
assign  lcd_ypos = lcd_request ? (line_count - (V_SYNC + V_BACK)) : 12'd0;

assign  lcd_clk  = clk;

endmodule
