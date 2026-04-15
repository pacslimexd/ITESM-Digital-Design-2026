module mux32(
    input wire [31:0] D, // 32-bit input data
    input wire S4, S3, S2, S1, S0, // 5-bit select signal
    output wire Y
);

    // Wires for enables
    wire E0, E1, E2, E3; 

    // Wires for outputs of MUXes
    wire Y0, Y1, Y2, Y3; 

    assign E0 = ~S4 & ~S3; // 00 : MUX 0 
    assign E1 = ~S4 & S3;  // 01 : MUX 1
    assign E2 = S4 & ~S3;  // 10 : MUX 2
    assign E3 = S4 & S3;   // 11 : MUX 3

    mux8_en m0(
        .data_in(D[7:0]), 
        .sel({S2, S1, S0}), 
        .enable(E0), 
        .y(Y0)
    );

     mux8_en m1(
        .data_in(D[7:0]), 
        .sel({S2, S1, S0}), 
        .enable(E1), 
        .y(Y1)
    );

     mux8_en m2(
        .data_in(D[7:0]), 
        .sel({S2, S1, S0}), 
        .enable(E2), 
        .y(Y2)
    );

     mux8_en m3(
        .data_in(D[7:0]), 
        .sel({S2, S1, S0}), 
        .enable(E3), 
        .y(Y3)
    );

    // OR Output of all MUXes to get final output
    assign Y = Y0 | Y1 | Y2 | Y3;


    // This design uses 4 instances of an 8-to-1 MUX with enable (mux8_en) to create a 32-to-1 MUX.
    // During class we did not implement the mux8_en, but you can easily modify the mux8 code to include an enable signal.


endmodule