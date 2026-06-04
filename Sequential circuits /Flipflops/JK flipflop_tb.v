module JKflip_tb;

reg clk, rst, J, K;
wire Y;

JKflip_gate uut(
    .clk(clk),
    .rst(rst),
    .J(J),
    .K(K),
    .Y(Y)
);
always #5 clk = ~clk;
initial begin
    $dumpfile("JKflip_tb.vcd");
    $dumpvars(0, JKflip_tb);
    $monitor("time=%0t clk=%b rst=%b J=%b K=%b Y=%b",
              $time, clk, rst, J, K, Y);
    clk = 0;
    rst = 1;
    J = 0;
    K = 0;
    #10;
    rst = 0;
    J = 0; K = 0; #10;  // hold
    J = 0; K = 1; #10;  // reset
    J = 1; K = 0; #10;  // set
    J = 1; K = 1; #10;  // toggle
    $finish;
end

endmodule
