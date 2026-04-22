module shift_register_4bit (
    input  wire clk,         // System clock
    input  wire reset_n,     // Active-low asynchronous reset
    input  wire enable,      
    input  wire shift_in,    // Serial data input
    output reg  [3:0] q      // 4-bit parallel output
);

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            q <= 4'b0000;    // Clear the register
        end else if (enable) begin
            // Shift left: concatenate the lower 3 bits with the new input
            q <= {q[2:0], shift_in}; 
        end
    end

endmodule