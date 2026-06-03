module fulladder_be(
		input A,B,C,
		output reg  Sum,Carry
);
always @(*) begin 
Sum=A^B^C;
Carry=(A&B)|(B&C)|(C&A);
end 
endmodule 
