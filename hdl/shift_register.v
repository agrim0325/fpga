module shift_register(
    input clk,
    input rst,
    input en,

    input [1:0] sel,

    input serial_in,
    input [3:0] parallel_in,

    output reg [3:0] q
);

always @(posedge clk or posedge rst)
begin
    if(rst)
        q <= 4'b0000;

    else if(en)
    begin
        case(sel)

            2'b00: q <= q;                      // Hold

            2'b01: q <= {q[2:0], serial_in};    // Shift Left

            2'b10: q <= {serial_in, q[3:1]};    // Shift Right

            2'b11: q <= parallel_in;            // Parallel Load

        endcase
    end
end

endmodule