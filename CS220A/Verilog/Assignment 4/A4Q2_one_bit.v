module one_bit_full_adder(a,b,cin,opcode,sum,cout);
    input a,b,cin,opcode;
    output sum,cout;
    wire x;
    wire sum,cout;
    assign x=b^opcode;
    assign sum = a ^ x ^ cin;
    assign cout = ((a&x)|(x&cin)|(cin&a));
endmodule