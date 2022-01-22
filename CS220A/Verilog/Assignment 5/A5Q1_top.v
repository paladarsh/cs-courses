module top;
    reg clk;
    reg [3:0] cur;
    reg [1:0] y;
    wire [3:0] next;
    fsm obj(clk,cur,y,next);
    initial begin
        clk=0;
        forever begin
            #5
            clk=~clk;
        end
    end
    initial begin
        #3
        cur=4'd12;
        y= 2'b00;
        #10
        cur=4'd00;
        y= 2'b00;
        #10
        cur=4'd11;
        y= 2'b01;
        #10
        cur=4'd10;
        y= 2'b00;
        #10
        cur=4'd5;
        y= 2'b00;
        #10
        cur=4'd1;
        y= 2'b00;
        #10
        cur=4'd4;
        y= 2'b00;
        #20
        $finish;
    end
endmodule