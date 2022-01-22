module fsm(clk,cur,y,next);
    input clk;
    input [3:0] cur;
    input [1:0] y;
    
    output wire [3:0] next;

    reg [3:0] inc;
    wire [3:0] micro;

    microcode obj(clk,cur,micro);
    dispatch ob(clk,cur,micro,y,next);

    always @(posedge clk) begin
    //   $display("Time = %d,  cur = %d, y= %b, micro= %d, new = %d", $time, cur, y, micro,next);
      $display("Time = %d,  current = %d, y= %b, next = %d", $time, cur, y, next);
   end
endmodule