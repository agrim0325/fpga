`timescale 1ns/1ps

module sequence_detector_moore(
    input clk,
    input rst,
    input din,
    output reg detect
);

    localparam S0 = 3'b000; // No match
    localparam S1 = 3'b001; // Seen 1
    localparam S2 = 3'b010; // Seen 10
    localparam S3 = 3'b011; // Seen 101
    localparam S4 = 3'b100; // Seen 1011

    reg [2:0] state, next_state;

    // State register
    always @(posedge clk or posedge rst)
    begin
        if(rst)
            state <= S0;
        else
            state <= next_state;
    end

    // Next-state logic
    always @(*)
    begin
        case(state)

            S0:
                if(din)
                    next_state = S1;
                else
                    next_state = S0;

            S1:
                if(din)
                    next_state = S1;
                else
                    next_state = S2;

            S2:
                if(din)
                    next_state = S3;
                else
                    next_state = S0;

            S3:
                if(din)
                    next_state = S4;
                else
                    next_state = S2;

            // Overlapping detection
            S4:
                if(din)
                    next_state = S1;
                else
                    next_state = S2;

            default:
                next_state = S0;

        endcase
    end

    // Moore output logic
    always @(*)
    begin
        if(state == S4)
            detect = 1'b1;
        else
            detect = 1'b0;
    end

endmodule