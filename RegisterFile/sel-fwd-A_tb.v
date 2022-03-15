`include "sel-fwd-A.v"

module fwd_sel_tb;

    wire [63:0]d_valA;
    reg [3:0]D_icode;
    reg [63:0]D_valP;
    reg [63:0]d_rvalA;
    reg [3:0]d_srcA;
    reg [63:0]W_valE;
    reg [3:0]W_dstE;
    reg [63:0]W_valM;
    reg [3:0]W_dstM;
    reg [63:0]m_valM;
    reg [3:0]M_dstM;
    reg [63:0]M_valE;
    reg [3:0]M_dstE;
    reg [63:0]e_valE;
    reg [3:0]e_dstE;

fwd_sel uut
(
    .d_valA(d_valA),
    .D_icode(D_icode),
    .D_valP(D_valP),
    .d_rvalA(d_rvalA),
    .d_srcA(d_srcA),
    .W_valE(W_valE),
    .W_dstE(W_dstE),
    .W_valM(W_valM),
    .W_dstM(W_dstM),
    .m_valM(m_valM),
    .M_dstM(M_dstM),
    .M_valE(M_valE),
    .M_dstE(M_dstE),
    .e_valE(e_valE),
    .e_dstE(e_dstE)
);

initial begin
    $dumpfile("fwd_sel_tb.vcd");
    $dumpvars(0, fwd_sel_tb);
    $monitor("d_valA=%d D_icode=%h D_valP=%d d_rvalA=%d d_srcA=%h W_valE=%d W_dstE=%h W_valM=%d W_dstM=%h m_valM=%d M_DstM=%h M_valE=%d M_dstE=%h e_valE=%d e_dstE=%h",d_valA,
    D_icode,D_valP,d_rvalA,d_srcA,W_valE,W_dstE,W_valM,W_dstM,m_valM,M_dstM,M_valE,M_dstE,e_valE,e_dstE);
end

initial begin
    D_icode<=8;
    D_valP<=64'd125;
    d_rvalA<=64'd22;
    d_srcA<=4'd7;
    W_valE<=64'd14;
    W_dstE<=4'd7;
    W_valM<=64'd30;
    W_dstM<=4'd7;
    m_valM<=64'd2;
    M_dstM<=4'd4;
    M_valE<=64'd10;
    M_dstE<=4'd5;
    e_valE<=64'd7;
    e_dstE<=4'd12;

end    
endmodule