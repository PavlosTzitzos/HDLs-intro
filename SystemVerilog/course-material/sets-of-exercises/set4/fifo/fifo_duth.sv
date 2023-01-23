/**
 * @info fifo_duth
 *
 * @author VLSI Lab, EE dept., Democritus University of Thrace
 *
 * @brief FIFO circular buffer. Uses an input decoder to store to the proper place and an output MUX to select the proper output data.
 *
 * @param DW data width
 * @param DEPTH number of buffer slots. Note: If 1, leads to 50% throughput, so use @see eb_one_slot with FULL_THROUGHPUT asserted.
 */
 
module fifo_duth
#(
    parameter int DW    = 16,
    parameter int DEPTH = 4
)
(
    input  logic            clk,
    input  logic            rst,
    // input channel
    input  logic[DW-1:0]    write_data,
    input  logic            push,
    output logic            full,
    // output channel
    output logic[DW-1:0]    read_data,
    output logic            empty,
    input  logic            pop
);
    
logic[DEPTH-1:0][DW-1:0]    mem;
logic[DEPTH-1:0]            tail;
logic[DEPTH-1:0]            head;
logic[DEPTH  :0]            status_cnt;

assign empty = status_cnt[0];
assign full = status_cnt[DEPTH];

//Pointer update (one-hot shifting pointers)
always_ff @ (posedge clk, posedge rst) begin: ff_tail
    if (rst) begin
        tail <= 0;
    end else begin
        // push pointer
        if (push && (pop || !full)) begin
            tail <= tail + 1;
            if (tail == DEPTH-1)
              tail <= 0;
        end
    end
end
always_ff @ (posedge clk, posedge rst) begin: ff_head
    if (rst) begin
        head <= 0;
    end else begin
        // pop pointer
        if (pop && !empty) begin
            head <= head + 1;
            if (head == DEPTH-1)
              head <= 0;
        end
    end
end
    
// Status (occupied slots) Counter
always_ff @ (posedge clk, posedge rst) begin: ff_status_cnt
    if (rst) begin
        status_cnt <= 1; // status counter onehot coded
    end else begin
        if (push & ~pop & ~full) begin
            // shift left status counter (increment)
            status_cnt <= { status_cnt[DEPTH-1:0],1'b0 } ;
        end else if (~push &  pop & ~empty) begin
            // shift right status counter (decrement)
            status_cnt <= {1'b0, status_cnt[DEPTH:1] };
        end
    end
end
 
// data write (push) 
// address decoding needed for onehot push pointer
always_ff @ (posedge clk) begin: ff_reg_dec
    if ( push && ( pop || !full)) begin
        mem[tail] <= write_data;
    end
end

assign read_data = mem[head];

endmodule
