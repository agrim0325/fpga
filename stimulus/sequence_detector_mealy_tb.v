`timescale 1ns/1ps

module sequence_detector_mealy_tb;

reg clk;
reg rst;
reg din;

wire detect;

integer detections;

sequence_detector_mealy sequence_detector_mealy_0 (
    .clk(clk),
    .rst(rst),
    .din(din),
    .detect(detect)
);

//-------------------------------------
// Clock Generation
//-------------------------------------
initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

//-------------------------------------
// Count detection pulses
//-------------------------------------
always @(posedge detect)
begin
    detections = detections + 1;
    $display("[%0t] Detection #%0d", $time, detections);
end

//-------------------------------------
// Test Sequence
//-------------------------------------
initial begin

    detections = 0;

    rst = 1;
    din = 0;

    #20;
    rst = 0;

    // Apply 1011011
    // Change input on negedge
    // Gives maximum setup margin

    @(negedge clk) din = 1;
    @(negedge clk) din = 0;
    @(negedge clk) din = 1;
    @(negedge clk) din = 1;
    @(negedge clk) din = 0;
    @(negedge clk) din = 1;
    @(negedge clk) din = 1;

    // Return idle
    @(negedge clk) din = 0;

    // Wait for FSM to settle
    repeat(5) @(posedge clk);

    if(detections == 2)
        $display("PASS: Two sequences detected");
    else
        $display("FAIL: Expected 2 detections, got %0d",
                 detections);

    $finish;

end

endmodule