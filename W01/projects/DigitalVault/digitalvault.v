module digitalvault (
    input  wire [9:0] SW,    // 10 Switches
    output wire [9:0] LEDR   // 10 LEDs
);
    // Wire Declaration
    wire master;
    wire password;
    wire vault_unlocked;

    // Assign logic to our Wires
    assign master   = SW[9];                 // Master Switch
    assign password = (SW[3:0] == 4'b1011);  // Secret Key (1011)
    
    // Final Condition
    assign vault_unlocked = master & password;

    // Mapping the results to the physical LEDs
    assign LEDR[9]   = vault_unlocked;  // Lock
    assign LEDR[8]   = master;          // Master Status
    assign LEDR[3:0] = SW[3:0];         // Input Feedback

    // Turn off unused LEDs to avoid Driver Warnings
    assign LEDR[7:4] = 4'b0000; 

endmodule