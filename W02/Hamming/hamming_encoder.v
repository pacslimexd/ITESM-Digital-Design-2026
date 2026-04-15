module hamming_encoder (
    input  wire [3:0] d,    // 4 data bits
    output wire [6:0] c     // 7 codification bits (4 data + 3 parity
);

    // The "c" array represents the 7 bits of the Hamming code, where:
    // c[0] = P1 (parity bit 1)
    // c[1] = P2 (parity bit 2) 
    // c[2] = D1 (data bit 1)
    // c[3] = P3 (parity bit 3)
    // c[4] = D2 (data bit 2)
    // c[5] = D3 (data bit 3)
    // c[6] = D4 (data bit 4)
    
    // We get the parity bits by performing XOR operations on the data bits. 
    assign c[0] = d[0] ^ d[1] ^ d[3]; // P1 
    assign c[1] = d[0] ^ d[2] ^ d[3]; // P2 
    assign c[3] = d[1] ^ d[2] ^ d[3]; // P3 

    // Data bits are directly assigned to their respective positions in the codeword
    assign c[2] = d[0]; // D1
    assign c[4] = d[1]; // D2
    assign c[5] = d[2]; // D3
    assign c[6] = d[3]; // D4

endmodule