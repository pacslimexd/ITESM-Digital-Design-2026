module alu4 (
    input [3:0] A, B,      // 4-bit inputsi
    input [1:0] opcode,    // 2-bit opcode to select the operation
    output reg [3:0] result, // 4-bit output result

); 
    always @(*) begin
        case (opcode)
            2'b00: result = A + B; // ADD
            2'b01: result = A - B; // SUB
            2'b10: result = A & B; // AND
            2'b11: result = A | B; // OR
            default: result = 4'b0000; // Default case to avoid latches
        endcase
    end

endmodule