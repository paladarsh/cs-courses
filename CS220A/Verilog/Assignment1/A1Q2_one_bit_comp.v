module one_bit_compare(a,b,lin,ein,gin,l,e,g);
    input a,b,lin,ein,gin;
    output l,e,g;
    reg l,e,g;
    always @(a or b or lin or ein or gin) begin
        if(lin==1'b1) begin
            l=1'b1; e=1'b0; g=1'b0;
        end
        else if(gin==1'b1) begin
            l=1'b0; e=1'b0; g=1'b1;
        end
        else if(a<b) begin
            l=1'b1; e=1'b0; g=1'b0;
        end
        else if(a==b) begin
            l=1'b0; e=1'b1; g=1'b0;
        end
        else begin
            l=1'b0; e=1'b0; g=1'b1;
        end
    end
endmodule