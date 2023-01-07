`timescale 1ns/1ps

module top_test;
logic clk;
logic rst;
logic button_left;
logic button_right;
logic button_up;
logic button_down;
logic button_play;
logic winA;
logic winB;
logic tie;
logic [3:0] cursor_test;
logic [3:0] position_test;
logic [8:0] rX_test,rO_test;
logic turn_test;

top dut (
    .clk(clk),
    .rst(rst),
    .button_left(button_left),
    .button_right(button_right),
    .button_up(button_up),
    .button_down(button_down),
    .button_play(button_play),
    .winA(winA),
    .winB(winB),
    .tie(tie),
    .cursor_test(cursor_test),
    .position_test(position_test),
    .rX_test(rX_test),
    .rO_test(rO_test),
    .turn_test(turn_test)
);

initial begin 
    clk = 0;
    forever #5ns clk = ~clk;
end

initial begin
    $dumpfile("dumptop.vcd");
    $dumpvars(1);
    //clk = 0;
    rst = 0;
    button_left = 0;
    button_right = 0;
    button_up = 0;
    button_down = 0;
    button_play = 0;
    #2ns;
    rst = 1;
    #5ns;
    rst = 0;
    #3ns;
    //clk = first negedge;
    button_right = 1; // move cursor at block 1.
    #6ns;
    button_right = 0;
    #14ns;
    button_play = 1; // X plays - 1st move of the game
    #6ns;
    button_play = 0; // O_turn = 0 , X_turn = 1
    #14ns;
    //button_left = 1; // move cursor at block 0.
    #6ns;
    //button_left = 0;
    #14ns;
    //button_play = 1; // O plays - 2nd move of the game
    #6ns;
    //button_play = 0; // O_turn = 1 , X_turn = 0
    #14ns;
    //button_right = 1; // move cursor at block 1.
    #6ns;
    //button_right = 0;
    #14ns;
    button_down = 1; // move cursor at block 4.
    #6ns;
    button_down = 0;
    #14ns;
    button_play = 1; // X plays - 3rd move of the game
    #6ns;
    button_play = 0; // O_turn = 0 , X_turn = 1
    #14ns;
    //button_left = 1; // move cursor at block 3.
    #6ns;
    //button_left = 0;
    #14ns;
    //button_play = 1; // O plays - 4th move of the game
    #6ns;
    //button_play = 0; // O_turn = 1 , X_turn = 0
    #14ns;
    button_down = 1; // move cursor at block 6.
    #6ns;
    button_down = 0;
    #14ns;
    //button_right = 1; // move cursor at block 7.
    #6ns;
    //button_right = 0;
    #14ns;
    button_play = 1; // X plays - 5th move of the game
    #6ns;
    button_play = 0; // O_turn = 0 , X_turn = 1
    
    #20ns;// game finish , X player wins
    $stop;
    $finish;
end

endmodule
