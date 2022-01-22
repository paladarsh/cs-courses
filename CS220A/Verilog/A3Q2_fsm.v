// Author: Mainak Chaudhuri

`define TICK #2

module fsm (clk, x, y);

   input clk;
   input x;

   output y;

   wire y;

   reg [2:0] states;
   wire a;
   wire b;
   wire c;

   initial begin
      states = 0;
   end

   always @ (posedge clk) begin
      states <= `TICK {a,b,c};
   end

   assign y = ~states[2] | states[1] | ~states[0];
   assign a = (~x & (states[0] | states[2])) | (states[2] & (states[1] | states[0])) | (states[1] & x);
   assign b = (states[2] & states[1]) | (~states[2] & ~states[1] & x) | (states[2] & ~states[0] & x);
   assign c = ~states[0] | states[2] | (states[1] & x) | (~states[1] & states[0] & ~x);

endmodule
