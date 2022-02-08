
module tb_2;
wire signed [63:0]S;
wire OF;

reg signed [63:0]a;
reg signed [63:0]b;
reg M;

 
ADDSUB uut(
    .S(S),
    .OF(OF),
    .a (a),
    .b(b),
    .M(M)
);


initial begin
    $dumpfile("tb_ADDSUB.vcd");
    $dumpvars(0, tb_2);
end

initial begin
        // testcases used in the waveform
//    $monitor($time," M=%b a=%b, b=%b, S=%b",M,a,b,S);
//     for(integer k=0;k<=1;k=k+1)
//     begin
//         M=k;
//         for(integer i=0;i<1;i=i+1)
//         begin
//             a<=3;
//             for(integer j=0;j<=4;j=j+1)
//             begin
//                 b=j;
//                 #1;
//             end
//         end
//     end
//     $finish(2);
    

        // testcases taken at random    
    for(integer i=0;i<=10;i=i+1)
    begin
        a[31:0]=$urandom;
        a[63:32]=$random;
        for(integer j=0;j<=10;j=j+1)
        begin
            b[31:0]=$urandom;
            b[63:32]=$random;
            for(integer k=0;k<=1;k=k+1)
            begin
                $display(" M=%b a=%b, b=%b, S=%b",M,a,b,S);
                M=k;
                #3;
            end
        end
    end
    $finish(2);
end

endmodule
`default_nettype wire