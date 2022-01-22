module one_bit_comp(a,b,lin,ein,gin,lout,eout,gout);

    input a,b,lin,ein,gin;
    
    output lout,eout,gout;
    reg lout,eout,gout;

    always @* begin
        if(lin==1'b1) begin
            lout <= lin;
            gout <= 1'b0;
            eout <= 1'b0;
        end

        else if(gin==1'b1) begin
            lout <= 1'b0;
            gout <= gin;
            eout <= 1'b0;
        end
        
        else if(ein==1'b1) begin
            lout <= ~a & b;
            gout <= a & ~b;
            eout <= (~a & ~b) + (a & b);
        end
    end
    
endmodule

