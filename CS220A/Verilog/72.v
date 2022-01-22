`define MAX_PC 3'b111
`define OUTPUT_REG 3'd5

module register_file(clk, read1Addr, read2Addr, writeAddr, writeValue, read1Valid, read2Valid, writeValid, read1Value, read2Value);
    input clk;
    input [4:0] read1Addr;
    input [4:0] read2Addr;
    input [4:0] writeAddr;
    input [7:0] writeValue;
    input read1Valid;
    input read2Valid;
    input writeValid;
        
    output [7:0] read1Value;
    output [7:0] read2Value;
        
    reg [7:0] read1Value;
    reg [7:0] read2Value;
        
    reg [7:0] regfile [0:31];
    integer i;
    initial begin
        for(i=0; i<32; i=i+1) begin
            regfile[i]=0;
        end
    end

    always @ (posedge clk) begin
        if (read1Valid == 1)  read1Value <= regfile[read1Addr];
        if (read1Valid == 1)  read2Value <= regfile[read2Addr];
        if (writeValid == 1)  regfile[writeAddr] <= writeValue;
        $display("time: %d one:%d two:%d three:%d four:%d five:%d six:%d",$time, regfile[1],regfile[2],regfile[3],regfile[4],regfile[5],regfile[6]);
    end
endmodule


module processor(clk, read1Addr, read2Addr, writeAddr, writeValue, read1Valid, read2Valid, writeValid, shift_amount, read1Value, read2Value);
   input clk;
   input [4:0] read1Addr;
   input [4:0] read2Addr;
   input [4:0] writeAddr;
   input [7:0] writeValue;
   input read1Valid;
   input read2Valid;
   input writeValid;
   input [4:0] shift_amount;

   output [7:0] read1Value;
   output [7:0] read2Value;

   wire [7:0] read1Value;
   wire [7:0] read2Value;

   register_file RF(clk, read1Addr, read2Addr, writeAddr, writeValue, read1Valid, read2Valid, writeValid, read1Value, read2Value);

endmodule

module adder(clk,first,second,instr,result);
    input clk;
    input [7:0] first;
    input [7:0] second;
    input [1:0] instr;
    output reg [7:0] result;
    always @(posedge clk) begin
        case(instr)
            2'd1,2'd3: result=first+second;
            2'd2: result=first-second;
        endcase
    end
endmodule

module top;
    reg clk;
    reg [31:0] inst[0:7];
    reg [31:0] regadd;
    reg done;

    reg [5:0] opcode;
    reg [4:0] rs;
    reg [4:0] rt;
    reg [4:0] rd;
    reg [4:0] shamt;
    reg [5:0] field;
    reg [7:0] imme;

    reg [2:0] pc;
    reg [2:0] state;
    reg invalid;

    reg [7:0] writeValue;
    reg read1Valid;
    reg read2Valid;
    reg writeValid;

    wire [7:0] read1Value;
    wire [7:0] read2Value;


    reg [7:0] add1;
    reg [7:0] add2;
    reg [1:0] instr;
    wire [7:0] result;

    processor PROCESSOR (clk, rs, rt, rd, writeValue, read1Valid, read2Valid, writeValid, shamt, read1Value, read2Value);
    adder uut(clk,add1,add2,instr,result);

    initial begin
        clk = 0;
        instr=0;
        read1Valid=0;
        read2Valid=0;
        writeValid=0;
        invalid=0;
        pc = 0;
        state=3'd0;
        done=0;
        inst[0]={6'h09,5'd0,5'd1,16'd45};
        inst[1]={6'h09,5'd0,5'd2,-16'd20};
        inst[2]={6'h09,5'd0,5'd3,-16'd60};
        inst[3]={6'h09,5'd0,5'd4,16'd30};
        inst[4]={6'h00,5'd1,5'd2,5'd5,5'h0,6'h21};
        inst[5]={6'h00,5'd3,5'd4,5'd6,5'h0,6'h21};
        inst[6]={6'h00,5'd5,5'd6,5'd5,5'h0,6'h23};
        forever begin
            #5
            clk = ~clk;
        end
        // #300
        // $finish;
    end


    always @(posedge done) begin
        #5
        $finish;
    end

    
    always @(posedge clk) begin
        case(state)
            3'd0: begin
                regadd=inst[pc];
                pc=pc+1;
                state=3'd1;
            end
            3'd1: begin
                opcode=regadd[31:26];
                rs=regadd[25:21];
                if(opcode==6'd0) begin
                    rt=regadd[20:16];
                    rd=regadd[15:11];
                    shamt=regadd[10:6];
                    field=regadd[5:0];
                end
                else begin
                    rd=regadd[20:16];
                    imme=regadd[7:0];
                end
                state=3'd2;
            end
            3'd2: begin
                read1Valid=1;
                if(opcode==6'd0)  read2Valid=1;
                state=3'd3;
            end
            3'd3: begin
                if(opcode==6'h0) begin
                    add1=read1Value;
                    add2=read2Value;
                    if(field==6'h21) instr=2'd1;
                    else if(field==6'h23) instr=2'd2;
                    else invalid=1;
                end
                else if(opcode==6'h9) begin
                    add1=read1Value;
                    add2=imme;
                    instr=2'd3;
                end
                else invalid=1;
                // $display("%d %d %d %d",$time,add1,add2,instr);
                #1
                read1Valid=0;
                read2Valid=0;
                state=3'd4;
            end
            3'd4: begin
                if(invalid==0 && rd!=0) begin
                    #1
                    writeValue=result;
                    writeValid=1;
                    repeat (1) @(posedge clk)
                    #1
                    writeValid=0;
                end
                if(pc<`MAX_PC) state=3'd0;
                else state=3'd5;
            end
            3'd5: begin
                rs=`OUTPUT_REG;
                read1Valid=1;
                #1
                $display("%d",read1Value);
                read1Valid=0;
                done=1;
            end
        endcase
    end
endmodule