
module hardware_trojan(
    input logic flush,
    input logic[7:0] data_i,
    input logic vld_i,
    input logic rdy_i,

    output logic[7:0] data_o,
    output logic vld_o,
    output logic rdy_o
);

always_comb begin
    case(flush)
        1'b0: begin
            data_o = data_i;
            vld_o = vld_i;
            rdy_o = rdy_i;
        end
        1'b1: begin
            data_o = 'z;
            vld_o = 'z;
            rdy_o = 'z;
        end
        default: begin

        end
    endcase
end

endmodule
