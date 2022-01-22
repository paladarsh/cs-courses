module eq(i,p);
    input[3:0]i;
    // output reg j;
    output [7:0]p;
    wire p,q;
    // wire[7:0] p;
    assign p={i,i[3:2],i[1:0]};
    assign q={i,i[3:2],i[1:0]};
endmodule
module try;
    reg z,x;
    wire a1;
    wire [7:0] b8,c8,d8;
    wire [3:0] i=4'b1001;
    wire [3:0] b4;
    reg [3:0] t,u;
    reg [4:0] v;
    assign b4=4'b1001;
    // assign b8={i,i[3:2],i[1:0]};
    // assign wire [3:0]a=a4;
    // eq axx(a4,b8);
    // eq s(a4,b8);
    initial begin
        // a=4'b1010;
        t=4'b1111;
        u=4'b0001;
        #5
        v=(0+t+u)>>1;
        x=a1;
        // assign 
        // #1
        // $display("%b %b %b %b",a1,a4,b8,c8,d8);
    end
    always @(v) begin
        // $display("%b %b",b8,a4);
        $display("%b %b\n",t,v);
    end
endmodule