module apb_master(
input pclk,
input presetn,
input transfer,
input write_read,
input [31:0] addr_in,
input [31:0] data_in,
input pready,
input [31:0]prdata,
output reg psel,
output reg penable,
output reg pwrite,
output reg [31:0] paddr,
output reg [31:0] pwdata,
output reg [31:0] data_out,
output reg ready_out
);
localparam IDLE =2'b00;
localparam SETUP=2'b01;
localparam ACCESS =2'b10;
reg [1:0] current_state;
reg [1:0] next_state;
always @(posedge pclk or negedge presetn)
begin 
if(!presetn)
current_state<=IDLE;
else 
current_state<=next_state;
end
always @(*) begin 
	case(current_state)
	IDLE:
	begin 
	if(transfer)
		next_state = SETUP;
	else
		next_state = IDLE;
end
SETUP:
begin
	next_state = ACCESS;
end
		
ACCESS:
begin 
if(pready)
next_state=IDLE;
else
next_state=ACCESS;
end

default:
begin
next_state =IDLE;
end
endcase
end
always @(posedge pclk or negedge presetn)
begin 
if(!presetn)
begin
psel<=1'b0;
penable<=1'b0;
pwrite<=1'b0;
paddr<=32'b0;
pwdata<=32'b0;
ready_out<=1'b0;
data_out<=32'b0;
end
else
begin 
ready_out<=1'b0;
case(current_state)
IDLE:
begin 
psel<=1'b0;
penable<=1'b0;
end
SETUP:
begin 
psel<=1'b1;
penable<=1'b0;
paddr<=addr_in;
pwrite<=write_read;
if(write_read)
pwdata<=data_in;
end
ACCESS:
begin 
psel<=1'b1;
penable<=1'b1;
if(pready)
begin
	ready_out<=1'b1;
	if(!pwrite)
		data_out<=prdata;
end
end
default:
begin 
psel<=1'b0;
penable <=1'b0;
end
endcase
end
end
endmodule 
