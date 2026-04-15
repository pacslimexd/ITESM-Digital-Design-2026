module mux8 (
    input [7:0] data_in; // 8-bit input data
    input [2:0] sel;     // 3-bit select signal
    output reg y 
); 
    always @(*) begin
        case (sel)
            3'b000: y = data_in[0]; // Select bit 0
            3'b001: y = data_in[1]; // Select bit 1
            3'b010: y = data_in[2]; // Select bit 2
            3'b011: y = data_in[3]; // Select bit 3
            3'b100: y = data_in[4]; // Select bit 4
            3'b101: y = data_in[5]; // Select bit 5
            3'b110: y = data_in[6]; // Select bit 6
            3'b111: y = data_in[7]; // Select bit 7
            default: y = 1'b0;      // IMPORTANT: Always include a default case to avoid latches
        endcase
    end
endmodule