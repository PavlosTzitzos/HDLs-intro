
module PanelDisplay(
	input logic clk, rst,
	
	output logic hsync, vsync,
	output logic pxlClk,
	output logic [10:0] hcount, vcount,
	output logic [3:0] red, green, blue
);
	
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
