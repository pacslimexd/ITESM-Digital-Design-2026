module mux2_behavioral (
    input  a, b, sel,   
    output reg y  
);
    always @(*) begin
        if (sel) 
            y = b;  // If sel is 1, y takes the value of b
        else 
            y = a;  // If sel is 0, y takes the value of a
    end
    
endmodule