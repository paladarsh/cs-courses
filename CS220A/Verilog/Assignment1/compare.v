module compare(a,b,lp,ep,gp,l,e,g);
    input a,b,lp,ep,gp;
    output l,e,g;
    reg l,e,g;
    always @(a or b or lp or ep or gp) begin
        if(lp==1) begin
            l=1; e=0; g=0;
        end
        else if(gp==1) begin
            l=0; e=0; g=1;
        end
        else if(a<b) begin
            l=1; e=0; g=0;
        end
        else if(a==b) begin
            l=0; e=1; g=0;
        end
        else begin
            l=0; e=0; g=1;
        end
    end
endmodule

module eight_bit_compare(x,y,lt, et, gt);
    input [0:7] x;
    input [0:7] y;
    output gt,et,lt;
    wire gt,et,lt;
    wire [0:7] l;
    wire [0:7] e;
    wire [0:7] g;
    compare Comp0(x[0], y[0], l[0], e[0], g[0], l[1], e[1], g[1]);
    compare Comp1(x[1], y[1], l[1], e[1], g[1], l[2], e[2], g[2]);
    compare Comp2(x[2], y[2], l[2], e[2], g[2], l[3], e[3], g[3]);
    compare Comp3(x[3], y[3], l[3], e[3], g[3], l[4], e[4], g[4]);
    compare Comp4(x[4], y[4], l[4], e[4], g[4], l[5], e[5], g[5]);
    compare Comp5(x[5], y[5], l[5], e[5], g[5], l[6], e[6], g[6]);
    compare Comp6(x[6], y[6], l[6], e[6], g[6], l[7], e[7], g[7]);
    compare Comp7(x[7], y[7], l[7], e[7], g[7], lt, et, gt);
endmodule

module eight_bit_comparator_top;

   reg [0:7] A;
   reg [0:7] B;

   wire g,l,e;

   eight_bit_compare comp(A, B, l, e, g);
   always @ (A or B or l or e or g) begin
        // $display("%d: a=%b, b=%b, lesser=%b, equal=%b, greater=%b", A, B, l, e, g);
        $display("%d: a=%d, b=%d, lesser=%d, equal=%d, greater=%d", A, B, l, e, g);
   end
   initial begin
      A = 100; B = 100; Cin = 1;
      #1
      $display("\n");
      A = 200; B = 200; Cin = 0;
      #1
      $display("\n");
      A = 20; B = 200; Cin = 0;
      #1
      $display("\n");
      A = 33; B = 66; Cin = 1;
      #1
      $display("\n");
      A = 220; B = 80; Cin = 0;
      #1
      $display("\n");
      A = 160; B = 60; Cin = 1;
      #1
      $display("\n");
      A = 73; B = 220; Cin = 0;
      #1
      $display("\n");
      A = 65; B = 200; Cin = 0;
      #1
      $display("\n");
      A = 20; B = 75; Cin = 1;
      #1
      $display("\n");
      A = 199; B = 99; Cin = 0;
   end
   initial begin
       #10
       $finish;
   end
endmodule