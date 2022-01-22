`define MAX_PC 3'b111
module top;
    reg clk;
    reg [31:0] inst [0:7];
    reg [2:0] pc;
    reg done;
    wire [2:0] r;
    wire [2:0] i;
    wire [2:0] j;
    wire [2:0] three;
    wire [2:0] four;
    wire [2:0] five;
    wire [2:0] six;

    process uut(clk,inst[pc],r,i,j,three,four,five,six);
    initial begin
        clk = 0;
        forever begin
            #5
            clk = ~clk;
        end
    //     #100
    //     $finish;
    end
    always @(posedge done) begin
        $display("r=%d i=%d j=%d three=%d four=%d five=%d six=%d",r,i,j,three,four,five,six);
        #10
        $finish;
    end

    initial begin
        pc = 0;  // Points to the next instruction
        done=0;
        inst[0]={6'h08,5'd0,5'd4,16'h3456};
        inst[1]={6'h08,5'd0,5'd5,16'hffff};
        inst[2]={6'h00,5'd5,5'd4,5'd6,5'h00,6'h20};
        inst[3]={6'h08,5'd0,5'd3,16'h7};
        inst[4]={6'h00,5'd6,5'd3,5'd6,5'h00,6'h4};
        inst[5]={6'h00,5'd0,5'd3,5'd3,5'h1,6'h2};
        inst[6]={6'h23,5'd4,5'd5,16'h9abc};
        inst[7]={6'h2,26'h123456};
    end

    always @ (posedge clk) begin
        #2
        if(pc< `MAX_PC) pc=pc+1;
        else done=1;
    end
endmodule