`timescale 1ns/1ps

module tb_apb_led_slave;

    reg         PCLK;
    reg         PRESETN;
    reg         PSEL;
    reg         PENABLE;
    reg         PWRITE;
    reg  [7:0]  PADDR;
    reg  [31:0] PWDATA;
    wire [31:0] PRDATA;
    wire        PREADY;
    wire [3:0]  led;

    integer errors = 0;

    // DUT
    apb_led_slave apb_led_slave_0 (
        .PCLK    (PCLK),
        .PRESETN (PRESETN),
        .PSEL    (PSEL),
        .PENABLE (PENABLE),
        .PWRITE  (PWRITE),
        .PADDR   (PADDR),
        .PWDATA  (PWDATA),
        .PRDATA  (PRDATA),
        .PREADY  (PREADY),
        .led     (led)
    );

    // 100 MHz clock, matches FCCC_C0 GL0 output
    always #5 PCLK = ~PCLK;

    // APB write task: 2-phase SETUP + ACCESS
    task apb_write(input [7:0] addr, input [31:0] data);
        begin
            @(posedge PCLK);
            PSEL    = 1'b1;
            PENABLE = 1'b0;
            PWRITE  = 1'b1;
            PADDR   = addr;
            PWDATA  = data;

            @(posedge PCLK);
            PENABLE = 1'b1;

            @(posedge PCLK);
            PSEL    = 1'b0;
            PENABLE = 1'b0;
            PWRITE  = 1'b0;
        end
    endtask

    // APB read task: 2-phase SETUP + ACCESS, captures PRDATA
    task apb_read(input [7:0] addr, output [31:0] data);
        begin
            @(posedge PCLK);
            PSEL    = 1'b1;
            PENABLE = 1'b0;
            PWRITE  = 1'b0;
            PADDR   = addr;

            @(posedge PCLK);
            PENABLE = 1'b1;
            #3; // settling margin for post-layout combinational delay
            data = PRDATA;

            @(posedge PCLK);
            PSEL    = 1'b0;
            PENABLE = 1'b0;
        end
    endtask

    reg [31:0] readback;

    initial begin
        PCLK    = 1'b0;
        PRESETN = 1'b0;
        PSEL    = 1'b0;
        PENABLE = 1'b0;
        PWRITE  = 1'b0;
        PADDR   = 8'h00;
        PWDATA  = 32'h00000000;

        // Reset sequence
        repeat (5) @(posedge PCLK);
        PRESETN = 1'b1;
        @(posedge PCLK);

        // Check PREADY always 1
        if (PREADY !== 1'b1) begin
            $display("FAIL: PREADY not asserted after reset");
            errors = errors + 1;
        end

        // Check led is 0 after reset
        if (led !== 4'b0000) begin
            $display("FAIL: led not cleared after reset, got %b", led);
            errors = errors + 1;
        end

        // Test 1: Write 4'b1010 to led register at addr 0x00
        apb_write(8'h00, 32'h0000000A);
        @(posedge PCLK);
        #2; // settling margin for post-layout propagation delay
        if (led !== 4'b1010) begin
            $display("FAIL: led mismatch after write 0xA, got %b expected 1010", led);
            errors = errors + 1;
        end else begin
            $display("PASS: led = %b after writing 0xA", led);
        end

        // Test 2: Read back register at addr 0x00, expect {28'b0, led} = 0x0000000A
        apb_read(8'h00, readback);
        if (readback !== 32'h0000000A) begin
            $display("FAIL: readback mismatch, got %h expected 0000000A", readback);
            errors = errors + 1;
        end else begin
            $display("PASS: readback = %h", readback);
        end

        // Test 3: Write all LEDs on (0xF)
        apb_write(8'h00, 32'h0000000F);
        @(posedge PCLK);
        #2;
        if (led !== 4'b1111) begin
            $display("FAIL: led mismatch after write 0xF, got %b expected 1111", led);
            errors = errors + 1;
        end else begin
            $display("PASS: led = %b after writing 0xF", led);
        end

        // Test 4: Write to an unmapped address (0x04) -- should not change led (default case)
        apb_write(8'h04, 32'h00000000);
        @(posedge PCLK);
        #2;
        if (led !== 4'b1111) begin
            $display("FAIL: led changed on unmapped address write, got %b", led);
            errors = errors + 1;
        end else begin
            $display("PASS: led unchanged on unmapped address write");
        end

        // Test 5: Read from unmapped address -- should return 0
        apb_read(8'h04, readback);
        if (readback !== 32'h00000000) begin
            $display("FAIL: unmapped address read returned %h, expected 0", readback);
            errors = errors + 1;
        end else begin
            $display("PASS: unmapped address read returned 0");
        end

        // Test 6: PSEL without PENABLE should already show valid PRDATA (combinational read)
        @(posedge PCLK);
        PSEL    = 1'b1;
        PENABLE = 1'b0;
        PWRITE  = 1'b0;
        PADDR   = 8'h00;
        #3;
        if (PRDATA !== 32'h0000000F) begin
            $display("FAIL: combinational read during SETUP phase wrong, got %h", PRDATA);
            errors = errors + 1;
        end else begin
            $display("PASS: combinational read valid during SETUP phase");
        end
        PSEL = 1'b0;
        @(posedge PCLK);

        // Test 7: Reset clears led again
        PRESETN = 1'b0;
        repeat (3) @(posedge PCLK);
        PRESETN = 1'b1;
        @(posedge PCLK);
        if (led !== 4'b0000) begin
            $display("FAIL: led not cleared on second reset, got %b", led);
            errors = errors + 1;
        end else begin
            $display("PASS: led cleared on second reset");
        end

        repeat (5) @(posedge PCLK);

        if (errors == 0)
            $display("TESTBENCH PASSED: all checks succeeded");
        else
            $display("TESTBENCH FAILED: %0d error(s)", errors);

        $finish;
    end

endmodule