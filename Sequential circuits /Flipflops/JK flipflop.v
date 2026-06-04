module JKflip_gate(
		input J,
		input K,
		input clk,
		input rst,
		output Y
);
wire u,v,w,x,z;
not g1(u,w);
not g2(x,K);
and g3(v,u,J);
and g4(z,x,w);
or g5(Y,v,z);
endmodule

		
