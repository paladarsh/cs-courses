module string;
    reg [8*18:1] str;
    reg [5:0] ar;
    always@(str) begin
        $display("%s",str);
    end
    initial begin
        str="Hello Verilog Wor";
        #1
        $finish;
    end
endmodule