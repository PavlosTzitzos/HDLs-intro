module RockPaperScissors_tb;

  logic [2:0] A, B;
  logic valid, tie, winA, winB;
  
  // moveset
  logic [2:0] rock = 3'b010;
  logic [2:0] papper = 3'b100;
  logic [2:0] scissor = 3'b001;

  RockPaperScissors DUT(.inA (A),.inB (B),
                        .valid (valid), .tie (tie),
					    .winA (winA), .winB (winB));

  initial begin
    $display("Starting simulation...\n");

	// expected out --> valid=1, tie=0, winA=0, winB=1
	A <= rock;
	B <= papper;
	#10ns;
	$display("valid=%b, tie=%b, winA=%b, winB=%b", valid,tie,winA,winB);
	
	// expected out --> valid=1, tie=1, winA=0, winB=0
	A <= scissor;
	B <= scissor;
	#10ns;
	$display("valid=%b, tie=%b, winA=%b, winB=%b", valid,tie,winA,winB);
	
	// expected out --> valid=1, tie=0, winA=1, winB=0
	A <= scissor;
	B <= papper;
	#10ns;
	$display("valid=%b, tie=%b, winA=%b, winB=%b", valid,tie,winA,winB);
	
	
	// expected out --> valid=0, tie=_, winA=_, winB=_
	A <= 3'b011;
	B <= papper;
	#10ns;
	$display("valid=%b, tie=%b, winA=%b, winB=%b", valid,tie,winA,winB);
	
    $display("\nEnd of simulation\n");
	$stop;
  end

endmodule