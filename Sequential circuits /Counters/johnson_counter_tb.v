module johnson_counter_tb;
reg rst;
reg clk;
wire [3:0]q;
johnson_counter dut (.rst(rst),
		     .clk(clk),
		     .q(q)
);
always #5 clk=~clk;
initial begin 
clk=0;
rst=1;
#10;
rst=0;
#80;
$finish;
end
initial begin 
$monitor("Time=%0t|rst=%b|clk=%b|q=%b",$time,rst,clk,q);
end
initial begin
$dumpfile("johnson_counter_tb.vcd");
$dumpvars(0,johnson_counter_tb);
end
endmodule
