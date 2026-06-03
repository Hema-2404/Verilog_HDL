module fullsub_data(
input A,B,C,
output Differ,Borrow
);
assign Differ=A^B^C;
assign Borrow=(~A&B)+(B&C)+(~A&C);
endmodule
