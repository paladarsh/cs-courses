module M(clk,z,prevw,neww);
    input clk,prevw;
    input [14:0]z;
    output neww;
    reg neww;
    always @(negedge clk) begin
        if(z==15'b0) begin
            if(prevw==1'bz) neww=0;
            else neww=~prevw;
        end
    end
endmodule
module start;
    reg prevw;
    wire neww;
    reg clk;
    reg [14:0] z;
    M obj(clk,z,prevw,neww);
    always @(neww) begin
        $display("%d %d %d\n", $time,z,prevw);
    end
    initial begin
        clk=1;
        prevw=0;
        z=15'b0;
        forever begin
            clk<=0;
            #5
            z<=((z+1==15'd25000)?0:z+1);
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