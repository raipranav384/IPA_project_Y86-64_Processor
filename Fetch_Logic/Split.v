module split (
    output [3:0]icode,
    output [3:0]ifun,
    input [7:0]Byte0
);

    assign icode=Byte0[7:4];
    assign ifun=Byte0[3:0];
    
endmodule