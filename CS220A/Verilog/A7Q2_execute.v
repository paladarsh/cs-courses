// Authored by Mainak Chaudhuri

`include "A7Q2_state_defs.h"
`include "A7Q2_opcode_defs.h"
`include "A7Q2_func_defs.h"

`define PROP_DELAY #2

module execute(clk, state, opcode, rsv, rtv, imm, func, result, instruction_invalid);

   input clk;
   input [2:0] state;
   input [5:0] opcode;
   input [7:0] rsv;
   input [7:0] rtv;
   input [15:0] imm;
   input [5:0] func;
	
   output [7:0] result;
   output instruction_invalid;
	
   reg [7:0] result;
   reg instruction_invalid;
	
   initial begin
      instruction_invalid = 1;
   end
	
   always @ (posedge clk) begin
      if (state == `STATE_EX) begin
         if ((opcode == `OP_ADDU) && (func == `FUNC_ADDU)) begin
	    result <= `PROP_DELAY rsv + rtv;
	    instruction_invalid <= `PROP_DELAY 0;
	 end
	 else if ((opcode == `OP_SUBU) && (func == `FUNC_SUBU)) begin
	    result <= `PROP_DELAY rsv - rtv;
            instruction_invalid <= `PROP_DELAY 0;
	 end
	 else if (opcode == `OP_ADDIU) begin
	    result <= `PROP_DELAY rsv + imm[7:0];
	    instruction_invalid <= `PROP_DELAY 0;
	 end
	 else begin
	    instruction_invalid <= `PROP_DELAY 1;
	 end
      end
   end

endmodule
