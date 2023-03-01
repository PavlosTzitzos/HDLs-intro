/* Fetch
 * 
 * contanis the pc with the +4 circuit hidden
 */

`include "pc.sv"
module fetch(
    input logic clk,
    input logic rst,
    output logic [31:0] pc_plus_4_out,
    output logic [31:0] pc,
    input logic [31:0] jr_target,
    input logic [31:0] jal_br_target,
    input logic [1:0] pc_sel
);

pc DUT(
    .clk(clk),
    .rst(rst),
    .pc_plus_4(pc_plus_4_out),
    .pc(pc),
    .jr_target(jr_target),
    .jal_br_target(jal_br_target),
    .pc_sel(pc_sel),
    .pc_plus_4_out(pc_plus_4_out)
);

assign pc_plus_4 = pc_plus_4_out;

endmodule
