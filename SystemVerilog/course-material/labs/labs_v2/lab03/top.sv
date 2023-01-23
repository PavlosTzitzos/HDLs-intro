module top(
	input logic clk,
	input logic rst,

	input logic button_left,
	input logic button_right,
	input logic button_up,
	input logic button_down,
  
	input logic button_play,

	output logic winA,
	output logic winB,
	output logic tie,
	output logic [1:0] cursor_x,cursor_y,
	output logic turn,
	output logic [8:0] rX,rO,
	output logic [3:0] red,
	output logic [3:0] green,
	output logic [3:0] blue,
	output logic hsync,
	output logic vsync
);
	
	// Code Here
	logic left,right,up,down;
	logic play;
	
	edge_detector uut_left(.clk(clk),.rst(rst),.in(button_left),.out(left));
	edge_detector uut_right(.clk(clk),.rst(rst),.in(button_right),.out(right));
	edge_detector uut_up(.clk(clk),.rst(rst),.in(button_up),.out(up));
	edge_detector uut_down(.clk(clk),.rst(rst),.in(button_down),.out(down));
	edge_detector uut_play(.clk(clk),.rst(rst),.in(button_play),.out(play));
	
	//logic [1:0] cursor_x,cursor_y;
	logic [3:0] cursor;
	//logic [8:0] rX, rO;
	logic [3:0] pos_onehot;
	//logic turn = 1'b1;
	
	logic[2:0] row_win_X;
	logic win_in_rows_X;
	logic[2:0] col_win_X;
	logic win_in_cols_X;
	logic[1:0] diag_win_X;
	logic win_in_diags_X;
	logic[2:0] row_win_O;
	logic win_in_rows_O;
	logic[2:0] col_win_O;
	logic win_in_cols_O;
	logic[1:0] diag_win_O;
	logic win_in_diags_O;
	
	logic [8:0] ttt_table;
	
	assign buttons = {left,right,up,down};
	
	always_ff @(posedge clk) begin
		if (rst) begin 
			cursor_x <= 2'b00;
			cursor_y <= 2'b00;
		end else begin
		//case(buttons)
		//	4'b
			if (left & cursor_x > 0)
				cursor_x <= cursor_x - 1;
			else if (right & cursor < 2)
				cursor_x <= cursor_x + 1;
			else if (up & cursor > 0)
				cursor_y <= cursor_y - 1;
			else if (down & cursor < 2)
				cursor_y <= cursor_y + 1;
		end
	end
	
	assign cursor = {cursor_x,cursor_y};
	
	always_ff @(posedge clk) begin
		case(cursor)
		4'b0000:
			pos_onehot <= 4'b0000;//0
		4'b0001:
			pos_onehot <= 4'b0011;//3
		4'b0010:
			pos_onehot <= 4'b0110;//6
		4'b0100:
			pos_onehot <= 4'b0001;//1
		4'b0101:
			pos_onehot <= 4'b0100;//4
		4'b0110:
			pos_onehot <= 4'b0111;//7
		4'b1000:
			pos_onehot <= 4'b0010;//2
		4'b1001:
			pos_onehot <= 4'b0101;//5
		4'b1010:
			pos_onehot <= 4'b1000;//8
		default: 
			pos_onehot <= 4'b0000;//0
		endcase
	end
	
	always_ff @(posedge clk) begin
		if (rst) begin
			rX <= 9'b000000000;
			rO <= 9'b000000000;
			turn <= 1'b1; //Χ plays first
		end else begin
			if (play) begin
				if (turn & rX[pos_onehot] == 0 & rO[pos_onehot] == 0) begin
					rX[pos_onehot] <= 1;
					turn <= !turn;
				end
				else begin 
					if (!turn & rX[pos_onehot] == 0 & rO[pos_onehot] == 0) begin
						rO[pos_onehot] <= 1;
						turn <= !turn;
					end
				end
			end
		end
	end
	
	//tic_tac_toe_checker:
	always_ff @(posedge clk) begin
		// X player:
		// check if X wins in rows 
		row_win_X[0] <= rX[0] & rX[1] & rX[2];
		row_win_X[1] <= rX[3] & rX[4] & rX[5];
		row_win_X[2] <= rX[6] & rX[7] & rX[8];
		win_in_rows_X <= row_win_X[0] | row_win_X[1] | row_win_X[2];
		// same code for columns
		col_win_X[0] <= rX[0] & rX[3] & rX[6];
		col_win_X[1] <= rX[1] & rX[4] & rX[7];
		col_win_X[2] <= rX[2] & rX[5] & rX[8];
		win_in_cols_X <= |col_win_X;
		// do the same for diagonal 
		// there are only 2 diagonal
		// check if X wins in diagonals
		diag_win_X[0] <= rX[0] & rX[4] & rX[8];
		diag_win_X[1] <= rX[6] & rX[4] & rX[2];
		win_in_diags_X <= | diag_win_X;
		// check final win
		winA <= win_in_rows_X | win_in_cols_X | win_in_diags_X;
		//---------//
		//O player:
		// check if O wins in rows
		row_win_O[0] <= rO[0] & rO[1] & rO[2];
		row_win_O[1] <= rO[3] & rO[4] & rO[5];
		row_win_O[2] <= rO[6] & rO[7] & rO[8];
		win_in_rows_O <= | row_win_O;
		// same code for columns 
		col_win_O[0] <= rO[0] & rO[3] & rO[6]; 
		col_win_O[1] <= rO[1] & rO[4] & rO[7]; 
		col_win_O[2] <= rO[2] & rO[5] & rO[8]; 
		win_in_cols_O <= |col_win_O;
		// do the same for diagonal 
		// there are only 2 diagonal
		// check if O wins in diagonals
		diag_win_O[0] <= rO[0] & rO[4] & rO[8];
		diag_win_O[1] <= rO[6] & rO[4] & rO[2];
		win_in_diags_O <= | diag_win_O;
		// check final win
		winB <= win_in_rows_O | win_in_cols_O | win_in_diags_O;
	end
	
	always_ff @(posedge clk) begin
		ttt_table <= rX | rO;
		if (ttt_table == 9'b111111111 | winA == 0 | winB == 0)
			tie <= 1;
	end
	
		
//	logic hcount;
//	logic vcount;
	
	logic [10:0] hlines = 11'b10000010000;//1040
	logic [10:0] vcolumns = 11'b1010011010;//666
	logic [1:0] counter_compare;
//------------------------------------------------//
	//create the 50MHz clock:
	//logic pxlClk;
	always_ff @(posedge clk)
	begin
		if (rst)
			pxlClk <= 1'b1;
		else
			pxlClk <= ~pxlClk;
	end
//------------------------------------------------//
	// vga_counter:
	always_ff @(posedge clk) begin
		if (rst)
			begin
				// start from (0,0) pixel:
				hcount <= 11'b00000000000;
				vcount <= 11'b00000000000;
				//hsync and vsync start from 1;
				hsync <= 1'b1;
				vsync <= 1'b1;
				red <= 4'b0000;
				green <= 4'b0000;
				blue <= 4'b0000;
				counter_compare <= 2'b00;
			end
		else
			begin
				if (pxlClk)
					begin
						// count lines :
						if (hcount < hlines - 1)
							hcount <= hcount + 1;
						else begin
							// when count all lines go to columns 
							hcount = 0;
							if (vcount < vcolumns - 1)
								vcount <= vcount + 1;
							else
								vcount <= 0;
						end
					end
			end
	end
//------------------------------------------------//
	always_comb begin
		// hsync  is 1 only for sync time:
		/*0 < hcount < 856 : hsync = 1
		856 < hcount < 976 : hsync = 0
		976 < hcount < 1040: hsync = 1 */
		if ((hcount < 11'b01101011000)|(hcount > 11'b01111010000))
			hsync = 1;
		else
			hsync = 0;
//------------------------------------------------//
		// vsync is 1 only for sync time:
		/*0 < vcount < 637 : vsync = 1
		637 < vcount < 643 : vsync = 0
		643 < vcount < 666 : vsync = 1 */
		if ((vcount < 11'b01001111101)|(vcount > 11'b01010000011))
			vsync = 1;
		else
			vsync = 0;
//------------------------------------------------//
		//compare hcount :
		/*0 < hcount < 399 : area 1
		399 < hcount < 799 : area 2*/
		if (hcount < 11'b00110001111)
			counter_compare[0] = 0;
		else
			counter_compare[0] = 1;
//------------------------------------------------//
		//compare vcount
		/*0 < hcount < 299 : area 1
		299 < hcount < 599 : area 2*/
		if (vcount < 11'b00100101011)
			counter_compare[1] = 0;
		else
			counter_compare[1] = 1;
//------------------------------------------------//
		// 4 squares = 4 cases defined by counter_compare
		case(counter_compare)
			2'b00: begin
				//red
				red = 4'b1111;
				green = 4'b0000;
				blue = 4'b0000;
			end
			2'b01: begin
				//yellow
				red = 4'b1111;
				green = 4'b1111;
				blue = 4'b0000;
			end
			2'b10: begin
				//green
				red = 4'b0000;
				green = 4'b1111;
				blue = 4'b0000;
			end
			2'b11: begin
				//blue
				red = 4'b0000;
				green = 4'b0000;
				blue = 4'b1111;
			end
			default: begin
				//black
				red = 4'b0000;
				green = 4'b0000;
				blue = 4'b0000;
			end
		endcase
	end
endmodule