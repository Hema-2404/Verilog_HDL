module decoder_2to4_tb;

    reg  [1:0] A;
    wire [3:0] Y;
    decoder_2to4 dut (
        .A(A),
        .Y(Y)
    );
    initial begin
        $dumpfile("decoder.vcd");
        $dumpvars(0, decoder_2to4_tb);
    end

  
    initial begin
        $monitor("Time = %0t | A = %b | Y = %b",
                 $time, A, Y);
    end
    initial begin

        A = 2'b00;
        #10;

        A = 2'b01;
        #10;

        A = 2'b10;
        #10;

        A = 2'b11;
        #10;

        $finish;
    end

endmodule
