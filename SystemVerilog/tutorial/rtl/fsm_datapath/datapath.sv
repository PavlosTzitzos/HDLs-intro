
module datapath (
    // to/from outside world
    input logic clk, 
    output logic [7:0] R,
    // to-from memory
    input logic [7:0] rd_data, 
    output logic [7:0] addr,
    // from/to controller – fsm
    input logic sum_sel,
    input logic ld_sum,
    input logic pnt_sel,
    input logic ld_pnt,
    input logic a_sel,
    output logic pnt_zero
);

// register sum and associated logic
always_ff @(posedge clk) begin
    if (sum_sel==0) 
        sum <= 0;
    else if (ld_sum)
        sum <= sum + rd_data;
end
// select next pnt value
assign pnt_next = (pnt_sel) ? rd_data : 0;
// check if pnt will be zero in this cycle
assign pnt_zero = (pnt_next==0);

// register pnt
always_ff @(posedge clk) begin
    if (ld_pnt)
        pnt <= pnt_next;
end
// increment pointer
assign pnt_inc = pnt+1;
// address generation
assign addr = (A_SEL) ? pnt : pnt_inc;

endmodule
