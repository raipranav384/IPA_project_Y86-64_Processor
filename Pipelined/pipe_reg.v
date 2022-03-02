module pipe_reg (
    output o_stat,
    output [3:0]o_icode,
    output [3:0]o_ifun,
    output [2:0]o_cnd,
    output [3:0]o_rA,
    output [3:0]o_rB,
    output [63:0]o_valC,
    output [63:0]o_valA,
    output [63:0]o_valB,
    output [63:0]o_valP,
    output [63:0]o_pred_PC,
    output [3:0]o_dstE,
    output [3:0]o_dstM,
    output [3:0]o_srcA,
    output [3:0]o_srcB,
    input stall,
    input bubble,
    input stat,
    input [3:0]icode,
    input [3:0]ifun,
    input [2:0]cnd,
    input [3:0]rA,
    input [3:0]rB,
    input [63:0]valC,
    input [63:0]valA,
    input [63:0]valB,
    input [63:0]valP,
    input [63:0]pred_PC,
    input [3:0]dstE,
    input [3:0]dstM,
    input [3:0]srcA,
    input [3:0]srcB,
    input clk
);
    initial begin
        pipeReg[79:16]<=64'd0;
    end
    reg [355:0]pipeReg;
    always @(posedge clk)
    begin
        
        pipeReg[355]<=stat;
        pipeReg[354:351]<=icode;
        pipeReg[350:347]<=ifun;
        pipeReg[346:344]<=cnd;
        pipeReg[343:340]<=rA;
        pipeReg[339:336]<=rB;
        pipeReg[335:272]<=valC;
        pipeReg[271:208]<=valA;
        pipeReg[207:144]<=valB;
        pipeReg[143:80]<=valP;
        pipeReg[79:16]<=pred_PC;
        pipeReg[15:12]<=dstE;
        pipeReg[11:8]<=dstM;
        pipeReg[7:3]<=srcA;
        pipeReg[3:0]<=srcB;
    end
        
        assign o_stat      =pipeReg[355];
        assign o_icode     =pipeReg[354:351];
        assign o_ifun      =pipeReg[350:347];
        assign o_cnd       =pipeReg[346:344];
        assign o_rA        =pipeReg[343:340];
        assign o_rB        =pipeReg[339:336];
        assign o_valC      =pipeReg[335:272];
        assign o_valA      =pipeReg[271:208];
        assign o_valB      =pipeReg[207:144];
        assign o_valP      =pipeReg[143:80];
        assign o_pred_PC   =pipeReg[79:16];
        assign o_dstE      =pipeReg[15:12];
        assign o_dstM      =pipeReg[11:8];
        assign o_srcA      =pipeReg[7:3];
        assign o_srcB      =pipeReg[3:0];
endmodule