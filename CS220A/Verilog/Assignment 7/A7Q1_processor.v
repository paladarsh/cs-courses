`define MAX_PC 3'b111
module process(clk,inst32,r,i,j,three,four,five,six);
    input clk;
    input [31:0] inst32;
    output reg [2:0] r;
    output reg [2:0] i;
    output reg [2:0] j;
    output reg [2:0] three;
    output reg [2:0] four;
    output reg [2:0] five;
    output reg [2:0] six;
    initial begin
        r=3'b0;
        i=3'b0;
        j=3'b0;
        three=3'b0;
        four=3'b0;
        five=3'b0;
        six=3'b0;
    end

    always @(posedge clk) begin
        case(inst32[31:26])
            6'h00: begin
                r=r+1;
                case(inst32[15:11])
                    5'd3: three=three+1;
                    5'd4: four=four+1;
                    5'd5: five=five+1;
                    5'd6: six=six+1;
                endcase
            end
            6'h2,6'h3: begin
                j=j+1;
            end
            default: begin
                i=i+1;
                case(inst32[20:16])
                    5'd3: three=three+1;
                    5'd4: four=four+1;
                    5'd5: five=five+1;
                    5'd6: six=six+1;
                endcase
            end
        endcase
    end
endmodule