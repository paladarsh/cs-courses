`define PROP_DELAY #2
`define MAX_PC 11
`define OUTPUT_REG 4

module data(clk,state,ra,instruction_invalid,opcode,rv);
    input clk;
    input instruction_invalid;
    input [2:0] state;
    input [7:0] ra;
    input [5:0] opcode;

    output reg [7:0] rv;

    reg signed [7:0] datafile [0:2];

    initial begin
        datafile[0]=-8'd20;
        datafile[1]=8'd10;
        datafile[2]=8'd2;
    end
    always @(posedge clk) begin
        if(state==4 && opcode==6'h23 && instruction_invalid==0) rv<= #2 datafile[ra];
        else rv<=ra;
    end
endmodule

