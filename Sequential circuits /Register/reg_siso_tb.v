module reg_siso_tb;
reg clk;
reg rst;
reg serial_in;
wire serial_out;

reg_siso dut(.clk(clk),
		.rst(rst),
		.serial_in(serial_in),
		.serial_out(serial_out)
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
$monitor("Time=0%t|clk=%b| rst=%b|serial_in=%b|serial_out=%b",
$time, clk,rst,serial_in,serial_out);
end
initial begin 
$dumpfile("reg_siso_tb.vcd");
$dumpvars(0,reg_siso_tb);
end
endmodule 
