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

module eight_bit_full_adder(a,b,opcode,sum,cout,ofl);

    input signed[7:0] a;
    input signed [7:0] b;
    input opcode;

    output signed [7:0] sum;
    output cout;
    output ofl;

    wire [7:0] sum;
    wire cout;
    wire ofl;

    wire [6:0] c_mid;

    one_bit_full_adder FA0(a[0],b[0],opcode,opcode,sum[0],c_mid[0]);
    one_bit_full_adder FA1(a[1], b[1], c_mid[0], opcode, sum[1], c_mid[1]);
    one_bit_full_adder FA2(a[2], b[2], c_mid[1], opcode, sum[2], c_mid[2]);
    one_bit_full_adder FA3(a[3], b[3], c_mid[2], opcode, sum[3], c_mid[3]);
    one_bit_full_adder FA4(a[4], b[4], c_mid[3], opcode, sum[4], c_mid[4]);
    one_bit_full_adder FA5(a[5], b[5], c_mid[4], opcode, sum[5], c_mid[5]);
    one_bit_full_adder FA6(a[6], b[6], c_mid[5], opcode, sum[6], c_mid[6]);
    one_bit_full_adder FA7(a[7], b[7], c_mid[6], opcode, sum[7], cout);
    assign ofl=cout^c_mid[6];
    // always @(a or b or sum) begin
    //     $display("%d %d %d %b %d",$time,a,b,sum,opcode);
    // end
    // assign ofl=1'b1;
endmodule

module eight_bit_adder_top;

    reg signed [7:0] A;
    reg signed [7:0] B;
    reg opcode;
    reg cin;
    
    wire signed [7:0] sum;
    wire carry;
    wire ofl;


    eight_bit_full_adder uut(A,B,opcode,sum,carry,ofl);

    always @(sum or carry or ofl) begin
    // always @($time)
        // $display("Time: <%d> A: %d B: %d opcode: %b Sum: %d Carry: %b Overflow: %b\n",$time,A,B, opcode, sum,carry,ofl);
    end

    initial begin
        A = 100; B = 100; opcode=0; 
        #1
        A = 100; B = 100; opcode=1;
        #1
        A = 20; B = 200; opcode=1;
        #1
        A = 100; B = 10; opcode=0;
        #1
        A = 100; B = 100; opcode=1;
        #1
        A = 20; B = 200; opcode=0;
        #1
        A = 100; B = 10; opcode=1;
        #1
        A = 100; B = 100; opcode=0;
        #1
        A = 20; B = 200; opcode=1;
        #20
        $finish;
    end
endmodule