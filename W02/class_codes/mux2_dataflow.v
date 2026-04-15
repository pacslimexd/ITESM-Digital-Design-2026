module mux2_dataflow (
    input  a, b, sel,   
    output y  
);
    // Implementation using a continuous assignment statement
    assign y = sel ? b : a;
    // This is equivalent to: 
    // assign y = (sel & b) | (~sel & a);

    // "?" is a ternary operator that acts as a concise if-else statement.
    // The syntax is: condition ? true_value : false_value;

endmodule