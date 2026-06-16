`timescale 1ns/1ps

module traffic_light_fsm_tb;

reg clk;
reg rst;

wire [1:0] roadA;
wire [1:0] roadB;

integer errors;

traffic_light_fsm traffic_light_fsm_0 (
    .clk(clk),
    .rst(rst),
    .roadA(roadA),
    .roadB(roadB)
);

// Clock generation
initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin

    errors = 0;

    //-------------------
    // Reset
    //-------------------
    rst = 1;
    #20;
    rst = 0;

    //-------------------
    // Check S0
    //-------------------
    #1;
    if (roadA == 2'b10 && roadB == 2'b00)
        $display("PASS: S0 (A=Green, B=Red)");
    else begin
        errors = errors + 1;
        $display("ERROR: S0");
    end

    //-------------------
    // Wait for S1
    //-------------------
    wait(roadA == 2'b01 && roadB == 2'b00);

    #1;
    if (roadA == 2'b01 && roadB == 2'b00)
        $display("PASS: S1 (A=Yellow, B=Red)");
    else begin
        errors = errors + 1;
        $display("ERROR: S1");
    end

    //-------------------
    // Wait for S2
    //-------------------
    wait(roadA == 2'b00 && roadB == 2'b10);

    #1;
    if (roadA == 2'b00 && roadB == 2'b10)
        $display("PASS: S2 (A=Red, B=Green)");
    else begin
        errors = errors + 1;
        $display("ERROR: S2");
    end

    //-------------------
    // Wait for S3
    //-------------------
    wait(roadA == 2'b00 && roadB == 2'b01);

    #1;
    if (roadA == 2'b00 && roadB == 2'b01)
        $display("PASS: S3 (A=Red, B=Yellow)");
    else begin
        errors = errors + 1;
        $display("ERROR: S3");
    end

    //-------------------
    // Wait for return to S0
    //-------------------
    wait(roadA == 2'b10 && roadB == 2'b00);

    #1;
    if (roadA == 2'b10 && roadB == 2'b00)
        $display("PASS: Return to S0");
    else begin
        errors = errors + 1;
        $display("ERROR: Return to S0");
    end

    //-------------------
    // Final Result
    //-------------------
    if(errors == 0)
        $display("TRAFFIC LIGHT FSM TEST PASSED");
    else
        $display("TEST FAILED. Errors = %0d", errors);

    $stop;

end

endmodule