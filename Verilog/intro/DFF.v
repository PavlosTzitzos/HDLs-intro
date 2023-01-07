    // referencedesigner.com
    // D Flip Flop without Reset
     
    module d_ff
       (
        input wire Clock,
        input wire D,
        output reg Q
       );
     
       always @(posedge Clock)
          Q = D;
    endmodule