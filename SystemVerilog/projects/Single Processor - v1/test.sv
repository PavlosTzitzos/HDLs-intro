/* Testbench on for all files
 * 
 * uncomment the area to use
 * 
 * this was tested with icarus verilog
 * 
 * open cmd
 * go to the current directory
 * use the command:
 * 
 *      iverilog -g2012 -o test test.sv     (1)
 * 
 * the include files help shorten the above command length
 * the timescale command is necessary for icarus
 * 
 * to generate a file with gaveforms after command (1) type:
 * 
 *              vvp test                    (2)
 * 
 */

`timescale 1ns/1ps


// section for ALU.sv only
/*
`include "ALU.sv"
module test;
logic clk;
logic [31:0] A , B , C;
logic [1:0] selALU;
logic [5:0] status;

always #5ns clk = ~clk;

ALU DUT(
    .A(A),
    .B(B),
    .C(C),
    .selALU(selALU),
    .status(status)
);

initial begin
$display("Starting Simulation");
$monitor("$time");
$dumpfile("dumpfile.vcd");
$dumpvars(1);

clk = 0;
#10ns;
A = 32'h2;
B = 32'h5;
selALU = 2'b00;
#10ns;
A = 32'h3;
B = 32'h0;
#10ns;
$stop();
end
endmodule

// section for regfile.sv only
`include "regfile.sv"
module test;
logic clk;
logic [5:0] read_a;
logic [5:0] read_b;
logic write;
logic [5:0] write_addr;
logic [31:0] Rin;
logic [31:0] Ra;
logic [31:0] Rb;

always #5ns clk = ~clk;

regfile DUT(
    .clk(clk),
    .read_a(read_a),
    .read_b(read_b),
    .write(write),
    .write_addr(write_addr),
    .Rin(Rin),
    .Ra(Ra),
    .Rb(Rb)
);

initial begin
$display("Starting Simulation");
$monitor("$time");
$dumpfile("dumpfile.vcd");
$dumpvars(1);

clk = 0;
write = 0;
#10ns;
write = 1;
#10ns;
write_addr = 32'h0;
Rin = 32'h0;
#10ns;
write = 0;
#10ns;
read_a = 32'h0;
read_b = 32'h1;
#10ns;
write = 1;
#10ns;
write_addr = 32'h1;
Rin = 32'h2;
#10ns;
write = 0;
#10ns;
read_a = 32'h0;
read_b = 32'h1;
#10ns;
$stop();
end
endmodule

// section for pc.sv only
`include "pc.sv"
module test;
logic clk;
logic rst;
logic [31:0] pc_plus_4, pc_plus_4_out;
logic [31:0] pc;
logic [31:0] jr_target;
logic [31:0] jal_br_target;
logic [0:1] pc_sel;

always #5ns clk = ~clk;

pc DUT(
    .clk(clk),
    .rst(rst),
    .pc_plus_4(pc_plus_4_out),
    .pc(pc),
    .jr_target(jr_target),
    .jal_br_target(jal_br_target),
    .pc_sel(pc_sel),
    .pc_plus_4_out(pc_plus_4_out)
);

initial begin
$display("Starting Simulation");
$monitor("$time");
$dumpfile("dumpfile.vcd");
$dumpvars(1);
clk = 0;
rst = 0;
#4ns;
rst=1;
#6ns;
rst=0;
#10ns;
jr_target = 32'h0;
jal_br_target = 32'h0;
pc_sel = 2'b00;
#10ns;
pc_sel = 2'b00;
#10ns;

#10ns;

#100ns;
$stop();
end
endmodule

// section for pc, execute , DMEM , regfile , ALU 

`include "regfile.sv"
`include "pc.sv"
`include "DMEM.sv"
`include "execute.sv"

module test;
logic clk, rst;

//regfile:
logic [4:0] addr_a;
logic [4:0] addr_b;
logic write;
logic [4:0] write_addr;
logic [31:0] Rin;
logic [31:0] read_a;
logic [31:0] read_b;

//pc:
logic [31:0] pc_plus_4, pc_plus_4_out;
logic [31:0] pc;
logic [31:0] jr_target;
logic [31:0] jal_br_target;
logic [1:0] pc_sel;

//execute:
logic [24:0] imm;
// Output Data
logic eq;
// Control Signals
logic imm_type;
logic [1:0] op2_sel;
logic [2:0] alu_func;
logic [1:0] shft;
logic [1:0] wb_sel;

//dmem:
logic write_en;
logic [31:0] write_data;
logic [31:0] addr;
logic [31:0] read_data;

//DUTs:

regfile DUT1(
    .clk(clk),
    .read_a(read_a),
    .read_b(read_b),
    .write(write),
    .write_addr(write_addr),
    .Rin(Rin),
    .addr_a(addr_a),
    .addr_b(addr_b)
);

pc DUT2(
    .clk(clk),
    .rst(rst),
    .pc_plus_4(pc_plus_4_out),
    .pc(pc),
    .jr_target(jr_target),
    .jal_br_target(jal_br_target),
    .pc_sel(pc_sel),
    .pc_plus_4_out(pc_plus_4_out)
);

dmem DUT3(
    .clk(clk),
    .rst(rst),
    .write_en(write_en),
    .write_data(write_data),
    .addr(addr),
    .read_data(read_data)
);

execute DUT4(
    // Input Data
    .imm(imm),
    .pc(pc),
    .pc_plus_4_out(pc_plus_4_out),
    .A(read_a),
    .B(read_b),
    .shamt(addr_b),
    .read_data(read_data),
    // Output Data
    .jal_br_target(jal_br_target),
    .write_data(write_data),
    .addr(addr),
    .Rin(Rin),
    .eq(eq),
    // Control Signals
    .imm_type(imm_type),
    .op2_sel(op2_sel),
    .alu_func(alu_func),
    .shft(shft),
    .wb_sel(wb_sel)
);

//clock :
always #5ns clk = ~clk;

// simulation :
initial begin
$display("Starting Simulation");
$monitor("$time");
$dumpfile("dumpfile.vcd");
$dumpvars(1);

// clock
clk = 0;
// reset
rst = 1;
# 10ns;
// Control signals:
pc_sel = 2'b00;
imm_type = 0;
op2_sel = 2'b00;
alu_func = 2'b00;
shft = 2'b00;
write_en = 0;
wb_sel = 2'b01;
write = 0;
#5ns;
rst = 0;
#10ns;

$stop();
end
endmodule
*/
// section for fetch.sv only
`include "fetch.sv"
module test;
logic clk;
logic rst;
logic [31:0] pc_plus_4_out;
logic [31:0] pc;
logic [31:0] jr_target;
logic [31:0] jal_br_target;
logic [0:1] pc_sel;

always #5ns clk = ~clk;

fetch DUT(
    .clk(clk),
    .rst(rst),
    .pc(pc),
    .jr_target(jr_target),
    .jal_br_target(jal_br_target),
    .pc_sel(pc_sel),
    .pc_plus_4_out(pc_plus_4_out)
);

initial begin
$display("Starting Simulation");
$monitor("$time");
$dumpfile("dumpfile.vcd");
$dumpvars(1);
clk = 0;
rst = 0;
#4ns;
rst=1;
#6ns;
rst=0;
#10ns;
jr_target = 32'h0;
jal_br_target = 32'h0;
pc_sel = 2'b00;
#10ns;
pc_sel = 2'b00;
#10ns;

#10ns;

#100ns;
$stop();
end
endmodule
