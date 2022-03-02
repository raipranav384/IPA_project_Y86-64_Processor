`include "wrap.v"
`default_nettype none

module tb_wrap;
reg clk;
reg rst_n;
reg [63:0]temp;
    wire [63:0]PC;
    wire signed [63:0]valM,valE,valC,valP,valA,valB;
    wire [3:0] icode,ifun,rA,rB;
    wire [1:0]stat;
    wire cnd,imem_err,Instr_valid,need_regids,need_valC;
    wire [79:0]Byte;


y86wrap uut(
    Byte,
    valM,valE,valC,valP,valA,valB,
    icode,ifun,rA,rB,
    cnd,imem_err,Instr_valid,need_regids,need_valC,
    stat,
    PC,
    clk
);

localparam CLK_PERIOD = 500;
always #(CLK_PERIOD/2) clk=~clk;
// always #(CLK_PERIOD/4) $display($time," clk=%d, PC=%d, valM=%d, valE=%d, valC=%d, valP=%d, valA=%d, valB=%d, icode=%d, ifun=%d, rA=%d, rB=%d, need_reg=%b, stat=%d",clk,PC,valM,valE,valC,valP,valA,valB,icode,ifun,rA,rB,need_regids,stat);
initial begin
    $dumpfile("tb_wrap.vcd");
    $dumpvars(0, tb_wrap);
    $monitor($time," clk=%d, icode=%d, ifun=%d, PC=%d, valM=%d, valE=%d, valC=%d, valP=%d, valA=%d, valB=%d, rA=%d, rB=%d, need_reg=%b, stat=%d",clk,icode,ifun,PC,valM,valE,valC,valP,valA,valB,rA,rB,need_regids,stat);
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