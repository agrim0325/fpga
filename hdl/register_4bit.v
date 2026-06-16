///////////////////////////////////////////////////////////////////////////////////////////////////
// Company: <Name>
//
// File: register_4bit.v
// File history:
//      <Revision number>: <Date>: <Comments>
//      <Revision number>: <Date>: <Comments>
//      <Revision number>: <Date>: <Comments>
//
// Description: 
//
// <Description here>
//
// Targeted device: <Family::SmartFusion2> <Die::M2S010> <Package::256 VF>
// Author: <Name>
//
/////////////////////////////////////////////////////////////////////////////////////////////////// 

//`timescale <time_units> / <precision>

module register_4bit( input clk,input rst, input en,input [3:0] d,output reg [3:0] q );
always@(posedge clk or posedge rst)
begin
    if(rst)
        q<=4'b0000;
    else if(en)
        q<=d;
        
end

endmodule

