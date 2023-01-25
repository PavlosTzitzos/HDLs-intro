
module list_processor (
// to/from outside world
input logic clk, 
input logic start,
output logic done,
output logic [7:0] R,
// to-from memory
input logic [7:0] rd_data, 
output logic [7:0] addr,
);

logic sum_sel, pnt_sel;
logic ld_pnt, ld_sum;
logic pnt_zero, a_sel;
fsm_controller cntrl (.clk(clk), .start(start), .done(done), .sum_sel(sum_sel), .pnt_sel(pnt_sel), .ld_pnt(ld_pnt), .ld_sum(ld_sum), .a_sel(a_sel), .pnt_zero(pnt_zero));
datapath dp (.clk(clk), .R(R), .rd_data(rd_data), .addr(addr), sum_sel(sum_sel), .pnt_sel(pnt_sel), .ld_pnt(ld_pnt), .a_sel(a_sel), .pnt_zero(pnt_zero));

endmodule
