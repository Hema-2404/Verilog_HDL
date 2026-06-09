module fsm_nonov_moore(
		input clk,
		input rst,
		input din,
		output reg dout
);
parameter  S0=3'b000,
	   S1=3'b001,
	   S2=3'b010,
	   S3=3'b011,
	   S4=3'b100;
reg [2:0]ns,ps;
always @(posedge clk or posedge rst)begin
if (rst)
ps<=S0;
else
ps<=ns;
end
always @(*) begin 
case (ps)
S0:begin 
if (din)
ns=S0;
else
ns=S1;
end
S1:begin
if(din)
ns=S2;
else
ns=S1;
end
S2:begin
if(din)
ns=S3;
else 
ns=S1;
end
S3:begin
if(din)
ns=S0;
else
ns=S4;
end
S4:begin 
if(din)
ns=S0;
else
ns=S1;
end
default:ns=S0;
endcase 
end 
always @(*)begin 
case(ps)
S4:dout=1'b1;
default :dout=1'b0;
endcase
end
endmodule
