module mux1to2_tb;
reg d0,d1,S;
wire y;
mux1to2_be uut(.d0(d0),
	       .d1(d1),
	       .S(S),
	       .y(y)
);
initial begin 
$dumpfile("mux1to2_tb.vcd");
$dumpvars(0,mux1to2_tb);
$monitor("d0=%b d1=%b S=%b y=%b",d0,d1,S,y);
d0=0; d1=0; S=0; #10;
d0=0; d1=0; S=1; #10;
d0=0; d1=1; S=0; #10;
d0=0; d1=1; S=1; #10;
d0=1; d1=0; S=0; #10;
d0=1; d1=0; S=1; #10;
d0=1; d1=1; S=0; #10;
d0=1; d1=1; S=1; #10;
$finish;
end
endmodule
