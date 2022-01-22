module ex(a,out);
    input a;
    output wire out;
    not unit(out,a);
    initial begin
        // xs=1;
    end
endmodule

module top;
    reg a,b;
    wire out=1'b1;
    ex unit(a,out);
    initial begin
        a=1'b0;
        // out=1'b1;
        #1
        b=out;
        #1
        a=~a;
        #1
        b=out;
        $display("%b %b",a,b);
    end
endmodule
