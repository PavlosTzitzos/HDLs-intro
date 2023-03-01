/* Execute stage only
 * 
 * 
 * 
 * 
 * 
 * 
 * 
 * 
 */

`include "ALU.sv"
module execute(
    // Input Data
    input logic [24:0] imm,
    input logic [31:0] pc,
    input logic [31:0] pc_plus_4_out,
    input logic [31:0] A,B,
    input logic [4:0] shamt,
    input logic [31:0] read_data,
    // Output Data
    output logic [31:0] jal_br_target,
    output logic [31:0] write_data,
    output logic [31:0] addr,
    output logic [31:0] Rin,
    output logic eq,
    // Control Signals
    input logic imm_type,
    input logic [1:0] op2_sel,
    input logic [3:0] alu_func,
    input logic [1:0] shft,
    input logic [1:0] wb_sel
);

logic [31:0] imm_32;

// immediate generator
always_comb begin
    case(imm_type)
        2'b00: begin
            // immidiate of R-type, load and jalr 
            imm_32[11:0] = imm;
        end
        2'b01: begin
            // immidiate of store
            imm_32[19:0] = imm;
        end
        2'b10: begin
            // immidiate of B-type
            imm_32[] = imm;
        end
        2'b11: begin
        end
        default:
            imm_32 = 0;
    endcase
end

// calculate the next jump
assign jal_br_target = imm_32 + pc;

logic [31:0] op_2;
// Select 2nd operator
always_comb begin
    case(op2_sel)
        00: begin
            // op_2 is B
            op_2 = B;
        end
        01: begin
            // op_2 is pc_plus_4_out
            op_2 = pc_plus_4_out;
        end
        10: begin
            // op_2 is imm_32
            op_2 = imm_32;
        end
        default:
            op_2 = B;
    endcase
end

logic [4:0] temp_op_2;
assign temp_op_2 = op_2[4:0];
logic [4:0] shamnt;
//Shift operations:
always_comb begin
    case(shft)
        00: shamnt = 5'b01100;// 12 position shift
        01: shamnt = shamt; // shamt
        10: shamnt = temp_op_2;
    endcase
end

logic [31:0] ALU_result;
// ALU 
ALU DUT(
    .A(A),
    .B(op_2),
    .C(ALU_result),
    .status(eq),
    .selALU(alu_func),
    .shamnt(shamnt)
);

logic [31:0] mul_result;
//multiply
always_comb begin
    mul_result = A*B;
end

//data to write in register file
always_comb begin
    case(wb_sel)
        00: Rin = mul_result;
        01: Rin = ALU_result;
        10: Rin = read_data;
        default: Rin = mul_result;
    endcase
end

// intercation with DMEM :
assign addr = ALU_result;
assign write_data = B;


endmodule
