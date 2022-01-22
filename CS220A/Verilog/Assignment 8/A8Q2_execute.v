`define PROP_DELAY #2
`define MAX_PC 11
`define OUTPUT_REG 4

module execute(clk, state, opcode, rsv, rtv, imm, jt, func, result, instruction_invalid,PC);

    input clk;
    input [2:0] state;
    input [5:0] opcode;
    input [7:0] rsv;
    input [7:0] rtv;
    input [15:0] imm;
    input [25:0] jt;
    input [5:0] func;
        
    output reg [7:0] result;
    output reg instruction_invalid;
    output reg [7:0] PC;
        
    initial begin
        instruction_invalid = 1;
        PC=8'd0;
    end
	
    always @ (posedge clk) begin
        if(state==3) begin
            instruction_invalid = 0;
            case(opcode)
                //addiu, lw
                6'h9,6'h23: begin
                    result<= #2 rsv+imm[7:0];
                    PC<= #2 PC+1;
                end
                //beq,bne
                6'h4: PC<= #2 PC+((rsv==rtv)?imm[7:0]:1);
                6'h5: PC<= #2 PC+((rsv!=rtv)?imm[7:0]:1);
                //jal
                6'h3: begin
                    result<= #2 PC+1;
                    PC <= #2 jt[7:0];
                end
                6'h0: begin
                    case(func)
                        //slt
                        6'h2a: begin
                            result<= (($signed(rsv)<$signed(rtv))?1:0);
                            PC<= #2 PC+1;
                        end
                        //addu
                        6'h21: begin
                            result<=#2 rsv+rtv;
                            PC<= #2 PC+1;
                        end
                        //jr
                        6'h8: PC<= #2 rsv;

                        default: begin
                            PC <= #2 `MAX_PC;
                            instruction_invalid=1;
                        end
                    endcase
                end
                default: begin
                    PC <= #2 `MAX_PC;
                    instruction_invalid=1;
                end
            endcase
        end
        // $display("%d: state:%d opcode:%h rs:%d rt:%d imm:%d func:%d result: %d",$time, state, opcode,rsv,rtv,imm,func,result);
        // $display("%d %d", $time,result);
    end
endmodule

