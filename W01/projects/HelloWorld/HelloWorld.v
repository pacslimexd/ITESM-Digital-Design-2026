module HelloWorld1 (
    input  wire SW,   // Switch 0
    output wire LED   // LED 0
);
    assign LED = SW; 
endmodule