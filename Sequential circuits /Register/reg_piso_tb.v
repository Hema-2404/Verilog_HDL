module reg_piso_tb;
reg clk;
reg rst;
reg load;
reg [3:0]parallel_in;
wire  serial_out;

reg_piso dut(.clk(clk),
		.rst(rst),
		.load(load),
		.parallel_in(parallel_in),
		.serial_out(serial_out)
);
always #5 clk=~clk;
initial begin 
clk = 1'b0;
    rst = 1'b1;
load=1'b0;
    parallel_in = 4'b0000;
 
    #10;
    rst = 1'b0;

   
    parallel_in = 4'b1011;
load=1'b1;
    #10;

    parallel_in = 4'b0010;
load=1'b0;
    #10;

   
    $finish;
end
initial begin 
$monitor("Time=%0t|clk=%b| rst=%b|load=%b|parallel_in=%b|serial_out=%b",
$time, clk,rst,load,parallel_in,serial_out);
end
initial begin 
$dumpfile("reg_piso_tb.vcd");
$dumpvars(0,reg_piso_tb);
end
endmodule 
