module demux_1to4_tb;
reg D;
reg [1:0] S;
wire [3:0] Y;
demux_1to4 dut (
.D(D),
.S(S),
.Y(Y)
);
initial begin 
$dumpfile("demux.vcd");
$dumpvars(0,demux_1to4_tb);
end
initial begin 
$monitor("Time = %0t | D = %b | S = %b | Y = %b",
                 $time, D, S, Y);
    end
    initial begin
        D = 1'b0;

        S = 2'b00;
        #10;

        S = 2'b01;
        #10;

        S = 2'b10;
        #10;

        S = 2'b11;
        #10;

        
        D = 1'b1;

        S = 2'b00;
        #10;

        S = 2'b01;
        #10;

        S = 2'b10;
        #10;

        S = 2'b11;
        #10;

        $finish;

    end

endmodule
