module interface(clk,ra,rb,w,wd,op,rda,rdb,done);
// module interface;
    input clk;
    // input re;
    input [4:0] ra;
    input [4:0] rb;
    input [4:0] w;
    input [15:0] wd;
    input [2:0] op;

    output reg[15:0] rda;
    output reg[15:0] rdb;
    output reg done;

    reg [15:0] file[0:31];
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
                repeat (2) @(posedge clk);
                file[w]=rda+rdb;
            end 
            3'b110: begin
                repeat (2) @(posedge clk);
                rda=file[ra];
                repeat (2) @(posedge clk);
                file[w]=rda-rdb;
            end 
            3'b111: begin
                repeat (2) @(posedge clk);
                rda=file[ra];
                repeat (2) @(posedge clk);
                file[w]=rda<<1;
            end 
        endcase
        done = 1'b1;
    end
endmodule

module top;
    reg clk;
    reg [4:0] ra;
    reg [4:0] rb;
    reg [4:0] w;
    reg [15:0] wd;
    reg [2:0] op;

    wire [15:0] rda;
    wire [15:0] rdb;
    wire done;
    reg re;

    interface uut(clk,ra,rb,w,wd,op,rda,rdb,done);

    always @(posedge done) begin
        // $display("Time: <%d>, Operation: %b, ra:%b, rb:%b, w:%d, wd:%b, rdb:%b, rda:%b",$time,op,ra,ra,rb,w,wd,rda,rdb);
        case(op)
            // 3'b000: $display("Time: %d op: %d",$time,op);
            3'b001: $display("Time: %d op: %d ra: %d rda: %d", $time, op, ra,rda);
            3'b010: $display("Time: %d op: %d ra: %d rda: %d rb: %d rdb: %d", $time, op, ra,rda,rb,rdb);
            3'b011: $display("Time: %d op: %d ra: %d rda: %d", $time,op,ra,rda);
            3'b100: $display("Time: %d op: %d ra: %d rda: %d rb: %d rdb: %d", $time, op, ra,rda,rb,rdb);
            3'b000, 3'b101,3'b110,3'b111: $display("Time: %d op: %d, w: %d wd: %d", $time,op,w,wd);
        endcase
    end

    initial begin
        clk=0;
        #1000
        $finish;
    end

    initial begin
        forever begin
            #5
            clk=~clk;
        end
    end

    initial begin
       #3
    //    op=3'b000; w=5'd0; wd=16'd23;
    //    #50
    //    op=3'b001; ra=5'd1;
    //    #50
    //    op=3'b010; ra=5'd2; rb=5'd3;
    //    #50
    //    op=3'b011; ra=5'd4; w=5'd5; wd=16'd21;
    //    #50
    //    op=3'b100; ra=5'd6; rb=5'd7; w=5'd8; wd=16'd20;
    //    #50
       op=3'b101; ra=5'd9; rb=5'd10;
    //    #50
    //    op=3'b110; ra=5'd11; rb=5'd12;
    //    #50
    //    op=3'b111; ra=5'd13;
    end
    // // always @(posedge clk) begin
    //     #1
    //     re=done;
    // end
endmodule