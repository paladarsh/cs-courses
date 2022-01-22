module eight_bit_adder_top;

    reg signed [7:0] A;
    reg signed [7:0] B;
    reg opcode;
    
    wire signed [7:0] sum;
    wire carry;
    
    eight_bit_full_calc uut(A,B,opcode,sum,carry,over_flow);

    always @(A or B or sum or carry or over_flow) begin
        $display("Time: <%d> A: %d(%b) B: %d(%b) Opcode: %b Sum: %d(%b) Cout: %b Overflow: %b\n",$time,A,A,B,B,opcode,sum,sum,carry,over_flow);
    end

    initial begin
        A = 100; B = 10; opcode = 0;
        #1
        A = -127; B = -127; opcode = 0;
        #1
        A = 20; B = 50; opcode=1;
        #1
        A = 10; B = -100; opcode=0;
        #1
        A = -100; B = 100; opcode=1;
        #1
        A = -20; B = 100; opcode=0;
        #1
        A = 100; B = 10; opcode=1;
        #1
        A = -100; B = 10; opcode=0;
        #1
        A = 20; B = -100; opcode=1;
        #1
        A = -20; B = -100; opcode=1;
        #20
        $finish;
    end
endmodule