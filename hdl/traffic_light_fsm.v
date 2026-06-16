module traffic_light_fsm(
    input clk,
    input rst,

    output reg [1:0] roadA,
    output reg [1:0] roadB
);

localparam S0 = 2'b00;
localparam S1 = 2'b01;
localparam S2 = 2'b10;
localparam S3 = 2'b11;

reg [1:0] state;
reg [2:0] count;

always @(posedge clk or posedge rst)
begin
    if(rst)
    begin
        state <= S0;
        count <= 0;
    end
    else
    begin
        case(state)

        S0:
        begin
            if(count == 4)
            begin
                state <= S1;
                count <= 0;
            end
            else
                count <= count + 1;
        end

        S1:
        begin
            if(count == 1)
            begin
                state <= S2;
                count <= 0;
            end
            else
                count <= count + 1;
        end

        S2:
        begin
            if(count == 4)
            begin
                state <= S3;
                count <= 0;
            end
            else
                count <= count + 1;
        end

        S3:
        begin
            if(count == 1)
            begin
                state <= S0;
                count <= 0;
            end
            else
                count <= count + 1;
        end

        endcase
    end
end

always @(*)
begin
    case(state)

    S0:
    begin
        roadA = 2'b10; // Green
        roadB = 2'b00; // Red
    end

    S1:
    begin
        roadA = 2'b01; // Yellow
        roadB = 2'b00; // Red
    end

    S2:
    begin
        roadA = 2'b00; // Red
        roadB = 2'b10; // Green
    end

    S3:
    begin
        roadA = 2'b00; // Red
        roadB = 2'b01; // Yellow
    end

    default:
    begin
        roadA = 2'b00;
        roadB = 2'b00;
    end

    endcase
end

endmodule