module top;
    reg prevw;
    wire neww;
    reg clk;
    reg [14:0] in;
    blink obj(clk,in,prevw,neww);
    always @(neww) begin
        $display("%d %b\n", $time,prevw);
    end
    initial begin
        clk=1;
        prevw=0;
        in=15'b0;
        forever begin
            clk<=0;
            #5
            in<=((in+1==15'd25000)?0:in+1);
            clk<=1;
            prevw<=neww;
            #5
            clk<=0;
        end
    end
    initial begin
        #3100000
        $finish;
    end
endmodule