module top_random_gen (
    input  wire MAX10_CLK1_50, // Physical 50MHz clock
    input  wire [1:0] KEY,     // KEY[0] Reset (Active-low on board)
    output wire [6:0] HEX0,    // 7-segment display
    output wire [6:0] HEX1,    // 7-segment display
    output wire [6:0] HEX2,    // 7-segment display
    output wire [6:0] HEX3,    // 7-segment display
);

    wire slow_clk;
    wire [15:0] lfsr_data;
    wire rst_high;

    // Board keys are active-low, our modules use active-high reset
    assign rst_high = ~KEY[0];

    // 1. Instantiate the Clock Divider
    clk_divider timer (
        .clk     (MAX10_CLK1_50),
        .rst     (????),
        .clk_div (????)		   // Which clk is EXPECTED from the divider? 
    );

    // 2. Instantiate the 16-bit LFSR
    // Wire the 'slow_clk' to the correct input
    lfsreg #(.WIDTH(16)) generator (
        .clk      ( // ??? ), 	   // There should be a clock here, which one?
        .reset_n  (KEY[0]),        // Active-low reset
        .enable   ( // ??? ),      // Which signal should trigger a new number? (Hint: It's a clock)
        .out      (lfsr_data)
    );

    // 3. Instantiate the Hex Decoder, pick your own bits tobe displayed
    hex_decoder display0 (.hex_digit(lfsr_data[??:??]),   .segments(HEX0));
    hex_decoder display1 (.hex_digit(lfsr_data[??:??]),   .segments(HEX1));
    hex_decoder display2 (.hex_digit(lfsr_data[??:??]),   .segments(HEX2));
    hex_decoder display3 (.hex_digit(lfsr_data[??:??]),  .segments(HEX3));

endmodule