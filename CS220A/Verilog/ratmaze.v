module one_bit_full_adder(a,b,cin,opcode,sum,cout);
    input a,b,cin,opcode;
    output sum,cout;
    wire x;
    wire sum,cout;
    assign x=b^opcode;
    assign sum = a ^ x ^ cin;
    assign cout = ((a&x)|(x&cin)|(cin&a));
endmodule

module five_bit_full_adder(a,b,opcode,sum,ofl);

    input [4:0] a;
    input [4:0] b;
    input opcode;

    output [4:0] sum;
    output ofl;

    wire [4:0] sum;
    wire ofl;

    wire cout;
    wire [3:0] c_mid;

    one_bit_full_adder FA0(a[0],b[0],opcode,opcode,sum[0],c_mid[0]);
    one_bit_full_adder FA1(a[1], b[1], c_mid[0], opcode, sum[1], c_mid[1]);
    one_bit_full_adder FA2(a[2], b[2], c_mid[1], opcode, sum[2], c_mid[2]);
    one_bit_full_adder FA3(a[3], b[3], c_mid[2], opcode, sum[3], c_mid[3]);
    one_bit_full_adder FA4(a[4], b[4], c_mid[3], opcode, sum[4], cout);
    assign ofl=sum[4];
endmodule

module ratmaze(clk,cur,steps,opcode,newvalue,ofl);
    input clk;
    input [4:0] cur;
    input [1:0] steps;
    input opcode;

    output reg [4:0] newvalue;
    output wire ofl;
    wire [4:0] new;

    five_bit_full_adder uut(cur,{1'b0,1'b0,1'b0,steps[1:0]},opcode,new,ofl);

    always @(posedge clk) begin
        #1
        case(ofl)
            1'b1: newvalue<=(opcode==1'b1)?5'b0:5'd15;
            1'b0: newvalue<=new;
        endcase
    end
endmodule

module rat_top;
    reg [4:0] x;
    reg [4:0] y;

    wire [4:0] newx;
    wire [4:0] newy;

    reg [1:0] steps;
    reg [1:0] stepsx;
    reg [1:0] stepsy;
    reg [1:0] inp;
    reg opcode;

    wire oflx;
    wire ofly;
    reg ofl;
    reg clk;

    ratmaze uutx(clk, x,stepsx,inp[0],newx,oflx);
    ratmaze uuty(clk, y,stepsy,inp[0],newy,ofly);

    always@(posedge clk) begin
        if(inp[1]==1'b0) begin
            stepsx<= steps;
            stepsy<= 2'b00;
            #2
            x<= newx;
            ofl<= oflx;
        end
        else begin
            stepsy<= steps;
            stepsx<= 2'b00;
            #2
            y<= newy;
            ofl<= ofly;
        end
    end
    always @(posedge clk) begin
        $display("Time: %d, x: %d, y: %d, Overflow: %d, Direction: %d, Steps: %d",$time,x, y, ofl, inp,steps);
    end
    initial begin
        clk=0;
        forever begin
           #5
           clk=~clk; 
        end
    end
    initial begin
        x=5'b0;
        y=5'b0;
        #3
        steps=2'd3;
        inp=2'd0;
        #10
        steps=2'd3;
        inp=2'd2;
        #10
        steps=2'd2;
        inp=2'd1;
        #10
        steps=2'd2;
        inp=2'd1;
        #10
        steps=2'd0;
        inp=2'd2;
        #10
        steps=2'd3;
        inp=2'd0;
        #10
        steps=2'd3;
        inp=2'd0;
        #10
        steps=2'd3;
        inp=2'd0;
        #10
        steps=2'd3;
        inp=2'd0;
        #10
        steps=2'd3;
        inp=2'd0;
        #10
        steps=2'd3;
        inp=2'd0;
        #10
        steps=2'dx;
        inp=2'dx;
        #10
        $finish;
    end
endmodule