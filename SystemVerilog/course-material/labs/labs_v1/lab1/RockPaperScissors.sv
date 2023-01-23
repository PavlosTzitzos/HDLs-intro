module RockPaperScissors
(
  input logic [2:0] inA,
  input logic [2:0] inB,
  output logic valid,
  output logic tie,
  output logic winA,
  output logic winB
);

  // Check if the two inputs are valid moves
  validIO isVal(.inA(inA), .inB(inB), .valid(valid));
  
  // Check if the winner is player A
  winnerA winsA(.inA(inA), .inB(inB), .winA(winA));
  
  // Check if the winner is player B
  winnerB winsB(.inA(inA), .inB(inB), .winB(winB));
  
  // Check if the result is a tie
  checkTie isTie(.inA(inA), .inB(inB), .tie(tie));

endmodule