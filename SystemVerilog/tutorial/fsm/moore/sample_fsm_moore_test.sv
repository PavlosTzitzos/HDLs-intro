
module sample_fsm_moore_test;
// wires:
logic clk;
logic reset;
logic token;
logic tdone;
logic clrt;
logic spray;

//instatiation of module:
sample_fsm_moore DUT(
    .clk(clk),
    .reset(reset),
    .token(token),
    .tdone(tdone),
    .clrt(clrt),
    .spray(spray)
);
//create a clk every ten seconds:
always #10 clk = ~clk;

//start simulation:
initial begin
    //start display data to terminal:
    $monitor($time);
    //create a vcd file to view the waveforms:
    $dumpfile("dump.vcd");
    //export all variables:
    $dumpvars(1);
    //intialization:
    // state = sIdle
    // and
    // reset = 1 then 0 again
    clk = 0;
    reset = 1;
    token=0;
    tdone=0;
    #15;
    reset=0;
    #5;
    token=1;
    #15;
    $finish;
    // token = 1 move from state sIdle to sToken
    // then it will go to state sSpray
    // and it will stay there cause tdone is 0.
end

endmodule
