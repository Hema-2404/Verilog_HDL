module Dflip(
		input D,
		input rst,
		input clk,
		output reg Y
);
always @(posedge clk)begin
if (rst)
Y<=0;
else 
Y<=D;
end
endmodule
