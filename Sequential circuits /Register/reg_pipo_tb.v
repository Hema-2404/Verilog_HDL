module reg_pipo_tb;

reg clk;
reg rst;
reg load;
reg [3:0] parallel_in;

wire [3:0] parallel_out;


reg_pipo dut (
    .clk(clk),
    .rst(rst),
    .load(load),
    .parallel_in(parallel_in),
    .parallel_out(parallel_out)
);

always #5 clk = ~clk;


initial begin

    clk = 1'b0;
    rst = 1'b1;
    load = 1'b0;
    parallel_in = 4'b0000;

   
    #10;
    rst = 1'b0;

    
    parallel_in = 4'b1010;
    load = 1'b1;
    #10;

    
    parallel_in = 4'b1101;
    #10;

    
    parallel_in = 4'b0110;
    #10;

   
    load = 1'b0;
    parallel_in = 4'b1111;
    #10;

    $finish;
end


initial begin
    $monitor("Time=%0t | clk=%b | rst=%b | load=%b | parallel_in=%b | parallel_out=%b",
             $time, clk, rst, load, parallel_in, parallel_out);
end


initial begin
    $dumpfile("reg_pipo_tb.vcd");
    $dumpvars(0, reg_pipo_tb);
end

endmodule
