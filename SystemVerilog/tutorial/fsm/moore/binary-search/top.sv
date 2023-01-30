/*

*/

module top(
    input logic clk,
    input logic rst,
    input logic start,
    output logic [9:0] out
);

logic [6:0]i;
logic [6:0] [9:0]a;
logic [9:0]x;

enum logic[2:0] {IDLE, INIT, CHECK_1, CHECK_2, DECR, INCR, END_LOOP, OUT} state_t;
state_t state;

always_ff @ (posedge clk) begin
    if (rst) begin
        state <= IDLE;
        x <= 0;
        i <= 0;
    end else
        case (state)
            IDLE:
                if (start)
                    state <= INIT;
            INIT: begin
                x <= 0;
                i <= 0;
                state <= CHECK_1;
            end
            CHECK_1:
                if (i<100)
                    state <= CHECK_2;
                else
                    state <= OUT;
            CHECK_2:
                if (a[i]>0)
                    state <= INCR;
                else
                    state <= DECR;
            INCR: begin
                x <= x + 1;
                state <= END_LOOP;
            end
            DECR: begin
                x <= x - 1;
                state <= END_LOOP;
            end
            END_LOOP: begin
                a[i] <= x;
                i <= i + 1;
                state <= CHECK_1;
            end
            OUT: begin
                out <= x;
                state <= IDLE;
            end
        endcase
end

endmodule
