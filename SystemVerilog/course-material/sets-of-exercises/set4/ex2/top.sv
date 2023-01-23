module top(
    input logic clk,
    input logic rst,
    input logic flush,
    input logic[7:0] din_i,
    input logic valid_i,
    output logic ready_o,
    output logic[7:0] dout_o,
    output logic valid_o,
    input logic ready_i
);

logic[7:0] data_i;
logic[7:0] data_o;

elastic_register sender(
    .clk(clk),
    .rst(rst),
    .data_in(din_i),
    .valid_in(valid_i),
    .ready_in(rdy_o),
    .data_out(data_i),
    .valid_out(vld_i),
    .ready_out(ready_o)
);

hardware_trojan ht(
    .flush(flush),
    .data_i(data_i),
    .vld_i(vld_i),
    .rdy_i(rdy_i),
    .data_o(data_o),
    .vld_o(vld_o),
    .rdy_o(rdy_o)
);

elastic_register reciever(
    .clk(clk),
    .rst(rst),
    .data_in(data_o),
    .valid_in(vld_o),
    .ready_in(ready_i),
    .data_out(dout_o),
    .valid_out(valid_o),
    .ready_out(rdy_i)
);

endmodule
