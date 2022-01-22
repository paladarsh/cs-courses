module top(x,w);
    input[7:0] x;
    output [2:0]w;
    reg [2:0]w;
    always @(x) begin
        if(x[0]==1'b1) w=3'b000;
        else if(x[1]==1'b1) w=3'b001;
        else if(x[2]==1'b1) w=3'b010;
        else if(x[3]==1'b1) w=3'b011;
        else if(x[4]==1'b1) w=3'b100;
        else if(x[5]==1'b1) w=3'b101;
        else if(x[6]==1'b1) w=3'b110;
        else if(x[7]==1'b1) w=3'b111;
    end
endmodule
module start;
    reg[7:0] x;
    wire [2:0] z;
    top obj(x,z);
    always @(z) begin
        $display("%d %b %b\n", $time,x,z);
    end
    initial begin
        x=8'b10000000;
        #1
        x=8'b01000000;
        #1
        x=8'b00100000;
        #1
        x=8'b00010001;
        #1
        x=8'b00001000;
        #1
        x=8'b00000100;
        #1
        x=8'b00000010;
        #1
        x=8'b00100001;
    end
    initial begin
        #20
        $finish;
    end
endmodule