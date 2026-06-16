`timescale 1ns/1ps

module sequence_detector_moore_tb;

reg clk;
reg rst;
reg din;

wire detect;

integer detections;

sequence_detector_moore sequence_detector_moore_0 (
    .clk(clk),
    .rst(rst),
    .din(din),
    .detect(detect)
);

// Clock generation
initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

// Count detection pulses
always @(posedge detect)
begin
    detections = detections + 1;
    $display("Detection #%0d at time %0t", detections, $time);
end

initial begin

    detections = 0;

    //--------------------------
    // Reset
    //--------------------------
    rst = 1;
    din = 0;

    #20;
    rst = 0;

    //--------------------------
    // Apply sequence 1011011
    //--------------------------

    @(negedge clk) din = 1;
    @(negedge clk) din = 0;
    @(negedge clk) din = 1;
    @(negedge clk) din = 1;

    @(negedge clk) din = 0;
    @(negedge clk) din = 1;
    @(negedge clk) din = 1;

    //--------------------------
    // Wait for FSM to settle
    //--------------------------

    repeat(5) @(posedge clk);

    //--------------------------
    // Check result
    //--------------------------

    if(detections == 2)
        $display("PASS: Two sequences detected");
    else
        $display("ERROR: Expected 2 detections, Got %0d", detections);

    $stop;

end

endmodule