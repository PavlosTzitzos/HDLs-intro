`timescale 1ns/1ps

module top_test;
	logic clk, rst;
	logic button_left,button_right,button_up,button_down;
	logic button_play;
	logic winA,winB,tie;
	logic [3:0] red, green, blue;
	logic hsync,vsync,turn;
	logic [8:0] rX,rO;
	logic [1:0] cursor_x,cursor_y;
	top dut (
		.clk(clk),
		.button_left(button_left),
		.button_right(button_right),
		.button_up(button_up),
		.button_down(button_down),
		.button_play(button_play),
		.winA(winA),
		.winB(winB),
		.tie(tie),
		.cursor_x(cursor_x),
		.cursor_y(cursor_y),
		.turn(turn),
		.rX(rX),
		.rO(rO),
		.red(red),
		.green(green),
		.blue(blue),
		.hsync(hsync),
		.vsync(vsync)
	);
	
	initial begin
		
		$dumpfile("dumptoptest.vcd");
		$dumpvars(1);
		clk = 0;
		rst = 1;
		#10ns;
		clk = 1;
		#10ns;
		clk = 0;
		#10ns;
		clk = 1;
		#10ns;
		clk = 0;
		rst = 0;
		button_left = 0;
		button_right = 1;
		button_up = 0;
		button_down = 0;
		button_play = 1;
		#10ns;
		clk = 1;
		#5ns;
		button_play = 0;
		#5ns;
		clk = 0;
		button_left = 0;
		button_right = 0;
		button_up = 0;
		button_down = 0;
		button_play = 1;
		#10ns;
		clk = 1;
		#5ns;
		button_play = 0;
		#5ns;
		clk = 0;
		button_left = 0;
		button_right = 0;
		button_up = 0;
		button_down = 1;
		button_play = 1;
		#10ns;
		clk = 1;
		#5ns;
		button_play = 0;
		#5ns;
		clk = 0;
		$finish;
	end
endmodule
