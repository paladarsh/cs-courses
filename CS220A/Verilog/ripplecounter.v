module tff(t,r,q);
    input t,r;
    output q;
    reg q;
    always @(posedge r or negedge t) begin
        if(r==1) q<=0;
        else q<= #2 ~q;
    end
endmodule

module ripple;
    reg clk,rst;
    initial begin
        forever begin
            clk=1;
            #5
            clk=0;
            #5
            clk=1;
        end
    end
    initial begin
        rst=1;
        #1
        rst=0;
        #160
        $finish;
    end
    wire [3:0]q;
    // reg [0:3]ans;
    // reg [0:4] w;
    tff t0(clk,rst,q[0]);
    tff t1(q[0],rst,q[1]);
    tff t2(q[1],rst,q[2]);
    tff t3(q[2],rst,q[3]);

    always @(negedge clk) begin
        // $display("%d: %d %d %d%d%d%d",$time,clk, rst, q[3], q[2], q[1], q[0]);
        $display("%d: %d %d",$time,clk, rst, q);
    end
endmodule