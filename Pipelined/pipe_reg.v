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
    input [3:0]dstE,
    input [3:0]dstM,
    input [3:0]srcA,
    input [3:0]srcB
);
    reg [292:0]pipeReg;
    always @(posedge clk)
    begin
        pipeReg[292]<=stall;
        pipeReg[291]<=bubble;
        pipeReg[290:287]<=icode;
        pipeReg[286:283]<=ifun;
        pipeReg[282:280]<=cnd;
        pipeReg[279:276]<=rA;
        pipeReg[275:272]<=rB;
        pipeReg[271:208]<=valC;
        pipeReg[207:144]<=valA;
        pipeReg[143:80]<=valB;
        pipeReg[79:16]<=valP;
        pipeReg[15:12]<=dstE;
        pipeReg[11:8]<=dstM;
        pipeReg[7:3]<=srcA;
        pipeReg[3:0]<=srcB;
    end
        assign o_stall=pipeReg[292];
        assign o_bubble=pipeReg[291];
        assign o_icode=pipeReg[290:287];
        assign o_ifun=pipeReg[286:283];
        assign o_cnd=pipeReg[282:280];
        assign o_rA=pipeReg[279:276];
        assign o_rB=pipeReg[275:272];
        assign o_valC=pipeReg[271:208];
        assign o_valA=pipeReg[207:144];
        assign o_valB=pipeReg[143:80];
        assign o_valP=pipeReg[79:16];
        assign o_dstE=pipeReg[15:12];
        assign o_dstE=pipeReg[11:8];
        assign o_srcA=pipeReg[7:3];
        assign o_srcB=pipeReg[3:0];
endmodule