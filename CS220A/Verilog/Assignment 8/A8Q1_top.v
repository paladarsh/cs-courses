`define PROP_DELAY #2
`define MAX_PC 14
`define OUTPUT_REG 2

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