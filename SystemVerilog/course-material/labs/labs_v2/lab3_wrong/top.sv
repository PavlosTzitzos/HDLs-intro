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

	output logic [3:0] red,
	output logic [3:0] green,
	output logic [3:0] blue,
	output logic hsync,
	output logic vsync,
	output logic play,
	output logic turn);
  
  // Code Here
  	//Constants
	localparam HD = 800; // Horizontal Display Area
	localparam HF = 56; // Front Porch
	localparam HB = 64; // Back Porch
	localparam HR = 120; // Horizontal Retrace
	localparam VD = 600; // Vertcal Display Area
	localparam VF = 37; // Front Porch
	localparam VB = 23; // Back Porch
	localparam VR = 6; // Vertical Retrace

  	logic [1:0] cursor_x,cursor_y;
	logic [3:0] cursor;
	logic [8:0] rX, rO;
	logic [3:0] pos_onehot;
	//logic turn;

	logic up, down, left, right; //play*/;

	Tic_Tac_Toe_Win_Checker win_checker (.X(rX), .O(rO), .win_X(winA), .win_O(winB));

	edge_detector edge_detector_left(.clk(clk), .rst(rst), .in(button_left), .out(left));
	edge_detector edge_detector_right(.clk(clk), .rst(rst), .in(button_right), .out(right));
	edge_detector edge_detector_up(.clk(clk), .rst(rst), .in(button_up), .out(up));
	edge_detector edge_detector_down(.clk(clk), .rst(rst), .in(button_down), .out(down));
	edge_detector edge_detector_play(.clk(clk), .rst(rst), .in(button_play), .out(play));

	
	always_ff @(posedge clk) begin
		if (rst) begin 
			cursor_x <= 0;
			cursor_y <= 0;
		end
		else if (left & cursor_x > 0)
			cursor_x <= cursor_x - 1;
		else if (right & cursor_x < 2)
			cursor_x <= cursor_x + 1;
		else if (up & cursor_y > 0)
			cursor_y <= cursor_y - 1;
		else if (down & cursor_y < 2)
			cursor_y <= cursor_y + 1;
	end
	
	assign cursor = {cursor_x, cursor_y};
	
	always_comb begin
		case(cursor)
		4'b0000: //0
			pos_onehot = 0;
		4'b0001: //3
			pos_onehot = 3;
		4'b0010: //6
			pos_onehot = 6;
		4'b0100: //1
			pos_onehot = 1;
		4'b0101: //4
			pos_onehot = 4;
		4'b0110: //7
			pos_onehot = 7;
		4'b1000: //2
			pos_onehot = 2;
		4'b1001: //5
			pos_onehot = 5;
		4'b1010: //8
			pos_onehot = 8;
		default: 
			pos_onehot = 0;
		endcase
	end
	
	always_ff @(posedge clk) begin
		if (rst) begin
			rX <= 9'b000000000;
			rO <= 9'b000000000;
			turn <= 1'b1;
		end
		else begin 
			if (play) begin
				if (turn==1) begin
					if((rX[pos_onehot] == 0) & (rO[pos_onehot] ==0)) begin
						rX[pos_onehot] <= 1;
						turn <= 0;
					end
				end
				else begin
				    if(turn==0) begin
                        if (rX[pos_onehot] == 0 & rO[pos_onehot ==0]) begin
                            rO[pos_onehot] <= 1;
                            turn <= 1;
                        end
					end
				end
			end
		end
	end

	//Tie Checker
	logic [8:0] ttt_table;
	always_ff @(posedge clk) begin
	    if (rst) begin
	       ttt_table = 9'b000000000;
	       tie = 1'b0;
	    end
	    else begin
            ttt_table = rX | rO;
            if ((ttt_table == 9'b111111111) & (winA == 1'b0) & (winB == 1'b0)) begin
                tie = 1'b1;
            end
        end
	end




	//**************************
	//Panel Display*************
	//**************************


	//Clock division
	logic pxlClk;
	always_ff @(posedge clk) begin
		if (rst)
			pxlClk <= 1'b1;
		else
			pxlClk <= ~pxlClk;
	end

	reg [10:0] h_count_reg,v_count_reg ; // Horizontal and Vertical Counters (Current Position)

	//Set pixel position throughout the screen
	always_ff @(posedge clk) begin
		if (rst) begin
			//Initialization
			h_count_reg <= 11'b00000000000;
			v_count_reg <= 11'b00000000000;
		end
		else begin
			if (pxlClk) begin
				if (h_count_reg < (HD + HF + HB + HR - 1)) begin
					h_count_reg <= h_count_reg + 1;
				end
				else begin
					h_count_reg <= 11'b00000000000;
					if (v_count_reg < (VD + VF + VB + VR - 1)) begin
						v_count_reg <= v_count_reg + 1;
					end
					else begin
						v_count_reg <= 11'b00000000000;
					end
				end
			end
		end
	end

	//Horizontal Sync
	always_ff @(posedge clk) begin
	    if (rst) begin
	       hsync <= 1;
	    end
	    else begin
            if (pxlClk) begin
                    if (h_count_reg < (HD + HF) | h_count_reg > (HD + HF + HR - 1)) begin
                        hsync <= 1'b1;
                    end
                    else begin
                        hsync <= 1'b0;
                    end
            end
		end
	end

	always_ff @(posedge clk) begin
	    if (rst) begin
	       vsync <= 1;
	    end
	    else begin
            if (pxlClk) begin
                    if ((v_count_reg < (VD + VF)) | (v_count_reg > (VD + VF + VR - 1)) ) begin
                        vsync <= 1'b1;
                    end
                    else begin
                         vsync <= 1'b0;			
                    end
            end
		end
	end

	reg [6:0] addressX, addressO;
	reg [99:0] dataX, dataO;
	X_ROM x_rom(.address(addressX), .data(dataX));
	O_ROM o_rom(.address(addressO), .data(dataO));

	always_ff @(posedge clk) begin
	    /*if (rst) begin
	       
	    end
	    else begin*/
            if (pxlClk) begin
                if ((((h_count_reg>=290) & (h_count_reg<=304))||((h_count_reg>=495) & (h_count_reg<=509)))) begin
                    red <= 4'b1111;
                    blue <= 4'b1111;
                    green <= 4'b1111;
                end
                else begin
                    if (((h_count_reg>=100)&(h_count_reg<=699))&(((v_count_reg>=190)&(v_count_reg<=204))||((v_count_reg>=395)&(v_count_reg<=409)))) begin
                        red <= 4'b1111;
                        blue <= 4'b1111;
                        green <= 4'b1111;
                    end
                    else begin
                        if (((h_count_reg>=100)&(h_count_reg<=289))&((v_count_reg>=0)&(v_count_reg<=189))) begin
                            if ((pos_onehot==0)&((h_count_reg>=110)&(h_count_reg<=129))&((v_count_reg>=10)&(v_count_reg<=29))) begin
                                red <= 4'b1111;
                                blue <= 4'b1111;
                                green <= 4'b1111;
                            end
                            else begin
                                red <= 4'b0000;
                                blue <= 4'b0000;
                                green <= 4'b0000;
                            end
                            if (((h_count_reg>=145)&(h_count_reg<=244))&((v_count_reg>=45)&(v_count_reg<=144))) begin
                                if (rX[0]==1) begin
                                    addressX <= v_count_reg-45;
                                    if(dataX[h_count_reg-145]==1) begin
                                        red <= 4'b1111;
                                        blue <= 4'b1111;
                                        green <= 4'b1111;
                                    end
                                    else begin
                                        red <= 4'b0000;
                                        blue <= 4'b0000;
                                        green <= 4'b0000;
                                    end
                                end
                                else begin
                                    if (rO[0]==1) begin
                                        addressO <= v_count_reg-45;
                                        if(dataO[h_count_reg-145]==1) begin
                                            red <= 4'b1111;
                                            blue <= 4'b1111;
                                            green <= 4'b1111;
                                        end
                                        else begin
                                            red <= 4'b0000;
                                            blue <= 4'b0000;
                                            green <= 4'b0000;
                                        end
                                    end
                                    else begin
                                        red <= 4'b0000;
                                        blue <= 4'b0000;
                                        green <= 4'b0000;
                                    end
                                end
                            end
                        end
                        else begin
                            if (((h_count_reg>=305)&(h_count_reg<=494))&((v_count_reg>=0)&(v_count_reg<=189))) begin
                                if ((pos_onehot==1)&((h_count_reg>=315)&(h_count_reg<=334))&((v_count_reg>=10)&(v_count_reg<=29))) begin
                                    red <= 4'b1111;
                                    blue <= 4'b1111;
                                    green <= 4'b1111;
                                end
                                else begin
                                    red <= 4'b0000;
                                    blue <= 4'b0000;
                                    green <= 4'b0000;
                                end
                                if (((h_count_reg>=350)&(h_count_reg<=449))&((v_count_reg>=45)&(v_count_reg<=144))) begin
                                    if (rX[1]==1) begin
                                        addressX <= v_count_reg-45;
                                        if(dataX[h_count_reg-350]==1) begin
                                            red <= 4'b1111;
                                            blue <= 4'b1111;
                                            green <= 4'b1111;
                                        end
                                        else begin
                                            red <= 4'b0000;
                                            blue <= 4'b0000;
                                            green <= 4'b0000;
                                        end
                                    end
                                    else begin
                                        if (rO[1]==1) begin
                                            addressO <= v_count_reg-45;
                                            if(dataO[h_count_reg-350]==1) begin
                                                red <= 4'b1111;
                                                blue <= 4'b1111;
                                                green <= 4'b1111;
                                            end
                                            else begin
                                                red <= 4'b0000;
                                                blue <= 4'b0000;
                                                green <= 4'b0000;
                                            end
                                        end
                                        else begin
                                            red <= 4'b0000;
                                            blue <= 4'b0000;
                                            green <= 4'b0000;
                                        end
                                    end
                                end
                            end
                            else begin
                                if (((h_count_reg>=510)&(h_count_reg<=699))&((v_count_reg>=0)&(v_count_reg<=189))) begin
                                    if ((pos_onehot==2)&((h_count_reg>=520)&(h_count_reg<=539))&((v_count_reg>=10)&(v_count_reg<=29))) begin
                                        red <= 4'b1111;
                                        blue <= 4'b1111;
                                        green <= 4'b1111;
                                    end
                                    else begin
                                        red <= 4'b0000;
                                        blue <= 4'b0000;
                                        green <= 4'b0000;
                                    end
                                    if (((h_count_reg>=555)&(h_count_reg<=654))&((v_count_reg>=45)&(v_count_reg<=154))) begin
                                        if (rX[2]==1) begin
                                            addressX <= v_count_reg-55;
                                            if(dataX[h_count_reg-555]==1) begin
                                                red <= 4'b1111;
                                                blue <= 4'b1111;
                                                green <= 4'b1111;
                                            end
                                            else begin
                                                red <= 4'b0000;
                                                blue <= 4'b0000;
                                                green <= 4'b0000;
                                            end
                                        end
                                        else begin
                                            if (rO[2]==1) begin
                                                addressO <= v_count_reg-55;
                                                if(dataO[h_count_reg-555]==1) begin
                                                    red <= 4'b1111;
                                                    blue <= 4'b1111;
                                                    green <= 4'b1111;
                                                end
                                                else begin
                                                    red <= 4'b0000;
                                                    blue <= 4'b0000;
                                                    green <= 4'b0000;
                                                end
                                            end
                                            else begin
                                                red <= 4'b0000;
                                                blue <= 4'b0000;
                                                green <= 4'b0000;
                                            end
                                        end
                                    end
                                end
                                else begin
                                    if (((h_count_reg>=100)&(h_count_reg<=289))&((v_count_reg>=205)&(v_count_reg<=394))) begin 						//Position 3
                                        if ((pos_onehot==3)&((h_count_reg>=110)&(h_count_reg<=129))&((v_count_reg>=215)&(v_count_reg<=234))) begin
                                            red <= 4'b1111;
                                            blue <= 4'b1111;
                                            green <= 4'b1111;
                                        end
                                        else begin
                                            red <= 4'b0000;
                                            blue <= 4'b0000;
                                            green <= 4'b0000;
                                        end
                                        if (((h_count_reg>=145)&(h_count_reg<=244))&((v_count_reg>=250)&(v_count_reg<=349))) begin
                                            if (rX[3]==1) begin
                                                addressX <= v_count_reg-250;
                                                if(dataX[h_count_reg-145]==1) begin
                                                    red <= 4'b1111;
                                                    blue <= 4'b1111;
                                                    green <= 4'b1111;
                                                end
                                                else begin
                                                    red <= 4'b0000;
                                                    blue <= 4'b0000;
                                                    green <= 4'b0000;
                                                end
                                            end
                                            else begin
                                                if (rO[3]==1) begin
                                                    addressO <= v_count_reg-250;
                                                    if(dataO[h_count_reg-145]==1) begin
                                                        red <= 4'b1111;
                                                        blue <= 4'b1111;
                                                        green <= 4'b1111;
                                                    end
                                                    else begin
                                                        red <= 4'b0000;
                                                        blue <= 4'b0000;
                                                        green <= 4'b0000;
                                                    end
                                                end
                                                else begin
                                                    red <= 4'b0000;
                                                    blue <= 4'b0000;
                                                    green <= 4'b0000;
                                                end
                                            end
                                        end
                                    end
                                    else begin
                                        if (((h_count_reg>=305)&(h_count_reg<=494))&((v_count_reg>=205)&(v_count_reg<=394))) begin
                                            if ((pos_onehot==4)&((h_count_reg>=315)&(h_count_reg<=334))&((v_count_reg>=215)&(v_count_reg<=234))) begin
                                                red <= 4'b1111;
                                                blue <= 4'b1111;
                                                green <= 4'b1111;
                                            end
                                            else begin
                                                red <= 4'b0000;
                                                blue <= 4'b0000;
                                                green <= 4'b0000;
                                            end
                                            if (((h_count_reg>=350)&(h_count_reg<=449))&((v_count_reg>=250)&(v_count_reg<=349))) begin
                                                if (rX[4]==1) begin
                                                    addressX<=v_count_reg-250;
                                                    if(dataX[h_count_reg-350]==1) begin
                                                        red <= 4'b1111;
                                                        blue <= 4'b1111;
                                                        green <= 4'b1111;
                                                    end
                                                    else begin
                                                        red <= 4'b0000;
                                                        blue <= 4'b0000;
                                                        green <= 4'b0000;
                                                    end
                                                end
                                                else begin
                                                    if (rO[4]==1) begin
                                                        addressO <= v_count_reg-250;
                                                        if(dataO[h_count_reg-350]==1) begin
                                                            red <= 4'b1111;
                                                            blue <= 4'b1111;
                                                            green <= 4'b1111;
                                                        end
                                                        else begin
                                                            red <= 4'b0000;
                                                            blue <= 4'b0000;
                                                            green <= 4'b0000;
                                                        end
                                                    end
                                                    else begin
                                                        red <= 4'b0000;
                                                        blue <= 4'b0000;
                                                        green <= 4'b0000;
                                                    end
                                                end
                                            end
                                        end
                                        else begin
                                            if (((h_count_reg>=510)&(h_count_reg<=699))&((v_count_reg>=205)&(v_count_reg<=394))) begin
                                                if ((pos_onehot==5)&((h_count_reg>=520)&(h_count_reg<=539))&((v_count_reg>=215)&(v_count_reg<=234))) begin
                                                    red <= 4'b1111;
                                                    blue <= 4'b1111;
                                                    green <= 4'b1111;
                                                end
                                                else begin
                                                    red <= 4'b0000;
                                                    blue <= 4'b0000;
                                                    green <= 4'b0000;
                                                end
                                                if (((h_count_reg>=555)&(h_count_reg<=654))&((v_count_reg>=250)&(v_count_reg<=349))) begin
                                                    if (rX[5]==1) begin
                                                        addressX <= v_count_reg-250;
                                                        if(dataX[h_count_reg-555]==1) begin
                                                            red <= 4'b1111;
                                                            blue <= 4'b1111;
                                                            green <= 4'b1111;
                                                        end
                                                        else begin
                                                            red <= 4'b0000;
                                                            blue <= 4'b0000;
                                                            green <= 4'b0000;
                                                        end
                                                    end
                                                    else begin
                                                        if (rO[5]==1) begin
                                                            addressO <= v_count_reg-250;
                                                            if(dataO[h_count_reg-555]==1) begin
                                                                red <= 4'b1111;
                                                                blue <= 4'b1111;
                                                                green <= 4'b1111;
                                                            end
                                                            else begin
                                                                red <= 4'b0000;
                                                                blue <= 4'b0000;
                                                                green <= 4'b0000;
                                                            end
                                                        end
                                                        else begin
                                                            red <= 4'b0000;
                                                            blue <= 4'b0000;
                                                            green <= 4'b0000;
                                                        end
                                                    end
                                                end
                                            end
                                            else begin
                                                if (((h_count_reg>=100)&(h_count_reg<=289))&((v_count_reg>=410)&(v_count_reg<=599))) begin 						//Position 6
                                                    if ((pos_onehot==6)&((h_count_reg>=110)&(h_count_reg<=129))&((v_count_reg>=420)&(v_count_reg<=439))) begin
                                                        red <= 4'b1111;
                                                        blue <= 4'b1111;
                                                        green <= 4'b1111;
                                                    end
                                                    else begin
                                                        red <= 4'b0000;
                                                        blue <= 4'b0000;
                                                        green <= 4'b0000;
                                                    end
                                                    if (((h_count_reg>=145)&(h_count_reg<=244))&((v_count_reg>=455)&(v_count_reg<=554))) begin
                                                        if (rX[6]==1) begin
                                                            addressX <= v_count_reg-455;
                                                            if(dataX[h_count_reg-145]==1) begin
                                                                red <= 4'b1111;
                                                                blue <= 4'b1111;
                                                                green <= 4'b1111;
                                                            end
                                                            else begin
                                                                red <= 4'b0000;
                                                                blue <= 4'b0000;
                                                                green <= 4'b0000;
                                                            end
                                                        end
                                                        else begin
                                                            if (rO[6]==1) begin
                                                                addressO <= v_count_reg-455;
                                                                if(dataO[h_count_reg-145]==1) begin
                                                                    red <= 4'b1111;
                                                                    blue <= 4'b1111;
                                                                    green <= 4'b1111;
                                                                end
                                                                else begin
                                                                    red <= 4'b0000;
                                                                    blue <= 4'b0000;
                                                                    green <= 4'b0000;
                                                                end
                                                            end
                                                            else begin
                                                                red <= 4'b0000;
                                                                blue <= 4'b0000;
                                                                green <= 4'b0000;
                                                            end
                                                        end
                                                    end
                                                end
                                                else begin
                                                    if (((h_count_reg>=305)&(h_count_reg<=494))&((v_count_reg>=410)&(v_count_reg<=599))) begin
                                                        if ((pos_onehot==7)&((h_count_reg>=315)&(h_count_reg<=334))&((v_count_reg>=420)&(v_count_reg<=439))) begin
                                                            red <= 4'b1111;
                                                            blue <= 4'b1111;
                                                            green <= 4'b1111;
                                                        end
                                                        else begin
                                                            red <= 4'b0000;
                                                            blue <= 4'b0000;
                                                            green <= 4'b0000;
                                                        end
                                                        if (((h_count_reg>=350)&(h_count_reg<=449))&((v_count_reg>=455)&(v_count_reg<=554))) begin
                                                            if (rX[7]==1) begin
                                                                addressX <= v_count_reg-455;
                                                                if(dataX[h_count_reg-350]==1) begin
                                                                    red <= 4'b1111;
                                                                    blue <= 4'b1111;
                                                                    green <= 4'b1111;
                                                                end
                                                                else begin
                                                                    red <= 4'b0000;
                                                                    blue <= 4'b0000;
                                                                    green <= 4'b0000;
                                                                end
                                                            end
                                                            else begin
                                                                if (rO[7]==1) begin
                                                                    addressO <= v_count_reg-455;
                                                                    if(dataO[h_count_reg-350]==1) begin
                                                                        red <= 4'b1111;
                                                                        blue <= 4'b1111;
                                                                        green <= 4'b1111;
                                                                    end
                                                                    else begin
                                                                        red <= 4'b0000;
                                                                        blue <= 4'b0000;
                                                                        green <= 4'b0000;
                                                                    end
                                                                end
                                                                else begin
                                                                    red <= 4'b0000;
                                                                    blue <= 4'b0000;
                                                                    green <= 4'b0000;
                                                                end
                                                            end
                                                        end
                                                    end
                                                    else begin
                                                        if (((h_count_reg>=510)&(h_count_reg<=699))&((v_count_reg>=410)&(v_count_reg<=599))) begin
                                                            if ((pos_onehot==8)&((h_count_reg>=520)&(h_count_reg<=539))&((v_count_reg>=420)&(v_count_reg<=439))) begin
                                                                red <= 4'b1111;
                                                                blue <= 4'b1111;
                                                                green <= 4'b1111;
                                                            end
                                                            else begin
                                                                red <= 4'b0000;
                                                                blue <= 4'b0000;
                                                                green <= 4'b0000;
                                                            end
                                                            if (((h_count_reg>=555)&(h_count_reg<=654))&((v_count_reg>=455)&(v_count_reg<=554))) begin
                                                                if (rX[8]==1) begin
                                                                    addressX <= v_count_reg-455;
                                                                    if(dataX[h_count_reg-555]==1) begin
                                                                        red <= 4'b1111;
                                                                        blue <= 4'b1111;
                                                                        green <= 4'b1111;
                                                                    end
                                                                    else begin
                                                                        red <= 4'b0000;
                                                                        blue <= 4'b0000;
                                                                        green <= 4'b0000;
                                                                    end
                                                                end
                                                                else begin
                                                                    if (rO[8]==1) begin
                                                                        addressO<=v_count_reg-455;
                                                                        if(dataO[h_count_reg-555]==1) begin
                                                                            red <= 4'b1111;
                                                                            blue <= 4'b1111;
                                                                            green <= 4'b1111;
                                                                        end
                                                                        else begin
                                                                            red <= 4'b0000;
                                                                            blue <= 4'b0000;
                                                                            green <= 4'b0000;
                                                                        end
                                                                    end
                                                                    else begin
                                                                        red <= 4'b0000;
                                                                        blue <= 4'b0000;
                                                                        green <= 4'b0000;
                                                                    end
                                                                end
                                                            end
                                                        end
                                                        else begin
                                                            red <= 4'b0000;
                                                            blue <= 4'b0000;
                                                            green <= 4'b0000;
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
		//end
	end
	
endmodule