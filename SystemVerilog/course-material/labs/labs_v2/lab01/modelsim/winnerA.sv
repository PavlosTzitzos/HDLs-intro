module winnerA (
  input logic [2:0] inA,
  input logic [2:0] inB,
  output logic winA);
  
  always_comb begin
    if ( inA == 3'b001 & inB == 3'b010 ) winA = 1;
	else if ( inA == 3'b010 & inB == 3'b100 ) winA = 1;
	else if ( inA == 3'b100 & inB == 3'b001 ) winA = 1;
	else winA = 0;
  end
endmodule