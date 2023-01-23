module PanelDisplay (
	input logic clk,
	input logic rst,
	output logic hsync,
	output logic vsync,
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

	reg [8:0] rX=9'b010010100;
	reg [8:0] rO=9'b101000000; 

	reg [6:0] addressX, addressO;
	reg [99:0] dataX, dataO;
	X_ROM x_rom(.address(addressX), .data(dataX));
	O_ROM o_rom(.address(addressO), .data(dataO));

	always_ff @(posedge clk) begin
		if (pxlClk) begin
			if ((((h_count_reg>=290) & (h_count_reg<=304))||((h_count_reg>=495) & (h_count_reg<=509)))) begin
				red = 4'b1111;
				blue = 4'b1111;
				green = 4'b1111;
			end
			else begin
				if (((h_count_reg>=100)&(h_count_reg<=699))&(((v_count_reg>=190)&(v_count_reg<=204))||((v_count_reg>=395)&(v_count_reg<=409)))) begin
					red = 4'b1111;
					blue = 4'b1111;
					green = 4'b1111;
				end
				else begin
					if (((h_count_reg>=100)&(h_count_reg<=289))&((v_count_reg>=0)&(v_count_reg<=189))) begin
						if (((h_count_reg>=110)&(h_count_reg<=129))&((v_count_reg>=10)&(v_count_reg<=29))) begin
							red = 4'b1111;
							blue = 4'b1111;
							green = 4'b1111;
						end
						else begin
							red = 4'b0000;
							blue = 4'b0000;
							green = 4'b0000;
						end
						if (((h_count_reg>=145)&(h_count_reg<=244))&((v_count_reg>=55)&(v_count_reg<=154))) begin
							if (rX[0]==1) begin
								addressX=v_count_reg-55;
								if(dataX[h_count_reg-145]==1) begin
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
							else begin
								if (rO[0]==1) begin
									addressO=v_count_reg-55;
									if(dataO[h_count_reg-145]==1) begin
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
								else begin
									red = 4'b0000;
									blue = 4'b0000;
									green = 4'b0000;
								end
							end
						end
					end
					else begin
						if (((h_count_reg>=305)&(h_count_reg<=494))&((v_count_reg>=0)&(v_count_reg<=189))) begin
							if (((h_count_reg>=315)&(h_count_reg<=334))&((v_count_reg>=10)&(v_count_reg<=29))) begin
								red = 4'b1111;
								blue = 4'b1111;
								green = 4'b1111;
							end
							else begin
								red = 4'b0000;
								blue = 4'b0000;
								green = 4'b0000;
							end
							if (((h_count_reg>=350)&(h_count_reg<=449))&((v_count_reg>=55)&(v_count_reg<=154))) begin
								if (rX[1]==1) begin
									addressX=v_count_reg-55;
									if(dataX[h_count_reg-350]==1) begin
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
								else begin
									if (rO[1]==1) begin
										addressO=v_count_reg-55;
										if(dataO[h_count_reg-350]==1) begin
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
									else begin
										red = 4'b0000;
										blue = 4'b0000;
										green = 4'b0000;
									end
								end
							end
						end
						else begin
							if (((h_count_reg>=510)&(h_count_reg<=699))&((v_count_reg>=0)&(v_count_reg<=189))) begin
								if (((h_count_reg>=520)&(h_count_reg<=539))&((v_count_reg>=10)&(v_count_reg<=29))) begin
									red = 4'b1111;
									blue = 4'b1111;
									green = 4'b1111;
								end
								else begin
									red = 4'b0000;
									blue = 4'b0000;
									green = 4'b0000;
								end
								if (((h_count_reg>=555)&(h_count_reg<=654))&((v_count_reg>=55)&(v_count_reg<=154))) begin
									if (rX[2]==1) begin
										addressX=v_count_reg-55;
										if(dataX[h_count_reg-555]==1) begin
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
									else begin
										if (rO[2]==1) begin
											addressO=v_count_reg-55;
											if(dataO[h_count_reg-555]==1) begin
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
										else begin
											red = 4'b0000;
											blue = 4'b0000;
											green = 4'b0000;
										end
									end
								end
							end
							else begin
								if (((h_count_reg>=100)&(h_count_reg<=289))&((v_count_reg>=205)&(v_count_reg<=394))) begin 						//Position 3
									if (((h_count_reg>=110)&(h_count_reg<=129))&((v_count_reg>=215)&(v_count_reg<=234))) begin
										red = 4'b1111;
										blue = 4'b1111;
										green = 4'b1111;
									end
									else begin
										red = 4'b0000;
										blue = 4'b0000;
										green = 4'b0000;
									end
									if (((h_count_reg>=145)&(h_count_reg<=244))&((v_count_reg>=250)&(v_count_reg<=349))) begin
										if (rX[3]==1) begin
											addressX=v_count_reg-250;
											if(dataX[h_count_reg-145]==1) begin
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
										else begin
											if (rO[3]==1) begin
												addressO=v_count_reg-250;
												if(dataO[h_count_reg-145]==1) begin
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
											else begin
												red = 4'b0000;
												blue = 4'b0000;
												green = 4'b0000;
											end
										end
									end
								end
								else begin
									if (((h_count_reg>=305)&(h_count_reg<=494))&((v_count_reg>=205)&(v_count_reg<=394))) begin
										if (((h_count_reg>=315)&(h_count_reg<=334))&((v_count_reg>=215)&(v_count_reg<=234))) begin
											red = 4'b1111;
											blue = 4'b1111;
											green = 4'b1111;
										end
										else begin
											red = 4'b0000;
											blue = 4'b0000;
											green = 4'b0000;
										end
										if (((h_count_reg>=350)&(h_count_reg<=449))&((v_count_reg>=250)&(v_count_reg<=349))) begin
											if (rX[4]==1) begin
												addressX=v_count_reg-250;
												if(dataX[h_count_reg-350]==1) begin
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
											else begin
												if (rO[4]==1) begin
													addressO=v_count_reg-250;
													if(dataO[h_count_reg-350]==1) begin
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
												else begin
													red = 4'b0000;
													blue = 4'b0000;
													green = 4'b0000;
												end
											end
										end
									end
									else begin
										if (((h_count_reg>=510)&(h_count_reg<=699))&((v_count_reg>=205)&(v_count_reg<=394))) begin
											if (((h_count_reg>=520)&(h_count_reg<=539))&((v_count_reg>=215)&(v_count_reg<=234))) begin
												red = 4'b1111;
												blue = 4'b1111;
												green = 4'b1111;
											end
											else begin
												red = 4'b0000;
												blue = 4'b0000;
												green = 4'b0000;
											end
											if (((h_count_reg>=555)&(h_count_reg<=654))&((v_count_reg>=250)&(v_count_reg<=349))) begin
												if (rX[5]==1) begin
													addressX=v_count_reg-250;
													if(dataX[h_count_reg-555]==1) begin
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
												else begin
													if (rO[5]==1) begin
														addressO=v_count_reg-250;
														if(dataO[h_count_reg-555]==1) begin
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
													else begin
														red = 4'b0000;
														blue = 4'b0000;
														green = 4'b0000;
													end
												end
											end
										end
										else begin
											if (((h_count_reg>=100)&(h_count_reg<=289))&((v_count_reg>=410)&(v_count_reg<=599))) begin 						//Position 6
												if (((h_count_reg>=110)&(h_count_reg<=129))&((v_count_reg>=420)&(v_count_reg<=439))) begin
													red = 4'b1111;
													blue = 4'b1111;
													green = 4'b1111;
												end
												else begin
													red = 4'b0000;
													blue = 4'b0000;
													green = 4'b0000;
												end
												if (((h_count_reg>=145)&(h_count_reg<=244))&((v_count_reg>=455)&(v_count_reg<=554))) begin
													if (rX[6]==1) begin
														addressX=v_count_reg-455;
														if(dataX[h_count_reg-145]==1) begin
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
													else begin
														if (rO[6]==1) begin
															addressO=v_count_reg-455;
															if(dataO[h_count_reg-145]==1) begin
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
														else begin
															red = 4'b0000;
															blue = 4'b0000;
															green = 4'b0000;
														end
													end
												end
											end
											else begin
												if (((h_count_reg>=305)&(h_count_reg<=494))&((v_count_reg>=410)&(v_count_reg<=599))) begin
													if (((h_count_reg>=315)&(h_count_reg<=334))&((v_count_reg>=420)&(v_count_reg<=439))) begin
														red = 4'b1111;
														blue = 4'b1111;
														green = 4'b1111;
													end
													else begin
														red = 4'b0000;
														blue = 4'b0000;
														green = 4'b0000;
													end
													if (((h_count_reg>=350)&(h_count_reg<=449))&((v_count_reg>=455)&(v_count_reg<=554))) begin
														if (rX[7]==1) begin
															addressX=v_count_reg-455;
															if(dataX[h_count_reg-350]==1) begin
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
														else begin
															if (rO[7]==1) begin
																addressO=v_count_reg-455;
																if(dataO[h_count_reg-350]==1) begin
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
															else begin
																red = 4'b0000;
																blue = 4'b0000;
																green = 4'b0000;
															end
														end
													end
												end
												else begin
													if (((h_count_reg>=510)&(h_count_reg<=699))&((v_count_reg>=410)&(v_count_reg<=599))) begin
														if (((h_count_reg>=520)&(h_count_reg<=539))&((v_count_reg>=420)&(v_count_reg<=439))) begin
															red = 4'b1111;
															blue = 4'b1111;
															green = 4'b1111;
														end
														else begin
															red = 4'b0000;
															blue = 4'b0000;
															green = 4'b0000;
														end
														if (((h_count_reg>=555)&(h_count_reg<=654))&((v_count_reg>=455)&(v_count_reg<=554))) begin
															if (rX[8]==1) begin
																addressX=v_count_reg-455;
																if(dataX[h_count_reg-555]==1) begin
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
															else begin
																if (rO[8]==1) begin
																	addressO=v_count_reg-455;
																	if(dataO[h_count_reg-555]==1) begin
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
																else begin
																	red = 4'b0000;
																	blue = 4'b0000;
																	green = 4'b0000;
																end
															end
														end
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
							end
						end
					end
				end
			end
		end
	end


endmodule