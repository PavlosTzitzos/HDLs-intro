module validIO (
  input logic [2:0] inA,
  input logic [2:0] inB,
  output logic valid);
  
//with always_comb block:
/*
  always_comb begin
    case (inA)
	  3'b000 : valid = 0;
	  3'b011 : valid = 0;
	  3'b101 : valid = 0;
	  3'b110 : valid = 0;
	  3'b111 : valid = 0;
	default : begin case (inB) 
					  3'b000 : valid = 0;
					  3'b011 : valid = 0;
					  3'b101 : valid = 0;
					  3'b110 : valid = 0;
					  3'b111 : valid = 0;
					  default : valid = 1;
					endcase
			  end
	endcase
  end
*/
  //with assign :
  assign valid = ((inA[0] & !inA[1] & !inA[2])|(!inA[0] & !inA[1] & inA[2])|(!inA[0] & inA[1] & !inA[2]))&((inB[0] & !inB[1] & !inB[2])|(!inB[0] & !inB[1] & inB[2])|(!inB[0] & inB[1] & !inB[2]));

endmodule