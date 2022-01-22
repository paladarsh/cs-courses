module eight_bit_comp(a,b,lout,eout,gout);

    input [7:0] a;
    input [7:0] b;
    
    wire [6:0] l;
    wire [6:0] e;
    wire [6:0] g;
    
    output lout,eout,gout;
    wire lout,eout,gout;

    one_bit_comp comp7(a[7],b[7],1'b0,1'b1,1'b0,l[6],e[6],g[6]);
    one_bit_comp comp6(a[6],b[6],l[6],e[6],g[6],l[5],e[5],g[5]);
    one_bit_comp comp5(a[5],b[5],l[5],e[5],g[5],l[4],e[4],g[4]);
    one_bit_comp comp4(a[4],b[4],l[4],e[4],g[4],l[3],e[3],g[3]);
    one_bit_comp comp3(a[3],b[3],l[3],e[3],g[3],l[2],e[2],g[2]);
    one_bit_comp comp2(a[2],b[2],l[2],e[2],g[2],l[1],e[1],g[1]);
    one_bit_comp comp1(a[1],b[1],l[1],e[1],g[1],l[0],e[0],g[0]);
    one_bit_comp comp0(a[0],b[0],l[0],e[0],g[0],lout,eout,gout);
    
endmodule
