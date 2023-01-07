module MoveGen(
    input logic[8:0] x,
    input logic[8:0] o,
    output logic[8:0] newO,test1,
    output logic [23:0] test2
);
    // code here
    logic [8:0] win_in_rows,win_in_cols,block_in_rows,block_in_cols;
    logic [5:0] win_in_diags,block_in_diags;
    logic [8:0] move_empty;
    logic win_0, block_1, empty_2;
    logic [8:0] newO_0 = 9'b000000000;
    logic [8:0] newO_1 = 9'b000000000;
    logic [8:0] newO_2 = 9'b000000000;
    logic [1:0] switch;
    // win
    //row cases
    assign win_in_rows[0] = o[0] & o[1]  & ~x[2];
    assign win_in_rows[1] = o[0] & o[2]  & ~x[1];
    assign win_in_rows[2] = o[1] & o[2]  & ~x[0];

    assign win_in_rows[3] = o[3] & o[4]  & ~x[5];
    assign win_in_rows[4] = o[3] & o[5]  & ~x[4];
    assign win_in_rows[5] = o[4] & o[5]  & ~x[3];

    assign win_in_rows[6] = o[6] & o[7]  & ~x[8];
    assign win_in_rows[7] = o[6] & o[8]  & ~x[7];
    assign win_in_rows[8] = o[7] & o[8]  & ~x[6];
    
    //column cases
    assign win_in_cols[0] = o[0] & o[3]  & ~x[6];
    assign win_in_cols[1] = o[0] & o[6]  & ~x[3];
    assign win_in_cols[2] = o[3] & o[6]  & ~x[0];

    assign win_in_cols[3] = o[1] & o[4]  & ~x[7];
    assign win_in_cols[4] = o[1] & o[7]  & ~x[4];
    assign win_in_cols[5] = o[4] & o[7]  & ~x[1];

    assign win_in_cols[6] = o[2] & o[5]  & ~x[8];
    assign win_in_cols[7] = o[2] & o[8]  & ~x[5];
    assign win_in_cols[8] = o[5] & o[8]  & ~x[2];
    
    //diagonal cases
    assign win_in_diags[0] = o[0] & o[4]  & ~x[8];
    assign win_in_diags[1] = o[0] & o[8]  & ~x[4];
    assign win_in_diags[2] = o[4] & o[8]  & ~x[0];

    assign win_in_diags[3] = o[2] & o[4]  & ~x[6];
    assign win_in_diags[4] = o[2] & o[6]  & ~x[4];
    assign win_in_diags[5] = o[4] & o[6]  & ~x[2];
    
    assign win_0 = win_in_rows[0] | win_in_rows[1] | win_in_rows[2] | win_in_rows[3] | win_in_rows[4] | win_in_rows[5] | win_in_rows[6] | win_in_rows[7] | win_in_rows[8] | win_in_cols[0] | win_in_cols[1] | win_in_cols[2] | win_in_cols[3] | win_in_cols[4] | win_in_cols[5] | win_in_cols[6] | win_in_cols[7] | win_in_cols[8] | win_in_diags[0] | win_in_diags[1] | win_in_diags[2] | win_in_diags[3] | win_in_diags[4] | win_in_diags[5];
    assign test2 = {win_in_rows,win_in_cols,win_in_diags};
    always @(*) begin
        case({win_in_rows,win_in_cols,win_in_diags})
            24'b???????????????????????1: newO_0[8] = 1;
            24'b??????????????????????10: newO_0[4] = 1;
            24'b?????????????????????100: newO_0[0] = 1;
            24'b????????????????????1000: newO_0[6] = 1;
            24'b???????????????????10000: newO_0[4] = 1;
            24'b??????????????????100000: newO_0[2] = 1;
            24'b?????????????????1000000: newO_0[6] = 1;
            24'b????????????????10000000: newO_0[3] = 1;
            24'b???????????????100000000: newO_0[0] = 1;
            24'b??????????????1000000000: newO_0[7] = 1;
            24'b?????????????10000000000: newO_0[4] = 1;
            24'b????????????100000000000: newO_0[1] = 1;
            24'b???????????1000000000000: newO_0[8] = 1;
            24'b??????????10000000000000: newO_0[5] = 1;
            24'b?????????100000000000000: newO_0[2] = 1;
            24'b????????1000000000000000: newO_0[2] = 1;
            24'b???????10000000000000000: newO_0[1] = 1;
            24'b??????100000000000000000: newO_0[0] = 1;
            24'b?????1000000000000000000: newO_0[5] = 1;
            24'b????10000000000000000000: newO_0[4] = 1;
            24'b???100000000000000000000: newO_0[3] = 1;
            24'b??1000000000000000000000: newO_0[8] = 1;
            24'b?10000000000000000000000: newO_0[7] = 1;
            24'b100000000000000000000000: newO_0[6] = 1;
            default: newO_0 = 9'b000000000;
        endcase
    end

    // block
    //row cases
    assign block_in_rows[0] = x[0] & x[1]  & ~o[2];
    assign block_in_rows[1] = x[0] & x[2]  & ~o[1];
    assign block_in_rows[2] = x[1] & x[2]  & ~o[0];

    assign block_in_rows[3] = x[3] & x[4]  & ~o[5];
    assign block_in_rows[4] = x[3] & x[5]  & ~o[4];
    assign block_in_rows[5] = x[4] & x[5]  & ~o[3];

    assign block_in_rows[6] = x[6] & x[7]  & ~o[8];
    assign block_in_rows[7] = x[6] & x[8]  & ~o[7];
    assign block_in_rows[8] = x[7] & x[8]  & ~o[6];
    
    //column cases
    assign block_in_cols[0] = x[0] & x[3]  & ~o[6];
    assign block_in_cols[1] = x[0] & x[6]  & ~o[3];
    assign block_in_cols[2] = x[3] & x[6]  & ~o[0];

    assign block_in_cols[3] = x[1] & x[4]  & ~o[7];
    assign block_in_cols[4] = x[1] & x[7]  & ~o[4];
    assign block_in_cols[5] = x[4] & x[7]  & ~o[1];

    assign block_in_cols[6] = x[2] & x[5]  & ~o[8];
    assign block_in_cols[7] = x[2] & x[8]  & ~o[5];
    assign block_in_cols[8] = x[5] & x[8]  & ~o[2];
    
    //diagonal cases
    assign block_in_diags[0] = x[0] & x[4]  & ~o[8];
    assign block_in_diags[1] = x[0] & x[8]  & ~o[4];
    assign block_in_diags[2] = x[4] & x[8]  & ~o[0];

    assign block_in_diags[3] = x[2] & x[4]  & ~o[6];
    assign block_in_diags[4] = x[2] & x[6]  & ~o[4];
    assign block_in_diags[5] = x[4] & x[6]  & ~o[2];

    assign block_1 = block_in_rows[0] | block_in_rows[1] | block_in_rows[2] | block_in_rows[3] | block_in_rows[4] | block_in_rows[5] | block_in_rows[6] | block_in_rows[7] | block_in_rows[8] | block_in_cols[0] | block_in_cols[1] | block_in_cols[2] | block_in_cols[3] | block_in_cols[4] | block_in_cols[5] | block_in_cols[6] | block_in_cols[7] | block_in_cols[8] | block_in_diags[0] | block_in_diags[1] | block_in_diags[2] | block_in_diags[3] | block_in_diags[4] | block_in_diags[5];
    
    always @(*) begin
        case({block_in_rows,block_in_cols,block_in_diags})
            24'b???????????????????????1: newO_1[8] = block_in_diags[0];
            24'b??????????????????????10: newO_1[4] = block_in_diags[1];
            24'b?????????????????????100: newO_1[0] = block_in_diags[2];
            24'b????????????????????1000: newO_1[6] = block_in_diags[3];
            24'b???????????????????10000: newO_1[4] = block_in_diags[4];
            24'b??????????????????100000: newO_1[2] = block_in_diags[5];
            24'b?????????????????1000000: newO_1[6] = block_in_cols[0];
            24'b????????????????10000000: newO_1[3] = block_in_cols[1];
            24'b???????????????100000000: newO_1[0] = block_in_cols[2];
            24'b??????????????1000000000: newO_1[7] = block_in_cols[3];
            24'b?????????????10000000000: newO_1[4] = block_in_cols[4];
            24'b????????????100000000000: newO_1[1] = block_in_cols[5];
            24'b???????????1000000000000: newO_1[8] = block_in_cols[6];
            24'b??????????10000000000000: newO_1[5] = block_in_cols[7];
            24'b?????????100000000000000: newO_1[2] = block_in_cols[8];
            24'b????????1000000000000000: newO_1[2] = block_in_rows[0];
            24'b???????10000000000000000: newO_1[1] = block_in_rows[1];
            24'b??????100000000000000000: newO_1[0] = block_in_rows[2];
            24'b?????1000000000000000000: newO_1[5] = block_in_rows[3];
            24'b????10000000000000000000: newO_1[4] = block_in_rows[4];
            24'b???100000000000000000000: newO_1[3] = block_in_rows[5];
            24'b??1000000000000000000000: newO_1[8] = block_in_rows[6];
            24'b?10000000000000000000000: newO_1[7] = block_in_rows[7];
            24'b100000000000000000000000: newO_1[6] = block_in_rows[8];
            default: newO_1 = 9'b000000000;
        endcase
    end
    //empty
    assign move_empty[0] = ~o[0] & ~x[0];
    assign move_empty[1] = ~o[1] & ~x[1];
    assign move_empty[2] = ~o[2] & ~x[2];
    assign move_empty[3] = ~o[3] & ~x[3];
    assign move_empty[4] = ~o[4] & ~x[4];
    assign move_empty[5] = ~o[5] & ~x[5];
    assign move_empty[6] = ~o[6] & ~x[6];
    assign move_empty[7] = ~o[7] & ~x[7];
    assign move_empty[8] = ~o[8] & ~x[8];
    assign empty_2 = move_empty[0] | move_empty[1] | move_empty[2] | move_empty[3] | move_empty[4] | move_empty[5] | move_empty[6] | move_empty[7] | move_empty[8];
    
    always @(*) begin
        case(move_empty)
            9'b????????1: newO_2[0] = move_empty[0];
            9'b???????10: newO_2[1] = move_empty[1];
            9'b??????100: newO_2[2] = move_empty[2];
            9'b?????1000: newO_2[3] = move_empty[3];
            9'b????10000: newO_2[4] = move_empty[4];
            9'b???100000: newO_2[5] = move_empty[5];
            9'b??1000000: newO_2[6] = move_empty[6];
            9'b?10000000: newO_2[7] = move_empty[7];
            9'b100000000: newO_2[8] = move_empty[8];
            9'b000000000: newO_1[0] = 1;
            default: newO_2 = 9'b000000000;
        endcase
    end

    //switch with priority
    always @(*) begin
        case({win_0,block_1,empty_2})
            3'b1??: switch = 2'b00;
            3'b01?: switch = 2'b01;
            3'b001: switch = 2'b10;
            default: switch = 2'b10;
        endcase
    end
    assign test1 = newO_0;
    always @(*) begin
        case(switch)
            2'b00: newO = newO_0 | o;
            2'b01: newO = newO_1 | o;
            2'b10: newO = newO_2 | o;
            default: newO = o;
        endcase
    end
endmodule
