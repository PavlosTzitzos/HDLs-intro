`timescale 1ns / 1ns
`include "JKFF.v"

module JKFF_test;
    reg J;
    reg K;
    reg clk;

    always #5 clk = ~clk;

    JKFF jk0( .J(J), .K(K), .clk(clk), .Q(Q));

    initial begin
//        Q <= 0;
        J <= 0;
        K <= 1;
        #5;
        J <= 1;
        K <= 0;
        #20;
        J <= 1;
        K <= 1;
        #20;
        J <= 0;
        K <= 0;
        #20;
        $display("Test Completed");
        $finish;
    end

    initial
        $monitor ("J=%0d K=%0d Q=%0d", J, K, Q);
endmodule
