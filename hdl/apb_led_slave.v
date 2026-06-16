`timescale 1ns/1ps

module apb_led_slave(

    input wire PCLK,
    input wire PRESETN,

    input wire PSEL,
    input wire PENABLE,
    input wire PWRITE,

    input wire [7:0] PADDR,
    input wire [31:0] PWDATA,

    output reg [31:0] PRDATA,
    output wire PREADY,

    output reg [3:0] led

);

assign PREADY = 1'b1;

//
// Write Logic
//
always @(posedge PCLK or negedge PRESETN)
begin
    if(!PRESETN)
        led <= 4'b0000;

    else if(PSEL && PENABLE && PWRITE)
    begin
        case(PADDR)

            8'h00:
                led <= PWDATA[3:0];

            default:
                led <= led;

        endcase
    end
end

//
// Read Logic
//
always @(*)
begin
    PRDATA = 32'h00000000;

    if(PSEL && !PWRITE)
    begin
        case(PADDR)

            8'h00:
                PRDATA = {28'b0, led};

            default:
                PRDATA = 32'h00000000;

        endcase
    end
end

endmodule