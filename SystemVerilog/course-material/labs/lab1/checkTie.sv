module checkTie (
  input logic [2:0] inA,
  input logic [2:0] inB,
  output logic tie);
  
/*
  always_comb begin
    assign tie = 1'b1;
	
    for (int i=0; i < 2; i++) begin 
	  if ( inA[i] == inB[i] & tie == 1'b1 )
	    assign tie = 1'b1;
	  else
	    assign tie = 1'b0;
    end
  end
*/
  assign tie = (inA[0]^inB[0]) | (inA[1]^inB[1]) | (inA[2]^inB[2]);
endmodule