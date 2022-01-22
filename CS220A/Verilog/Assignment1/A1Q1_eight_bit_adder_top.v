module eight_bit_adder_top;
   reg [7:0] A;
   reg [7:0] B;
   reg Cin;

   wire [7:0] Sum;
   wire Carry;

   eight_bit_adder ADDER(A, B, Cin, Sum, Carry);
   always @ (A or B or Cin or Sum or Carry) begin
        // $display("Time: <%d> A: %b B: %b, Cin: %d, Sum: %b Carry: %b\n",$time,A,B,Cin,Sum,Carry);
        $display("Time: <%d> A: %d B: %d, Cin: %d, Sum: %d Carry: %b\n",$time,A,B,Cin,Sum,Carry);
   end
   initial begin
      A = 100; B = 100; Cin = 1;
      #1
      $display("\n");
      A = 200; B = 200; Cin = 0;
      #1
      $display("\n");
      A = 20; B = 200; Cin = 1;
      #1
      $display("\n");
      A = 33; B = 66; Cin = 0;
      #1
      $display("\n");
      A = 220; B = 80; Cin = 0;
      #1
      $display("\n");
      A = 160; B = 60; Cin = 1;
      #1
      $display("\n");
      A = 73; B = 220; Cin = 1;
      #1
      $display("\n");
      A = 65; B = 200; Cin = 0;
      #1
      $display("\n");
      A = 20; B = 75; Cin = 0;
      #1
      $display("\n");
      A = 199; B = 99; Cin = 1;
      $display("\n");
      #1
      $finish;
   end
endmodule