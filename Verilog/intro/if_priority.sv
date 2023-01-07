module if_priority;
logic x = 1;

initial begin
    priority if(x) $monitor("x is %b",x);
    else if (!x) $monitor("x is %b", x);
    else $monitor("Hello World!");
end

endmodule
