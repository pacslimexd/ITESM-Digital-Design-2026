module baud_rate_gen 
#(
    parameter CLK_FREQ = 50000000, 
    parameter BAUD = 115200 
); 
(
    input wire clk, 
    input wire rst_n, 
    output reg baud_tick

);

// Local param is useful for values that are derived from the parameters and are not expected to change
localparam TICK_COUNT = CLK_FREQ / BAUD;
// 5000000 / 115200 = 434.02777777777777

// Reg (counter)
reg [31:0] counter;

// State Machine
// if counter == TICK_COUNT - 1, reset counter and set baud_tick
always @(posedge clk or negedge rst_n) begin 
    if (!rst_n) begin 
        counter <= 32'd0; 
        baud_tick <= 1'b0; 
    end else begin 
        if (counter == TICK_COUNT - 1) begin 
            counter <= 32'd0;
            baud_tick <= 1'b1; 
        end else begin 
            counter <= counter + 1; 
            baud_tick <= 1'b0; 
        end
    end 


endmodule 