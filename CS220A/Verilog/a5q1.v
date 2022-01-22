// module dispatch(clk,cur,inp,y,newst);
//     input clk;
//     input [3:0] cur;
//     input [3:0] inp;
//     input [1:0] y;
//     output reg [3:0] newst;

//     reg [3:0] incrementer;
//     always @(posedge clk) begin
//         #1
//         incrementer=cur+1;
//         // incrementer=0;
//         if(inp==4'd0) begin
//             // newst=incrementer;
//             newst=cur+1;
//         end
//         else if(inp==4'd1) begin
//             case(y)
//                 2'b00: newst=4'd4;
//                 2'b01: newst=4'd5;
//                 2'b1x: newst=4'd6;
//             endcase
//         end
//         else if(inp==4'd2) newst=4'd7;
//         else if(inp==4'd3) newst=4'd7;
//         else if(inp==4'd4) begin
//             case(y)
//                 2'b00: newst=4'd11;
//                 2'b01,2'b1x: newst=4'd12;
//             endcase
//             // $display("Good\n");
//         end
//         else if(inp==4'd5) newst=4'd0;
//         else newst=4'd0;
//     end
// endmodule
module dispatch(clk,cur,inp,y,newst);
    input clk;
    input [3:0] cur;
    input [3:0] inp;
    input [1:0] y;
    output reg [3:0] newst;
    reg [0:3] val;

    reg [3:0] file1 [0:3];
    reg [3:0] file4[0:3];
    initial begin
        // file[1]={4'd4,4'd5,4'd6,4'd6};
        file1[0]=4'd4;
        file1[1]=4'd5;
        file1[2]=4'd6;
        file1[3]=4'd6;
        // file[2]=4{4'd7};
        // file[3]=4{4'd7};
        // file[4]={4'd11,4'd12,4'd12,4'd12};
        // file4={4'd11,4'd12,4'd12,4'd12};
        file4[0]=4'd11;
        file4[1]=4'd12;
        file4[2]=4'd12;
        file4[3]=4'd12;

        // file[5]=4{4'd0};
        // file[6]=4{4'd0};
    end
    always @(posedge clk) begin
        if(inp==4'd0) begin
            #1
            newst=cur+1;
        end
        else if(inp==4'd1) newst=file1[y];
        else if(inp==4'd2 || inp==4'd3) newst=4'd7;
        else if(inp==4'd4) newst=file4[y];
        else if(inp==4'd5 || inp==4'd6) newst=4'd0;
    end
endmodule

module microcode(clk,cur,val);
    input clk;
    input [3:0] cur;
    output reg [3:0] val;

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
        #1
        val=file[cur];
    end
endmodule

module fsm(clk,cur,y,next);
    input clk;
    input [3:0] cur;
    input [1:0] y;
    
    output wire [3:0] next;

    reg [3:0] disp;
    wire [3:0] micro;

    microcode obj(clk,cur,micro);
    dispatch ob(clk,cur,disp,y,next);
    always @(posedge clk) begin
        // disp<=#1 micro;
        #2
        disp<=micro;
    end
//    always @ (micro or cur or disp or y or next) begin
    always @(posedge clk) begin
       #3
      $display("Time = %d,  cur = %d, y= %b, micro= %d, disp=%d, new = %d", $time, cur, y, micro,disp,next);
   end
endmodule

module top;
    reg clk;
    reg [3:0] cur;
    reg [1:0] y;
    wire [3:0] new;
    fsm obj(clk,cur,y,new);
    initial begin
        clk=0;
        forever begin
            #5
            clk=~clk;
        end
    end
    initial begin
        #3
        cur=4'd10;
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
        #10
        $finish;
    end
endmodule