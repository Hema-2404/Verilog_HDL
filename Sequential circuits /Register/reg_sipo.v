module reg_sipo(
input clk,
input rst,
input serial_in,
output [3:0]parallel_out
);
reg [3:0] q;
always @ (posedge clk)begin 
if (rst)
q<=4'b0000;
else 
q<={q[2:0],serial_in};
end
assign parallel_out=q;
endmodule
