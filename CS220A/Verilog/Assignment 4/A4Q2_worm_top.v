module worm_top;
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

    worm uutx(clk, x,stepsx,inp[0],newx,oflx);
    worm uuty(clk, y,stepsy,inp[0],newy,ofly);

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
        steps=2'd2;
        inp=2'd0;
        #10
        steps=2'd2;
        inp=2'd0;
        #10
        steps=2'dx;
        inp=2'dx;
        #10
        $finish;
    end
endmodule