module uart_rx(
	pclk,
	presetn,
	baud_tick,
	rx,
	rx_data,
	rx_valid,
	busy,
	parity_error,
	framing_error
);
input pclk;
input presetn;
input baud_tick;
input rx;
output reg [7:0] rx_data;
output reg  rx_valid;
output reg  busy;
output reg parity_error;
output reg framing_error;

reg [2:0] current_state;
reg [2:0] next_state;

reg [7:0]  shift_reg;
reg [2:0] bit_count;
reg parity_calc;


parameter PARITY_EN=1'b1;
parameter EVEN_PARITY=1'b1;

localparam IDLE=3'd0;
localparam START=3'd1;
localparam DATA=3'd2;
localparam PARITY=3'd3;
localparam STOP=3'd4;

always @(posedge pclk or negedge presetn)
begin
	if(!presetn)
		current_state<=IDLE;
	else
		current_state<=next_state;
end
always @(*)
begin
	next_state =current_state;
	
	case(current_state)
		IDLE:
		begin
			if(!rx)
next_state =START;
end
START:
begin 
if(baud_tick) 
begin 
	if(!rx)
		next_state=DATA;
	else
		next_state =IDLE;
end
end
DATA:
begin 
if(baud_tick)
begin
	if(bit_count ==3'd7)
	begin
		if(PARITY_EN)
			next_state =PARITY;
		else
			next_state =STOP;
	end
end
end
PARITY:
begin 
if(baud_tick)
		next_state=STOP;
	
end
STOP:
begin
	if(baud_tick)
			next_state=IDLE;
	end
	default:
		next_state = IDLE;
endcase
end

always @(posedge pclk or negedge presetn)
begin
	if(!presetn)
       	begin 
	shift_reg <=8'd0;
		rx_data <=8'd0;
		bit_count <=3'd0;
		parity_calc <=1'b0;

		rx_valid <=1'b0;
		busy<=1'b0;
		parity_error<=1'b0;
		framing_error<=1'b0;
	end
	else
       	begin 
		rx_valid<=1'b0;
		case(current_state)
			IDLE:
			begin
				busy<=1'b0;
				bit_count <=3'd0;
				parity_calc<=1'b0;
				parity_error <=1'b0;
				framing_error<=1'b0;
				end
				START:
				begin 
				busy <=1'b1;
			end
			DATA:
			begin 
			busy<=1'b1;
			if(baud_tick)
			begin
				shift_reg[bit_count]<=rx;
				parity_calc<=parity_calc^rx;
				if(bit_count != 3'd7)
				bit_count <=bit_count+1'b1;
			end
		end
		PARITY:begin
			busy <=1'b1;
			if(baud_tick)begin
				if(EVEN_PARITY)begin 
					if(rx != parity_calc)
						parity_error <=1'b1;
				end
				else
			       	begin
					if(rx == parity_calc)
					parity_error <=1'b1;
			end
				end
			end
		
		STOP:
		begin 
		busy <=1'b1;
		if(baud_tick)
		begin
			if (rx == 1'b0)
				framing_error <=1'b1;
			rx_data <= shift_reg;
			rx_valid<=1'b1;
			busy <=1'b0;
		end
	end
default :
begin
	busy<=1'b0;
end
endcase
end
end
endmodule

