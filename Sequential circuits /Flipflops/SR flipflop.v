module SRflip_gate(
		input clk,
		input rst,
		input S,
		input R,
		output reg Y
);
wire w,x,z;
not g1(x,R);
and g2(z,x,Y);
or g3(w,S,z);
endmodule

