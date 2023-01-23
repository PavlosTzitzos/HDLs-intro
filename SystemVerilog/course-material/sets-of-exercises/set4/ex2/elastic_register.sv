
module elastic_register(
    input logic clk,
    input logic rst,
    input logic[7:0] data_in,
    input logic valid_in,
    input logic ready_in,
    output logic[7:0] data_out,
    output logic valid_out,
    output logic ready_out
);

assign enable = (!valid_out)|ready_in;
assign ready_out = enable;

always_ff@(posedge clk) begin: valid_register
    if(rst)
        valid_out <= 0;
    else begin
        if(enable) begin
            valid_out <= valid_in;
        end
    end
end

always_ff@(posedge clk) begin: data_register
    if(rst)
        data_out <= 0;
    else begin
        if(enable) begin
            data_out <= data_in;
        end
    end
end

endmodule
