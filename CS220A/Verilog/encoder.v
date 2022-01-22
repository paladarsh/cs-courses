module top(x,w);
    input[0:7] x;
    output [0:2]w;
    reg [0:2]w;
    always @(x) begin
        w[0]=|(x[4:7]);
        w[1]=x[2]|x[3]|x[6]|x[7];
        w[2]=x[1]|x[3]|x[5]|x[7];
    end
endmodule
module start;
    reg[0:7] x;
    wire [0:2] z;
    top obj(x,z);
    always @(z) begin
        $display("%d %b %b\n", $time,x,z);
    end
    initial begin
        x=8'b10000000;
        #1
        x=8'b01000000;
        #1
        x=8'b00100000;
        #1
        x=8'b00010000;
        #1
        x=8'b00001000;
        #1
        x=8'b00000100;
        #1
        x=8'b00000010;
        #1
        x=8'b00000001;
    end
    initial begin
        #20
        $finish;
    end
endmodule