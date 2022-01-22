module fsm(x,clk,out);
    input x,clk;
    output reg out;
    reg [2:0] st;
    initial begin
        st=3'b000;
        out=1'b1;
            out=1'b1;
    end
    always @(posedge clk) begin
        case({st[2:0],x})
            4'bxxx0, 4'b0000: st=3'b001;
            4'bxxx1,4'b0001: st=3'b011;
            4'b0010: st=3'b101;
            4'b0011: st=3'b010;
            4'b0100: st=3'b001;
            4'b0101: st=3'b101;
            4'b0110: st=3'b100;
            4'b0111: st=3'b101;
            4'b1000: st=3'b101;
            4'b1001: st=3'b011;
            4'b1010: st=3'b101;
            4'b1011: st=3'b101;
            default: st=3'b000;
        endcase
        out= ~(st[0] & ~st[1] & st[2]);
    end
endmodule
module top;
    reg clk,in;
    wire out;
    fsm obj(in,clk,out);
    initial begin
        clk=0;
        forever begin
            #5
            clk=~clk;
        end
    end
    initial begin
        in=1;
        #3
        in=0;
        #10
        in=1;
        #10
        in=0;
        #10
        in=1;
        #10
        in=0;
        #10
        in=1;
        #10
        in=0;
        #10
        in=1;
        #10
        in=0;
        #20
        $finish;
    end
    always @(posedge clk) begin
        #0
        $display("time:%d clk:%b in:%b out:%b" ,$time,clk,in,out);
    end
endmodule