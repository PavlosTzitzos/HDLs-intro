/*
Testbench for mealy fsm.
For Icarus Verilog run on terminal:
> iverilog -g2012 -o output_file_name sample_fsm_mealy_test.sv sample_fsm_mealy.sv
Then :
> vvp output_file_name
With VSCode with TraceViewer click  on dump.vcd to view the waveforms.

*/
module sample_fsm_mealy_test;
// wires:
logic clk;
logic rst;
logic in;
logic out;

//instatiation of module:
sample_fsm_mealy DUT(
    .clk(clk),
    .rst(rst),
    .in(in),
    .out(out)
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
    // state = S0
    // and
    // reset = 1 then 0 again
    clk = 0;
    rst = 1;
    in = 0;
    #15; // after 15 sec do :
    rst = 0;
    #5; // after 5 sec do :
    in = 1;
    #25; // after 25 sec do :
    in = 0;
    #20; // after 20 sec do :
    in = 1;
    #30; // after 30 sec do :
    $finish; // finish vvp
    // in = 1 move from state S0 to S1
    // then it will go to state S2
    // and it will stay there cause tdone is 0.
end

endmodule
