`define MAX_PC 3'b111
`define OUTPUT_REG 3'd5

module processor(clk, read1Addr, read2Addr, writeAddr, writeValue, read1Valid, read2Valid, writeValid, shift_amount, read1Value, read2Value);
   input clk;
   input [4:0] read1Addr;
   input [4:0] read2Addr;
   input [4:0] writeAddr;
   input [7:0] writeValue;
   input read1Valid;
   input read2Valid;
   input writeValid;
   input [4:0] shift_amount;

   output [7:0] read1Value;
   output [7:0] read2Value;

   wire [7:0] read1Value;
   wire [7:0] read2Value;

   register_file RF(clk, read1Addr, read2Addr, writeAddr, writeValue, read1Valid, read2Valid, writeValid, read1Value, read2Value);

endmodule

module adder(clk,first,second,instr,result);
    input clk;
    input [7:0] first;
    input [7:0] second;
    input [1:0] instr;
    output reg [7:0] result;
    always @(posedge clk) begin
        case(instr)
            2'd1,2'd3: result=first+second;
            2'd2: result=first-second;
        endcase
    end
endmodule
