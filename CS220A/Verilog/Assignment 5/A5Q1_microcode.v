module microcode(clk,cur,index);
    input clk;
    input [3:0] cur;
    output reg [3:0] index;

    reg [3:0] file[0:12];
    initial begin
        file[0]=4'd0;
        file[1]=4'd0;
        file[2]=4'd0;
        file[6]=4'd0;
        file[7]=4'd0;
        file[8]=4'd0;
        file[9]=4'd0;

        file[3]=4'd1;
        file[4]=4'd2;
        file[5]=4'd3;
        file[10]=4'd4;
        file[11]=4'd5;
        file[12]=4'd6;
    end

    always @(posedge clk) begin
        index=file[cur];
    end
endmodule