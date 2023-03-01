/* Arithmetic Logic Unit (ALU)
 * Given two 32-bit numbers A and B and a 
 * control signal selALU output the result 
 * and the proper status
*/

module ALU(
    input logic [31:0] A,
    input logic [31:0] B,
    input logic [3:0] selALU,
    output logic [31:0] C,
    output logic status,
    input logic [4:0] shamnt
);

always_comb begin
    case(selALU)
        4'b0000: begin
            // ADD
            C = A + B;
        end
        4'b0001: begin
            // SUB
            C = A - B;
        end
        4'b0010:begin
            // SLL
            C = A << shamnt;
        end
        4'b0011:begin
            // SLT
            //C = A<B?32'h1:32'h0;
        end
        4'b0100: begin
            // SLTU
            //C = A;
        end
        4'b0101: begin
            // XOR
            C = A ^ B;
        end
        4'b0110: begin
            // SRL
            C = A >> shamnt;
        end
        4'b0111: begin
            // SRA
            C = A >> shamnt;
        end
        4'b1000: begin
            // OR
            C = A | B;
        end
        4'b1001: begin
            // AND
            C = A & B;
        end
        default: begin
        end
    endcase
end

endmodule
