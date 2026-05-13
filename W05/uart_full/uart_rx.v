module uart_rx #(
	parameter DATA_WIDTH = 8
) (
	input  wire                  clk,
	input  wire                  rst_n,
	input  wire                  rx_in,
	input  wire                  baud_tick_16x,
	output reg  [DATA_WIDTH-1:0] rx_data,
	output reg                   rx_done,
	output reg                   rx_busy,
	output reg                   rx_frame_error
);

	localparam IDLE  = 2'b00;
	localparam START = 2'b01;
	localparam DATA  = 2'b10;
	localparam STOP  = 2'b11;

	localparam BIT_COUNT_WIDTH = $clog2(DATA_WIDTH);

	reg [1:0] current_state;
	reg [1:0] next_state;
	reg [BIT_COUNT_WIDTH-1:0] bit_counter;

	// Wait 8 ticks to validate START at mid-bit; then sample every 16 ticks.
	reg [3:0] sample_counter;

	// Shift register captures serial RX bits
    // Hold register keeps last full byte
	reg [DATA_WIDTH-1:0] rx_shift_reg;
	reg [DATA_WIDTH-1:0] rx_hold_reg;

	// Next-state logic 
	always @(*) begin
		next_state = current_state;

		case (current_state)
			IDLE: begin
				if (!rx_in) begin
					next_state = START;
				end
			end

			START: begin
				if (baud_tick_16x && (sample_counter == 4'd7)) begin
					if (!rx_in) begin
						next_state = DATA;
					end else begin
						next_state = IDLE;
					end
				end
			end

			DATA: begin
				if (baud_tick_16x && (sample_counter == 4'd15) && (bit_counter == DATA_WIDTH-1)) begin
					next_state = STOP;
				end
			end

			STOP: begin
				if (baud_tick_16x && (sample_counter == 4'd15)) begin
					next_state = IDLE;
				end
			end

			default: begin
				next_state = IDLE;
			end
		endcase
	end

	// State, counters, and datapath logic (synchronous)
	always @(posedge clk or negedge rst_n) begin
		if (!rst_n) begin
			current_state   <= IDLE;
			bit_counter     <= {BIT_COUNT_WIDTH{1'b0}};
			sample_counter  <= 4'd0;
			rx_shift_reg    <= {DATA_WIDTH{1'b0}};
			rx_hold_reg     <= {DATA_WIDTH{1'b0}};
			rx_data         <= {DATA_WIDTH{1'b0}};
			rx_done         <= 1'b0;
			rx_busy         <= 1'b0;
			rx_frame_error  <= 1'b0;
		end else begin
			rx_done <= 1'b0;

			case (current_state)
				IDLE: begin
					rx_busy        <= 1'b0;
					sample_counter <= 4'd0;
					bit_counter    <= {BIT_COUNT_WIDTH{1'b0}};
				end

				START: begin
					rx_busy <= 1'b1;
					if (baud_tick_16x) begin
						sample_counter <= sample_counter + 1'b1;
						if (sample_counter == 4'd7) begin
							sample_counter <= 4'd0;
							bit_counter <= {BIT_COUNT_WIDTH{1'b0}};
						end
					end
				end

				DATA: begin
					if (baud_tick_16x) begin
						sample_counter <= sample_counter + 1'b1;
						if (sample_counter == 4'd15) begin
							sample_counter <= 4'd0;
							rx_shift_reg <= {rx_in, rx_shift_reg[DATA_WIDTH-1:1]};
							bit_counter <= bit_counter + 1'b1;
						end
					end
				end

				STOP: begin
					if (baud_tick_16x) begin
						sample_counter <= sample_counter + 1'b1;
						if (sample_counter == 4'd15) begin
							sample_counter <= 4'd0;
							if (rx_in) begin
								rx_hold_reg <= rx_shift_reg;
								rx_data <= rx_shift_reg;
								rx_done <= 1'b1;
								rx_frame_error <= 1'b0;
							end else begin
								rx_frame_error <= 1'b1;
							end
						end
					end
				end

				default: begin
					current_state <= IDLE;
				end
			endcase

			current_state <= next_state;
		end
	end

endmodule
