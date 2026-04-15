module hamming_decoder(
    input  wire [6:0] r,        // Received 7 bits (4 data + 3 parity)
    output reg  [6:0] fixed,    // Corrected output
    output wire [3:0] data_out, // Clean data bits
    output wire [2:0] syndrome  // For monitoring (to see the error)
);
    
    /*  Calculate the syndrome bits
    This is made through XOR operations between the received bits 
    according to the Hamming code parity check matrix which defines 
    the relationship between data and parity bits */
    assign syndrome[0] = r[0] ^ r[2] ^ r[4] ^ r[6];
    assign syndrome[1] = r[1] ^ r[2] ^ r[5] ^ r[6];
    assign syndrome[2] = r[3] ^ r[4] ^ r[5] ^ r[6];

    // Correct the error if syndrome is not zero
    always @(*) begin
        fixed = r; // For default, we will assume the received bits are correct
        
        if (syndrome != 3'b000) begin
            /* If the syndrome is not zero, it indicates the position of the error (1 to 7).
            We can use the syndrome value to determine which bit is incorrect and flip it to correct the error. 
            The syndrome value directly corresponds to the bit position in the received codeword (1-based index).
            */
            fixed[syndrome - 1] = ~r[syndrome - 1]; 
        end
    end

    // Clean data bits are in positions 3, 5, 6, and 7 of the fixed output 
    assign data_out = {fixed[6:5], fixed[4], fixed[2]};

endmodule 