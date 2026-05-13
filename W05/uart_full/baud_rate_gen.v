module baud_rate_gen #(
    parameter CLK_FREQ = 50000000,
    parameter BAUD     = 115200
) (
    input  wire clk,
    input  wire rst_n,
    output reg  baud_tick,
    output reg  baud_tick_16x
);

    // Divide system clock to a 16x baud enable, then derive 1x from it.
    localparam integer OVERSAMPLE      = 16;
    localparam integer TICK_16X_COUNT  = CLK_FREQ / (BAUD * OVERSAMPLE);

    reg [31:0] clk_div_counter;
    reg [3:0]  sub_tick_counter;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            clk_div_counter <= 32'd0;
            sub_tick_counter <= 4'd0;
            baud_tick_16x <= 1'b0;
            baud_tick <= 1'b0;
        end else begin
            baud_tick_16x <= 1'b0;
            baud_tick <= 1'b0;

            if (clk_div_counter == TICK_16X_COUNT - 1) begin
                clk_div_counter <= 32'd0;
                baud_tick_16x <= 1'b1;

                if (sub_tick_counter == OVERSAMPLE - 1) begin
                    sub_tick_counter <= 4'd0;
                    baud_tick <= 1'b1;
                end else begin
                    sub_tick_counter <= sub_tick_counter + 1'b1;
                end
            end else begin
                clk_div_counter <= clk_div_counter + 1'b1;
            end
        end
    end

endmodule