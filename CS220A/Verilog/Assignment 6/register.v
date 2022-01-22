module interface(clk,ra,rb,w,wd,op,rda,rdb,done);
    input clk;
    input [4:0] ra;
    input [4:0] rb;
    input [4:0] w;
    input signed [15:0] wd;
    input [2:0] op;

    output reg signed [15:0] rda;
    output reg signed [15:0] rdb;
    output reg done;

    reg signed [15:0] file[0:31];
    integer i;
    initial begin
        done=1'b1;
        for(i=0; i<32; i=i+1) begin
            file[i]=16'd0;
        end
    end
    
    always @(posedge clk) begin
        if(done) done=1'b0;
        case(op)
            3'b000: begin
                repeat (2) @(posedge clk)
                file[w]=wd;
                rda=file[w];
            end
            3'b001: begin
                repeat (2) @(posedge clk)
                rda=file[ra];
            end
            3'b010: begin
                repeat (2) @(posedge clk)
                rda=file[ra];
                rdb=file[rb];
            end 
            3'b011: begin
                repeat (2) @(posedge clk)
                rda=file[ra];
                repeat (2) @(posedge clk)
                file[w]=wd;
            end 
            3'b100: begin
                repeat (2) @(posedge clk)
                rda=file[ra];
                rdb=file[rb];
                repeat (2) @(posedge clk)
                file[w]=wd;
            end 
            3'b101: begin
                repeat (2) @(posedge clk)
                rda=file[ra];
                rdb=file[rb];
                repeat (16) @(posedge clk);
                file[w]=rda+rdb;
                repeat (2) @(posedge clk);
                rda=file[w];
            end 
            3'b110: begin
                repeat (2) @(posedge clk);
                rda=file[ra];
                rdb=file[rb];
                repeat (16) @(posedge clk);
                file[w]=rda-rdb;
                repeat (2) @(posedge clk);
                rda=file[w];
            end 
            3'b111: begin
                repeat (2) @(posedge clk);
                rda=file[ra];
                repeat (16) @(posedge clk);
                rda=(rda<<wd);
                repeat (2) @(posedge clk)
                file[w]=rda;
            end 
        endcase
        done = 1'b1;
    end
endmodule

module register_top;
    reg clk;
    reg [2:0] op[0:8];
    reg [4:0] ra[0:8];
    reg [4:0] rb[0:8];
    reg [4:0] w[0:8];
    reg signed [15:0] wd[0:8];
    reg [3:0] i;

    wire done;
    wire signed [15:0] rda;
    wire signed [15:0] rdb;

    interface uut(clk,ra[i],rb[i],w[i],wd[i],op[i],rda,rdb,done);

    always @(posedge done) begin
        case(op[i])
            3'b001: $display("Time: %d op: %b ra: %d rda: %d", $time, op[i], ra[i],rda);
            3'b010: $display("Time: %d op: %b ra: %d rda: %d rb: %d rdb: %d", $time, op[i], ra[i],rda,rb[i],rdb);
            3'b011: $display("Time: %d op: %b ra: %d rda: %d", $time,op[i],ra[i],rda);
            3'b100: $display("Time: %d op: %b ra: %d rda: %d rb: %d rdb: %d", $time, op[i], ra[i],rda,rb[i],rdb);
            3'b000, 3'b101,3'b110,3'b111: $display("Time: %d op: %b, w: %d wd: %d", $time,op[i],w[i],rda);
        endcase
    end

    initial begin
        i=4'd0;
        op[0]=3'b000; w[0]=5'd1; wd[0]=16'd17;
        op[1]=3'b011; ra[1]=5'd1; w[1]=5'd2; wd[1]=-16'd9;
        op[2]=3'b100; ra[2]=5'd1; rb[2]=5'd2; w[2]=5'd3; wd[2]=16'd65;
        op[3]=3'b010; ra[3]=5'd2; rb[3]=5'd3;
        op[4]=3'b111; ra[4]=5'd3; w[4]=5'd5; wd[4]=16'd3;
        op[5]=3'b101; ra[5]=5'd1; rb[5]=5'd2; w[5]=5'd4;
        op[6]=3'b111; ra[6]=5'd4; w[6]=5'd4; wd[6]=16'd9;
        op[7]=3'b110; ra[7]=5'd5; rb[7]=5'd4; w[7]=5'd6;
        op[8]=3'b001; ra[8]=5'd6;
    end 

    initial begin
        clk=0;
        forever begin
            #6
            clk=~clk;
        end
    end
    always @(posedge clk) begin
        #1
        if(done) begin
            if(i==9) $finish;
            i<=i+1;
        end
    end
endmodule