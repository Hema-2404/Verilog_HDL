module fsm_nonov_mealy1110_tb;
reg clk,rst,din;
wire dout;
fsm_nonov_mealy1110 DUT (clk,rst,din,dout);
 task apply_bit;
    input b;
    begin
      din = b;
      @(posedge clk);
    end
  endtask
always #5 clk=~clk;
initial begin 
clk=0;
rst=1;
din=0;
$dumpfile("fsm_nonov_mealy1110_tb.vcd");
$dumpvars(0,fsm_nonov_mealy1110_tb);
$monitor("clk=%b rst=%b din=%b dout=%b",clk,rst,din,dout);
@(posedge clk);
rst=0; 
apply_bit(1);
apply_bit(1);
apply_bit(1);
apply_bit(0);

apply_bit(1);
apply_bit(1);
apply_bit(1);
apply_bit(0);

apply_bit(1);
apply_bit(1);
apply_bit(0);
apply_bit(0);
apply_bit(1);

#20;
$finish;
end
endmodule
