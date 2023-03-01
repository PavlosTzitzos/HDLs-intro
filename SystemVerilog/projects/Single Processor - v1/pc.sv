/* Program Counter (PC)
 * 
 * starting from 0 counts with step 4
 * 32-bit length
 * supports : Jump , Branch commands
 * 
 */

module pc(
    input logic clk,
    input logic rst,
    input logic [31:0] pc_plus_4,
    output logic [31:0] pc,
    input logic [31:0] jr_target,
    input logic [31:0] jal_br_target,
    input logic [0:1] pc_sel,
    output logic [31:0] pc_plus_4_out
);

always_ff@(posedge clk) begin
    if(rst)
        pc <= 0;
    else
        case(pc_sel)
        00:
            pc = pc_plus_4;
        01:
            pc = jal_br_target;
        10:
            pc = jr_target;
        default:
            pc = pc_plus_4;
        endcase
end

assign pc_plus_4_out = pc + 4;

endmodule
