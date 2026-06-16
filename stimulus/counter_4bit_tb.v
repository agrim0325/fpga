`timescale 1ns/1ps

module counter_4bit_tb;

reg clk;
reg rst;
reg en;

wire [3:0] q;

counter_4bit DUT (
    .clk(clk),
    .rst(rst),
    .en(en),
    .q(q)
);

//
// Clock Generation
//
initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

//
// Test Sequence
//
initial begin

    //----------------------------------
    // Reset Test
    //----------------------------------
    rst = 1;
    en  = 0;

    #20;
    rst = 0;

    if (q !== 4'b0000)
        $display("ERROR: Reset failed");
    else
        $display("PASS: Reset successful");

    //----------------------------------
    // Count 0 -> 4
    //----------------------------------
    en = 1;

    repeat (4)
        @(posedge clk);

    #2;

    if (q !== 4'd4)
        $display("ERROR: Count failed");
    else
        $display("PASS: Count successful");

    //----------------------------------
    // Hold Test
    //----------------------------------
    en = 0;

    repeat (3)
        @(posedge clk);

    #2;

    if (q !== 4'd4)
        $display("ERROR: Hold failed");
    else
        $display("PASS: Hold successful");

    //----------------------------------
    // Overflow Test
    //----------------------------------
    en = 1;

    repeat (12)
        @(posedge clk);

    #2;

    if (q !== 4'd0)
        $display("ERROR: Overflow failed");
    else
        $display("PASS: Overflow successful");

    //----------------------------------
    // Finish
    //----------------------------------
    $display("All Counter Tests Passed");

    $stop;

end

endmodule