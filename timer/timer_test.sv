module main();

reg clk;
reg state;
reg pb;
wire pb_out;

debounce db(pb, clk, pb_out);

initial begin
	clk = 0;
	forever #1 clk = ~clk; 
end

initial begin
	clk = 0;
	#2 pb = 0;
	forever #3 pb = ~pb;
end

initial #40 $finish; 

endmodule

module debounce(input pb_1,clk,output pb_out);
	wire slow_clk;
	wire Q1,Q2,Q2_bar;
	clock_div u1(clk,slow_clk);

	dff d1(slow_clk, pb_1,Q1 );
	dff d2(slow_clk, Q1,Q2 );
	
	initial begin
		$monitor($time, " CLK: %b | PB: %b | %b == %b", slow_clk, pb_1, Q1, Q2);
	end
	
	assign Q2_bar = ~Q2;
	assign pb_out = Q1 & Q2_bar;
endmodule

// Slow clock for debouncing 
module clock_div(input clk, output reg slow_clk);
    reg [2:0]counter=0;
    always @(posedge clk)
    begin
        counter <= (counter>=3) ? 1'b0 : counter + 1'b1;
        slow_clk <= (counter < 2) ? 1'b0: 1'b1;
    end
endmodule

module dff(
	input clk,
	input d,
	output reg q
);

reg qq;

always @(posedge clk) begin
	q <= d;
	qq <= q;
	$display("DFF: %b <= %b | %b", q, d, qq);	
end
endmodule
