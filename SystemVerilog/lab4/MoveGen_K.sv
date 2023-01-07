module MoveGen_K(
    input logic[8:0] x,
    input logic[8:0] o,
    output logic[8:0] newO
);

//assign newO1 = o;
logic [8:0] newO1 = 9'b000000000;
logic [8:0] newO2 = 9'b000000000;
logic [8:0] newO3 = 9'b000000000;
logic c1,c2,c3;
logic [8:0] condition1,condition2,condition3;
logic f1 = 0;
logic f2 = 0;
logic f3 = 0;
logic flag = 0;
assign test1 = f1;
assign test2 = newO2;
assign test3 = newO3;
//1. Win block
always @(*) begin
	//Row Check
	priority if (o[1] & o[2]  & ~x[0] & ~f1) begin
		newO1[0] = 1;
		f1 = 1;
	end else if (o[0] & o[2]  & ~x[1] & ~f1) begin
		newO1[1] = 1;
		f1 = 1;
	end else if (o[0] & o[1]  & ~x[2] & ~f1) begin
		newO1[2] = 1;
		f1 = 1;
	end else if (o[4] & o[5]  & ~x[3] & ~f1) begin
		newO1[3] = 1;
		f1 = 1;
	end else if (o[3] & o[5]  & ~x[4] & ~f1) begin
		newO1[4] = 1;
		f1 = 1;
	end else if (o[3] & o[4]  & ~x[5] & ~f1) begin
		newO1[5] = 1;
		f1 = 1;
	end else if (o[7] & o[8]  & ~x[6] & ~f1) begin
		newO1[6] = 1;
		f1 = 1;
	end else if (o[6] & o[8]  & ~x[7] & ~f1) begin
		newO1[7] = 1;
		f1 = 1;
	end else if (o[6] & o[7]  & ~x[8] & ~f1) begin
		newO1[8] = 1;
		f1 = 1;
//Columns check
	end else if (o[3] & o[6]  & ~x[0] & ~f1) begin
		newO1[0] = 1;
		f1 = 1;
	end else if (o[0] & o[6]  & ~x[3] & ~f1) begin
		newO1[3] = 1;
		f1 = 1;
	end else if (o[0] & o[3]  & ~x[6] & ~f1) begin
		newO1[6] = 1;
		f1 = 1;
	end else if (o[4] & o[7]  & ~x[1] & ~f1) begin
		newO1[1] = 1;
		f1 = 1;
	end else if (o[1] & o[7]  & ~x[4] & ~f1) begin
		newO1[4] = 1;
		f1 = 1;
	end else if (o[1] & o[4]  & ~x[7] & ~f1) begin
		newO1[7] = 1;
		f1 = 1;
	end else if (o[5] & o[8]  & ~x[2] & ~f1) begin
		newO1[2] = 1;
		f1 = 1;
	end else if (o[2] & o[8]  & ~x[5] & ~f1) begin
		newO1[5] = 1;
		f1 = 1;
//Diagonals check
	end else if (o[2] & o[5]  & ~x[8] & ~f1) begin
		newO1[8] = 1;
		f1 = 1;
	end else if (o[4] & o[8]  & ~x[0] & ~f1) begin
		newO1[0] = 1;
		f1 = 1;
	end else if (o[0] & o[8]  & ~x[4] & ~f1) begin
		newO1[4] = 1;
		f1 = 1;
	end else if (o[0] & o[4]  & ~x[8] & ~f1) begin
		newO1[8] = 1;
		f1 = 1;
	end else if (o[4] & o[6]  & ~x[2] & ~f1) begin
		newO1[2] = 1;
		f1 = 1;
	end else if (o[2] & o[6]  & ~x[4] & ~f1) begin
		newO1[4] = 1;
		f1 = 1;
	end else if (o[2] & o[4]  & ~x[6] & ~f1) begin
		newO1[6] = 1;
		f1 = 1;
	end else begin
		newO1 = 9'b000000000;
		//f1 = 1;
	end
