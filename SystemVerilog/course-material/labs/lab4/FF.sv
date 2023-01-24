module FF(
    input logic clk,
    input logic rst,
    input logic [8:0] old_data,
    output logic [8:0] new_data
);

always_ff @(posedge clk) begin
    if(rst)
        new_data <= 0;
    else
        new_data <= old_data;
end

endmodule
