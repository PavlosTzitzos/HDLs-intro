    `timescale 1ns / 1ps
    module stimulus;
    	reg Clock;
    	reg D;
    	wire Q;
    	// Instantiate the Unit Under Test (UUT)
    	d_ff d1 (
    		.Clock(Clock), 
    		.D(D), 
    		.Q(Q)
    	);
     
    	integer i;
     
    	initial begin
    	$dumpfile("test.vcd");
        $dumpvars(0,stimulus);
    	D = 0;
    	#8  D= 1;
    	#10 D= 0;
    	#10 D= 0;	
    	#10 D =1;	
        #10 D =0;
    	#10 D = 1;	
    	#40;
        end  
     
    	initial begin
    	Clock = 0;
    	for ( i =0; i <=10; i= i+1)
    	#10 Clock = ~Clock;
        end  
     
     
    		initial begin
    		 $monitor("Clock=%d,D=%d,Q=%d \n",Clock,D,Q);
    		 end
     
    endmodule