`timescale 1ns/1ps
module MoveGen_test;

logic[8:0] x,o,newO,test3;
logic [8:0] test1;
logic [23:0] test2;
MoveGen dut(.x(x), .o(o), .newO(newO),.test1(test1),.test2(test2));

//MoveGen_K dut(.x(x), .o(o), .newO(newO),.test2(test2),.test3(test3),.test1(test1));


initial begin
    $monitor($time," x = %b ,o= %b ,newO = %b \n",x,o,newO);
    $dumpfile("dump.vcd");
    $dumpvars(1);
    o = 9'b000_010_001;
    x = 9'b000_101_010;
    #5ns;//2
    o = 9'b010_000_000;
    x = 9'b000_010_001;
    #5ns;//3
    o = 9'b100_000_000;
    x = 9'b000_010_001;
    #5ns;//4
    o = 9'b000_000_000;
    x = 9'b000_010_000;
    #5ns;//1
    $finish;
end
endmodule
