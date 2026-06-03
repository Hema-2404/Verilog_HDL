module mux1to2_be(
		input d0,d1,S,
		output reg  y
);
always @(*) begin 
y=(~S&d0)|(S&d1);
end
endmodule
