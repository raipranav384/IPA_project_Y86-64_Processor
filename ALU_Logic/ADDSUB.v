//`include "./FA.v";

module ADDSUB #(
    parameter N=64
)(
    output [N-1:0]S,
    output OF,
    input [N-1:0]a,
    input [N-1:0]b,
    input M
);

    wire [N:0]c;
    assign c[0]=M;
    genvar i;
    generate
        for(i=0;i<N;i=i+1)
        begin
            wire tmp;
            xor t(tmp,b[i],M);
            FA F(S[i],c[i+1],a[i],tmp,c[i]);
        end
    endgenerate
    xor (OF,c[N],c[N-1]);

    
endmodule