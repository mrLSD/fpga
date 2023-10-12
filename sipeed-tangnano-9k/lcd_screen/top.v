module top
(
    input           clk,
    input           rst,

	output			LCD_CLK,
	output			LCD_HSYNC,
	output			LCD_VSYNC,
	output			LCD_DE,
	output	[4:0]	LCD_R,
	output	[5:0]	LCD_G,
	output	[4:0]	LCD_B,

    output  [5:0]   LED
);

wire CLK_SYS;
wire CLK_PIX;

Gowin_rPLL chip_pll
(
    .clkout(CLK_SYS),   // output clkout  - 200M
    .clkoutd(CLK_PIX),  // output clkoutd - 33.33M
    .clkin(clk)         // input clkin
);

assign  LCD_R[4:0]  = lcd_rgb[4 + 8*2 : 8*2];
assign  LCD_G[5:0]  = lcd_rgb[5 + 8*1 : 8*1];
assign  LCD_B[4:0]  = lcd_rgb[4 + 8*0 : 8*0];

wire [23:0] lcd_rgb;
wire [23:0] lcd_data;

wire [11:0]	lcd_xpos;		
wire [11:0]	lcd_ypos;

lcd_ctrl lcd_ctrl_inst (
  	.clk        (CLK_PIX),      // lcd clock
	.rst_n      (~rst),         // sync reset
	.lcd_data   (lcd_data),     // lcd data
	.lcd_hs     (LCD_HSYNC),    // lcd horizontal sync
	.lcd_vs     (LCD_VSYNC),    // lcd vertical sync
	.lcd_de     (LCD_DE),       // lcd display enable; 1:Display Enable Signal;0: Disable Ddsplay
    .lcd_clk     (LCD_CLK),
	.lcd_rgb    (lcd_rgb),      // lcd display data
	.lcd_xpos   (lcd_xpos),     // lcd horizontal coordinate
	.lcd_ypos   (lcd_ypos)      // lcd vertical coordinate
);

lcd_data lcd_data_inst( 
	.clk		(clk),
	.rst_n		(~rst),
	.lcd_xpos	(lcd_xpos),		// lcd horizontal coordinate
	.lcd_ypos	(lcd_ypos),		// lcd vertical coordinat
	.lcd_data	(lcd_data)	    //lcd data
);

// LED drive
reg [23:0]  counter;
reg [5:0]   led_values;

always @(posedge clk or negedge rst) begin
    if (!rst)
        counter <= 24'd0;
    else if (counter < 24'd400_0000)       // 0.5s delay
        counter <= counter + 1;
    else
        counter <= 24'd0;
end

always @(posedge clk or negedge rst) begin
    if (!rst)
        led_values <= 6'b111010;       
    else if (counter == 24'd400_0000) // 0.5s delay
        led_values[5:0] <= {led_values[0], led_values[5:1]};
    else
        led_values <= LED;
end

assign LED = led_values;

endmodule
