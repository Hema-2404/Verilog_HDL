module sequence_detector_1111(
input clk,
input rst,
input din,
output reg dout
);
parameter S0=2'b00;
parameter S1=2'b01;
parameter S2=2'b10;
parameter S3=2'b11;
reg [1:0] current_state;
reg [1:0] next_state;
always @(posedge clk or posedge rst)begin
if(rst)
current_state<=S0;
else
current_state<=next_state;
end
always @(*)begin
next_state=S0;
dout=1'b0;
case(current_state)
S0:begin
if(din == 1'b1)
next_state = S1;
else
next_state =S0;
end
S1:begin 
if(din ==1'b1)
next_state = S2;
else
next_state = S0;
end
S2:begin 
if(din == 1'b1)
next_state = S3;
else
next_state = S0;
end
S3:begin
if(din == 1'b1)begin
next_state = S0;
dout=1'b1;
end
else begin
next_state =S0;
end
end
default:begin
next_state=S0;
dout=1'b0;
end
endcase
end
endmodule
