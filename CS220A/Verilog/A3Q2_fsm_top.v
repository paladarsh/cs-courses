// Author: Mainak Chaudhuri

module A3Q2_fsm_top;

   reg clk;
   reg x;
   wire y;

   fsm FSM (clk, x, y);

   always @ (posedge clk) begin
      $display("Time = %d, x = %d, y = %d", $time, x, y);
   end

   initial begin
      forever begin
         clk = 0;
         #5
         clk = 1;
         #5
         clk = 0;
      end
   end

   initial begin
      #3
      x=0;
      #10
      x=1;
      #10
      x=0;
      #10
      x=1;
      #10
      x=0;
      #10
      x=1;
      #10
      x=0;
      #10
      x=1;
      #10
      x=1;
      #10
      x=0;
   end

   initial begin
      #100
      $finish;
   end

endmodule
