`define PROP_DELAY #2
`define MAX_PC 14
`define OUTPUT_REG 2

module fetch(clk, state, program_counter, instruction);
    input clk;
    input [2:0] state;
    input [7:0] program_counter;
        
    output reg [31:0] instruction;
        
    reg [31:0] instruction_mem [0:13];
        
    initial begin
        instruction = 0;
        instruction_mem[0] = {6'h9,5'd0,5'd2,16'd0};
        instruction_mem[1] = {6'h9,5'd0,5'd3,16'd0};
        instruction_mem[2] = {6'h0,5'd3,5'd1,5'd4,5'd0,6'h2a};
        instruction_mem[3] = {6'h4,5'd4,5'd0,16'd8};
        instruction_mem[4] = {6'h9,5'd0,5'd5,16'd10};
        instruction_mem[5] = {6'h4,5'd3,5'd5,16'd6};
        instruction_mem[6] = {6'h23,5'd3,5'd6,16'd0};
        instruction_mem[7] = {6'h0,5'd2,5'd6,5'd2,5'd0,6'h21};
        instruction_mem[8] = {6'h9,5'd3,5'd3,16'd1};
        instruction_mem[9] = {6'h0,5'd3,5'd1,5'd4,5'd0,6'h2a};
        instruction_mem[10] = {6'h5,5'd4,5'd0,-16'd5};
        instruction_mem[11] = {6'h0,5'd31,5'd0,5'd0,5'd0,6'h8};
        instruction_mem[12] = {6'h23,5'd0,5'd1,16'd10};
        instruction_mem[13] = {6'h3,26'd0};
    end
        
    always @ (posedge clk) begin
        if (state == 0) begin
            instruction <= `PROP_DELAY instruction_mem[program_counter];
        end
    end
endmodule

