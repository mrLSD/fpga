module debouncer(
	input clk, button,
	output reg key_press
);

// Use two flip-flops to synchronize the PB signal the "clk" clock domain
reg button_sync_0;
// invert button to make button_sync_0 active high  
always @(posedge clk) button_sync_0 <= ~button; 
	
reg button_sync_1;
always @(posedge clk) button_sync_1 <= button_sync_0;

reg [2:0] counter;
wire counter_max = &counter;
wire idle = (key_press == button_sync_1);

initial begin
	key_press = 0;
	$monitor(clk, " B = %b | PRESS = %b | SYNC = %b | IDEL = %b", button, key_press, button_sync_1, idle);
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
