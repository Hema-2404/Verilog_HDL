module reg_sipo_tb;
reg clk;
reg rst;
reg serial_in;
wire [3:0] parallel_out;

reg_sipo dut(.clk(clk),
		.rst(rst),
		.serial_in(serial_in),
		.parallel_out(parallel_out)
);
always #5 clk=~clk;
initial begin 
clk = 1'b0;
    rst = 1'b1;
    serial_in = 1'b0;
 
    #10;
    rst = 1'b0;

   
    serial_in = 1'b1;
    #10;

    serial_in = 1'b0;
    #10;

    serial_in = 1'b1;
    #10;

    serial_in = 1'b1;
    #10;
    $finish;
end
initial begin 
$monitor("Time=%0t|clk=%b| rst=%b|serial_in=%b|parallel_out=%b",
$time, clk,rst,serial_in,parallel_out);
end
initial begin 
$dumpfile("reg_sipo_tb.vcd");
$dumpvars(0,reg_sipo_tb);
end
endmodule 
