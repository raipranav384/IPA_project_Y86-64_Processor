`include "registerfile2.v"
`include "dst_srcLogic.v"

`default_nettype none

module tb_registerfile2;
    wire [63:0]valA;
    wire [63:0]valB;
    reg [63:0]valM;
    reg [63:0]valE;
    reg [3:0]icode;
    reg clk;
    reg [3:0]rA;
    reg [3:0]rB;
    wire [3:0]dstE,dstM,srcA,srcB;
    reg cnd;

RegFile uut1
(
    valA,
    valB,
    valM,
    valE,
    srcA,srcB,dstE,dstM,
    clk
);

dst_src uut2(
    .dstE(dstE),.dstM(dstM),.srcA(srcA),.srcB(srcB),
    .icode(icode),
    .rA(rA),.rB(rB),
    .cnd(1'b1)
);

localparam CLK_PERIOD = 10;
always #(CLK_PERIOD/2) clk=~clk;

initial begin
    $dumpfile("tb_registerfile2.vcd");
    $dumpvars(0, tb_registerfile2);
    $monitor($time,"clk=%d, valA=%d ,valB=%d ,srcA=%d ,srcB=%d ,dstE=%d ,dstM=%d",clk,valA,valB,srcA,srcB,dstE,dstM);
end

initial begin
    clk<=1'b0;
    icode<=4'd6;
    #1 rA<=4'd2;
    rB<=4'd3;
    valE<=64'd5;
    #(CLK_PERIOD) rB<=4'd2;
    #(CLK_PERIOD) valE<=4'd6;
    #(CLK_PERIOD) rB<=4'd3;

    
    #500;
    $finish(2);
end

endmodule
`default_nettype wire