`timescale 1ns/1ps

module sequence_detector_mealy(
    input clk,
    input rst,
    input din,
    output reg detect
);

    localparam S0 = 2'b00; // No match
    localparam S1 = 2'b01; // Seen 1
    localparam S2 = 2'b10; // Seen 10
    localparam S3 = 2'b11; // Seen 101

    reg [1:0] state, next_state;

    //------------------------------------
    // State Register
    //------------------------------------
    always @(posedge clk or posedge rst)
    begin
        if(rst)
            state <= S0;
        else
            state <= next_state;
    end

    //------------------------------------
    // Next State Logic
    //------------------------------------
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
                    next_state = S1; // overlap support
                else
                    next_state = S2;

            default:
                next_state = S0;

        endcase
    end

    //------------------------------------
    // Mealy Output Logic
    //------------------------------------
    always @(*)
    begin
        if(state == S3 && din == 1'b1)
            detect = 1'b1;
        else
            detect = 1'b0;
    end

endmodule