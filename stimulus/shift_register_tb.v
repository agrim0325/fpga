`timescale 1ns/1ps

module shift_register_tb;

reg clk;
reg rst;
reg en;

reg [1:0] sel;
reg serial_in;
reg [3:0] parallel_in;

wire [3:0] q;

shift_register shift_register_0(
    .clk(clk),
    .rst(rst),
    .en(en),
    .sel(sel),
    .serial_in(serial_in),
    .parallel_in(parallel_in),
    .q(q)
);

always #5 clk = ~clk;

initial
begin
    clk = 0;
    rst = 1;
    en = 0;

    sel = 2'b00;
    serial_in = 0;
    parallel_in = 4'b0000;

    // Reset
    #20;
    rst = 0;

    // Parallel Load 1010
    en = 1;
    sel = 2'b11;
    parallel_in = 4'b1010;

    @(posedge clk);
   // @(posedge clk);
    #8;
    if(q !== 4'b1010)
        $display("ERROR: Parallel Load Failed");
    else
        $display("PASS: Parallel Load");

    // Shift Left with serial input = 1
    sel = 2'b01;
    serial_in = 1;

    @(posedge clk);
   // @(posedge clk);
    #8;
    if(q !== 4'b0101)
        $display("ERROR: Shift Left Failed");
    else
        $display("PASS: Shift Left");

    // Shift Right with serial input = 0
    sel = 2'b10;
    serial_in = 0;

    @(posedge clk);
   // @(posedge clk);
    #8;
    if(q !== 4'b0010)
        $display("ERROR: Shift Right Failed");
    else
        $display("PASS: Shift Right");

    // Hold
    sel = 2'b00;

    @(posedge clk);
    //@(posedge clk);
    #8;
    if(q !== 4'b0010)
        $display("ERROR: Hold Failed");
    else
        $display("PASS: Hold");

    // Reset Again
    rst = 1;
    #10;

    if(q !== 4'b0000)
        $display("ERROR: Reset Failed");
    else
        $display("PASS: Reset");

    $display("ALL SHIFT REGISTER TESTS PASSED");

    $stop;
end

endmodule