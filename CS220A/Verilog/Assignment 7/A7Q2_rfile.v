`define MAX_PC 3'b111
`define OUTPUT_REG 3'd5

module register_file(clk, read1Addr, read2Addr, writeAddr, writeValue, read1Valid, read2Valid, writeValid, read1Value, read2Value);
    input clk;
    input [4:0] read1Addr;
    input [4:0] read2Addr;
    input [4:0] writeAddr;
    input [7:0] writeValue;
    input read1Valid;
    input read2Valid;
    input writeValid;
        
    output [7:0] read1Value;
    output [7:0] read2Value;
        
    reg [7:0] read1Value;
    reg [7:0] read2Value;
        
    reg [7:0] regfile [0:31];
    integer i;
    initial begin
        for(i=0; i<32; i=i+1) begin
            regfile[i]=0;
        end
    end

    always @ (posedge clk) begin
        if (read1Valid == 1)  read1Value <= regfile[read1Addr];
        if (read1Valid == 1)  read2Value <= regfile[read2Addr];
        if (writeValid == 1)  regfile[writeAddr] <= writeValue;
        // $display("time: %d one:%d two:%d three:%d four:%d five:%d six:%d",$time, regfile[1],regfile[2],regfile[3],regfile[4],regfile[5],regfile[6]);
    end
endmodule


