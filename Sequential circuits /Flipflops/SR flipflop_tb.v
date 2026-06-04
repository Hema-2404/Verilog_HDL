module SRflip_gate_tb;
reg S, R, clk, rst;
wire Y;
integer i;
SRflip_gate uut (
    .S(S),
    .R(R),
    .clk(clk),
    .rst(rst),
    .Y(Y)
);
always #5 clk = ~clk;
initial begin
    $dumpfile("SRflip_gate_tb.vcd");
    $dumpvars(0, SRflip_gate_tb);
    clk = 0;
    rst = 1;
    S = 0;
    R = 0;
 #10;
    rst = 0;
 for (i = 0; i < 4; i = i + 1) begin
        case (i)
            0: begin S = 0; R = 0; end   // hold
            1: begin S = 1; R = 0; end   // set
            2: begin S = 0; R = 1; end   // reset
            3: begin S = 1; R = 1; end   // invalid
        endcase
	#10;
end
#20
    $finish;
end
endmodule
