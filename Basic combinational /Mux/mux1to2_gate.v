module mux1to2_gate(
		input d0,d1,S,
		output y
);
wire w,x,z;
not(w,S);
and(x,w,d0);
and(z,s,d1);
or(y,x,z);
endmodule
