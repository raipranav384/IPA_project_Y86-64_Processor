`include "Split.v"
`include "Align.v"
`default_nettype wire

module tb_Split;

wire [3:0]icode;
wire [3:0]ifun;
wire [3:0]rA;
wire [3:0]rB;
wire [63:0]valC; 
reg [7:0]Byte[9:0];

split uut2
(
    .icode(icode),
    .ifun(ifun),
    .Byte0(Byte[9])
);

align uut 
(
    .rA(rA),
    .rB(rB),
    .valC(valC), 
    .Byte19(Byte),
    .need_regids()
);

// align uut 
// (
//     rA,
//     rB,
//     valC, 
//     Byte[1:9],
//     need_regids(0)
// );


// localparam CLK_PERIOD = 10;
// always #(CLK_PERIOD/2) clk=~clk;

initial begin
    $dumpfile("tb_Split.vcd");
    $dumpvars(0, tb_Split);
    $monitor($time,"icode=%h ifun=%h rA=%h rB=%h valC=%d",icode,ifun,rA,rB,valC);
    // $monitor($time," icode=%h ifun=%h rA=%h rB=%h",icode,ifun,rA,rB);

end

initial begin
    #1;
    Byte[9]<=8'b00110000;
    Byte[8]<=8'b00010101;
    Byte[7]<=8'b11110100;
    Byte[6]<=8'b11111111;
    Byte[5]<=8'b11111111;
    Byte[4]<=8'b11111111;
    Byte[3]<=8'b11111111;
    Byte[2]<=8'b11111111;
    Byte[1]<=8'b11111111;
    Byte[0]<=8'b11111111;
    #5;
    
    // integer val={>>{valC}};
end

endmodule
