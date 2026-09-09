module apb_tb;
reg pclk;
reg presetn;
reg transfer;
reg write_read;
reg [31:0] addr_in;
reg [31:0] data_in;
wire psel;
wire penable;
wire pwrite;
wire [31:0] paddr;
wire [31:0] pwdata;
wire [31:0] prdata;
wire pready;
wire [31:0] data_out;
wire ready_out;
apb_master master (
.pclk(pclk),
.presetn(presetn),
.transfer(transfer),
.write_read(write_read),
.addr_in(addr_in),
.data_in(data_in),
.pready(pready),
.prdata(prdata),
.psel(psel),
.penable(penable),
.pwrite(pwrite),
.paddr(paddr),
.pwdata(pwdata),
.data_out(data_out),
.ready_out(ready_out)
);
apb_slave slave(
.pclk(pclk),
.presetn(presetn),
.psel(psel),
.penable(penable),
.pwrite(pwrite),
.paddr(paddr),
.pwdata(pwdata),
.prdata(prdata),
.pready(pready)
);
always #5 pclk=~pclk;
initial
begin
    $dumpfile("apb_tb.vcd");
    $dumpvars(0, apb_tb);
    pclk = 1'b0;
    presetn = 1'b0;
    transfer = 1'b0;
    write_read = 1'b0;
    addr_in = 32'b0;
    data_in = 32'b0;
    #20;
    presetn = 1'b1;

    @(posedge pclk);

    transfer = 1'b1;
    write_read = 1'b1;

    addr_in = 32'h04;
    data_in = 32'h12345678;

    wait(ready_out);
     $display("WRITE COMPLETE");
    $display("ADDRESS = %h", addr_in);
    $display("DATA    = %h", data_in);

    @(posedge pclk);

    transfer = 1'b0;



    @(posedge pclk);

    transfer = 1'b1;
    write_read = 1'b0;

    addr_in = 32'h04;

    wait(ready_out);
$display("READ COMPLETE");
    $display("ADDRESS  = %h", addr_in);
    $display("READ DATA = %h", data_out);

    @(posedge pclk);

    transfer = 1'b0;

    #50;

    $finish;

end

endmodule
