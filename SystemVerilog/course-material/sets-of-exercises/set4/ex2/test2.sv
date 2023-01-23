`timescale 1ns/1ps

module test2;
logic clk;
logic rst;
logic flush;
logic[7:0] din_i;
logic valid_i;
logic ready_o;
logic[7:0] dout_o;
logic valid_o;
logic ready_i;


top dut(
    .clk(clk),
    .rst(rst),
    .flush(flush),
    .din_i(din_i),
    .valid_i(valid_i),
    .ready_o(ready_o),
    .dout_o(dout_o),
    .valid_o(valid_o),
    .ready_i(ready_i)
);

always begin
    clk = 0;
    #5ns;
    clk = 1;
    #5ns;
end

initial begin
    $dumpfile("dumpset2.vcd");
    $dumpvars(1);

    rst     <= 0;
    flush   <= 0;
    valid_i <= 0;
    ready_i <= 0;
    din_i  <= 0;

    @(posedge clk); // First positive edge of the clock 
    rst <= 1;
    @(posedge clk); // Second positive edge of the clock
    rst <= 0;
    @(posedge clk);

    READY(1);
    SENT_DATA(7);
    SENT_DATA(6);
    SENT_DATA(0);
    SENT_DATA(5);
    SENT_DATA(4);
    SENT_DATA(0);
    SENT_DATA(3);
    SENT_DATA(2);
    SENT_DATA(0);
    SENT_DATA(1);
    SENT_DATA(0);
    
    @(posedge clk);
    flush <= 1;

    SENT_DATA(7);
    SENT_DATA(6);
    SENT_DATA(0);
    SENT_DATA(5);
    SENT_DATA(4);
    SENT_DATA(0);
    SENT_DATA(3);
    SENT_DATA(2);
    SENT_DATA(0);
    SENT_DATA(1);
    SENT_DATA(0);
    
    $stop();
end

task SENT_DATA(input [7:0] X);
begin
    @(posedge clk);
    din_i <= X;
    valid_i <= 1;
end
endtask

task READY(input Y);
begin
    @(posedge clk);
    ready_i <= Y;
end
endtask

endmodule