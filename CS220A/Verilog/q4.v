module M(clk,z,prevw,neww);
    input clk;
    input [3:0] prevw;
    input [14:0]z;
    output [3:0] neww;
    reg [3:0] neww;
    always @(negedge clk) begin
        if(z==0) begin
            case(prevw)
                4'b0001: neww=4'b0010;
                4'b0010: neww=4'b0100;
                4'b0100: neww=4'b1000;
                4'b1000: neww=4'b0001;
            endcase
        end
    end
endmodule
module start;
    reg [3:0] prevw;
    wire [3:0] neww;
    reg clk;
    reg [14:0] z;
    M obj(clk,z,prevw,neww);
    always @(neww) begin
        $display("%d %d %b\n", $time,z,prevw);
    end
    initial begin
        clk=1;
        prevw=4'b0001;
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