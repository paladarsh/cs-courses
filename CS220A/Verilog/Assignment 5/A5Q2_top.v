module min_of_four_top;

    reg [2:0] a,b,c,d;
    wire [1:0] result_index;

    min_of_four uut(a,b,c,d,result_index);

    always @(*)begin
        $display("Time:<%d> a=%b b=%b c=%b d=%b Index of minimum value:%d",$time,a,b,c,d,result_index);
    end

    initial begin
        #10
        $finish;
    end

    initial begin
        a=3'b110; b=3'b010; c=3'b001; d=3'b111;   
        #1
        a=3'b000; b=3'b001; c=3'b010; d=3'b111;   
        #1
        a=3'b110; b=3'b001; c=3'b001; d=3'b111;   
        #1
        a=3'b110; b=3'b010; c=3'b001; d=3'b111;   
        #1
        a=3'b111; b=3'b110; c=3'b101; d=3'b011;   
        #1
        a=3'b000; b=3'b001; c=3'b011; d=3'b111;   
        #1
        a=3'b100; b=3'b010; c=3'b001; d=3'b001;   
        #1
        a=3'b100; b=3'b011; c=3'b001; d=3'b001;   
        #1
        a=3'b111; b=3'b110; c=3'b101; d=3'b101;   
        #1
        a=3'b100; b=3'b010; c=3'b001; d=3'b001;   
    end
endmodule