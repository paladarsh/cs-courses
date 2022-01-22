module encode(in,out);
    input[7:0] in;
    output [2:0] out;
    reg [2:0] out;
    always @(in) begin
        out[2]=|(in[7:4]);
        out[1]=in[2]|in[3]|in[6]|in[7];
        out[0]=in[1]|in[3]|in[5]|in[7];
    end
endmodule