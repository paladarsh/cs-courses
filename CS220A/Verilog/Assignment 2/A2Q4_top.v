module top;
    reg [3:0] prevw;
    wire [3:0] neww;
    reg clk;
    reg [14:0] in;
    rotate obj(clk,in,prevw,neww);
    always @(neww) begin
        $display("%d %b\n", $time,prevw);
    end
    initial begin
        clk=1;
        prevw=4'b0001;
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