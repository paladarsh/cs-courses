module top;
    reg [2:0] in;
    wire [7:0] z;
    wire [2:0] out;
    decode ob(in,z);
    encode obj(z,out);
    always @(out) begin
        $display("%d %b %b %b",$time,in,z,out);
    end
    initial begin
        in=3'b000;
        #1
        in=3'b001;
        #1
        in=3'b010;
        #1
        in=3'b011;
        #1
        in=3'b100;
        #1
        in=3'b101;
        #1
        in=3'b110;
        #1
        in=3'b111;
    end
    initial begin
        #20
        $finish;
    end
endmodule 