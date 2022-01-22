module dispatch(clk,cur,inp,y,next);
    input clk;
    input [3:0] cur;
    input [3:0] inp;
    input [1:0] y;
    output reg [3:0] next;
    wire [0:3] inc;

    reg [3:0] file1 [0:3];
    reg [3:0] file4[0:3];

    initial begin
        file1[0]=4'd4;
        file1[1]=4'd5;
        file1[2]=4'd6;
        file1[3]=4'd6;
        file4[0]=4'd11;
        file4[1]=4'd12;
        file4[2]=4'd12;
        file4[3]=4'd12;
    end
    incrementer uut(clk,cur,inc);
    always @(posedge clk) begin
        #1
        if(inp==4'd0) begin
            next=inc;
        end
        else if(inp==4'd1) next=file1[y];
        else if(inp==4'd2 || inp==4'd3) next=4'd7;
        else if(inp==4'd4) next=file4[y];
        else if(inp==4'd5 || inp==4'd6) next=4'd0;
    end
endmodule