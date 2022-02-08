
module tb_AND;
wire signed [63:0]X;
reg signed [63:0]a;
reg signed [63:0]b;

 
AND64 uut(
    .X(X),
    .a (a),
    .b(b)
);


initial begin
    $dumpfile("tb_AND.vcd");
    $dumpvars(0, tb_AND);
end

initial begin
    $monitor($time," a=%b, b=%b, X=%b",a,b,X);
    //testcases of inputs provided in report
    /*    b<=0;
    for(integer i=0;i<10;i=i+1)
    begin
     a=1;
     b=b+1;
     #1;
    end;
    $finish;*/
    
    // testcases for random inputs
    for(integer i=0;i<300;i=i+1)
    begin
     a[31:0]=$urandom;
     a[63:32]=$random;
     b[31:0]=$urandom;
     b[63:32]=$random;
     #3;
    end;
    $finish;

end

endmodule
