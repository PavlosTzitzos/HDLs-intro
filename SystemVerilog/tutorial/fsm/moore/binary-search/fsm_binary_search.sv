/*



*/
module fsm_binary_search
# (
    parameter int N = 4,
    parameter int M = 4
)
(
    input logic clk,
    input logic rst,
    input logic [M-1:0] target,
    output logic [M-1:0] index,
    output logic done
);

enum logic[3:0] {
    S0=4'b0000, S1=4'b0001,
    S2=4'b0010, S3=4'b0011,
    S4=4'b0100, S5=4'b0101,
    S6=4'b0110, S7=4'b0111,
    S8=4'b1000
} state;

logic [M-1:0] left, right, mid, mem_read_data;

sram array (.R_A(mid), .R_D(mem_read_data));

always_ff @(posedge clk, posedge rst) begin
    if (rst)
        state <= S0;
    else
        case (state)
            S0: begin
                left <= 0;
                right <= N-1;
                index <= -1;
                state <= S1;
            end
            S1:
                if (left <= right)
                    state <= S2;
                else
                    state <= S8;
            S2: begin
                mid <= (right+left)/2;
                state <= S3;
            end
            S3:
                if (mem_read_data < target)
                    state <= S4;
                else
                    state <= S5;
            S4: begin
                left <= mid+1;
                state <= S1;
            end
            S5:
                if (mem_read_data > target)
                    state <= S6;
                else
                    state <= S7;
            S6: begin
                right <= mid-1;
                state <= S1;
            end
            S7: begin
                index <= mid;
                state <= S8;
            end
        endcase
end

assign done = (state == S8)? 1 : 0;

endmodule