module state_control(clk, program_counter, state);

    input clk;
    input [7:0] program_counter;

    output reg [2:0] state;
        
    initial begin
        state = 0;
    end
        
    always @ (posedge clk) begin
        if (state == 5) begin
            if(program_counter < `MAX_PC) state <= `PROP_DELAY 0;
            else state <= `PROP_DELAY 6;
        end
        else if (state!=6) begin
            state <= `PROP_DELAY state + 1;
        end
    end
endmodule

module decode(clk, state, instruction, opcode, rs, rt, rd, imm, jt, func);
    input clk;
    input [2:0] state;
    input [31:0] instruction;
        
    output reg [5:0] opcode;
    output reg [4:0] rs;
    output reg [4:0] rt;
    output reg [4:0] rd;
    output reg [15:0] imm;
    output reg [5:0] func;
    output reg [25:0] jt;
	
    always @ (posedge clk) begin
        if (state == 1) begin
            opcode <= `PROP_DELAY instruction[31:26];
            rs <= `PROP_DELAY instruction[25:21];
            if(instruction[31:26]==6'h3) rt<= #2 6'd31;
            else rt <= `PROP_DELAY instruction[20:16];
            rd <= `PROP_DELAY instruction[15:11];
            imm <= `PROP_DELAY instruction[15:0];
            func <= `PROP_DELAY instruction[5:0];
            jt <= `PROP_DELAY instruction[25:0];
        end
        // $display("%d: state:%d opcode:%h rs:%d rt:%d rd:%d imm:%d jt:%d func:%d",$time, state, opcode,rs,rt,rd,imm,jt,func);
    end
endmodule

module execute(clk, state, opcode, rsv, rtv, imm, jt, func, result, instruction_invalid,PC);

    input clk;
    input [2:0] state;
    input [5:0] opcode;
    input [7:0] rsv;
    input [7:0] rtv;
    input [15:0] imm;
    input [25:0] jt;
    input [5:0] func;
        
    output reg [7:0] result;
    output reg instruction_invalid;
    output reg [7:0] PC;
        
    initial begin
        instruction_invalid = 1;
        PC=8'd12;
    end
	
    always @ (posedge clk) begin
        if(state==3) begin
            instruction_invalid = 0;
            case(opcode)
                //addiu, lw
                6'h9,6'h23: begin
                    result<= #2 rsv+imm[7:0];
                    PC<= #2 PC+1;
                end
                //beq,bne
                6'h4: PC<= #2 PC+((rsv==rtv)?imm[7:0]:1);
                6'h5: PC<= #2 PC+((rsv!=rtv)?imm[7:0]:1);
                //jal
                6'h3: begin
                    result<= #2 PC+1;
                    PC <= #2 jt[7:0];
                end
                6'h0: begin
                    case(func)
                        //slt
                        6'h2a: begin
                            result<= (($signed(rsv)<$signed(rtv))?1:0);
                            PC<= #2 PC+1;
                        end
                        //addu
                        6'h21: begin
                            result<=#2 rsv+rtv;
                            PC<= #2 PC+1;
                        end
                        //jr
                        6'h8: PC<= #2 rsv;

                        default: begin
                            PC <= #2 `MAX_PC;
                            instruction_invalid=1;
                        end
                    endcase
                end
                default: begin
                    PC <= #2 `MAX_PC;
                    instruction_invalid=1;
                end
            endcase
        end
        // $display("%d: state:%d opcode:%h rs:%d rt:%d imm:%d func:%d result: %d",$time, state, opcode,rsv,rtv,imm,func,result);
        // $display("%d %d", $time,result);
    end
endmodule

module register_file(pc,clk,opcode,state, rs, rt, rd, result, instruction_invalid, rsv, rtv, done);
    input clk;
    input [7:0] pc;
    input [2:0] state;
    input [5:0] opcode;
    input [4:0] rs;
    input [4:0] rt;
    input [4:0] rd;
    input [7:0] result;
    input instruction_invalid;
        
    output reg [7:0] rsv;
    output reg [7:0] rtv;
    output reg done;
        
    reg signed [7:0] regfile [0:31];
    integer i;
    initial begin
        done = 0;
        for(i=0; i<32; i=i+1) begin
            regfile[i]=32'b0;
        end
    end
	
    always @ (posedge clk) begin
        if (state == 2) begin
            rsv <= `PROP_DELAY regfile[rs];
            rtv <= `PROP_DELAY regfile[rt];
        end
        else if ((state == 5) && (rd != 6'h0) && (instruction_invalid == 0)) begin
            if(opcode!=6'h4 && opcode!=6'h5) regfile[rd] <= `PROP_DELAY result;
        end
        else if (state == 6) begin
            rsv <= `PROP_DELAY regfile[`OUTPUT_REG];
            done <= `PROP_DELAY 1;
        end
        // $display("%d: pc: %d rd:%d state:%d one:%d two:%d three:%d four:%d five:%d six:%d thirtyone: %d",$time, pc, rd, state, regfile[1], regfile[2], regfile[3], regfile[4], regfile[5], regfile[6],regfile[31]);
    end
endmodule

module data(clk,state,ra,instruction_invalid,opcode,rv);
    input clk;
    input instruction_invalid;
    input [2:0] state;
    input [7:0] ra;
    input [5:0] opcode;

    output reg [7:0] rv;

    reg signed [7:0] datafile [0:10];

    initial begin
        datafile[0]=-8'd4;
        datafile[1]=-8'd5;
        datafile[2]=-8'd8;
        datafile[3]=-8'd9;
        datafile[4]=8'd4;
        datafile[5]=8'd5;
        datafile[6]=8'd6;
        datafile[7]=8'd7;
        datafile[8]=8'd8;
        datafile[9]=8'd9;
        datafile[10]=8'd4;
    end
    always @(posedge clk) begin
        if(state==4 && opcode==6'h23 && instruction_invalid==0) rv<= #2 datafile[ra];
        else rv<=ra;
    end
endmodule

module processor;
    reg clk;
    wire [7:0] PC;
    wire [2:0] state;
    wire [31:0] instruction;
    wire [5:0] opcode;
    wire [4:0] rs;
    wire [4:0] rt;
    wire [4:0] rd;
    wire [15:0] imm;
    wire [25:0] jt;
    wire [5:0] func;
    wire [7:0] result;
    wire [7:0] res;
    wire instruction_invalid;
    wire signed [7:0] rsv;
    wire [7:0] rtv;
    wire [7:0] rv;
    wire done;
        
    state_control SC(clk, PC, state);
    //0
    fetch IF(clk, state, PC, instruction);
    //1
    decode ID(clk, state, instruction, opcode, rs, rt, rd, imm,jt,func);
    //2,5,6
    register_file RF(PC,clk,opcode,state, rs, rt, (opcode == 0) ? rd : rt, result, instruction_invalid, rsv, rtv, done);
    //3
    execute EX(clk, state, opcode, rsv, rtv, imm,jt,func, res, instruction_invalid,PC);
    //4
    data obj(clk,state,res,instruction_invalid,opcode,result);
        
    initial begin
        clk = 0;
        forever begin
            #5
            clk = ~clk;
        end
    end

    always @ (posedge done) begin
        $display("Time: %3d, output = %d", $time, rsv);
        $finish;
    end
endmodule