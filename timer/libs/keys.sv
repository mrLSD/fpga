module debouncer(
	input clk, button,
	output reg key_press
);
// Time delay for detect keypress
// For CLK_50Mgz - 16bit ~1.3ms
parameter TIME_DELAY = 16;

// Use two flip-flops to synchronize the PB signal the "clk" clock domain
reg button_sync_0;
// invert button to make button_sync_0 active high  
always @(posedge clk) button_sync_0 <= ~button; 
	
reg button_sync_1;
always @(posedge clk) button_sync_1 <= button_sync_0;

reg [TIME_DELAY-1:0] counter;
wire counter_max = &counter;
wire idle = (key_press == button_sync_1);

initial begin
	key_press = 0;
end

always @(posedge clk) begin
	if (idle)
		counter <= 0;
	else begin
		counter <= counter + 1'b1;
		// if the counter is maxed out, key_press changed!
		if (counter_max)
			key_press <= ~key_press; 
	end
end
	
endmodule
