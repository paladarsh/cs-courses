// module top(x,w);
module top(w);
    // input x;
    reg x;
    output w;
    reg w;
    always @(x) begin
        w<= #2 ~x;
    end
    initial begin
        x=1'b0;
        forever begin
            #5
            x=~x;
        end
    end
    // initial begin
    //     #20
    //     $finish;
    // end
endmodule
module start;
    wire z;
    // reg x;
    top obj(z);
    // top obj(x,z);
    always @(z) begin
        $display("%d %b %b\n", $time,z,z);
        // $display("%d %b %b\n", $time,x,z);
    end
    // initial begin
    //     x=1'b0;
    //     forever begin
    //         #5
    //         x=~x;
    //     end
    // end
    initial begin
        #20
        $finish;
    end
endmodule