module lfsreg #(
    parameter WIDTH = 16,
    parameter [WIDTH-1:0] SEED = 16'h1001, 
    
    // These are the default taps for 16-bit: bits 15, 13, 12, 10
    parameter [WIDTH-1:0] TAP_MASK = 16'hB400
    )(
    input clk, reset_n, enable, 
    output reg [WIDTH-1:0] out
    );

    wire feedback; 
    assign feedback = ^(out & TAP_MASK);

    always @(posedge clk or negedge reset_n)
	begin
	    if(!reset_n)
		    out <= SEED;
	    else if (enable == 1'b1)
            out <= {out[WIDTH-2:0],feedback};	
	end

endmodule 