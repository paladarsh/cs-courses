module incrementer(clk,cur,next);
    input [3:0] cur;
    input clk;
    output reg [3:0] next;

    always @(posedge clk) begin
        next=cur+1;
    end
endmodule

module dispatch(clk,cur,inp,y,next);
    input clk;
    input [3:0] cur;
    input [3:0] inp;
    input [1:0] y;
    output reg [3:0] next;
    wire [0:3] inc;

    reg [3:0] file1 [0:3];
    reg [3:0] file4[0:3];

    initial begin
        file1[0]=4'd4;
        file1[1]=4'd5;
        file1[2]=4'd6;
        file1[3]=4'd6;
        file4[0]=4'd11;
        file4[1]=4'd12;
        file4[2]=4'd12;
        file4[3]=4'd12;
    end
    incrementer uut(clk,cur,inc);
    always @(posedge clk) begin
        #1
        if(inp==4'd0) begin
            next=inc;
        end
        else if(inp==4'd1) next=file1[y];
        else if(inp==4'd2 || inp==4'd3) next=4'd7;
        else if(inp==4'd4) next=file4[y];
        else if(inp==4'd5 || inp==4'd6) next=4'd0;
    end
endmodule

module microcode(clk,cur,index);
    input clk;
    input [3:0] cur;
    output reg [3:0] index;

    reg [3:0] file[0:12];
    initial begin
        file[0]=4'd0;
        file[1]=4'd0;
        file[2]=4'd0;
        file[6]=4'd0;
        file[7]=4'd0;
        file[8]=4'd0;
        file[9]=4'd0;

        file[3]=4'd1;
        file[4]=4'd2;
        file[5]=4'd3;
        file[10]=4'd4;
        file[11]=4'd5;
        file[12]=4'd6;
    end

    always @(posedge clk) begin
        index=file[cur];
    end
endmodule

module fsm(clk,cur,y,next);
    input clk;
    input [3:0] cur;
    input [1:0] y;
    
    output wire [3:0] next;

    reg [3:0] inc;
    wire [3:0] micro;

    microcode obj(clk,cur,micro);
    dispatch ob(clk,cur,micro,y,next);

    always @(posedge clk) begin
    //   $display("Time = %d,  cur = %d, y= %b, micro= %d, new = %d", $time, cur, y, micro,next);
      $display("Time = %d,  current = %d, y= %b, next = %d", $time, cur, y, next);
   end
endmodule

module top;
    reg clk;
    reg [3:0] cur;
    reg [1:0] y;
    wire [3:0] next;
    fsm obj(clk,cur,y,next);
    initial begin
        clk=0;
        forever begin
            #5
            clk=~clk;
        end
    end
    initial begin
        #3
        cur=4'd12;
        y= 2'b00;
        #10
        cur=4'd00;
        y= 2'b00;
        #10
        cur=4'd11;
        y= 2'b01;
        #10
        cur=4'd10;
        y= 2'b00;
        #10
        cur=4'd5;
        y= 2'b00;
        #10
        cur=4'd1;
        y= 2'b00;
        #10
        cur=4'd4;
        y= 2'b00;
        #20
        $finish;
    end
endmodule