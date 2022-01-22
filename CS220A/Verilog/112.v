module nrda(clk, bit, dend, sor,ldend, lsor, q,rem,done,add,sub);
    input clk;
    input bit;
    input [31:0] dend;
    input [31:0] sor;
    input [5:0] ldend;
    input [5:0] lsor;

    reg [5:0] i;
    reg [31:0] divi;

    output reg [31:0] q;
    output reg [31:0] rem;
    output reg done;
    output reg [5:0] add;
    output reg [5:0] sub;
    
    initial begin
        i=0;
        q=0;
        done=1;
    end
    always @(posedge clk) begin
        // initial
        // $display("%d %d",$time,i);
        if(bit==1) begin 
            rem=dend;
            q=0;
            done=0;
            add=0;
            sub=0;
            i=0;
            if(dend>=sor) divi=sor<<(ldend-lsor);
            else begin
                done=1;
            end
        end

        if(done==0) begin
        if(rem[31]==1) begin
            rem=rem+divi;
            add=add+1;
            q=q^32'b1;
        end
        else begin
            rem=rem-divi;
            sub=sub+1;
        end
        divi=divi>>1;
        i=i+1;
        q=(q<<1)|1;

        if(i==(ldend-lsor+1) || ldend<lsor) begin
            divi=sor;
            if(rem[31]==1) begin
                rem=rem+divi;
                add=add+1;
                q=(q^1'b1);
            end
            done=1;
            #1
            i=0;
            q=0;
            add=0;
            sub=0;
        end
    end
    end
endmodule

module top;
    reg clk;
    reg bit;
    reg [31:0] dend[0:9];
    reg [31:0] sor[0:9];
    reg [5:0] ldend[0:9];
    reg [5:0] lsor[0:9];

    wire [5:0] add;
    wire [5:0] sub;
    wire [31:0] q;
    wire signed [31:0] rem;
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
        dend[0]=32'd10;
        dend[1]=32'd22;
        dend[2]=32'd36;
        dend[3]=32'd52;
        dend[4]=32'd70;
        dend[5]=32'd90;
        dend[6]=32'd112;
        dend[7]=32'd136;
        dend[8]=32'd162;
        dend[9]=32'd190;

        sor[0]=32'd10;
        sor[1]=32'd11;
        sor[2]=32'd12;
        sor[3]=32'd13;
        sor[4]=32'd14;
        sor[5]=32'd15;
        sor[6]=32'd16;
        sor[7]=32'd17;
        sor[8]=32'd18;
        sor[9]=32'd19;

        ldend[0]=6'd4;
        ldend[1]=6'd5;
        ldend[2]=6'd6;
        ldend[3]=6'd6;
        ldend[4]=6'd7;
        ldend[5]=6'd7;
        ldend[6]=6'd7;
        ldend[7]=6'd8;
        ldend[8]=6'd8;
        ldend[9]=6'd8;

        lsor[0]=6'd4;
        lsor[1]=6'd4;
        lsor[2]=6'd4;
        lsor[3]=6'd4;
        lsor[4]=6'd4;
        lsor[5]=6'd4;
        lsor[6]=6'd5;
        lsor[7]=6'd5;
        lsor[8]=6'd5;
        lsor[9]=6'd5;

        // dend[0]=32'd10;
        // dend[1]=32'd74;
        // dend[2]=32'd1000;
        // dend[3]=32'd18;
        // dend[4]=32'd19;
        // dend[5]=32'd20;
        // dend[6]=32'd21;
        // dend[7]=32'd22;
        // dend[8]=32'd23;
        // dend[9]=32'd24;

        // sor[0]=32'd100;
        // sor[1]=32'd9;
        // sor[2]=32'd1000;
        // sor[3]=32'd16;
        // sor[4]=32'd16;
        // sor[5]=32'd16;
        // sor[6]=32'd16;
        // sor[7]=32'd16;
        // sor[8]=32'd16;
        // sor[9]=32'd16;

        // ldend[0]=6'd4;
        // ldend[1]=6'd7;
        // ldend[2]=6'd10;
        // ldend[3]=6'd5;
        // ldend[4]=6'd5;
        // ldend[5]=6'd5;
        // ldend[6]=6'd5;
        // ldend[7]=6'd5;
        // ldend[8]=6'd5;
        // ldend[9]=6'd5;

        // lsor[0]=6'd7;
        // lsor[1]=6'd4;
        // lsor[2]=6'd10;
        // lsor[3]=6'd5;
        // lsor[4]=6'd5;
        // lsor[5]=6'd5;
        // lsor[6]=6'd5;
        // lsor[7]=6'd5;
        // lsor[8]=6'd5;
        // lsor[9]=6'd5;

        // dend[0]=234;     sor[0]=31;     ldend[0]=8;      lsor[0]=5;
        // dend[1]=1245;    sor[1]=65;     ldend[1]=11;     lsor[1]=7;
        // dend[2]=12;      sor[2]=31;     ldend[2]=4;      lsor[2]=5;
        // dend[3]=74;      sor[3]=9;      ldend[3]=7;      lsor[3]=4;

        // dend[4]=2020;    sor[4]=100;    ldend[4]=11;    lsor[4]=7;
        // dend[5]=50;      sor[5]=10;     ldend[5]=6;      lsor[5]=4;
        // dend[6]=333;     sor[6]=3;      ldend[6]=9;      lsor[6]=2;
        // dend[7]=999;     sor[7]=999;    ldend[7]=10;     lsor[7]=10;
        // dend[8]=100;     sor[8]=1;      ldend[8]=7;      lsor[8]=1;
        // dend[9]=294967295; sor[9]=999;   ldend[9]=29;     lsor[9]=10;

    end
    // module nrda(clk,bit, dend, sor,ldend, lsor, q,rem,done,add,sub);
    nrda uut(clk,bit,dend[i],sor[i],ldend[i], lsor[i],q,rem,done,add,sub);
    always @(negedge clk) begin
        if(done==1) begin
            if(i<10) bit=1;
        end
        else bit=0;
    end
    always @(posedge done) begin
        i=i+1;
        $display("time:%d i:%d dend:%d sor:%d ldend: %d lsor: %d q:%d rem:%d add:%d sub:%d",$time,i-1,dend[i-1], sor[i-1],ldend[i-1], lsor[i-1], q,rem, add,sub);
        // $display("time:%d i:%d dend:%d sor:%d q:%d rem:%d add:%d sub:%d",$time,i-1,dend[i-1], sor[i-1],q,rem, add,sub);
        // $display("time:%d i:%d dend:%b sor:%b ldend: %d lsor: %d q:%d rem:%d add:%d sub:%d",$time,i-1,dend[i-1], sor[i-1],ldend[i-1], lsor[i-1], q,rem, add,sub);
        if(i==10) $finish;
    end
endmodule