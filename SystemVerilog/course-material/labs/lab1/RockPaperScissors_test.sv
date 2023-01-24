// referencedesigner.com verilog tutorial
// testbench for RockPaperScissors.sv
`timescale 1ns / 1ps
module RockPaperScissors_test;
	// Inputs
	logic [2:0] inA , inB;
	// Outputs
	logic valid, tie, winA, winB;
	// Instantiate the Unit Under Test (UUT)
	// Here the name is RockPaperScissors
	RockPaperScissors uut(
		.inA(inA), 
		.inB(inB), 
		.valid(valid),
		.tie(tie),
		.winA(winA),
		.winB(winB)
	);
 
	initial begin
	//observer the variables and print their values
	// if at least one change its value
	$monitor($time, "A=%b,B=%b,valid=%b,tie=%b,winA=%b,winB=%b \n",inA,inB,valid,tie,winA,winB);
	$dumpfile("dump.vcd");
	$dumpvars(1);
	// Initialize Inputs
	inA = 3'b000;
	inB = 3'b000;
	#10;
	
	inA = 3'b001;
	inB = 3'b000;
	#10;
	
	inA = 3'b000;
	inB = 3'b111;
	#10;
	
	inA = 3'b010;
	inB = 3'b001;
	#10;
	
	inA = 3'b100;
	inB = 3'b001;
	#10;
	
	inA = 3'b010;
	inB = 3'b010;
	#10;
	
	inA = 3'b001;
	inB = 3'b101;
	#10;
	
	inA = 3'b010;
	inB = 3'b100;
	#10;
	
	end
endmodule