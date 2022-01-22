module main;
reg a,b;
reg clk;
always@(a or b) begin
    $display("time=%d: %b + %b ; clk= %b\n",$time,a,b,clk);
end
initial begin
    #10
    $finish;
end
initial begin
    a=1'b0;
    b=1'b0;
end
initial begin
    forever begin
        clk=1;
        #1
        clk=0;
        #1
        clk=1;
    end
end
always @(posedge clk) begin
    // $display("positive: %d\n",$time);
    a<=#1 1'b1;
    b<=#1 a;
end
endmodule