module ring_counter_tb;
reg clk;
reg rst;
wire [3:0] q;
ring_counter dut (.clk(clk),
		  .rst(rst),
		  .q(q)
);
always #5 clk=~clk;
initial begin 
clk=0;
rst=1;
#10;
rst=0;
#50;
$finish;
end
initial begin 
$dumpfile("ring_counter_tb.vcd");
$dumpvars(0,ring_counter_tb);
end
initial begin
$monitor("Time=%0t|clk=%b|rst=%b|q=%b",$time,clk,rst,q);
end
endmodule
