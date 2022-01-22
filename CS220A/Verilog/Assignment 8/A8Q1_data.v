`define PROP_DELAY #2
`define MAX_PC 14
`define OUTPUT_REG 2

module data(clk,state,ra,instruction_invalid,opcode,rv);
    input clk;
    input instruction_invalid;
    input [2:0] state;
    input [7:0] ra;
    input [5:0] opcode;

    output reg [7:0] rv;

    reg signed [7:0] datafile [0:10];

    initial begin
        datafile[0]=8'd0;
        datafile[1]=8'd1;
        datafile[2]=8'd2;
        datafile[3]=8'd3;
        datafile[4]=8'd4;
        datafile[5]=8'd5;
        datafile[6]=8'd6;
        datafile[7]=8'd7;
        datafile[8]=8'd8;
        datafile[9]=8'd9;
        datafile[10]=8'd12;
    end
    always @(posedge clk) begin
        if(state==4 && opcode==6'h23 && instruction_invalid==0) rv<= #2 datafile[ra];
        else rv<=ra;
    end
endmodule