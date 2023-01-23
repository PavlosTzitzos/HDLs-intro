module winnerB (
  input logic [2:0] inA,
  input logic [2:0] inB,
  output logic winB);
  
  always_comb begin
    if ( inA == 3'b010 & inB == 3'b001 ) winB = 1;
	else if ( inA == 3'b100 & inB == 3'b010 ) winB = 1;
	else if ( inA == 3'b001 & inB == 3'b100 ) winB = 1;
	else winB = 0;
  end
endmodule