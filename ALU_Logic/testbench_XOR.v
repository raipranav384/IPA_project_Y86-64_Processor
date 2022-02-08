
module tb_;
wire signed[63:0]X;
reg signed [63:0]a;
reg signed [63:0]b;

 
XOR64 uut(
    .X(X),
    .a (a),
    .b(b)
);


initial begin
    $dumpfile("tb_XOR.vcd");
    $dumpvars(0, tb_);
end

initial begin
  //testcases of inputs provided in report
    /*    b<=0;
    $monitor($time," a=%b, b=%b, X=%b",a,b,X);
    for(integer i=0;i<10;i=i+1)
    begin
     a=1;
     b=b+1;
     #1;
    end;
    $finish;*/
    
    // testcases for random inputs
    $monitor($time," a=%b, b=%b, X=%b",a,b,X);
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
`default_nettype wire
