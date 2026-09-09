module apb_slave #(
parameter addr_width=32,
parameter data_width=32,
parameter depth=256
)(
input pclk,
input presetn,
input psel,
input penable,
input pwrite,
input [addr_width-1:0] paddr,
input [data_width-1:0] pwdata,
output reg [data_width-1:0] prdata,
output reg pready
);
reg [data_width-1:0] mem [0:depth-1];
reg [1:0] wait_count;
integer i;
always @(posedge pclk or negedge presetn)
begin 
if(!presetn)
begin 
prdata<=32'b0;
pready<=1'b0;
wait_count<=2'b00;
for(i=0;i<depth;i=i+1)
begin
mem[i]<=32'b0;
end
end
else
begin  
if (psel && penable)
begin 
if(wait_count<2)
begin
pready<=1'b0;
wait_count <=wait_count+1'b1;
end
else
begin
pready<=1'b1;
wait_count<=2'b00;
if(pwrite)
begin
mem[paddr[7:0]]<=pwdata;
end
else
begin 
prdata<=mem[paddr[7:0]];
end
end
end
else
begin
pready<=1'b0;
wait_count<=2'b00;
end
end
end
endmodule
