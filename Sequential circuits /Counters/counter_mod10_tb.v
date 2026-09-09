module counter_mod10_tb;

reg clk;
reg rst;
reg en;
wire [3:0] count;

mod10_counter uut(
    .clk(clk),
    .rst(rst),
    .en(en),
    .count(count)
);


always #10 clk = ~clk;

initial begin
    $dumpfile("mod10_counter_tb.vcd");
    $dumpvars(0, mod10_counter_tb);

    $monitor("time=%0t clk=%b rst=%b en=%b count=%d",
              $time, clk, rst, en, count);

    clk = 0;
    rst = 1;
    en = 0;

    #20;
    rst = 0;
    en = 1;

    #250;

    en = 0;   
    #40;

    en = 1;   
    #100;

    $finish;
end

endmodule
