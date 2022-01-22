module eight_bit_comparator_top;

   reg [7:0] A;
   reg [7:0] B;

   wire g,l,e;

   eight_bit_compare comp(A, B, l, e, g);
   always @ (A or B or l or e or g) begin
        // $display("Time:<%d> A=%b, B=%b, lesser=%b, equal=%b, greater=%b", A, B, l, e, g);
        $display("Time:<%d> A=%d, B=%d, lesser=%d, equal=%d, greater=%d",$time, A, B, l, e, g);
   end
   initial begin
      A = 100; B = 100; 
      #1
      $display("\n");
      A = 200; B = 20; 
      #1
      $display("\n");
      A = 200; B = 200; 
      #1
      $display("\n");
      A = 1; B = 0; 
      #1
      $display("\n");
      A = 0; B = 1;
      #1
      $display("\n");
      A = 0; B = 0;
      #1
      $display("\n");
      A = 73; B = 220;
      #1
      $display("\n");
      A = 65; B = 200;
      #1
      $display("\n");
      A = 120; B = 75;
      #1
      $display("\n");
      A = 199; B = 99;
   end
   initial begin
       #10
       $finish;
   end
endmodule