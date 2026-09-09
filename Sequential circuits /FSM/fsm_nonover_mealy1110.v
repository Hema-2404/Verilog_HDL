module fsm_nonov_mealy1110(
		input clk,
		input rst,
		input din,
		output reg dout 
);
parameter S0=2'b00,
	  S1=2'b01,
	  S2=2'b10,
          S3=2'b11;
reg [1:0]ps,ns;
always @(posedge clk or posedge rst)begin
if(rst)
ps<=S0;
else
ps<=ns;
end
always @(*)begin
case(ps)
S0:begin
if(din)
ns=S1;
else
ns=S0;
end
S1:begin
if(din)
ns=S2;
else
ns=S0;
end
S2:begin
if(din)
ns=S3;
else
ns=S0;
end
S3:begin
if(din)
ns=S2;
else
ns=S0;
end
default ns=S0;
endcase 
end 
always@(*)begin
case(ps)
S3:dout=1'b1;
default:dout=1'b0;
endcase
end
endmodule
