module A11Q2_top;
    reg clk;
    reg [31:0] dividend;
    reg [31:0] dividendArr [0:9];
    reg [31:0] divisor;
    reg [31:0] divisorArr [0:9];
    reg [31:0] quotient;
    reg [31:0] remainder;
    reg [4:0] ldividend;
    reg [4:0] ldividendArr [0:9];
    reg [4:0] ldivisor;
    reg [4:0] ldivisorArr [0:9];
    reg [5:0] adds;
    reg [5:0] subs;
    reg done;
    reg newinput;
    reg checker;
    reg [3:0] ctr;


    always @ (negedge clk) begin
        //$display(" Time=%d, Done=%d", $time, done);
        if (done==1) begin
            $display("\n Dividend=%d, Divisor=%d, Quotient=%d, Remainder=%d, No. of Additions=%d, No. of Subtractions=%d", dividend, divisor, quotient, remainder, adds, subs);
            //$finish;
            if (ctr<9) begin
                ctr=ctr+1;
                dividend=dividendArr[ctr];
                divisor=divisorArr[ctr];
                ldividend=ldividendArr[ctr];
                ldivisor=ldivisorArr[ctr];
                newinput=1;
                checker=1;
            end
            else
                $finish;
        end

        if(checker==0)
            newinput=0;
    end


   initial begin
        clk=0;
        forever begin
            #5
            clk=1;
            #5
            clk=0;
        end
    end

    initial begin // User Input here
        ctr=0;
        dividendArr[0]=234;     divisorArr[0]=31;     ldividendArr[0]=8;      ldivisorArr[0]=5;
        dividendArr[1]=1245;    divisorArr[1]=65;     ldividendArr[1]=11;     ldivisorArr[1]=7;
        dividendArr[2]=12;      divisorArr[2]=31;     ldividendArr[2]=4;      ldivisorArr[2]=5;
        dividendArr[3]=74;      divisorArr[3]=9;      ldividendArr[3]=7;      ldivisorArr[3]=4;

        dividendArr[4]=2020;    divisorArr[4]=100;    ldividendArr[4]=11;     ldivisorArr[4]=7;
        dividendArr[5]=50;      divisorArr[5]=10;     ldividendArr[5]=6;      ldivisorArr[5]=4;
        dividendArr[6]=333;     divisorArr[6]=3;      ldividendArr[6]=9;      ldivisorArr[6]=2;
        dividendArr[7]=999;     divisorArr[7]=999;    ldividendArr[7]=10;     ldivisorArr[7]=10;
        dividendArr[8]=100;     divisorArr[8]=1;      ldividendArr[8]=7;      ldivisorArr[8]=1;
        dividendArr[9]=294967295;divisorArr[9]=999;   ldividendArr[9]=29;     ldivisorArr[9]=10;

        // dividendArr[0]=32'd20;
        // dividendArr[1]=32'd22;
        // dividendArr[2]=32'd36;
        // dividendArr[3]=32'd52;
        // dividendArr[4]=32'd70;
        // dividendArr[5]=32'd90;
        // dividendArr[6]=32'd112;
        // dividendArr[7]=32'd136;
        // dividendArr[8]=32'd162;
        // dividendArr[9]=32'd190;

        // divisorArr[0]=32'd10;
        // divisorArr[1]=32'd11;
        // divisorArr[2]=32'd12;
        // divisorArr[3]=32'd13;
        // divisorArr[4]=32'd14;
        // divisorArr[5]=32'd15;
        // divisorArr[6]=32'd16;
        // divisorArr[7]=32'd17;
        // divisorArr[8]=32'd18;
        // divisorArr[9]=32'd19;

        // ldividendArr[0]=6'd5;
        // ldividendArr[1]=6'd5;
        // ldividendArr[2]=6'd6;
        // ldividendArr[3]=6'd6;
        // ldividendArr[4]=6'd7;
        // ldividendArr[5]=6'd7;
        // ldividendArr[6]=6'd7;
        // ldividendArr[7]=6'd8;
        // ldividendArr[8]=6'd8;
        // ldividendArr[9]=6'd8;

        // ldivisorArr[0]=6'd4;
        // ldivisorArr[1]=6'd4;
        // ldivisorArr[2]=6'd4;
        // ldivisorArr[3]=6'd4;
        // ldivisorArr[4]=6'd4;
        // ldivisorArr[5]=6'd4;
        // ldivisorArr[6]=6'd5;
        // ldivisorArr[7]=6'd5;
        // ldivisorArr[8]=6'd5;
        // ldivisorArr[9]=6'd5;
        
        dividend=dividendArr[ctr]; //first input from here
        divisor=divisorArr[ctr];
        ldividend=ldividendArr[ctr];
        ldivisor=ldivisorArr[ctr];
        newinput=1;
    end

    reg [4:0] curindex=0;
    reg currentoperation=0;
    reg [31:0] origdivisor;

    always @( posedge clk ) begin
        if (newinput || currentoperation) begin

            if (newinput) begin // first cycle
                done=0;
                curindex=0;
                currentoperation=1;
                adds=0;
                subs=0;
                quotient=0;
                remainder=dividend;
                origdivisor=divisor;
                checker=0;
                if (dividend>=divisor)
                    divisor=divisor<<(ldividend-ldivisor);
                else begin // check this condition
                    done=1;
                    currentoperation=0;
                end

                //$display("\n --> Dividend=%b, Divisor=%b, Quotient=%b, Remainder=%b", dividend, divisor, quotient, remainder);
                
            end

            else begin

                if(remainder[31]==1) begin // remainder < 0
                    remainder=remainder+divisor;
                    adds=adds+1;
                    quotient=(quotient ^ 1'b1);
                end
                else begin
                    remainder=remainder-divisor;
                    subs=subs+1;
                end
                
                //$display("\n -->   Dividend=%b, Divisor=%b, Quotient=%b, Remainder=%b", dividend, divisor, quotient, remainder);
                quotient=(quotient<<1) | 1;
                divisor=divisor>>1;
                curindex=curindex+1;
                
                //$display(" ----> Dividend=%b, Divisor=%b, Quotient=%b, Remainder=%b", dividend, divisor, quotient, remainder);
                if (curindex==(ldividend-ldivisor+1)) begin // replace with termination condition
                    currentoperation=0;
                    divisor=origdivisor;
                    if(remainder[31]==1) begin // remainder < 0
                        remainder=remainder+divisor;
                        adds=adds+1;
                        quotient=(quotient ^ 1'b1);
                    end
                    done=1;
                end
                
            end
        end
    end


endmodule