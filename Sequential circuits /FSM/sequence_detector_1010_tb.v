module sequence_detector_1010_tb;
reg clk;
reg rst;
reg din;
wire dout;
sequence_detector_1010 dut(
.clk(clk),
.rst(rst),
.din(din),
.dout(dout)
);
always #5 clk =~clk;
initial begin 
$dumpfile("sequence_1010.vcd");
$dumpvars (0,sequence_detector_1010_tb);
$monitor("Time=%0t | din=%b |state=%b | dout=%b",$time,din,dut.current_state,dout);
clk=0;
rst=1;
din=0;
#10;
rst=0;
#10 din =1;
#10 din =0;
#10 din =1;
#10 din =0;

#10 din =1;
#10 din =0;
#20;
$finish;
end
endmodule
