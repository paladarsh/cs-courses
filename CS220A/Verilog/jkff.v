/* MODULE TO SIMULATE A JK FLIP-FLOP WITH
DIRECT RESET */
`define TICK #2 //Flip-flop time delay 2 units
module jkflop(j,k,clk,rst,q);
input j,k,clk,rst;
output q;
reg q;

// module jkflop continues
always @(posedge clk)begin
    if(j==1 & k==1)begin
        q <=`TICK ~q; //Toggles
    end
    else if(j==1 & k==0)begin
        q <= `TICK 1; //Set
    end
    else if(j==0 & k==1)begin
        q <= `TICK 0; //Cleared
    end
end
always @(posedge rst)begin
    q <= 0; //The reset normally has negligible delay and hence ignored.
end
endmodule

/* ENVIRONMENT FOR JK FLIP-FLOP */
module jkflop_top;
reg j,k,clk,rst;
wire q;
jkflop uut(j,k,clk,rst,q); // Unit under test
//Always at rising edge of clock display the status of flip-flop
always @(posedge clk)begin
    $display("<%d>: j=%b,k=%b,clk=%b,rst=%b,q=%b",$time,j,k,clk,rst,q);
end

//Module to generate clock with period 10 time units
initial begin
    forever begin
        clk=0;
        #5
        clk=1;
        #5
        clk=0;
    end
end
//Sample test values to run simulation (module jkflop_top continues)
initial begin
    j=0; k=0; rst=1;
    #4
    j=1; k=1; rst=0;
    #50
    j=0; k=1; rst=0;
    #20
    j=1; k=1; rst=0;
end
//Carry out simulation for 100 units of time
initial begin
    #100
    $finish;
end
endmodule