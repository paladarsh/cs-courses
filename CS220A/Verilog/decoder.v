module top(x,w);
    input[2:0] x;
    output [7:0]w;
    reg [7:0]w;
    assign y=8'b0;
    always @(x) begin
        w=8'b0;
        w[x]=1'b1;
    end
endmodule
module start;
    reg[2:0] x;
    wire [7:0] z;
    top obj(x,z);
    always @(z) begin
        $display("%d %b %b\n", $time,x,z);
    end
    initial begin
        x=0;
        #1
        x=1;
        #1
        x=2;
        #1
        x=3;
        #1
        x=4;
        #1
        x=5;
        #1
        x=6;
        #1
        x=7;
    end
    initial begin
        #20
        $finish;
    end
endmodule