`define PROP_DELAY #2
`define MAX_PC 11
`define OUTPUT_REG 4

module state_control(clk, program_counter, state);

    input clk;
    input [7:0] program_counter;

    output reg [2:0] state;
        
    initial begin
        state = 0;
    end
        
    always @ (posedge clk) begin
        if (state == 5) begin
            if(program_counter < `MAX_PC) state <= `PROP_DELAY 0;
            else state <= `PROP_DELAY 6;
        end
        else if (state!=6) begin
            state <= `PROP_DELAY state + 1;
        end
    end
endmodule
