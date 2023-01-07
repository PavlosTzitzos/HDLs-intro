module or_and(
output E,
input A,B,C
);
wire D;
assign E=(A||B)&&C;
endmodule
