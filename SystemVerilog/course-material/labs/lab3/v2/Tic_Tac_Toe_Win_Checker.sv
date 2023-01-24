module Tic_Tac_Toe_Win_Checker (input logic[8:0] X, 
								input logic[8:0] O,
								output logic win_X,
								output logic win_O);

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
logic win_in_diags_O;
logic win_in_diags_X;

always_comb begin
	//Row win X
	row_win_X[0] = X[0] & X[1] & X[2];
	row_win_X[1] = X[3] & X[4] & X[5];
	row_win_X[2] = X[6] & X[7] & X[8];

	win_in_rows_X = | row_win_X;

	//Column win X
	col_win_X[0] = X[0] & X[3] & X[6];
	col_win_X[1] = X[1] & X[4] & X[7];
	col_win_X[2] = X[2] & X[5] & X[8];
	
	win_in_cols_X = | col_win_X;

	//Diagonal win X
	diag_win_X[0] = X[0] & X[4] & X[8];
	diag_win_X[1] = X[6] & X[4] & X[2];
	
	win_in_diags_X = | diag_win_X;

	//Row win O
	row_win_O[0] = X[0] & X[1] & X[2];
	row_win_O[1] = X[3] & X[4] & X[5];
	row_win_O[2] = X[6] & X[7] & X[8];

	win_in_rows_O = | row_win_O;

	//Column win O
	col_win_O[0] = X[0] & X[3] & X[6];
	col_win_O[1] = X[1] & X[4] & X[7];
	col_win_O[2] = X[2] & X[5] & X[8];
	
	win_in_cols_O = | col_win_O;

	//Diagonal win O
	diag_win_O[0] = X[0] & X[4] & X[8];
	diag_win_O[1] = X[6] & X[4] & X[2];
	
	win_in_diags_O = | diag_win_O;

	//Final Win Check
	win_X = win_in_rows_X | win_in_cols_X | win_in_diags_X;
	win_O = win_in_rows_O | win_in_cols_O | win_in_diags_O;


end

endmodule