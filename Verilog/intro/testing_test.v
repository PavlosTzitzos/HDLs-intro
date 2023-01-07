`timescale 1ns / 1ns
`include "testing.v"

module testing_test;
    
    reg A;
    wire B;

    testing uut(A, B);

    initial begin
        $dumpfile("testing_test.vcd");
        $dumpvars(0, testing_test);

        A = 0;
        #20;

        A = 1;
        #20;

        A = 0;
        #20;

        $display("Test complete");

    end

endmodule
