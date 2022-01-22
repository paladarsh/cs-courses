module one_bit_full_adder(a,b,cin,opcode,sum,cout);

    input a,b,cin,opcode;
    output sum,cout;
    reg x;
    reg sum,cout;
    always @* begin
        x=b^opcode;
        sum = a ^ x ^ cin;
        cout = ((a&x)|(x&cin)|(cin&a));
    end
endmodule

module five_bit_full_adder(a,b,opcode,sum,ofl);

    input [4:0] a;
    input [4:0] b;
    input opcode;

    output [4:0] sum;
    output ofl;

    wire [4:0] sum;
    wire ofl;

    wire [3:0] c_mid;

    one_bit_full_adder FA0(a[0],b[0],opcode,opcode,sum[0],c_mid[0]);
    one_bit_full_adder FA1(a[1], b[1], c_mid[0], opcode, sum[1], c_mid[1]);
    one_bit_full_adder FA2(a[2], b[2], c_mid[1], opcode, sum[2], c_mid[2]);
    one_bit_full_adder FA3(a[3], b[3], c_mid[2], opcode, sum[3], c_mid[3]);
    one_bit_full_adder FA4(a[4], b[4], c_mid[3], opcode, ofl, sum[4]);
endmodule

module five_bit_adder_top;

    reg [4:0] A;
    reg [4:0] B;
    reg opcode;
    reg cin;
    
    wire [4:0] sum;
    wire ofl;


    five_bit_full_adder uut(A,B,opcode,sum,ofl);

    always @(sum or ofl) begin
    // always @($time)
        $display("Time: <%d> A: %d B: %d opcode: %b Sum: %d Overflow: %b\n",$time,A,B, opcode, sum,ofl);
    end

    initial begin
        A = 15; B = 2; opcode=0;
        #20
        $finish;
    end
endmodule