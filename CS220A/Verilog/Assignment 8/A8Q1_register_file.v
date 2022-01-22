`define PROP_DELAY #2
`define MAX_PC 14
`define OUTPUT_REG 2

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