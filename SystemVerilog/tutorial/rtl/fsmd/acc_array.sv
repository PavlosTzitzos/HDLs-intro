
module acc_array (
    // to/from outside world
    input logic clk, 
    input logic START,
    output logic done,
    output logic [7:0] acc,
    // to-from memory
    input logic [7:0] in_data, 
    output logic [7:0] addr
);

enum logic[2:0] {INIT,CHECK,END_FSMD,LOAD,ADD,INC} state;

logic [7:0] in_data; // data read from a[i]

always_ff @(posedge clk) begin
    if (START)
        state <= INIT; // on start move to init
    else
        case (state)
            INIT: begin
                acc<=0;
                i<=0;
                addr <= 0; // action
                state <= CHECK; // next state
            end
            CHECK:
                if (i<128) state <= LOAD;
                else state <= END_FSMD;
            END_FSMD:
                done <= 1;
            LOAD: begin
                in_data <= rd_data;
                state <= ADD;
            end
            ADD: begin
                acc <= acc+in_data;
                state <= INC;
            end
            INC: begin
                i<=i+1;
                addr <= addr+1;
                state <= CHECK;
            end
            default:
                state <= END_FSMD;
        endcase
end

endmodule
