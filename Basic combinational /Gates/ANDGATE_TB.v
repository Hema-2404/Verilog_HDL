module andgate_tb;
reg A, B;
wire Y;
andgate_gate uut (
    .A(A),
    .B(B),
    .Y(Y)
);
initial begin
    $dumpfile("andgate.vcd");
    $dumpvars(0, andgate_tb);
    $monitor("A=%b B=%b Y=%b", A, B, Y);

    A = 0; B = 0; #10;
    A = 0; B = 1; #10;
    A = 1; B = 0; #10;
    A = 1; B = 1; #10;

    $finish;
end

endmodule
