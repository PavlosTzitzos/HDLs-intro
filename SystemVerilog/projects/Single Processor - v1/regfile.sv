/* Register File 
 * 
 * with 32 registers 
 * each register has 32-bit length
 * 
 * clk : clock
 * read_a : address to read register A
 * read_b : address to read register B
 * Ra : data from address read_a
 * Rb : data from address read_b
 * 
 * write : write enable
 * write_addr : the address to write the data
 * Rin : the data to write in address write_addr
 * 
*/

module regfile(
    input logic clk,
//    input logic rst,
    input logic [4:0] addr_a,
    input logic [4:0] addr_b,
    input logic write,
    input logic [4:0] write_addr,
    input logic [31:0] Rin,
    output logic [31:0] read_a,
    output logic [31:0] read_b
);

logic [31:0][31:0] mem;

always_ff@(posedge clk) begin
    if(write)
        mem[write_addr] <= Rin;
end

assign read_a = mem[addr_a];
assign read_b = mem[addr_b];

endmodule
