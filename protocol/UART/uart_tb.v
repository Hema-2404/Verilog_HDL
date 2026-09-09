module uart_tb;
reg pclk;
reg presetn;
reg baud_tick;
reg tx_start;
reg [7:0] tx_data;
wire tx;
wire busy_tx;
wire tx_done;
wire [7:0] data_out;
wire data_valid;
wire parity_error;
wire framing_error;
wire busy_rx;
uart_tx DUT_TX
(
.pclk(pclk),
.presetn(presetn),
.baud_tick(baud_tick),
.tx_start(tx_start),
.tx_data(tx_data),
.tx(tx),
.busy(busy_tx),
.tx_done(tx_done)
);
uart_rx DUT_RX
(
.pclk(pclk),
.presetn(presetn),
.baud_tick(baud_tick),
.rx(tx),
.rx_data(data_out),
.rx_valid(data_valid),
.parity_error(parity_error),
.busy(busy_rx),
.framing_error(framing_error)
);

integer count;
always @(posedge pclk)
begin 
if(!presetn)
begin 
count<=0;
baud_tick<=1'b0;
end
else
begin
if(count==15)
begin 
baud_tick<=1'b1;
count<=0;
end
else
begin
baud_tick<=1'b0;
count<=count+1;
end
end
end
task send_byte;
input [7:0] data;
begin
@(posedge pclk);
while(busy_tx)
@(posedge pclk);
tx_data =data;
tx_start =1'b1;
@(posedge pclk)
tx_start=1'b0;
wait (tx_done);
@(posedge pclk);
end
endtask
initial begin
presetn =1'b0;
tx_start=1'b0;
tx_data=8'h00;
#100;
presetn=1'b1;
#50;
send_byte(8'h55);
#500;
send_byte(8'hA3);
#500;
send_byte(8'hF0);
#500;
send_byte(8'h3C);
#1000;
$finish;
end
initial begin
 $display("-------------------------------------------------------------");
    $display("Time\tTX\tTX_DONE\tRX_BUSY\tVALID\tPARITY_ERR\tFRAME\tDATA");
    $display("-------------------------------------------------------------");


$monitor("%0t\t%b\t%b\t%b\t%b\t%b\t\t%h",
$time,
tx,
tx_done,
busy_rx,
data_valid,
parity_error,
data_out);
end
always @(posedge pclk)
begin
if(data_valid)
begin

        $display("");
        $display("======================================");
        $display("Received Data = %h", data_out);
        $display("Time          = %0t", $time);
        $display("Parity Error  = %b", parity_error);
        $display("Frame Error   = %b", framing_error);
        $display("======================================");
        $display("");
	
end
end
initial begin
	$dumpfile("uart.vcd");
	$dumpvars(0,uart_tb);
end
endmodule
