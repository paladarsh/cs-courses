module swap(a,b,c,d);
    input a,b;
    output c,d;
    wire c,d;
    assign c=b;
    assign d=a;
endmodule
module sw;
    wire a=1'b0;
    wire b=1'b1;
    wire c,d;
    // swap ut(a,b,a,b);
    swap ut(a,b,c,d);
    initial begin
        #1
        $display("%b %b",c,d);
        #1
        $display("%b %b",a,b);
        #1
        $finish;
    end
endmodule