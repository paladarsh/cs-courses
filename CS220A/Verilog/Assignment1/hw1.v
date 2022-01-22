module one_bit_full_adder(a,b,cin,sum,cout);
    input a,b,cin;
    output sum,cout;
    wire sum,cout;
    assign sum=(a^b^cin);
    assign cout=((a & b) | (b & cin) | (a & cin));
endmodule

module eight_bit_adder(x,y,carry_in,sum,carry_out);
    input [7:0] x;
    input [7:0] y;
    input carry_in;

    output [7:0] sum;
    wire [7:0] sum;

    output carry_out;
    wire carry_out;

    wire [6:0] intermediate_carry;
    one_bit_full_adder FA0(x[0], y[0], carry_in, sum[0], intermediate_carry[0]);
    one_bit_full_adder FA1(x[1], y[1], intermediate_carry[0], sum[1], intermediate_carry[1]);
    one_bit_full_adder FA2(x[2], y[2], intermediate_carry[1], sum[2], intermediate_carry[2]);
    one_bit_full_adder FA3(x[3], y[3], intermediate_carry[2], sum[3], intermediate_carry[3]);
    one_bit_full_adder FA4(x[4], y[4], intermediate_carry[3], sum[4], intermediate_carry[4]);
    one_bit_full_adder FA5(x[5], y[5], intermediate_carry[4], sum[5], intermediate_carry[5]);
    one_bit_full_adder FA6(x[6], y[6], intermediate_carry[5], sum[6], intermediate_carry[6]);
    one_bit_full_adder FA7(x[7], y[7], intermediate_carry[6], sum[7], carry_out);
endmodule

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