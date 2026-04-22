`timescale 1ns/1ps

module clk_divider_tb;
    reg clk;
    reg rst;
    wire clk_div;

    clk_divider dut (
        .clk(clk),
        .rst(rst),
        .clk_div(clk_div)
    );

    
    always #10 clk = ~clk;

    initial begin
        $dumpfile("simulation.vcd");
        $dumpvars(0, clk_divider_tb);
        
        clk = 0;
        rst = 1;
        #50 rst = 0; // Soltar reset
        
        #500000000; 
        $finish;
    end
endmodule