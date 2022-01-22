module worm(clk,cur,steps,opcode,newvalue,ofl);
    input clk;
    input [4:0] cur;
    input [1:0] steps;
    input opcode;

    output reg [4:0] newvalue;
    output wire ofl;
    wire [4:0] new;

    five_bit_full_adder uut(cur,{1'b0,1'b0,1'b0,steps[1:0]},opcode,new,ofl);

    always @(posedge clk) begin
        #1
        case(ofl)
            1'b1: newvalue<=(opcode==1'b1)?5'b0:5'd15;
            1'b0: newvalue<=new;
        endcase
    end
endmodule