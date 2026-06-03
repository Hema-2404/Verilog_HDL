module fulladder_tb;
reg A,B,C;
wire Sum,Carry;
fulladder_be uut (.A(A),.B(B),.C(C),.Sum(Sum),.Carry(Carry));
initial begin 
$dumpfile("fulladder_tb.vcd");
$dumpvars(0,fulladder_tb);
$monitor("A=%b B=%b C=%b Sum=%b Carry=%b",A,B,C,Sum,Carry);
A=0;B=0;C=0;#10;
A=0;B=0;C=1;#10;
A=0;B=1;C=0;#10;
A=0;B=1;C=1;#10;
A=1;B=0;C=0;#10;
A=1;B=0;C=1;#10;
A=1;B=1;C=0;#10;
A=1;B=1;C=1;#10;
$finish;
end
endmodule 
