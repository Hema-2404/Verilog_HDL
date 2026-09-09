module counter_syn_down_tb;
reg clk;
reg en;
reg rst;
wire [3:0] count;

counter_syn_down dut (.clk(clk),
		    .en(en),
		    .rst(rst),
		    .count(count)
);
initial clk=0;
always #5 clk=~clk;
initial begin 
rst=0;
en=0;
#10;
rst=1;
#10;
en=1;
#150;
en=0;
#10;
en=1;
#40;
$display("Simulation finished at time %0t",$time);
$finish;
end
initial begin 
$monitor("Time=%0t|rst=%b|en=%b|count=%d (0b%b)",
$time,rst,en,count,count);
end
initial begin
$dumpfile("counter_syn_down.vcd");
$dumpvars(0,counter_syn_down_tb);
end
endmodule
