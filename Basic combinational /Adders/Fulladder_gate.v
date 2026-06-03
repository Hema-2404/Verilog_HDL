module full_adder(
    input A,
    input B,
    input Cin,
    output Sum,
    output Carry
);

wire w1, w2, w3;
xor x1(w1, A, B);
xor x2(Sum, w1, Cin);
and a1(w2, A, B);
and a2(w3, w1, Cin);
or  o1(Carry, w2, w3);

endmodule
