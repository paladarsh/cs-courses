module booth(clk,bit, cand, plier, prod,done,add,sub);
    input clk;
    input bit;
    input [31:0] cand;
    input [31:0] plier;
    reg [5:0] i;
    output reg done;
    output reg [4:0] add;
    output reg [4:0] sub;
    output reg [31:0] prod;
    
    initial begin
        i=0;
        prod=0;
        done=1;
        add=0;
        sub=0;
    end

    always @(posedge clk) begin
        // $display("%d %d",$time,i);
        if(bit==1) done=0;
        if(i==32) begin
            done=1;
            i=0;
            #1
            prod=0;
            add=0;
            sub=0;
        end
        else if(i==0) begin
            if(plier[0]==1) begin
                prod=prod-cand;
                sub=sub+1;
                // $display("%d Sub: %d %d %d %d",$time,i,plier,add,sub);
            end
        end
        else if(plier[i]==1 && plier[i-1]==0) begin
            prod=prod-(cand<<i);
            sub=sub+1;
            // $display("%d Sub: %d %d %d %d",$time,i,plier,add,sub);
        end
        else if(plier[i]==0 && plier[i-1]==1) begin
            prod=prod+(cand<<i);
            add=add+1;
            // $display("%d Add: %d %d %d %d",$time,i,plier,add,sub);
        end
        if(((plier>>i)==0) || ((plier>>i)+1)==0) begin 
            done=1;
            // $display("%d Good: %d %d %d %d",$time,i,plier,add,sub);
            i=-1;
            #1
            prod=0;
            add=0;
            sub=0;
        end
        i=i+1;
    end
endmodule

module top;
    reg clk;
    reg bit;
    reg [31:0] cand[0:9];
    reg [31:0] plier[0:9];
    wire [4:0] add;
    wire [4:0] sub;
    wire [31:0] prod;
    wire done;
    reg [3:0] i;
    initial begin
        clk=0;
        i=0;
        bit=0;
        forever begin
            #5
            clk=~clk;
        end
    end
    initial begin
        cand[0]=32'd1;
        cand[1]=32'd1;
        cand[2]=32'd2;
        cand[3]=32'd3;
        cand[4]=32'd4;
        cand[5]=32'd5;
        cand[6]=32'd6;
        cand[7]=32'd7;
        cand[8]=32'd8;
        cand[9]=32'd9;
        plier[0]=32'd10;
        plier[1]=32'd11;
        plier[2]=32'd12;
        plier[3]=32'd13;
        plier[4]=32'd14;
        plier[5]=32'd15;
        plier[6]=32'd16;
        plier[7]=32'd17;
        plier[8]=32'd18;
        plier[9]=32'd19;
    end
    booth uut(clk,bit,cand[i],plier[i],prod,done,add,sub);
    always @(negedge clk) begin
        if(done==1) begin
            if(i<10) bit=1;
        end
        else bit=0;
    end
    always @(posedge done) begin
        i=i+1;
        $display("time:%d i:%d cand:%d plier:%d prod:%d add:%d sub:%d",$time,i-1,cand[i-1], plier[i-1],prod,add,sub);
        // $display("time:%d i:%d cand:%b plier:%b prod:%d add:%d sub:%d",$time,i-1,cand[i-1], plier[i-1],prod,add,sub);
        if(i==10) $finish;
    end
endmodule