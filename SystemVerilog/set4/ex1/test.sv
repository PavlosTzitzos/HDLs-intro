`timescale 1ns/1ps

module test;


parameter DW = 8;
parameter DEPTH = 4;

logic clk;
logic rst;
logic [DW-1:0] din_i;
logic write_i;
logic full_o;
logic [DW-1:0] dout_o;
logic read_i;
logic empty_o;

// generate clock signal
always begin
  clk = 1;
  #5ns;
  clk = 0;
  #5ns;
end

duplicate_fifo dut (
  .clk(clk),
  .rst(rst),
  .data_in(din_i),
  .write(write_i),
  .full(full_o),
  .data_out(dout_o),
  .read(read_i),
  .empty(empty_o)
);

initial begin
  $dumpfile("dumpset1.vcd");
  $dumpvars(1);
  $display("Starting Simulation");
  write_i <= 0;  // Set starting values
  read_i  <= 0;
  rst     <= 0;
  din_i   <= 0;

  @(posedge clk); // First positive edge of the clock 
  rst <= 1;
  @(posedge clk); // Second positive edge of the clock
  rst <= 0;
  @(posedge clk);
  
  // Demo Simulation example
  PUSH(1);
  PUSH(2);
  PUSH(3);
  PUSH(4);
  PUSH(5);
  repeat(10) begin
    POP();
  end
  PUSH(5);
  // End of demo simulation example
  
  
  // Extra simulation example
  write_i <= 1;         // start push
  din_i <= 7;
  @(posedge clk);
  din_i <= 14;
  @(posedge clk);
  din_i <= 4;            
  read_i <= 1;          // start pop
  $strobe("Read data -> %d", dout_o);
  @(posedge clk);    // From now on push and pop happen together
  din_i <= 13;
  $strobe("Read data -> %d", dout_o);
  @(posedge clk);
  din_i <= 25;
  $strobe("Read data -> %d", dout_o);
  @(posedge clk);
  din_i <= 32;
  $strobe("Read data -> %d", dout_o);
  @(posedge clk);
  din_i <= 9;
  $strobe("Read data -> %d", dout_o);
  @(posedge clk);
  read_i <= 0;          // Stop pop
  din_i <= 21;
  @(posedge clk);    // From now on data should not be stored in FIFO because its full
  din_i <= 22;
  @(posedge clk);
  din_i <= 23;
  @(posedge clk);
  din_i <= 24;
  read_i <= 1;          // Start pop
  @(posedge clk);    // From now on push and pop happen together
  $strobe("Read data -> %d", dout_o);
  din_i <= 51;
  @(posedge clk);    
  $strobe("Read data -> %d", dout_o);
  write_i <= 0;         // Stop push
  din_i <= 21;          // 21 will not be stored in FIFO because push is 0
  @(posedge clk);   
  $strobe("Read data -> %d", dout_o);
  din_i <= 20;         // 20 will not be stored in FIFO because push is 0
  @(posedge clk);    
  $strobe("Read data -> %d", dout_o);
  @(posedge clk);    
  $strobe("Read data -> %d", dout_o);
  @(posedge clk);   
  $strobe("Read data -> %d", dout_o);
  @(posedge clk);    // From now on dout_o has the same value because FIFO is empty;
  $strobe("Read data -> %d", dout_o);
  read_i <= 0;
  @(posedge clk)
  
  
  
  $display("Simulation Finished");
  $stop();
end

task PUSH(input [DW-1:0] X); 
  begin
    write_i <= 1;
    din_i <= X;
    @(posedge clk);
    //$strobe("@%0t: Fifo values are: %d, %d, %d, %d", $time, dut.mem[0], dut.mem[1], dut.mem[2], dut.mem[3]);
    write_i <= 0;
    @(posedge clk);
  end
endtask

task POP(); 
  begin
    read_i <= 1;
    $strobe("@%0t: Read data -> %d", $time, dout_o);
    @(posedge clk);
    read_i <= 0;
    @(posedge clk);
  end
endtask

endmodule
