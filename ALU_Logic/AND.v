module AND64 #(
    parameter N=64
)(
    output [N-1:0]X,
    input [N-1:0]a,
    input [N-1:0]b
);

    genvar i;
    generate
        
        for(i=0;i<N;i=i+1)
        begin
            and u(X[i],a[i],b[i]);
        end
    endgenerate

    
endmodule

