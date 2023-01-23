`timescale 1ns/1ps

module TTTWC;
logic[8:0] X,O;
logic win_X,win_O;

Tic_Tac_Toe_Win_Checker dut (
    .X(X),
    .O(O),
    .win_X(win_X),
	.win_O(win_O)
);
initial begin

    $dumpfile("dump2.vcd");
    $dumpvars(1);
    O = 9'b000010001;
    X = 9'b000101010;
    #5ns;
    O = 9'b100010001;
    X = 9'b010101010;
    #5ns;
    $finish;
end

endmodule
