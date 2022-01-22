module blink(clk,in,prevw,neww);
    input clk,prevw;
    input [14:0] in;
    output neww;
    reg neww;
    always @(negedge clk) begin
        if(in==15'b0) begin
            if(prevw==1'bz) neww<=0;
            else neww<=~prevw;
        end
    end
endmodule