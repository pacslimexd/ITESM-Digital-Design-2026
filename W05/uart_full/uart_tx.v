module uart_tx #(
    parameter DATA_WIDTH = 8
) (
    input wire clk, 
    input wire rst_n, 
    input wire tx_start, 
    input wire baud_tick, 
    input wire [DATA_WIDTH-1:0] tx_data, 
    output reg tx_out, 
    output reg tx_busy
);
    // States 
    localparam IDLE  = 2'b00; 
    localparam START = 2'b01;
    localparam DATA  = 2'b10;
    localparam STOP  = 2'b11;
    // BIT_COUNT_WIDTH = $clog2(DATA_WIDTH);
    localparam BIT_COUNT_WIDTH = $clog2(DATA_WIDTH);

    // registers (current_state, next_state, bit_counter, data_buffer)
    reg [1:0] current_state, next_state;
    reg [BIT_COUNT_WIDTH-1:0] bit_counter;
    reg [DATA_WIDTH-1:0] data_buffer;

    // Next State Logic
    always @(*) begin 
        next_state = current_state; // Default: stay in current state
        case (current_state)
            IDLE:  if (tx_start)                              next_state = START; 
            START: if (baud_tick)                             next_state = DATA; 
            DATA:  if (baud_tick && bit_counter == (DATA_WIDTH-1)) next_state = STOP;
            STOP:  if (baud_tick)                             next_state = IDLE;  
            default:                                          next_state = IDLE;
        endcase
    end

    // Drive the signals
    always @(posedge clk or negedge rst_n) begin 
        if (!rst_n) begin 
            tx_out <= 1'b1; 
            tx_busy <= 1'b0; 
            bit_counter <= {BIT_COUNT_WIDTH{1'b0}}; // (Replicator Opeartor) {number of bits{value to replicate}}
            data_buffer <= {DATA_WIDTH{1'b0}};
            current_state <= IDLE;
        end else begin 
            case (current_state)
                IDLE: begin 
                    tx_out <= 1'b1; 
                    tx_busy <= 1'b0; 
                    bit_counter <= {BIT_COUNT_WIDTH{1'b0}};
                    data_buffer <= {DATA_WIDTH{1'b0}};
                end 
                START: begin 
                    tx_out <= 1'b0; // Start bit is always 0
                    tx_busy <= 1'b1; 
                    data_buffer <= tx_data; // Load the data into the buffer
                end
                DATA: begin 
                    if (baud_tick) begin 
                        tx_out <= data_buffer[0]; // Send the LSB first
                        data_buffer <= data_buffer >> 1; // Shift the buffer to get the next bit ready
                        bit_counter <= bit_counter + 1; // Increment the bit counter
                    end
                end
                STOP: begin 
                    if (baud_tick) begin 
                        tx_out <= 1'b1; // Stop bit is always 1
                        tx_busy <= 1'b0; 
                    end
                end
            endcase
            current_state <= next_state; // Update the current state
        end 
    end


endmodule 