module sample1(); 

endmodule

module main();

reg clk, en;
reg [27:0] count;
	
always #5 clk = ~clk;

always @(posedge clk) begin
	count = count + 1;
end
	
initial begin
	clk = 0;
	en = 1;	
	$display("Started...");
	$monitor($time, count);
	$monitor($time, " en ", en);
	#10 en = en + 2;
	#20 en = en + 3;
	#100 $finish;	
end
	
endmodule
