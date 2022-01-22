// Authored by Mainak Chaudhuri

`include "A7Q2_state_defs.h"
`include "A7Q2_opcode_defs.h"

module processor;

   reg clk;
	
   wire [2:0] PC;
   wire [2:0] state;
   wire [31:0] instruction;
   wire [5:0] opcode;
   wire [4:0] rs;
   wire [4:0] rt;
   wire [4:0] rd;
   wire [15:0] imm;
   wire [5:0] func;
   wire [7:0] result;
   wire instruction_invalid;
   wire [7:0] rsv;
   wire [7:0] rtv;
   wire done;
	
   state_control SC(clk, PC, state);
   fetch IF(clk, state, PC, instruction);
   decode ID(clk, state, instruction, opcode, rs, rt, rd, imm, func);
   register_file RF(clk, state, rs, rt, (opcode == `OP_RFORM) ? rd : rt, result, instruction_invalid, rsv, rtv, done);
   execute EX(clk, state, opcode, rsv, rtv, imm, func, result, instruction_invalid);
	
   initial begin
      forever begin
         clk = 0;
         #5
         clk = 1;
         #5
         clk = 0;
      end
   end

   always @ (posedge done) begin
      $display("Time: %3d, output = %d", $time, rsv);
      $finish;
   end

endmodule
