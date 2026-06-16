`timescale 1ns/1ps
module register_4bit_tb;

reg clk;
reg rst;
reg en;
reg [3:0] d;
wire [3:0] q;

register_4bit register_4bit_0 (
    .clk(clk),
    .rst(rst),
    .en(en),
    .d(d),
    .q(q)
);

// Clock generation using always block
initial clk = 0;
always #5 clk = ~clk;

initial
begin
    // Reset Test
    rst = 1;
    en  = 0;
    d   = 4'b0000;
    #20;
    rst = 0;

    // Test 1 : Load 1010
    en = 1;
    d  = 4'b1010;
    @(posedge clk);
    #10;
    if(q !== 4'b1010)
        $display("ERROR: Register load failed");
    else
        $display("PASS: Register loaded 1010");

    // Test 2 : Hold value
    en = 0;
    d  = 4'b1111;
    @(posedge clk);
    #10;
    if(q !== 4'b1010)
        $display("ERROR: Register hold failed");
    else
        $display("PASS: Register held value");

    // Test 3 : Load 1100
    en = 1;
    d  = 4'b1100;
    @(posedge clk);
    #10;
    if(q !== 4'b1100)
        $display("ERROR: Register update failed");
    else
        $display("PASS: Register loaded 1100");

    // Test 4 : Reset
    rst = 1;
    #10;
    if(q !== 4'b0000)
        $display("ERROR: Register reset failed");
    else
        $display("PASS: Register reset");

    $display("All Register Tests Passed");
    $stop;
end

endmodule