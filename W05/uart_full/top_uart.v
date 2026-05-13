module top_uart #(
    parameter DATA_WIDTH = 8,
    parameter CLK_FREQ   = 50000000,
    parameter BAUD       = 115200
) (
    input  wire                  clk,
    input  wire                  rst_n,
    input  wire                  rx_in,
    output wire                  tx_out,
    output wire                  state_led
);

    wire baud_tick;
    wire baud_tick_16x;

    wire [DATA_WIDTH-1:0] rx_data;
    wire                  rx_done;
    wire                  rx_busy;
    wire                  rx_frame_error;
    wire                  tx_busy;

    reg                   tx_start;
    reg [DATA_WIDTH-1:0]  tx_data;

    // Echo received bytes back on TX.
    // tx_start is a one-clock pulse when a byte is ready and TX is idle.
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            tx_start <= 1'b0;
            tx_data  <= {DATA_WIDTH{1'b0}};
        end else begin
            tx_start <= 1'b0;
            if (rx_done && !tx_busy) begin
                tx_data  <= rx_data;
                tx_start <= 1'b1;
            end
        end
    end

    // Status LED: ON when RX/TX active or a frame error is present.
    assign state_led = rx_busy | tx_busy | rx_frame_error;

    baud_rate_gen #(
        .CLK_FREQ(CLK_FREQ),
        .BAUD(BAUD)
    ) u_baud_rate_gen (
        .clk(clk),
        .rst_n(rst_n),
        .baud_tick(baud_tick),
        .baud_tick_16x(baud_tick_16x)
    );

    uart_tx #(
        .DATA_WIDTH(DATA_WIDTH)
    ) u_uart_tx (
        .clk(clk),
        .rst_n(rst_n),
        .tx_start(tx_start),
        .baud_tick(baud_tick),
        .tx_data(tx_data),
        .tx_out(tx_out),
        .tx_busy(tx_busy)
    );

    uart_rx #(
        .DATA_WIDTH(DATA_WIDTH)
    ) u_uart_rx (
        .clk(clk),
        .rst_n(rst_n),
        .rx_in(rx_in),
        .baud_tick_16x(baud_tick_16x),
        .rx_data(rx_data),
        .rx_done(rx_done),
        .rx_busy(rx_busy),
        .rx_frame_error(rx_frame_error)
    );

endmodule