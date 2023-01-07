module Tic_Tac_Toe_Win_Checker (
	input logic[8:0] X,
	input logic[8:0] O,
	output logic win_X,
	output logic win_O
);
	// check if X wins
	logic[2:0] row_win_X;
	logic win_in_rows_X;
	logic[2:0] col_win_X;
	logic win_in_cols_X;
	logic[1:0] diag_win_X;
	logic win_in_diag_X;

	// check if O wins
	logic[2:0] row_win_O;
	logic win_in_rows_O;
	logic[2:0] col_win_O;
	logic win_in_cols_O;
	logic[1:0] diag_win_O;
	logic win_in_diag_O;

	//always_comb begin
		//Row win X
	assign row_win_X[0] = X[0] & X[1] & X[2];
	assign row_win_X[1] = X[3] & X[4] & X[5];
	assign row_win_X[2] = X[6] & X[7] & X[8];

	assign win_in_rows_X = row_win_X[0]|row_win_X[1]|row_win_X[2];

		//Column win X
	assign col_win_X[0] = X[0] & X[3] & X[6];
	assign col_win_X[1] = X[1] & X[4] & X[7];
	assign col_win_X[2] = X[2] & X[5] & X[8];
		
	assign win_in_cols_X = col_win_X[0]|col_win_X[1]|col_win_X[2];

		//Diagonal win X
	assign diag_win_X[0] = X[0] & X[4] & X[8];
	assign diag_win_X[1] = X[6] & X[4] & X[2];
		
	assign win_in_diag_X = diag_win_X[0]|diag_win_X[1];

		//Row win O
	assign row_win_O[0] = O[0] & O[1] & O[2];
	assign row_win_O[1] = O[3] & O[4] & O[5];
	assign row_win_O[2] = O[6] & O[7] & O[8];

	assign win_in_rows_O = row_win_O[0]|row_win_O[1]|row_win_O[2];

		//Column win O
	assign col_win_O[0] = O[0] & O[3] & O[6];
	assign col_win_O[1] = O[1] & O[4] & O[7];
	assign col_win_O[2] = O[2] & O[5] & O[8];
		
	assign win_in_cols_O = col_win_O[0]|col_win_O[1]|col_win_O[2];

		//Diagonal win O
	assign diag_win_O[0] = O[0] & O[4] & O[8];
	assign diag_win_O[1] = O[6] & O[4] & O[2];
		
	assign win_in_diag_O = diag_win_O[0]|diag_win_O[1];

		//Final Win Check
	assign win_X = win_in_rows_X | win_in_cols_X | win_in_diag_X;
	assign win_O = win_in_rows_O | win_in_cols_O | win_in_diag_O;
	//end
endmodule