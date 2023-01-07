module askhsh5(
	input logic clk,
	input logic rst,
	output logic tick,
	output logic [2:0] slow_cnt
);
	logic [1:0] cnt_cycle;
	
	always_ff @(posedge clk) begin
		if(rst)
			cnt_cycle <= 0;
		else begin
			cnt_cycle <= cnt_cycle + 1;
			
			if (cnt_cycle == 2) cnt_cycle <= 0;
			
		end
	end
	
	always_ff @(posedge clk) begin
		if(rst) begin
			tick <= 0;
			slow_cnt <= 0;
		end
		else begin
			if(cnt_cycle == 1) tick <= 1;
			else tick <= 0;
			
			if(cnt_cycle == 1) slow_cnt <= slow_cnt + 1;
		end
	end
	
endmodule
