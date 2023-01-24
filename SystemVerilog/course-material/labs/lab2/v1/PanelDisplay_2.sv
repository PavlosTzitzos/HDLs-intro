module PanelDisplay_2 (
	input logic clk,
	input logic rst,
	output logic hsync,
	output logic vsync,
	output logic pxlClk,
	output logic [10:0] h_count_reg, v_count_reg,
	output logic [3:0] red,
	output logic [3:0] green,
	output logic [3:0] blue);
  
  // code here
	//Constants
	localparam HD = 800; // Horizontal Display Area
	localparam HF = 56; // Front Porch
	localparam HB = 64; // Back Porch
	localparam HR = 120; // Horizontal Retrace
	localparam VD = 600; // Vertcal Display Area
	localparam VF = 37; // Front Porch
	localparam VB = 23; // Back Porch
	localparam VR = 6; // Vertical Retrace
	//localparam h_end = 1040; // Total Horizontal Timing
	//localparam v_end = 666; // Total Vertical Timing


	//Clock division
	//logic pxlClk;
	always_ff @(posedge clk) begin
		if (rst)
			pxlClk <= 1'b1;
		else
			pxlClk <= ~pxlClk;
	end

	//reg [10:0] h_count_reg,v_count_reg ; // Horizontal and Vertical Counters (Current Position)

	//Set pixel position throughout the screen
	always_ff @(posedge clk) begin
		if (rst) begin
			//Initialization
			h_count_reg <= 11'b00000000000;
			v_count_reg <= 11'b00000000000;
			hsync <= 1;
			vsync <= 1;
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
		if (pxlClk) begin
				if (h_count_reg < (HD + HF) | h_count_reg > (HD + HF + HR - 1)) begin
					hsync = 1'b1;
				end
				else begin
					hsync = 1'b0;
				end
		end
	end

	always_ff @(posedge clk) begin
		if (pxlClk) begin
				if ((v_count_reg < (VD + VF)) | (v_count_reg > (VD + VF + VR - 1)) ) begin
					vsync = 1'b1;
				end
				else begin
					 vsync = 1'b0;			
				end
		end
	end

	always_ff @(posedge clk) begin
		if (pxlClk) begin
			if ((h_count_reg > 149) & (h_count_reg < 375) & (v_count_reg > 49) & (v_count_reg < 250)) begin
				red = 4'b1111;
				blue = 4'b0000;
				green = 4'b0000;
			end
			else begin
				if ((h_count_reg > 424) & (h_count_reg < 650) & (v_count_reg > 49) & (v_count_reg < 250)) begin
					red = 4'b0000;
					blue = 4'b1111;
					green = 4'b0000;
				end
				else begin
					if ((h_count_reg > 149) & (h_count_reg < 375) & (v_count_reg > 324) & (v_count_reg < 550)) begin
						red = 4'b0000;
						blue = 4'b0000;
						green = 4'b1111;
					end
					else begin
						if ((h_count_reg > 424) & (h_count_reg < 650) & (v_count_reg > 324) & (v_count_reg < 550)) begin
							red = 4'b1111;
							blue = 4'b1111;
							green = 4'b1111;
						end
						else begin
							red = 4'b0000;
							blue = 4'b0000;
							green = 4'b0000;
						end
					end
				end
			end

		end
	end


endmodule