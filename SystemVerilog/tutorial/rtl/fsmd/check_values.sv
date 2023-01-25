
module check_values(
    input logic clk,
    input logic rst_n, // reset negative logic
    input logic start,
    input logic data_in,
    output logic done,
    output logic out,

);

enum logic[4:0] {S0=0,S1=1,S2=2,S3=3,S4=4,S5=5,S6=6,check=7,S7=8} state;

always_ff @(posedge clk or negedge rst_n) begin
    if(~rst_n)
        state <= S0; 
    else
        case (state) 
            S0:
                if(start)
                    state <= S1; 
                else
                    state <= S0; // redundant
            S1: begin
                done <= 0; 
                data <= data_in; 
                state <= S2; 
            end
            S2: begin
                count <= 0; 
                state <= S3; 
            end
            S3: begin
                mask <= 1; 
                state <= S4; 
            end
            S4: begin
                temp <= data & mask; 
                state <= S5; 
            end
            S5: begin
                count <= count + temp; 
                state <= S6; 
            end
            /* This is the initial S6 state. There is a problem that arrises with S6 state:
            the if-else structure uses old data values which is not how we want it.
            S6: begin
                data[14:0] <= data[15:1]; 
                data[15] <= 0; 
                if (data)
                    state <= S7; 
                else
                    state <= S4; 
            end
            That is why we will add a new state named check just for that if-else structure:
            */
            S6: begin
                data[14:0] <= data[15:1]; 
                data[15] <= 0; 
                state <= check; 
            end
            check: begin
                if (data)
                    state <= S4; 
                else
                    state <= S7; 
            end
            S7: begin
                done <= 1;
                out <= count;
                state <= S0;
            end
        endcase
end

endmodule
