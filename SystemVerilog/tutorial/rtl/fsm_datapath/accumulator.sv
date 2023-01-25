
module accumulator(
    input logic d,
    input logic CE,
    output logic Q
);

always_ff @(posedge clk)
    if (CE)
        Q <= D;

endmodule
