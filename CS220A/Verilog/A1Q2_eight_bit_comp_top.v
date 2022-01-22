module eight_bit_comp_top;

    reg [7:0] A;
    reg [7:0] B;
    
    wire l,e,g;
    eight_bit_comp uut(A,B,l,e,g);

    always @(A or B or l or e or g) begin
        $display("Time: <%d> A: %d B: %d A Less: %d Equal: %b A Greater :%b\n",$time,A,B,l,e,g);
    end

    initial begin
        A = 100; B = 10;
        #1
        A = 100; B = 100;
        #1
        A = 20; B = 200;
        #1
        A = 100; B = 10;
        #1
        A = 100; B = 100;
        #1
        A = 20; B = 200;
        #1
        A = 100; B = 10;
        #1
        A = 100; B = 100;
        #1
        A = 20; B = 200;
        #1
        #20
        $finish;
    end
endmodule