module fullsub_tb;

reg A, B, C;
wire Differ, Borrow;
fullsub_be uut (
    .A(A),
    .B(B),
    .C(C),
    .Differ(Differ),
    .Borrow(Borrow)
);

initial begin
    $dumpfile("fullsub.vcd");
    $dumpvars(0, fullsub_tb);

    $monitor("Time=%0t A=%b B=%b Bin=%b Diff=%b Borrow=%b",
              $time, A, B,C, Differ, Borrow);

    A=0; B=0; C=0; #10;
    A=0; B=0; C=1; #10;
    A=0; B=1; C=0; #10;
    A=0; B=1; C=1; #10;
    A=1; B=0; C=0; #10;
    A=1; B=0; C=1; #10;
    A=1; B=1; C=0; #10;
    A=1; B=1; C=1; #10;

    $finish;
end

endmodule
