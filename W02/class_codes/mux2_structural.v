module mux2_structural (
    input  a, b, sel,   
    output y  
);
    wire not_sel, w1, w2;

    not (not_sel, sel);    // not_sel = ~sel
    and (w1, a, not_sel);  // w1 = a & ~sel
    and (w2, b, sel);      // w2 = b & sel
    or  (y, w1, w2);      // y = w1 |
    
endmodule