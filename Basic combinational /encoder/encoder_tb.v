module encoder_4to2_tb;
reg [3:0] D;
wire [1:0]Y;
encoder_4to2 dut (
.D(D),
.Y(Y)
);
initial begin
       $dumpfile("encoder_4to2.vcd");
$dumpvars(0,encoder_4to2_tb);
end
initial begin 
	$monitor("Time = %0t | D=%b |Y=%b",$time,D,Y);
end
initial begin 
D=4'b0001;
#10;
D=4'b0010;
#10;
D=4'b0100;
#10;
D=4'b1000;
#10;
$finish;
end
endmodule
