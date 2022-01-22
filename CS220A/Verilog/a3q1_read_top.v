module read_top;

    wire output_valid;
    reg clk, input_valid, in_time;
    wire [31:0] out_row;
    reg [3:0] row_no;

    read UUT(clk, row_no, input_valid, out_row, output_valid);  

    always @(posedge output_valid) begin
        // if(output_valid==1'b1) begin
            $display("Input valid: %b, Output Time: %d, Row No.: %d, Output: %d",input_valid, $time,row_no,out_row);
        // end
    end

    initial begin
        #3
        input_valid <= 1'b1; row_no <= 4'd2;
        #10
        input_valid <= 1'b0;
        #10
        input_valid <= 1'b0;
        #10
        input_valid <= 1'b1; row_no <= 4'd4; 
        #10
        input_valid <= 1'b0;
        #10
        input_valid <= 1'b0;
        #10
        input_valid <= 1'b1; row_no <= 4'd1;
        #10
        input_valid <= 1'b0;
        #10
        input_valid <= 1'b0;
        #10
        input_valid <= 1'b1; row_no <= 4'd6; 
        #10
        input_valid <= 1'b0;
        #10
        input_valid <= 1'b0;
        #10
        input_valid <= 1'b1; row_no <= 4'd9; 
        #10
        input_valid <= 1'b0;
        #10
        input_valid <= 1'b0;
        #10
        input_valid <= 1'b1; row_no <= 4'd11;
        #50
        $finish;
    end

    initial begin
        forever begin
            clk=0;
            #5
            clk=1;
            #5
            clk=0;   
        end
    end
endmodule