module rotate(clk,in,prevw,neww);
    input clk;
    input [3:0] prevw;
    input [14:0] in;
    output [3:0] neww;
    reg [3:0] neww;
    always @(negedge clk) begin
        if(in==0) begin
            case(prevw)
                4'b0001: neww=4'b0010;
                4'b0010: neww=4'b0100;
                4'b0100: neww=4'b1000;
                4'b1000: neww=4'b0001;
            endcase
        end
    end
endmodule