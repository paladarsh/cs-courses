`define PROP_DELAY #2
`define MAX_PC 11
`define OUTPUT_REG 4

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

