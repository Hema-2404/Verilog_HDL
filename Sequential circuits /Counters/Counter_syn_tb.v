module counter_syn_tb;

reg clk;
reg rst;
reg en;
wire [3:0] count;

counter_mod10 uut(
    .clk(clk),
    .rst(rst),
    .en(en),
    .count(count)
);

always #10 clk = ~clk;

initial begin
    $dumpfile("counter_syn_tb.vcd");
    $dumpvars(0, counter_syn_tb);

    $monitor("clk=%b rst=%b en=%b count=%b", clk, rst, en, count);

    clk = 0;
    rst = 1;
    en = 0;

    #20;
    rst = 0;
    en = 1;     

    #200;

    en = 0;     
    #40;

    $finish;
end

endmodule
