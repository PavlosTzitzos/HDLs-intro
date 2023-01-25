
module fibonacci(
    // to/from outside world
    input logic clk,
    input logic START,
    input logic [7:0] N,
    output logic done,
    // to-from memory
    output logic [7:0] out
);

enum logic[2:0] {IDLE,CHECK,DONE,COMPUTE} state;

logic [7:0] cnt;
logic [7:0] R0;
logic [7:0] R1;

always_ff @(posedge clk) begin
    if (START)
        state <= IDLE; 
    else
        case (state)
            INIT: begin
                R0<=1;
                R1<=0;
                cnt<=N; // action
                state<=CHECK; // next state
            end
            CHECK:
                if (cnt>1)
                    state <= COMPUTE;
                else
                    state <= DONE;
            COMPUTE: begin
                cnt<=cnt-1;
                R0 <=R0+R1;
                R1 <=R0;
                state <= CHECK;
            end
            DONE: begin
                done <= 1;
                out <= R0;
            end
            default:
                state <= DONE;
    endcase
end

endmodule
