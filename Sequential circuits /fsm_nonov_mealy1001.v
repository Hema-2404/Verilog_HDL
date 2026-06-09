module fsm_nonov_mealy1001(
			input clk,
			input rst,
			input din,
			output reg dout
);
parameter S0=3'b000,
	  S1=3'b001,
          S2=3'b010,
          S3=3'b011;
reg [2:0] ps,ns;
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
ns=S1;
else
ns=S2;
end
S2:begin
if(din)
ns=S1;
else
ns=S3;
end
S3:begin 
if(din)
ns=S0;
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
