module read(clk, row_no, input_valid, out_row, output_valid);

    input clk, input_valid;
    input [3:0] row_no;
    output [31:0] out_row;
    output output_valid;

    reg output_valid;
    reg [31:0] out_row;
    reg [3:0] open_row;
    reg [31:0] dram [15:0];

    initial begin
        open_row <= 4'd0000;
        output_valid <= 1'b0;
        // out_row=32'b0;
        dram[0]<=32'd0;
        dram[1]<=32'd1;
        dram[2]<=32'd2;
        dram[3]<=32'd3;
        dram[4]<=32'd4;
        dram[5]<=32'd5;
        dram[6]<=32'd6;
        dram[7]<=32'd7;
        dram[8]<=32'd8;
        dram[9]<=32'd9;
        dram[10]<=32'd10;
        dram[11]<=32'd11;
        dram[12]<=32'd12;
        dram[13]<=32'd13;
        dram[14]<=32'd14;
        dram[15]<=32'd15;   
    end

    always @(posedge clk) begin
        if(input_valid) begin
            if(open_row==4'b0000) begin                //After 1 cycle
                #10
                out_row <= dram[row_no];
                open_row <= row_no;
                output_valid <= 1'b1;
                //$display("Output Time: %d, Row No.: %d, Output: %d", $time,row_no,out_row);
            end

            else if(open_row==row_no) begin         //Same cycle
                output_valid<=1'b0;
                open_row <= row_no;
                out_row <= dram[row_no];
                output_valid <= 1'b1;
            end

            else if(open_row!=row_no) begin         //After 2 cycles
                #20
                output_valid <= 1'b0; 
                out_row <= dram[row_no];
                open_row <= row_no;
                output_valid <=1'b1;
            end
            // else $display("Good");
        end
    end

endmodule
