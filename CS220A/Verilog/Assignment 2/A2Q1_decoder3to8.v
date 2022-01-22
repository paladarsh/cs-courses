module decode(in,out);
    input[2:0] in;
    wire [2:0] in;
    wire y;
    output [7:0] out;
    reg [7:0] out;
    assign y=8'b0;
    always @(in) begin
        out=8'b0;
        out[in]=1'b1;
    end
endmodule