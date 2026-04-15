module hamming_top (
    input  wire [9:0] SW,       // SW[3:0]: Data | SW[9]: Error injector
    output wire [9:0] LEDR,     // LED[6:0]: Bus with error | LED[9]: Error indicator
    output wire [6:0] HEX0,     // HEX0: Recovered and corrected data
    output wire [6:0] HEX1      // HEX1: Corrupted data (to see the error)
);

    // Interconnection wires
    wire [6:0] hammered_code;   // Code output from the encoder
    wire [6:0] bus_with_error;  // Code traveling through the "cable"
    wire [3:0] corrected_data;  // Result after the decoder
    wire [3:0] noisy_data;      // Extracted data with the potential error

    // Protect the 4 input bits
    hamming_encoder enc (
        .d(SW[3:0]), 
        .c(hammered_code)
    );

    // If SW[9] is ON, we invert one bit (bit 2)
    // We use the XOR (^) operator to flip bit 2 only when SW[9] is 1
    assign bus_with_error = (SW[9]) ? (hammered_code ^ 7'b0000100) : hammered_code;

    // 3. DECODER: Receives the bus and repairs it
    hamming_decoder dec (
        .r(bus_with_error), 
        .data_out(corrected_data)
    );

    // We pull the data bits directly from the corrupted bus
    // In our Hamming (7,4) arrangement: D4=bit6, D3=bit5, D2=bit4, D1=bit2
    assign noisy_data = {bus_with_error[6:5], bus_with_error[4], bus_with_error[2]};

    // 5. MAPPING: Board outputs
    assign LEDR[6:0] = bus_with_error; // Show how the bus looks physically
    assign LEDR[9]   = SW[9];          // Warning LED: "Cosmic ray active"
    
    // HEX1 shows the raw, potentially corrupted data
    hex_decoder display_noisy (
        .hex_digit(noisy_data), 
        .segments(HEX1)
    );

    // HEX0 shows the final, error-corrected data
    hex_decoder display_clean (
        .hex_digit(corrected_data), 
        .segments(HEX0)
    );

endmodule