
`timescale 1ns/1ps
module PanelDisplay_test;
	logic clk, rst;
	logic hsync, vsync;
	logic [3:0] red, green, blue;
	
	PanelDisplay dut(
	.clk(clk),
	.rst(rst),
	.hsync(hsync),
	.vsync(vsync),
	.red(red),
	.green(green),
	.blue(blue)
	);
	always
		#5 clk = ~clk;
	// STIMULUS
	initial begin
		clk = 0;
		$timeformat(-9, 0, " ns", 6);
		$display("Starting simulation...\n");
		RESET();
		$display("Reset complete, writing vga frame...\n");
		
		$stop;
	end
	task RESET();
		rst <= 1;
		repeat(2) @(posedge clk);
		rst <= 0;
		repeat(10) @(posedge clk);
	endtask
	
endmodule
