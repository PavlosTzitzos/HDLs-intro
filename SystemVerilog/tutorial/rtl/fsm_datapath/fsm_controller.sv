module fsm_controller (
    // I/O interface
    // to/from outside world
    input logic clk, 
    input logic start,
    output logic done,
    // from/to datapath
    output logic sum_sel,
    output logic ld_sum,
    output logic pnt_sel,
    output logic ld_pnt,
    output logic a_sel,
    input logic pnt_zero
);

typedef enum logic[3:0] {START=4’b0001, COMP_SUM=4’b0010, GET_NEXT=4’b0100, DONE=4’b1000} fsm_state;
fsm_state state;

// fsm state transitions
always_ff @(posedge clk) begin
    if (start)
        state <= START;
    else
    case (state)
        START:
            if (start==0) state <= COMP_SUM;
        COMP_SUM:
            if (start==0) state <= GET_NEXT; 
        GET_NEXT:
            if (pnt_zero==1) state <= DONE;
            else if (start==0) state <= COMP_SUM; 
        DONE:
            if (start==1) start <= START;
        default:
            state <= START;
    endcase
end

// output logic
assign ld_sum = (state==START) || (state==COMP_SUM);
assign sum_sel = (state==COMP_SUM);
assign ld_pnt = (state==START) || (state==GET_NEXT);
assign pnt_sel = (state==GET_NEXT);
assign a_sel = (state==COMP_SUM);
assign done = (state==DONE);

endmodule
