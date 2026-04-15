module top_module (
    input  wire [9:0] SW,   // 10 switches 
    output wire [7:0] HEX0 // 8 segments of the 7-segment display (including the decimal point)
);

    // Instanciamos nuestro traductor
    hex_decoder mi_display (
        .hex_digit (SW[3:0]),        // Lets wire the rightmost 4 switches to the hex_digit input of the decoder
        .segments  (HEX0[6:0])       // Lets wire the segments output to the 7-segment display
    );

    // TURN OFF the decimal point explicitly (Active-Low -> 1)
    assign HEX0[7] = 1'b1; 

endmodule