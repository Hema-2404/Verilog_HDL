module reg_4bit_tb;
reg clk;
reg rst;
reg [3:0]d;
wire [3:0]q;

reg_4bit dut(.clk(clk),
                .rst(rst),
                .d(d),
                .q(q)
);
always #5 clk=~clk;
initial begin 
clk=1'b0;
rst=1'b0;
d=4'b1010;
#10;
rst=1'b1;
d=4'b1101;
#10;
rst=1'b1;
d=4'b1001;
#10;
$finish;
end
initial begin 
$display("time=%0t|clk=%b|rst=%b|d=%b|q=%q",
 $time,clk,rst,d,q);
end
initial begin 
$dumpfile("reg_4bit_tb.vcd");
$dumpvars(0,reg_4bit_tb);
end
endmodule
