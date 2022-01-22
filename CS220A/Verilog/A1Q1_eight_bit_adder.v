module eight_bit_full_adder(a,b,cin,sum,cout);

    input [7:0] a;
    input [7:0] b;
    input cin;

    output [7:0] sum;
    output cout;

    wire [7:0] sum;
    wire cout;

    wire [6:0] c_mid;

    one_bit_full_adder FA0(a[0],b[0],cin,sum[0],c_mid[0]);
    one_bit_full_adder FA1(a[1],b[1],c_mid[0],sum[1],c_mid[1]);
    one_bit_full_adder FA2(a[2],b[2],c_mid[1],sum[2],c_mid[2]);
    one_bit_full_adder FA3(a[3],b[3],c_mid[2],sum[3],c_mid[3]);
    one_bit_full_adder FA4(a[4],b[4],c_mid[3],sum[4],c_mid[4]);
    one_bit_full_adder FA5(a[5],b[5],c_mid[4],sum[5],c_mid[5]);
    one_bit_full_adder FA6(a[6],b[6],c_mid[5],sum[6],c_mid[6]);
    one_bit_full_adder FA7(a[7],b[7],c_mid[6],sum[7],cout);
endmodule
