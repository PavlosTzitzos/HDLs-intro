/* DRAM memory
 * 
 * supports:
 *  . clock
 *  . reset
 *  . write enable
 *  . seperate read/write ports
 * 
 */

module dmem(
    input logic clk,
    input logic rst,
    input logic write_en,
    input logic [31:0] write_data,
    input logic [31:0] addr,
    output logic [31:0] read_data
);

logic [31:0] [31:0] mem;

always_ff@(posedge clk) begin
    if(write_en)
        mem[addr] <= write_data;
end

assign read_data = mem[addr];

endmodule
