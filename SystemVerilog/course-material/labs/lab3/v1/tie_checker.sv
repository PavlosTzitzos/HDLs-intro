
module tie_checker(
	input logic 
	output logic tie
);
	logic [8:0] ttt_table;
	reg [8:0] rX, rO = 9'b000000000;
	
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
	
endmodule
