/* Decode one given instruction
 * 
 * implemented with case
 * 
 */

module decode(
    // Input an instruction
    input logic [16:0] instruction,
    input logic eq,
    // Output control signals
    output logic [1:0] pc_sel,
    output logic imm_type,
    output logic [1:0] op2_sel,
    output logic [3:0] alu_func,
    output logic [1:0] shft,
    output logic write_en,
    output logic [1:0] wb_sel,
    output logic write,
);

logic [6:0] opcode;
logic [2:0] fun3;
logic [6:0] fun7;

assign opcode = instrtuction[5:0];
assign fun3 = instrtuction[8:6];
assign fun7 = instrtuction[16:9];

// 1st way : with case
always_comb begin
    case(opcode)
        0110011: begin
            // R-type
            case(fun3)
                000: begin
                    if(fun7== 7'b0000000) begin
                        //ADD
                        pc_sel = 2'b00;
                        imm_type = 0;
                        op2_sel = 2'b00;
                        alu_func = 4'b0000;
                        shft = 2'b00;
                        write_en = 0;
                        wb_sel = 2'b01;
                        write = 1;
                    end else begin
                        //SUB
                        pc_sel = 2'b00;
                        imm_type = 0;
                        op2_sel = 2'b00;
                        alu_func = 4'b0001;
                        shft = 2'b00;
                        write_en = 0;
                        wb_sel = 2'b01;
                        write = 1;
                    end
                end
                001: begin
                    //SLL
                    pc_sel = 2'b00;
                    imm_type = 0;
                    op2_sel = 2'b00;
                    alu_func = 4'b0010;
                    shft = 2'b00;
                    write_en = 0;
                    wb_sel = 2'b01;
                    write = 1;
                end
                010: begin
                    //SLT
                    pc_sel = 2'b00;
                    imm_type = 0;
                    op2_sel = 2'b00;
                    alu_func = 4'b0011;
                    shft = 2'b00;
                    write_en = 0;
                    wb_sel = 2'b01;
                    write = 1;
                end
                011: begin
                    //SLTU
                    pc_sel = 2'b00;
                    imm_type = 0;
                    op2_sel = 2'b00;
                    alu_func = 4'b0100;
                    shft = 2'b00;
                    write_en = 0;
                    wb_sel = 2'b01;
                    write = 1;
                end
                100: begin
                    //XOR
                    pc_sel = 2'b00;
                    imm_type = 0;
                    op2_sel = 2'b00;
                    alu_func = 4'b0101;
                    shft = 2'b00;
                    write_en = 0;
                    wb_sel = 2'b01;
                    write = 1;
                end
                101: begin
                    if(fun7== 7'b0000000) begin
                        //SRL
                        pc_sel = 2'b00;
                        imm_type = 0;
                        op2_sel = 2'b00;
                        alu_func =4'b0110;
                        shft = 2'b00;
                        write_en = 0;
                        wb_sel = 2'b01;
                        write = 1;
                    end else begin
                        //SRA
                        pc_sel = 2'b00;
                        imm_type = 0;
                        op2_sel = 2'b00;
                        alu_func = 4'b0111;
                        shft = 2'b00;
                        write_en = 0;
                        wb_sel = 2'b01;
                        write = 1;
                    end
                end
                110: begin
                    //OR
                    pc_sel = 2'b00;
                    imm_type = 0;
                    op2_sel = 2'b00;
                    alu_func = 4'b1000;
                    shft = 2'b00;
                    write_en = 0;
                    wb_sel = 2'b01;
                    write = 1;
                end
                111: begin
                    //AND
                    pc_sel = 2'b00;
                    imm_type = 0;
                    op2_sel = 2'b00;
                    alu_func = 4'b1001;
                    shft = 2'b00;
                    write_en = 0;
                    wb_sel = 2'b01;
                    write = 1;
                end
                default: begin
                    //error
                    pc_sel = 2'b00;
                    imm_type = 0;
                    op2_sel = 2'b00;
                    alu_func = 4'b0000;
                    shft = 2'b00;
                    write_en = 0;
                    wb_sel = 2'b01;
                    write = 0;
                end
            endcase
        end
        0010011: begin
            // I-type
            case(fun3)
                000: begin
                    //ADDI
                    pc_sel = 2'b00;
                    imm_type = 0;
                    op2_sel = 2'b00;
                    alu_func = 4'b0000;
                    shft = 2'b00;
                    write_en = 0;
                    wb_sel = 2'b01;
                    write = 1;
                end
                001: begin
                    //SLLI
                    pc_sel = 2'b00;
                    imm_type = 0;
                    op2_sel = 2'b10;
                    alu_func = 4'b0010;
                    shft = 2'b10;
                    write_en = 0;
                    wb_sel = 2'b01;
                    write = 1;
                end
                010: begin
                    //SLTI
                    pc_sel = 2'b00;
                    imm_type = 0;
                    op2_sel = 2'b00;
                    alu_func = 4'b0011;
                    shft = 2'b00;
                    write_en = 0;
                    wb_sel = 2'b01;
                    write = 1;
                end
                011: begin
                    //SLTIU
                    pc_sel = 2'b00;
                    imm_type = 0;
                    op2_sel = 2'b00;
                    alu_func = 4'b0100;
                    shft = 2'b00;
                    write_en = 0;
                    wb_sel = 2'b01;
                    write = 1;
                end
                100: begin
                    //XORI
                    pc_sel = 2'b00;
                    imm_type = 0;
                    op2_sel = 2'b00;
                    alu_func = 4'b0101;
                    shft = 2'b00;
                    write_en = 0;
                    wb_sel = 2'b01;
                    write = 1;
                end
                101: begin
                    if(fun7== 7'b0000000) begin
                        //SRLI
                        pc_sel = 2'b00;
                        imm_type = 0;
                        op2_sel = 2'b10;
                        alu_func = 4'b0110;
                        shft = 2'b10;
                        write_en = 0;
                        wb_sel = 2'b01;
                        write = 1;
                    end else begin
                        //SRAI
                        pc_sel = 2'b00;
                        imm_type = 0;
                        op2_sel = 2'b10;
                        alu_func = 4'b0111;
                        shft = 2'b10;
                        write_en = 0;
                        wb_sel = 2'b01;
                        write = 1;
                    end
                end
                110: begin
                    //ORI
                    pc_sel = 2'b00;
                    imm_type = 0;
                    op2_sel = 2'b00;
                    alu_func = 4'b1000;
                    shft = 2'b00;
                    write_en = 0;
                    wb_sel = 2'b01;
                    write = 1;
                end
                111: begin
                    //ANDI
                    pc_sel = 2'b00;
                    imm_type = 0;
                    op2_sel = 2'b00;
                    alu_func = 4'b1001;
                    shft = 2'b00;
                    write_en = 0;
                    wb_sel = 2'b01;
                    write = 1;
                end
                default: begin
                    //error
                    pc_sel = 2'b00;
                    imm_type = 0;
                    op2_sel = 2'b00;
                    alu_func = 4'b0000;
                    shft = 2'b00;
                    write_en = 0;
                    wb_sel = 2'b01;
                    write = 0;
                end
            endcase
        end
        0100011: begin
            // Store
            pc_sel = 2'b00;
            imm_type = 2'b00;
            op2_sel = 2'b10;
            alu_func = 4'b0000;
            shft = 2'b00;
            write_en = 1;
            wb_sel = 2'b01;
            write = 0;
        end
        0000011: begin
            // Load
            pc_sel = 2'b00;
            imm_type = 2'b00;
            op2_sel = 2'b10;
            alu_func = 4'b0000;
            shft = 2'b00;
            write_en = 0;
            wb_sel = 2'b10;
            write = 1;
        end
        1100011: begin
            // Branch
            case(fun3)
                000: begin
                    //BEQ
                    pc_sel = ;
                    imm_type = ;
                    op2_sel = ;
                    alu_func = ;
                    shft = ;
                    write_en = ;
                    wb_sel = ;
                    write = ;
                end
                001: begin
                    //BNE
                    pc_sel = ;
                    imm_type = ;
                    op2_sel = ;
                    alu_func = ;
                    shft = ;
                    write_en = ;
                    wb_sel = ;
                    write = ;
                end
                100: begin
                    //BLT
                    pc_sel = ;
                    imm_type = ;
                    op2_sel = ;
                    alu_func = ;
                    shft = ;
                    write_en = ;
                    wb_sel = ;
                    write = ;
                end
                101: begin
                    //BGE
                    pc_sel = ;
                    imm_type = ;
                    op2_sel = ;
                    alu_func = ;
                    shft = ;
                    write_en = ;
                    wb_sel = ;
                    write = ;
                end
                110: begin
                    //BLTU
                    pc_sel = ;
                    imm_type = ;
                    op2_sel = ;
                    alu_func = ;
                    shft = ;
                    write_en = ;
                    wb_sel = ;
                    write = ;
                end
                111: begin
                    //BGEU
                    pc_sel = ;
                    imm_type = ;
                    op2_sel = ;
                    alu_func = ;
                    shft = ;
                    write_en = ;
                    wb_sel = ;
                    write = ;
                end
                default: begin
                    //error
                    pc_sel = ;
                    imm_type = ;
                    op2_sel = ;
                    alu_func = ;
                    shft = ;
                    write_en = ;
                    wb_sel = ;
                    write = ;
                end
            endcase
        end
        1100111: begin
            // JALR
            pc_sel = ;
            imm_type = ;
            op2_sel = ;
            alu_func = ;
            shft = ;
            write_en = ;
            wb_sel = ;
            write = ;
        end
        1101111: begin
            // JAL
            pc_sel = ;
            imm_type = ;
            op2_sel = ;
            alu_func = ;
            shft = ;
            write_en = ;
            wb_sel = ;
            write = ;
        end
        0110111: begin
            // LUI
            pc_sel = ;
            imm_type = ;
            op2_sel = ;
            alu_func = ;
            shft = ;
            write_en = ;
            wb_sel = ;
            write = ;
        end
        default: begin
            // idle
            pc_sel = 2'b00;
            imm_type = 4'b0000;
            op2_sel = 2'b00;
            alu_func = 4'b0000;
            shft = 2'b00;
            write_en = 0;
            wb_sel = 2'b00;
            write = 0;
        end
    endcase
end

// 2nd way : with fsm

endmodule
