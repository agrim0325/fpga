`timescale 1ns/1ps
`
module vending_machine_fsm_tb;

reg clk;
reg rst;
reg coin5;
reg coin10;

wire dispense;
wire change;

integer errors;

// DUT
vending_machine_fsm vending_machine_fsm_0 (
    .clk(clk),
    .rst(rst),
    .coin5(coin5),
    .coin10(coin10),
    .dispense(dispense),
    .change(change)
);

// Clock generation
initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin

    errors = 0;

    //-------------------------
    // Reset
    //-------------------------
    rst    = 1;
    coin5  = 0;
    coin10 = 0;

    #20;
    rst = 0;

    //-------------------------
    // CASE 1 : 5 + 5 + 5
    //-------------------------

    @(negedge clk) coin5 = 1;
    @(negedge clk) coin5 = 0;

    @(negedge clk) coin5 = 1;
    @(negedge clk) coin5 = 0;

    @(negedge clk) coin5 = 1;
    @(negedge clk) coin5 = 0;

    wait(dispense == 1);

    if(dispense)
        $display("PASS: 5+5+5 Dispense");
    else begin
        errors = errors + 1;
        $display("ERROR: 5+5+5");
    end

    @(posedge clk);

    //-------------------------
    // Reset
    //-------------------------
    rst = 1;
    #20;
    rst = 0;

    //-------------------------
    // CASE 2 : 10 + 5
    //-------------------------

    @(negedge clk) coin10 = 1;
    @(negedge clk) coin10 = 0;

    @(negedge clk) coin5 = 1;
    @(negedge clk) coin5 = 0;

    wait(dispense == 1);

    if(dispense)
        $display("PASS: 10+5 Dispense");
    else begin
        errors = errors + 1;
        $display("ERROR: 10+5");
    end

    @(posedge clk);

    //-------------------------
    // Reset
    //-------------------------
    rst = 1;
    #20;
    rst = 0;

    //-------------------------
    // CASE 3 : 10 + 10
    //-------------------------

    @(negedge clk) coin10 = 1;
    @(negedge clk) coin10 = 0;

    @(negedge clk) coin10 = 1;
    @(negedge clk) coin10 = 0;

    wait(dispense == 1);

    if(dispense)
        $display("PASS: 10+10 Dispense");
    else begin
        errors = errors + 1;
        $display("ERROR: 10+10 Dispense");
    end

    if(change)
        $display("PASS: Change Returned");
    else begin
        errors = errors + 1;
        $display("ERROR: Change Not Returned");
    end

    //-------------------------
    // Final Result
    //-------------------------

    if(errors == 0)
        $display("VENDING MACHINE TEST PASSED");
    else
        $display("TEST FAILED : %0d errors", errors);

    $finish;

end

endmodule