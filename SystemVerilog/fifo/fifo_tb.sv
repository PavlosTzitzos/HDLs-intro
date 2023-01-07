`timescale 1ns/1ps

module fifo_tb;

parameter DW = 16;
parameter DEPTH = 4;

logic clk, rst;
logic push, pop, full, empty;
logic [DW-1:0] wd, rd;

// Instantitation of our design
fifo_duth #(.DW(DW), .DEPTH(DEPTH)) dut(
  .clk        (clk),
  .rst        (rst),
  .push       (push),
  .write_data (wd),
  .full       (full),
  .pop        (pop),
  .read_data  (rd),
  .empty      (empty)
);

// generate clock signal
/*initial begin
clk = 0;
forever #5ns clk = ~clk;
end*/
always begin
  clk = 1;
  #5ns;
  clk = 0;
  #5ns;
end

initial begin
  $monitor($time);
  $dumpfile("dumpfifo.vcd");
  $dumpvars(1);
  $monitor("Starting Simulation");
  push <= 0;  // Set starting values
  pop  <= 0;
  rst  <= 0;
  wd   <= 0;

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
  repeat(5) begin
    POP();
  end
  PUSH(5);
  // End of demo simulation example
  
  
  // Extra simulation example
  push <= 1;         // start push
  wd <= 7;
  @(posedge clk);
  wd <= 14;
  @(posedge clk);
  wd <= 4;            
  pop <= 1;          // start pop
  $strobe("Read data -> %d", rd);
  @(posedge clk);    // From now on push and pop happen together
  wd <= 13;
  $strobe("Read data -> %d", rd);
  @(posedge clk);
  wd <= 25;
  $strobe("Read data -> %d", rd);
  @(posedge clk);
  wd <= 32;
  $strobe("Read data -> %d", rd);
  @(posedge clk);
  wd <= 9;
  $strobe("Read data -> %d", rd);
  @(posedge clk);
  pop <= 0;          // Stop pop
  wd <= 21;
  @(posedge clk);    // From now on data should not be stored in FIFO because its full
  wd <= 22;
  @(posedge clk);
  wd <= 23;
  @(posedge clk);
  wd <= 24;
  pop <= 1;          // Start pop
  @(posedge clk);    // From now on push and pop happen together
  $strobe("Read data -> %d", rd);
  wd <= 51;
  @(posedge clk);    
  $strobe("Read data -> %d", rd);
  push <= 0;         // Stop push
  wd <= 21;          // 21 will not be stored in FIFO because push is 0
  @(posedge clk);   
  $strobe("Read data -> %d", rd);
  wd <= 20;         // 20 will not be stored in FIFO because push is 0
  @(posedge clk);    
  $strobe("Read data -> %d", rd);
  @(posedge clk);    
  $strobe("Read data -> %d", rd);
  @(posedge clk);   
  $strobe("Read data -> %d", rd);
  @(posedge clk);    // From now on rd has the same value because FIFO is empty;
  $strobe("Read data -> %d", rd);
  pop <= 0;
  @(posedge clk)
  
  
  
  $display("Simulation Finished");
  $stop();
end

task PUSH(input [DW-1:0] X); 
  begin
    push <= 1;
    wd <= X;
    @(posedge clk);
    //$strobe("@%0t: Fifo values are: %d, %d, %d, %d", $time, DUT.mem[0], DUT.mem[1], DUT.mem[2], DUT.mem[3]);
    push <= 0;
    @(posedge clk);
  end
endtask

task POP(); 
  begin
    pop <= 1;
    $strobe("@%0t: Read data -> %d", $time, rd);
    @(posedge clk);
    pop <= 0;
    @(posedge clk);
  end
endtask



endmodule