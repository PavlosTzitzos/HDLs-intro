
module duplicate_fifo
#(
    parameter int DW    = 8,
    parameter int DEPTH = 4
)
(
    input  logic            clk,
    input  logic            rst,
    // input channel
    input  logic[DW-1:0]    data_in,
    input  logic            write,
    output logic            full,
    // output channel
    output logic[DW-1:0]    data_out,
    output logic            empty,
    input  logic            read
);

logic [DW-1:0] data;
logic pop_internal;
logic empty_internal;
logic push_internal;
logic full_internal;

fifo_duth 
#(
  .DW(DW),
  .DEPTH(DEPTH))
DUT1 (
  .clk(clk),
  .rst(rst),
  .write_data(data_in),
  .push(write),
  .full(full),
  .read_data(data),
  .pop(pop_internal),
  .empty(empty_internal)
);

assign pop_internal = ~empty_internal & ~full_internal;
assign push_internal = ~empty_internal & ~full_internal;

copy_queue
#(
    .DW(DW),
    .DEPTH(DEPTH))
DUT2 (
  .clk(clk),
  .rst(rst),
  .write_data(data),
  .push(push_internal),
  .full(full_internal),
  .read_data(data_out),
  .pop(pop_read),
  .empty(empty)
);

logic pop_read;
logic cnt_reads;
logic[1:0] cnt;

always_ff @(posedge clk) begin: count_reads
    if(rst)
        cnt <= 0;
    else begin
        if(read)
            cnt <= cnt + 1;
    end
end
/*
always_ff @(posedge clk) begin: count_2_reads
    if (rst)
        cnt_reads <= 0;
    else begin
        if(read && !empty) begin
            //if we try to read and it is not empty then reads counter counts + 1.
            cnt_reads <= 0;
        end else if(!read && !cnt_reads) begin
            if(cnt==1 || cnt == 3)
                cnt_reads <= 1;
        end
    end
end

always_ff@(posedge clk) begin: when_to_pop
    if(rst)
        pop_read <= 0;
    else begin
        if(cnt_reads)
            pop_read <= 1;
        else
            pop_read <= 0;
    end
end
*/
always_ff @(posedge clk) begin: count_2_reads
    if (rst) begin
        cnt_reads <= 0;
        pop_read <= 0;
    end else begin
        if((!read && !cnt_reads) && (cnt==1 || cnt == 3))
            cnt_reads <= 1;
        else if(read && !empty)
            cnt_reads <= 0;
        
        if(cnt_reads)
            pop_read <= 1;
        else
            pop_read <= 0;
    end
end

endmodule
