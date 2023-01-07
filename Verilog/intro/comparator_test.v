// referencedesigner.com verilog tutorial
// testbench for comparator module
`timescale 1ns / 1ps
module stimulus;
	// Inputs
	reg x;
	reg y;
	// Outputs
	wire z;
	// Instantiate the Unit Under Test (UUT)
	comparator uut (
		.x(x), 
		.y(y), 
		.z(z)
	);
 
	initial begin
		// Initialize Inputs
	x = 0;
	y = 0;
 
	#20 x = 1;
	#20 y = 1;
	#20 y = 0;	
	#20 x = 1;	  
	#40;
    end  
 
		initial begin
		 $monitor("x=%d,y=%d,z=%d \n",x,y,z);
		 end
 
endmodule