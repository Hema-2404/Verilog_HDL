module reg_pipo(
input clk,
input rst,
input load,
input [3:0]parallel_in,
output [3:0] parallel_out
);
reg[3:0]q;
always @ (posedge clk)begin 
if (rst)
q<=4'b0000;
else if(load)
	q<=parallel_in;
end
assign parallel_out=q;
endmodule
