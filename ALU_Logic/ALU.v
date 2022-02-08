module ALU #(
    parameter N=64
)(
    output reg [N-1:0]OUT,
    output [2:0]CF, //CF[0]=OF;CF[1]=ZF;CF[2]=SF
    input [N-1:0]a,
    input [N-1:0]b,
    input [1:0]c
);
    wire [63:0]OUT1,OUT2,OUT3;

    ADDSUB #(.N(N)) A1(OUT1,tmp,a,b,c[0]);
    AND64 #(.N(N)) A2(OUT2,a,b);
    XOR64 #(.N(N)) A3(OUT3,a,b);
    not (cbar,c[1]);
    and (CF[0],tmp,cbar);
    always @*
    begin
        case(c)
            2'b00: OUT=OUT1;
            2'b01: OUT=OUT1;
            2'b10: OUT=OUT2;
            2'b11: OUT=OUT3;
        endcase
        CF[1]=OUT==0?1:0;
        CF[2]=(OUT[N-1]==1)?1:0;
        
    end

endmodule