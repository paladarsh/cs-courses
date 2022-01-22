module top;
    reg[7:0] in;
    wire [2:0] out;
    priority obj(in,out);
    always @(out) begin
        $display("%d %b %b\n", $time,in,out);
    end
    initial begin
        in=8'b10000000;
        #1
        in=8'b11000000;
        #1
        in=8'b10100000;
        #1
        in=8'b10011001;
        #1
        in=8'b11110000;
        #1
        in=8'b10111000;
        #1
        in=8'b00000010;
        #1
        in=8'b00100100;
        #1
        in=8'b11110101;
        #1
        in=8'b00110110;
        #1
        $finish;
    end
endmodule