end

//2.Block X player block
always @(*) begin
	//Row Check
	priority if (x[1] & x[2]  & ~o[0] & ~f2) begin
		newO2[0] = 1;
		f2 = 1;
	end 
	else begin
		priority if (x[0] & x[2]  & ~o[1] & ~f2) begin
			newO2[1] = 1;
			f2 = 1;
		end else begin
    		priority if (x[0] & x[1]  & ~o[2] & ~f2) begin
    			newO2[2] = 1;
				f2 = 1;
    		end else begin
	    		priority if (x[4] & x[5]  & ~o[3] & ~f2) begin
	    			newO2[3] = 1;
					f2 = 1;
	    		end else begin
		    		priority if (x[3] & x[5]  & ~o[4] & ~f2) begin
		    			newO2[4] = 1;
						f2 = 1;
		    		end else begin
			    		priority if (x[3] & x[4]  & ~o[5] & ~f2) begin
			    			newO2[5] = 1;
							f2 = 1;
			    		end else begin
				    		priority if (x[7] & x[8]  & ~o[6] & ~f2) begin
				    			newO2[6] = 1;
								f2 = 1;
				    		end else begin
					    		priority if (x[6] & x[8]  & ~o[7] & ~f2) begin
					    			newO2[7] = 1;
									f2 = 1;
					    		end else begin
						    		priority if (x[6] & x[7]  & ~o[8] & ~f2) begin
						    			newO2[8] = 1;
										f2 = 1;
						    			//Columns check
						    		end else begin
							    		priority if (x[3] & x[6]  & ~o[0] & ~f2) begin
							    			newO2[0] = 1;
											f2 = 1;
							    		end else begin
								    		priority if (x[0] & x[6]  & ~o[3] & ~f2) begin
								    			newO2[3] = 1;
												f2 = 1;
								    		end else begin
									    		priority if (x[0] & x[3]  & ~o[6] & ~f2) begin
									    			newO2[6] = 1;
													f2 = 1;
									    		end else begin
										    		priority if (x[4] & x[7]  & ~o[1] & ~f2) begin
										    			newO2[1] = 1;
														f2 = 1;
										    		end else begin
											    		priority if (x[1] & x[7]  & ~o[4] & ~f2) begin
											    			newO2[4] = 1;
															f2 = 1;
											    		end else begin
												    		priority if (x[1] & x[4]  & ~o[7] & ~f2) begin
												    			newO2[7] = 1;
																f2 = 1;
												    		end else begin
													    		priority if (x[5] & x[8]  & ~o[2] & ~f2) begin
													    			newO2[2] = 1;
																	f2 = 1;
													    		end else begin
														    		priority if (x[2] & x[8]  & ~o[5] & ~f2) begin
														    			newO2[5] = 1;
																		f2 = 1;
														    			//Diagonals check
														    		end else begin
															    		priority if (x[2] & x[5]  & ~o[8] & ~f2) begin
															    			newO2[8] = 1;
																			f2 = 1;
															    		end else begin
																    		priority if (x[4] & x[8]  & ~o[0] & ~f2) begin
																    			newO2[0] = 1;
																				f2 = 1;
																    		end else begin
																	    		priority if (x[0] & x[8]  & ~o[4] & ~f2) begin
																	    			newO2[4] = 1;
																					f2 = 1;
																	    		end else begin
																		    		priority if (x[0] & x[4]  & ~o[8] & ~f2) begin
																		    			newO2[8] = 1;
																						f2 = 1;
																		    		end else begin
																			    		priority if (x[4] & x[6]  & ~o[2] & ~f2) begin
																			    			newO2[2] = 1;
																							f2 = 1;
																			    		end else begin
																				    		priority if (x[2] & x[6]  & ~o[4] & ~f2) begin
																				    			newO2[4] = 1;
																								f2 = 1;
																				    		end else begin
																					    		priority if (x[2] & x[4]  & ~o[6] & ~f2) begin
																					    			newO2[6] = 1;
																									f2 = 1;
																					    		end 
																					    		else begin
																					    			newO2 = 9'b000000000;
																									//f2 = 1;
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
	//f2 = 0;
