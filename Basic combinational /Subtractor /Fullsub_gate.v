module fullsub_gate(
		input A,B,C,
		output Differ,Borrow
);
wire v,w,x,y,z;
xor g1(w,A,B);
xor g2(Differ,w,C);
not g3(v,A);
and g4(x,v,B);
and g5(y,B,C);
and g6(z,v,C);
or(Borrow,x,y,z);
endmodule 
