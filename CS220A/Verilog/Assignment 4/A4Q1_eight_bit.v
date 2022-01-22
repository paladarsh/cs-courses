module eight_bit_full_calc(a,b,opcode,sum,cout,over_flow);

    input signed [7:0] a;
    input signed [7:0] b;
    input opcode;

    output signed [7:0] sum;
    output cout;
    output over_flow;

    wire signed [7:0] sum;
    wire cout;
    reg over_flow;

    wire signed [6:0] c_mid;

    one_bit_full_calc FA0(a[0],b[0],opcode,opcode,sum[0],c_mid[0]);
    one_bit_full_calc FA1(a[1],b[1],c_mid[0],opcode,sum[1],c_mid[1]);
    one_bit_full_calc FA2(a[2],b[2],c_mid[1],opcode,sum[2],c_mid[2]);
    one_bit_full_calc FA3(a[3],b[3],c_mid[2],opcode,sum[3],c_mid[3]);
    one_bit_full_calc FA4(a[4],b[4],c_mid[3],opcode,sum[4],c_mid[4]);
    one_bit_full_calc FA5(a[5],b[5],c_mid[4],opcode,sum[5],c_mid[5]);
    one_bit_full_calc FA6(a[6],b[6],c_mid[5],opcode,sum[6],c_mid[6]);
    one_bit_full_calc FA7(a[7],b[7],c_mid[6],opcode,sum[7],cout);

    always @(*) begin
        over_flow = cout^c_mid[6];
    end
endmodule