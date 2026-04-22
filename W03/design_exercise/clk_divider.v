module clk_divider (
    input clk,    // 50 MHz input
    input rst,    // Active-high reset
    output reg clk_div
);

    // CHALLENGE: Calculate the constant to get a 2Hz signal.
    // Formula: (Clock In (Hz) / (Desired Frequency * 2)) - 1 
    localparam constantNumber = // ??? ; 

    reg [31:0] count;

    // Counter Logic
    always @(posedge clk or posedge rst) begin
        if (rst)
            count <= 32'b0;
        else if (count == constantNumber)
            count <= 32'b0;
        else
            count <= count + 1;
    end

    // Flip-Flop Logic
    always @(posedge clk or posedge rst) begin
        if (rst)
            clk_div <= 1'b0;
        else if (count == constantNumber)
            clk_div <= ~clk_div; // Toggle the signal
        else
            clk_div <= clk_div;
    end

endmodule