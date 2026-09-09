module asyn_counter_tb;
reg clk;
reg rst;
wire [3:0] q;
asyn_counter dut(
.clk(clk),
.rst(rst),
.q(q)
);
always #5 clk=~clk;
initial begin 
$dumpfile("asyn_counter.vcd");
$dumpvars(0,asyn_counter_tb);
clk=0;
rst=1;
#10;
rst=0;
#200;
$finish;
end
initial begin 
$monitor("Time=%0t| rst=%b|clk=%b|q=%d",
$time,rst,clk,q);
end
endmodule
