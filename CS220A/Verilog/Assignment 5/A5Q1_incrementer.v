module incrementer(clk,cur,next);
    input [3:0] cur;
    input clk;
    output reg [3:0] next;

    always @(posedge clk) begin
        next=cur+1;
    end
endmodule