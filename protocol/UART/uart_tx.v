module uart_tx(
    pclk,
    presetn,
    baud_tick,
    tx_start,
    tx_data,
    tx,
    busy,
    tx_done
);

input pclk;
input presetn;
input baud_tick;
input tx_start;
input [7:0] tx_data;

output reg tx;
output reg busy;
output reg tx_done;

localparam IDLE   = 3'd0;
localparam START  = 3'd1;
localparam DATA   = 3'd2;
localparam PARITY = 3'd3;
localparam STOP   = 3'd4;



reg [2:0] current_state;
reg [2:0] next_state;

reg [7:0] shift_reg;
reg [2:0] bit_count;
reg parity_bit;



always @(posedge pclk or negedge presetn)
begin
    if (!presetn)
        current_state <= IDLE;
    else
        current_state <= next_state;
end




always @(*)
begin
    next_state = current_state;

    case (current_state)

        IDLE:
        begin
            if (tx_start)
                next_state = START;
        end

        START:
        begin
            if (baud_tick)
                next_state = DATA;
        end

        DATA:
        begin
            if (baud_tick)
            begin
                if (bit_count == 3'd7)
                    next_state = PARITY;
            end
        end

        PARITY:
        begin
            if (baud_tick)
                next_state = STOP;
        end

        STOP:
        begin
            if (baud_tick)
                next_state = IDLE;
        end

        default:
            next_state = IDLE;

    endcase
end



always @(posedge pclk or negedge presetn)
begin
    if (!presetn)
    begin
        shift_reg <= 8'd0;
        bit_count <= 3'd0;
        parity_bit <= 1'b0;
    end

    else
    begin

        case (current_state)

            IDLE:
            begin
                if (tx_start)
                begin
                    shift_reg <= tx_data;
                    bit_count <= 3'd0;

                    // Even parity
                    parity_bit <= ^tx_data;
                end
            end


            DATA:
            begin
                if (baud_tick)
                begin
                    shift_reg <= shift_reg >> 1;

                    if (bit_count != 3'd7)
                        bit_count <= bit_count + 1'b1;
                end
            end


            default:
            begin
            end

        endcase

    end
end

always @(*)
begin

    tx = 1'b1;
    busy = 1'b0;
    tx_done = 1'b0;

    case (current_state)

        IDLE:
        begin
            tx = 1'b1;
            busy = 1'b0;
            tx_done = 1'b0;
        end


        START:
        begin
            tx = 1'b0;
            busy = 1'b1;
        end


        DATA:
        begin
            tx = shift_reg[0];
            busy = 1'b1;
        end


        PARITY:
        begin
            tx = parity_bit;
            busy = 1'b1;
        end


        STOP:
        begin
            tx = 1'b1;
            busy = 1'b1;

            if (baud_tick)
                tx_done = 1'b1;
        end


        default:
        begin
            tx = 1'b1;
            busy = 1'b0;
            tx_done = 1'b0;
        end

    endcase

end

endmodule
