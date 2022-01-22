module top(x,w);
    input[9:0] x;
    output [9:0]w;
    reg [9:0]w;
    always @(x) begin
        w<=x;
    end
endmodule
module start;
    wire[9:0] z;
    reg[9:0] x;
    top obj(x,z);
    always @(z) begin
        $display("%d %d %d\n", $time,x,z);
    end
    initial begin
        // x=1'b0;
        x=1;
        forever begin
            #1
            x=x+1;
        end
    end
    initial begin
        #20
        $finish;
    end
endmodule