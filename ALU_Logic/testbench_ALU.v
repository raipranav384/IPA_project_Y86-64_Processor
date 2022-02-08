
module tb_4;
wire signed[63:0]OUT;
wire OF;

reg signed [63:0]a;
reg signed [63:0]b;
reg [1:0]c;

 
ALU uut(
    .OUT(OUT),
    .OF(OF),
    .a(a),
    .b(b),
    .c(c)
);


initial begin
    $dumpfile("tb_ALU.vcd");
    $dumpvars(0, tb_4);
end

initial begin
        // testcases used in the waveform
 /*  $monitor($time," c=%d a=%d, b=%d, OUT=%b",c,a,b,OUT);
    for(integer k=0;k<4;k=k+1)
    begin
        c=k;
        for(integer i=0;i<1;i=i+1)
        begin
            a<=5;
            for(integer j=0;j<=3;j=j+1)
            begin
                b=j+4;
                #2;
            end
        end
    end
    $finish(2);*/

        // testcases taken at random
    for(integer i=0;i<=10;i=i+1)
    begin
        a[31:0]=$urandom;
        a[63:32]=$random;
        for(integer j=0;j<=10;j=j+1)
        begin
            b[31:0]=$urandom;
            b[63:32]=$random;
            for(integer k=0;k<4;k=k+1)
            begin
                c=k;
                #3;
		$display($time," c=%d a=%d, b=%d, OUT=%d OF=%b",c,a,b,OUT,OF);
            end
        end
    end
    $finish(2);
end

endmodule
`default_nettype wire
