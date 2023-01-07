`timescale 1ns / 1ns
`include "FullAdder.v"

module FullAdder_test;
    reg [3:0] a;
    reg [3:0] b;
    reg c_in;
    wire c_out;
    wire [3:0] sum;
    integer i;

    FullAdder fa0 (.a(a), .b(b), .c_in(c_in), .c_out(c_out), .sum(sum));

    initial begin
        a <= 0;
        b <= 0;
        c_in <= 0;

        $monitor ("a=0x%0h b=0x%0h c_in=0x%0h c_out=0x%0h sum=0x%0h", a, b, c_in, c_out, sum);

        for (i=0; i<5; i=i+1) begin
            #10 a <= $random;
            b <= $random;
            c_in <= $random;
        end
    end

endmodule