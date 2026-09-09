module counter_4bit_syn_tb;
reg clk;
reg rst;
reg en;
wire [3:0] count;
counter_4bit_syn dut (.clk(clk),
			.rst(rst),
			.en(en),
			.count(count)
);
initial clk=0;
always #5 clk=~clk;
initial begin 
rst=0;
en=0;
#10;
rst=1;
#10
en=1;
#200;
en=0;
#10;
en=1;
#40;
rst=0;
#10;
rst=1;
#40;
$display("Simulation finished at time %0t", $time);
$finish;
end
initial begin 
$monitor("Time=%0t| rst=%0b|en=%b|count=%d (0b%b)",
$time,rst,en,count,count);
end
initial begin 
	$dumpfile("counter_4bit_syn.vcd");
	$dumpvars(0,counter_4bit_syn_tb);

end
endmodule
