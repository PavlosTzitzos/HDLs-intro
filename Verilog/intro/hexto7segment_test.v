    `timescale 1ns / 1ps
    module stimulus;
    	// Inputs
    	reg [3:0] x;
    	// Outputs
    	wire [6:0] z;
    	// Instantiate the Unit Under Test (UUT)
    	hexto7segment uut (
    		.x(x), 
    		.z(z)
    	);
     
    	initial begin
    		// Initialize Inputs
    		x = 0;
     
    	#20 x = 1;
    	#20 x = 2;
    	#20 x = 3;	
    	#20 x = 4;	
    	#20 x = 5;
    	#20 x = 6;
    	#20 x = 7;	
    	#20 x = 8;	
    	#20 x = 9;
    	#20 x = 10;
    	#20 x = 11;	
    	#20 x = 12;	
    	#20 x = 13;
    	#20 x = 14;
    	#20 x = 15;	
    	#40;
        end  
     
    		initial begin
    		 $monitor("x=%h,z=%7b",x,z);
    		 end
     
    endmodule