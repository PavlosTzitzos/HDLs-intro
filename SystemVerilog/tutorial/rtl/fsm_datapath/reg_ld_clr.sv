
module reg_ld_clr (
    input logic d,
    input logic clr,
    input logic CE,
    output logic Q
);

always_ff @(posedge clk) begin
    if (clr)
        Q <= 0;
    else if (CE)
        Q <= D;
end

endmodule
