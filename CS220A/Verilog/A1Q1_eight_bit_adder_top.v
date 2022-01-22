module eight_bit_adder_top;

    reg [7:0] A;
    reg [7:0] B;
    reg cin;
    
    wire [7:0] sum;
    wire carry;


    eight_bit_full_adder uut(A,B,cin,sum,carry);

    always @(A or B or cin or sum or carry) begin
        $display("Time: <%d> A: %d B: %d Sum: %d Carry: %b\n",$time,A,B,sum,carry);
    end

    initial begin
        A = 100; B = 10; cin = 0;
        #2
        A = 100; B = 100; cin = 1;
        #2
        A = 20; B = 200; cin = 0;
        #2
        A = 100; B = 10; cin = 0;
        #2
        A = 100; B = 100; cin = 1;
        #2
        A = 20; B = 200; cin = 0;
        #1
        A = 100; B = 10; cin = 0;
        #1
        A = 100; B = 100; cin = 1;
        #1
        A = 20; B = 200; cin = 0;
        #20
        $finish;
    end
endmodule