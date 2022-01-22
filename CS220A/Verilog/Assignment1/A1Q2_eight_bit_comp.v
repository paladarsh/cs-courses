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