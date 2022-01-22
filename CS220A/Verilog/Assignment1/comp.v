module one_bit_compare(a,b,lin,ein,gin,l,e,g);
    input a,b,lin,ein,gin;
    output l,e,g;
    reg l,e,g;
    always @(a or b or lin or ein or gin) begin
        if(lin==1'b1) begin
            l=1'b1; e=1'b0; g=1'b0;
        end
        else if(gin==1'b1) begin
            l=1'b0; e=1'b0; g=1'b1;
        end
        else if(a<b) begin
            l=1'b1; e=1'b0; g=1'b0;
        end
        else if(a==b) begin
            l=1'b0; e=1'b1; g=1'b0;
        end
        else begin
            l=1'b0; e=1'b0; g=1'b1;
        end
    end
endmodule

module eight_bit_compare(x,y,lout, eout, gout);
    input [7:0] x;
    input [7:0] y;

    output gout,eout,lout;
    wire gout,eout,lout;

    wire [7:0] l;
    wire [7:0] e;
    wire [7:0] g;

    one_bit_compare Comp0(x[7], y[7], l[7], e[7], g[7], l[6], e[6], g[6]);
    one_bit_compare Comp1(x[6], y[6], l[6], e[6], g[6], l[5], e[5], g[5]);
    one_bit_compare Comp2(x[5], y[5], l[5], e[5], g[5], l[4], e[4], g[4]);
    one_bit_compare Comp3(x[4], y[4], l[4], e[4], g[4], l[3], e[3], g[3]);
    one_bit_compare Comp4(x[3], y[3], l[3], e[3], g[3], l[2], e[2], g[2]);
    one_bit_compare Comp5(x[2], y[2], l[2], e[2], g[2], l[1], e[1], g[1]);
    one_bit_compare Comp6(x[1], y[1], l[1], e[1], g[1], l[0], e[0], g[0]);
    one_bit_compare Comp7(x[0], y[0], l[0], e[0], g[0], lout, eout, gout);
endmodule

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