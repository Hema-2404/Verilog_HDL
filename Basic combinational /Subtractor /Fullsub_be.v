module fullsub_be(
		input A,B,C,
		output  reg Differ,Borrow
);
always @(*)beign
Differ=A^B^C;
Borrow=(~A&B)|(B&C)|(~A&C);
end 
endmodule 
