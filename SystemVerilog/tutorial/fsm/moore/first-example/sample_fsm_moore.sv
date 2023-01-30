/*
This is a sample first example to fsm moore in systemverilog
*/

module sample_fsm_moore(
    input logic clk,
    input logic reset,
    input logic token,
    input logic tdone,

    output logic clrt,
    output logic spray
);

//declare fsm:
// type: logic , length: 2 bits ,
// symbolic names of states: sIdle , sToken, sSpray
// coding of states: 0 , 1 , 2 for binary representation
// coding of states: 3'b001 , 3'b010 , 3'b100 for onehot representation
// name of the fsm: fsm_state
typedef enum logic[1:0] {sIdle=0 , sToken=1, sSpray=2} fsm_state;
//create the state variable with name "state" :
fsm_state state;

// Now create one always_ff block :
always_ff @(posedge clk) begin : my_fsm
    if(reset)
        state <= sIdle;
    else begin
        case(state)
            sIdle:
                if(token) state <= sToken;
                else state <= sIdle;
            sToken:
                state <= sSpray;
            sSpray:
                if(tdone) state <= sIdle;
                else state <= sSpray;
        endcase
    end
end
//Output:
// next step is to create the combinational logic for the outputs
assign clrt = (state == sToken);
assign spray = (state == sToken || state == sSpray);

endmodule
