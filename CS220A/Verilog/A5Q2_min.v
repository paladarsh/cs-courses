module min_of_four(a,b,c,d,result_index);

    input [2:0] a,b,c,d;
    
    output [1:0] result_index;
    reg [1:0] result_index;

    reg [2:0] min_value;
    always @(a or b or c or d) begin
        result_index = 2'b00;
        min_value = a;
       if(b<min_value) begin
           min_value = b;
           result_index = 2'b01;
       end 
       if(c<min_value) begin
           min_value = c;
           result_index = 2'b10;
       end
       if(d<min_value) begin
           min_value = d;
           result_index = 2'b11;
       end
    end
endmodule