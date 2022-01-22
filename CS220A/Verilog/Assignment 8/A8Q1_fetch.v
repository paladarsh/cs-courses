
`define PROP_DELAY #2
`define MAX_PC 14
`define OUTPUT_REG 2

module fetch(clk, state, program_counter, instruction);
    input clk;
    input [2:0] state;
    input [7:0] program_counter;
        
    output reg [31:0] instruction;
        
    reg [31:0] instruction_mem [0:13];

    initial begin
        instruction = 0;
        instruction_mem[0] = {6'h9,5'd0,5'd2,16'd0};
        instruction_mem[1] = {6'h9,5'd0,5'd3,16'd0};
        instruction_mem[2] = {6'h0,5'd3,5'd1,5'd4,5'd0,6'h2a};
        instruction_mem[3] = {6'h4,5'd4,5'd0,16'd8};
        instruction_mem[4] = {6'h9,5'd0,5'd5,16'd10};
        instruction_mem[5] = {6'h4,5'd3,5'd5,16'd6};
        instruction_mem[6] = {6'h23,5'd3,5'd6,16'd0};
        instruction_mem[7] = {6'h0,5'd2,5'd6,5'd2,5'd0,6'h21};
        instruction_mem[8] = {6'h9,5'd3,5'd3,16'd1};
        instruction_mem[9] = {6'h0,5'd3,5'd1,5'd4,5'd0,6'h2a};
        instruction_mem[10] = {6'h5,5'd4,5'd0,-16'd5};
        instruction_mem[11] = {6'h0,5'd31,5'd0,5'd0,5'd0,6'h8};
        instruction_mem[12] = {6'h23,5'd0,5'd1,16'd10};
        instruction_mem[13] = {6'h3,26'd0};
    end
        
    always @ (posedge clk) begin
        if (state == 0) begin
            instruction <= `PROP_DELAY instruction_mem[program_counter];
        end
    end
endmodule