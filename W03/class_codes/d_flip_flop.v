module d_flip_flop (
    input  wire clk,
    input  wire reset_n,  // Active-low asynchronous reset
    input  wire d,
    output reg  q
);


    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            q <= 1'b0;    // Clear output when reset is 0
        end else begin
            q <= d;       // Capture input on the clk edge
        end
    end

endmodule