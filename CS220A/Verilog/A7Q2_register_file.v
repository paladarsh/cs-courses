// Authored by Mainak Chaudhuri

`include "A7Q2_state_defs.h"

`define OUTPUT_REG 5
`define PROP_DELAY #2

module register_file(clk, state, rs, rt, rd, result, instruction_invalid, rsv, rtv, done);

   input clk;
   input [2:0] state;
   input [4:0] rs;
   input [4:0] rt;
   input [4:0] rd;
   input [7:0] result;
   input instruction_invalid;
	
   output [7:0] rsv;
   output [7:0] rtv;
   output done;
	
   reg [7:0] rsv;
   reg [7:0] rtv;
   reg done;
	
   reg [7:0] regfile [0:31];
	
   initial begin
      regfile[0] = 0;
      regfile[1] = 0;
      regfile[2] = 0;
      regfile[3] = 0;
      regfile[4] = 0;
      regfile[5] = 0;
      regfile[6] = 0;
      regfile[7] = 0;
      regfile[8] = 0;
      regfile[9] = 0;
      regfile[10] = 0;
      regfile[11] = 0;
      regfile[12] = 0;
      regfile[13] = 0;
      regfile[14] = 0;
      regfile[15] = 0;
      regfile[16] = 0;
      regfile[17] = 0;
      regfile[18] = 0;
      regfile[19] = 0;
      regfile[20] = 0;
      regfile[21] = 0;
      regfile[22] = 0;
      regfile[23] = 0;
      regfile[24] = 0;
      regfile[25] = 0;
      regfile[26] = 0;
      regfile[27] = 0;
      regfile[28] = 0;
      regfile[29] = 0;
      regfile[30] = 0;
      regfile[31] = 0;

      done = 0;
   end
	
   always @ (posedge clk) begin
      if (state == `STATE_RF) begin
         rsv <= `PROP_DELAY regfile[rs];
	 rtv <= `PROP_DELAY regfile[rt];
      end
      else if ((state == `STATE_WB) && (rd != 0) && (instruction_invalid == 0)) begin
         regfile[rd] <= `PROP_DELAY result;
      end
      else if (state == `STATE_OUTPUT) begin
         rsv <= `PROP_DELAY regfile[`OUTPUT_REG];
         done <= `PROP_DELAY 1;
      end
   end
	
endmodule
