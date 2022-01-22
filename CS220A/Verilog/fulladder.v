module fulladder(a,b,c,sum,carry);
    input a,b,c;
    output sum,carry;
    wire sum,carry;
    assign sum=a^b^c; // sum bit
    assign carry=((a&b) | (b&c) | (a&c)); //carry bit
endmodule
module fulladder_top;
    reg a, b, c;
    // wire sum, carry;
    fulladder uut(a,b,c,sum,carry);
    always @(sum or carry)
        begin
            $display("time=%d: %b + %b + %b = %b, carry = %b\n",$time,a,b,c,sum,carry);
        end
        initial begin
            #40
            // #9.5 Still displays the values
            // #9.9
            $finish;
        end
    initial begin
        a = 0; b = 0; c = 0;
        #5
        a = 0; b = 1; c = 0;
        #5
        a = 1; b = 0; c = 1;
        // a = 1; assign b = a; c = 1;
        // a = 1; b = a; c = 1;
        #5
        a = 1; b = 1; c = 1;
    end
endmodule