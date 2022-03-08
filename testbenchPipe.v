`include "wrap_pipe.v"
`default_nettype none

module tb_wrap;
reg clk;
reg rst_n;
wire [79:0]f_Byte;
wire signed [63:0]f_pc,f_predPC,D_valC,D_valP,E_valA,E_valB,M_valA,F_predPC,M_valE,W_valE,W_valM,e_valE,E_valC,d_valA,d_valB;
wire [3:0] f_icode,D_icode,D_ifun,D_rA,D_rB,E_icode,E_ifun,E_dstE,E_dstM,E_srcA,E_srcB,e_dstE,
M_icode,M_dstE,M_dstM,W_icode,W_dstE,W_dstM,d_dstE,d_dstM,d_srcA,d_srcB;
    wire M_Cnd,F_stall;
    wire [1:0]D_stat,E_stat,M_stat,W_stat;


y86wrapPipe Ypipe(
    f_Byte,f_pc,f_predPC,D_valC,D_valP,E_valA,E_valB,M_valA,F_predPC,M_valE,W_valE,W_valM,e_valE,E_valC,d_valA,d_valB,
    f_icode,D_icode,D_ifun,D_rA,D_rB,E_icode,E_ifun,E_dstE,E_dstM,E_srcA,E_srcB,
    M_icode,M_dstE,M_dstM,W_icode,W_dstE,W_dstM,d_dstE,d_dstM,d_srcA,d_srcB,e_dstE,
    M_Cnd,F_stall,
    D_stat,E_stat,M_stat,W_stat,
   clk
);

localparam CLK_PERIOD = 500;
always #(CLK_PERIOD/2) clk=~clk;
// always #(CLK_PERIOD/4) $display($time," clk=%d, f_pc=%d, f_predPC=%d, F_predPC=%d, f_icode=%d, D_icode=%d, E_icode=%d, M_icode=%d, W_icode=%d",
//     clk,
//     f_pc,
//     f_predPC,
//     F_predPC,
//     // f_Byte[79:0],
//     f_icode,
//     D_icode,
//     E_icode,
//     M_icode,
//     W_icode,
//     );
initial begin
    $dumpfile("tb_wrap.vcd");
    $dumpvars(0, tb_wrap);
    $monitor($time," clk=%d, f_pc=%d, f_icode=%d, D_icode=%d, d_valA=%d , d_valB=%d, d_dstE=%d, d_dstM=%d, d_srcA=%d, d_srcB=%d, E_icode=%d, e_dstE=%d, e_valE=%d, E_valC=%d, E_valA=%d, E_valB=%d",// M_icode=%d, W_icode=%d",
    clk,
    f_pc,
    // f_Byte[79:0],
    f_icode,
    D_icode,d_valA,d_valB,d_dstE,d_dstM,d_srcA,d_srcB,
    E_icode,e_dstE,e_valE,E_valC,E_valA,E_valB,
    // M_icode,
    // W_icode,
    );
    // PC<=64'd2;
    // stat<=2'b0;
end
// assign PC=temp;

initial begin 
    clk<=0;
        #10000;

    $finish(2);
end

endmodule
`default_nettype wire