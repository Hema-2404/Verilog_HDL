module mod10_counter(
    input clk,
    input rst,
    input en,
    output reg [3:0] count
);

always @(posedge clk) begin
    if (rst)
        count <= 4'b0000;
    else if (en) begin
        if (count == 4'd9)
            count <= 4'b0000;
        else
            count <= count + 1;
    end
    else
        count <= count;
end

endmodule
