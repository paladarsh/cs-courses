// Authored by Mainak Chaudhuri

`include "A7Q2_state_defs.h"

`define PROP_DELAY #2

module decode(clk, state, instruction, opcode, rs, rt, rd, imm, func);

   input clk;
   input [2:0] state;
   input [31:0] instruction;
	
   output [5:0] opcode;
   output [4:0] rs;
   output [4:0] rt;
   output [4:0] rd;
   output [15:0] imm;
   output [5:0] func;
	
   reg [5:0] opcode;
   reg [4:0] rs;
   reg [4:0] rt;
   reg [4:0] rd;
   reg [15:0] imm;
   reg [5:0] func;
	
   always @ (posedge clk) begin
      if (state == `STATE_ID) begin
         opcode <= `PROP_DELAY instruction[31:26];
	 rs <= `PROP_DELAY instruction[25:21];
	 rt <= `PROP_DELAY instruction[20:16];
	 rd <= `PROP_DELAY instruction[15:11];
	 imm <= `PROP_DELAY instruction[15:0];
	 func <= `PROP_DELAY instruction[5:0];
      end
   end

endmodule