end

//3.Block Empty
always @(*) begin
	priority if (~o[0] & ~x[0] & ~f3) begin
		newO3[0] = 1;
		f3 = 1;
	end else begin
		priority if (~o[1] & ~x[1] & ~f3) begin
			newO3[1] = 1;
			f3 = 1;
		end else begin
			priority if (~o[2] & ~x[2] & ~f3) begin
				newO3[2] = 1;
				f3 = 1;
			end else begin
				priority if (~o[3] & ~x[3] & ~f3) begin
					newO3[3] = 1;
					f3 = 1;
				end else begin
					priority if (~o[4] & ~x[4] & ~f3) begin
						newO3[4] = 1;
						f3 = 1;
					end else begin
						priority if (~o[5] & ~x[5] & ~f3) begin
							newO3[5] = 1;
							f3 = 1;
						end else begin
							priority if (~o[6] & ~x[6] & ~f3) begin
								newO3[6] = 1;
								f3 = 1;
							end else begin
								priority if (~o[7] & ~x[7] & ~f3) begin
									newO3[7] = 1;
									f3 = 1;
								end else begin
									priority if (~o[8] & ~x[8] & ~f3) begin
										newO3[8] = 1;
										f3 = 1;
									end 
									else begin
										newO3 = 9'b000000000;
										//f3 = 1;
									end
								end
							end
						end
					end
				end
			end
		end
	end
	//f3 = 0;
end
//4. Switch
always @(*) begin
	condition1[0] = o[0] ^ newO1[0];
	condition1[1] = o[1] ^ newO1[1];
	condition1[2] = o[2] ^ newO1[2];
	condition1[3] = o[3] ^ newO1[3];
	condition1[4] = o[4] ^ newO1[4];
	condition1[5] = o[5] ^ newO1[5];
	condition1[6] = o[6] ^ newO1[6];
	condition1[7] = o[7] ^ newO1[7];
	condition1[8] = o[8] ^ newO1[8];
	c1 = condition1[0] | condition1[1] | condition1[2] | condition1[3] | condition1[4] | condition1[5] | condition1[6] | condition1[7] | condition1[8];
	condition2[0] = o[0] ^ newO2[0];
	condition2[1] = o[1] ^ newO2[1];
	condition2[2] = o[2] ^ newO2[2];
	condition2[3] = o[3] ^ newO2[3];
	condition2[4] = o[4] ^ newO2[4];
	condition2[5] = o[5] ^ newO2[5];
	condition2[6] = o[6] ^ newO2[6];
	condition2[7] = o[7] ^ newO2[7];
	condition2[8] = o[8] ^ newO2[8];
	c2 = condition2[0] | condition2[1] | condition2[2] | condition2[3] | condition2[4] | condition2[5] | condition2[6] | condition2[7] | condition2[8];
	condition3[0] = o[0] ^ newO3[0];
	condition3[1] = o[1] ^ newO3[1];
	condition3[2] = o[2] ^ newO3[2];
	condition3[3] = o[3] ^ newO3[3];
	condition3[4] = o[4] ^ newO3[4];
	condition3[5] = o[5] ^ newO3[5];
	condition3[6] = o[6] ^ newO3[6];
	condition3[7] = o[7] ^ newO3[7];
	condition3[8] = o[8] ^ newO3[8];
	c3 = condition3[0] | condition3[1] | condition3[2] | condition3[3] | condition3[4] | condition3[5] | condition3[6] | condition3[7] | condition3[8];
	priority if (c1==1) begin
			newO = o | newO1;
			flag = 1;
    end else begin
        priority if (c2==1) begin
            newO = o | newO2;
			flag = 1;
		end else begin
			priority if(c3==1) begin
				newO = o | newO3;
				flag = 1;
			end
			else
				newO = o;
        end
    end
end

endmodule
