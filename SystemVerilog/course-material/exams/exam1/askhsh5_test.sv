`timescale 1ns/1ps
module askhsh5_test;
logic clk,rst,tick;
logic [2:0] slow_cnt;

askhsh5 dut (.clk(clk), .rst(rst), .tick(tick), .slow_cnt(slow_cnt));

initial begin
clk = 0;
forever #5ns clk = ~clk;
end

initial begin
$dumpfile("dump5.vcd");
$dumpvars(1);
@(negedge clk);
#4ns;
rst = 1;
#5ns;
rst = 0;

#100ns;
$stop;
end

endmodule
