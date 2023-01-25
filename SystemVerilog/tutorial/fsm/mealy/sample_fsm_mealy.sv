/*
This is a sample first example to fsm mealy in systemverilog
*/

module sample_fsm_mealy(
    input logic clk,
    input logic rst,
    input logic in,

    output logic out
);

//declare fsm:
// type: logic , length: 2 bits ,
// symbolic names of states: S0 , S1 , S2
// coding of states: 0 , 1 , 2 for binary representation
// coding of states: 3'b001 , 3'b010 , 3'b100 for onehot representation
// name of the fsm: fsm_state
typedef enum logic[1:0] {S0=0 , S1=1, S2=2} fsm_state;
//create the state variable with name "state" :
fsm_state state;

// Now create one always_ff block for the FSM state transitions :
always_ff @(posedge clk) begin :my_fsm
    if (rst)
        state <= S0;
    else begin
        case (state)
            S0: if (in) state <= S1; 
            S1: if (!in) state <= S2;
            S2: if (!in) state <= S0;
                else state <= S1;
        endcase
    end
end

//Output:
// next step is to create the combinational logic for the outputs
always_comb begin
    case (state)
        S0: out = 0; // for both transitions 
        S1: out = 0; // equal to 0
        S2: if (in) out = 1;
            else out = 0;
    endcase
end

endmodule
