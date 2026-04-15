module hex_decoder (
    input      [3:0] hex_digit, // 4-bit input representing a hexadecimal digit (0-F)
    output reg [6:0] segments // 7-bit output for the segments (a-g) of the 7-segment display
);

    always @(*) begin
        case (hex_digit)
            // Remember : 0 ON, 1 OFF. Order: g-f-e-d-c-b-a
            4'h0: segments = 7'b1000000;
            4'h1: segments = 7'b1111001;
            4'h2: segments = 7'b0100100;
            4'h3: segments = 7'b0110000;
            4'h4: segments = 7'b0011001;
            4'h5: segments = 7'b0010010;
            4'h6: segments = 7'b0000010;
            4'h7: segments = 7'b1111000;
            4'h8: segments = 7'b0000000;
            4'h9: segments = 7'b0010000;
            4'hA: segments = 7'b0001000; // A
            4'hB: segments = 7'b0000011; // b
            4'hC: segments = 7'b1000110; // C
            4'hD: segments = 7'b0100001; // d
            4'hE: segments = 7'b0000110; // E
            4'hF: segments = 7'b0001110; // F
            default: segments = 7'b1111111; // All segments off for invalid input
        endcase
    end

endmodule