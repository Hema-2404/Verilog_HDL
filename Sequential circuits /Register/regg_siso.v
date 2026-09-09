module reg_siso(
input clk,
input rst,
input serial_in,
output serial_out
);
reg [3:0]q;
always @(posedge clk)begin 
if (rst)
	q<=4'b0000;
else 
q<={q[2:0],serial_in};
end
assign serial_out=q[3];
endmodule
