module pipe_reg (
    output [1:0]o_stat,
    output [3:0]o_icode,
    output [3:0]o_ifun,
    output o_cnd,
    output [3:0]o_rA,
    output [3:0]o_rB,
    output [63:0]o_valC,
    output [63:0]o_valM,
    output [63:0]o_valE,
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
    input [1:0]stat,
    input [3:0]icode,
    input [3:0]ifun,
    input cnd,
    input [3:0]rA,
    input [3:0]rB,
    input [63:0]valC,
    input [63:0]valM,
    input [63:0]valE,
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
    reg [482:0]pipeReg;

    initial begin
        pipeReg[79:16]<=64'd0;
    end
        assign o_stat      =pipeReg[482:481];
        assign o_icode     =pipeReg[480:477];
        assign o_ifun      =pipeReg[476:473];
        assign o_cnd       =pipeReg[472]    ;
        assign o_rA        =pipeReg[471:468];
        assign o_rB        =pipeReg[467:464];
        assign o_valC      =pipeReg[463:400];
        assign o_valE      =pipeReg[399:336];
        assign o_valM      =pipeReg[335:272];
        assign o_valA      =pipeReg[271:208];
        assign o_valB      =pipeReg[207:144];
        assign o_valP      =pipeReg[143:80] ;
        assign o_pred_PC   =pipeReg[79:16]  ;
        assign o_dstE      =pipeReg[15:12]  ;
        assign o_dstM      =pipeReg[11:8]   ;
        assign o_srcA      =pipeReg[7:3]    ;
        assign o_srcB      =pipeReg[3:0]    ;

    always @(posedge clk)
    begin
        if(~bubble&stall)
        begin
        pipeReg[482:481]<=pipeReg[482:481];
        pipeReg[480:477]<=pipeReg[480:477];
        pipeReg[476:473]<=pipeReg[476:473];
        pipeReg[472]    <=pipeReg[472]    ;
        pipeReg[471:468]<=pipeReg[471:468];
        pipeReg[467:464]<=pipeReg[467:464];
        pipeReg[463:400]<=pipeReg[463:400];
        pipeReg[399:336]<=pipeReg[399:336];
        pipeReg[335:272]<=pipeReg[335:272];
        pipeReg[271:208]<=pipeReg[271:208];
        pipeReg[207:144]<=pipeReg[207:144];
        pipeReg[143:80] <=pipeReg[143:80] ;
        pipeReg[79:16]  <=pipeReg[79:16]  ;
        pipeReg[15:12]  <=pipeReg[15:12]  ;
        pipeReg[11:8]   <=pipeReg[11:8]   ;
        pipeReg[7:3]    <=pipeReg[7:3]    ;
        pipeReg[3:0]    <=pipeReg[3:0]    ;
        end
        else if(~stall&bubble)
        begin
        pipeReg[482:481]<=stat;
        pipeReg[480:477]<=4'd1;
        pipeReg[476:473]<=4'd0;
        end
        else
        begin
        pipeReg[482:481]<=stat;
        pipeReg[480:477]<=icode;
        pipeReg[476:473]<=ifun;
        pipeReg[472]    <=cnd;
        pipeReg[471:468]<=rA;
        pipeReg[467:464]<=rB;
        pipeReg[463:400]<=valC;
        pipeReg[399:336]<=valE;
        pipeReg[335:272]<=valM;
        pipeReg[271:208]<=valA;
        pipeReg[207:144]<=valB;
        pipeReg[143:80] <=valP;
        pipeReg[79:16]  <=pred_PC;
        pipeReg[15:12]  <=dstE;
        pipeReg[11:8]   <=dstM;
        pipeReg[7:3]    <=srcA;
        pipeReg[3:0]    <=srcB;
        end
        //If this doesn't work for stall, add else if for that
    end
endmodule