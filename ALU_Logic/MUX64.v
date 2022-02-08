module MUX64 (
    output [63:0]MuxOut,
    input [63:0]x0,
    input [63:0]x1,
    input [63:0]x2,
    input [63:0]x3,
    input [1:0]s
);
    generate
        for(genvar i=0;i<64;i=i+1)
        begin
            MUX4x1 M(MuxOut[i],x0[i],x1[i],x2[i],x3[i],s);
        end
    endgenerate
endmodule