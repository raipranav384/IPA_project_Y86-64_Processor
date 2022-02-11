`include "Split.v"
`include "Align.v"
`include "cover.v"
`default_nettype wire

module tb_Split;

wire [3:0]icode;
wire [3:0]ifun;
wire [3:0]rA;
wire [3:0]rB;
wire signed [63:0]valC; 
reg [79:0]Byte;
wire need_regids;
wire need_valC;
wire Instr_valid;
split uut2
(
    .icode(icode),
    .ifun(ifun),
    .Byte0(Byte[79:72])
);

wrap uut1
(
    .need_regids(need_regids),
    .need_valC(need_valC),
    .Instr_valid(Instr_valid),
    .icode(icode)
);
align uut 
(
    .rA(rA),
    .rB(rB),
    .valC(valC), 
    // .Byte191(Byte[0]),
    // .Byte192(Byte[1]),
    // .Byte193(Byte[2]),
    // .Byte194(Byte[3]),
    // .Byte195(Byte[4]),
    // .Byte196(Byte[5]),
    // .Byte197(Byte[6]),
    // .Byte198(Byte[7]),
    // .Byte199(Byte[8]),
    .Byte19(Byte[71:0]),
    .need_regids(need_regids)
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
    $monitor($time,"icode=%h ifun=%h rA=%h rB=%h valC=%d, need_regids=%b, needValC=%b",icode,ifun,rA,rB,valC,need_regids,need_valC);
    // $monitor($time," icode=%h ifun=%h rA=%h rB=%h",icode,ifun,rA,rB);

end

initial begin
    #1;
    Byte[79:72]<=8'b01010000;
    Byte[71:64]<=8'b00010101;
    Byte[63:56]<=8'b11110100;
    Byte[55:48]<='b11111111;
    Byte[47:40]<=8'b11111111;
    Byte[39:32]<=8'b11111111;
    Byte[31:24]<=8'b11111111;
    Byte[23:16]<=8'b11111111;
    Byte[15:8]<=8'b11111111;
    Byte[7:0]<=8'b11111111;
    // Byte[6]<=8'b11111111;
    // Byte[5]<=8'b11111111;
    // Byte[4]<=8'b11111111;
    // Byte[3]<=8'b11111111;
    // Byte[2]<=8'b11111111;
    // Byte[1]<=8'b11111111;
    // Byte[0]<=8'b11111111;
    #5;
    
    // integer val={>>{valC}};
end

endmodule
