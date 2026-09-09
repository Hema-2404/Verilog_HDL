module reg_piso(
input rst,
input clk,
input load,
input[3:0] parallel_in,
output  serial_out
);
reg [3:0]q;
always @(posedge clk)begin
if (rst)
q<=4'b0000;
else if(load)
q<=parallel_in;
else
q<={q[2:0],1'b0};
end
assign serial_out=q[3];
endmodule
