module ALU (
    output [63:0]OUT,
    output OF,
    input [63:0]a,
    input [63:0]b,
    input [1:0]c
);
    wire [63:0]OUT1,OUT2,OUT3;

    ADDSUB A1(OUT1,tmp,a,b,c[0]);
    AND64 A2(OUT2,a,b);
    XOR64 A3(OUT3,a,b);
    not (cbar,c[1]);
    and (OF,tmp,cbar);
    
    MUX64 X(OUT,OUT1,OUT1,OUT2,OUT3,c);

endmodule