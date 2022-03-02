`include "Fetch_Logic/inst_mem.v"
`include "Fetch_Logic/Split1.v"
`include "Fetch_Logic/Align.v"
`include "Fetch_Logic/predict_pc.v"
`include "Fetch_Logic/select_pc.v"
`include "Fetch_Logic/pc_increment.v"
`include "ALU_Logic/ALU_func.v"
`include "RegisterFile/registerfile1.v"
`include "Data_mem/Data_memWrap.v"
`include "PC_update/PC_update.v"
`include "Pipelined/Pipeline_logic.v"
`include "Pipelined/pipe_reg.v"



module y86wrap (
    output [79:0]Byte,
    output [63:0]valM,valE,valC,valP,valA,valB,
    output [3:0] icode,ifun,rA,rB,
    output cnd,imem_err,Instr_valid,need_regids,need_valC,
    output [1:0]stat,
    output [63:0]PCt,
    input clk
);

reg [7:0]in; //for loading to the instruction memory

wire [79:0]Byte;
wire [63:0]PC;

// Required Wires
//for fetch
    wire F_stall,F_bubble,F_stat;
    wire [3:0]F_icode;
    wire [3:0]F_ifun;
    wire [2:0]F_cnd;
    wire [3:0]F_rA;
    wire [3:0]F_rB;
    wire [63:0]F_valC;
    wire [63:0]F_valA;
    wire [63:0]F_valB;
    wire [63:0]F_valP;
    wire [3:0]F_dstE;
    wire [3:0]F_dstM;
    wire [3:0]F_srcA;
    wire [3:0]F_srcB;

    //for execute
    wire D_stall,D_bubble,D_stat;
    wire [3:0]D_icode;
    wire [3:0]D_ifun;
    wire [2:0]D_cnd;
    wire [3:0]D_rA;
    wire [3:0]D_rB;
    wire [63:0]D_valC;
    wire [63:0]d_valA;
    wire [63:0]d_valB;
    wire [63:0]D_valP;
    wire [3:0]d;
    wire [3:0]d;
    wire [3:0]D_srcA;
    wire [3:0]D_srcB;

    //for execute
    wire E_stall,E_bubble,E_stat;
    wire [3:0]E_icode;
    wire [3:0]E_ifun;
    wire [2:0]E_cnd;
    wire [3:0]E_rA;
    wire [3:0]E_rB;
    wire [63:0]E_valC;
    wire [63:0]E_valA;
    wire [63:0]E_valB;
    wire [63:0]E_valP;
    wire [3:0]E_dstE;
    wire [3:0]E_dstM;
    wire [3:0]E_srcA;
    wire [3:0]E_srcB;

    //for memory
    wire M_stall,M_bubble,M_stat;
    wire [3:0]M_icode;
    wire [3:0]M_ifun;
    wire [2:0]M_cnd;
    wire [3:0]M_rA;
    wire [3:0]M_rB;
    wire [63:0]M_valC;
    wire [63:0]M_valA;
    wire [63:0]M_valB;
    wire [63:0]M_valP;
    wire [3:0]M_dstE;
    wire [3:0]M_dstM;
    wire [3:0]M_srcA;
    wire [3:0]M_srcB;

    //for Write back
    wire W_stall,W_bubble,W_stat;
    wire [3:0]W_icode;
    wire [3:0]W_ifun;
    wire [2:0]W_cnd;
    wire [3:0]W_rA;
    wire [3:0]W_rB;
    wire [63:0]W_valC;
    wire [63:0]W_valA;
    wire [63:0]W_valB;
    wire [63:0]W_valP;
    wire [3:0]W_dstE;
    wire [3:0]W_dstM;
    wire [3:0]W_srcA;
    wire [3:0]W_srcB;
//


        // always @(posedge clk)   PC<=PCt;
        pipe_reg F (
        .stat(f_stat),
        .icode(f_icode),
        .ifun(f_ifun),
        .rA(f_rA),
        .rB(f_rB),
        .valC(f_valC),
        .valP(f_valP),

        .o_stat(E_stat),
        .o_icode(E_icode),
        .o_ifun(D_ifun),
        .o_rA(D_rA),
        .o_rB(D_rB),
        .o_valC(D_valC),
        .o_valP(D_valP)
            );
        //PC_update PCU(.PC(PC),.icode(icode),.cnd(cnd),.valC(valC),.valM(valM),.valP(valP),.stat(stat),.clk(clk));
        //FETCH STAGE
        pipe_reg F(
            .o_pred_PC(F_predPC),
            .pred_PC(sel_PC)
        );
        //Fetch
        sel_PC selP(.f_pc(f_pc),.F_predPC(F_predPC),.W_valM(W_valM),.W_icode(W_icode),.M_valA(M_valA),.M_Cnd(M_Cnd),.M_icode(M_icode));
        pc_predic PCP(.predPC(f_predPC),.icode(f_icode),.valC(f_valC),.valP(f_valP));
        
        instruction_memory IM(.byte19(Byte[71:0]),.byte0(Byte[79:72]),.imem_err(imem_err),.clk(clk),.wEn(1'b0),.PC(PC));
        split Sp(.need_regids(need_regids),.need_valC(need_valC),.Instr_valid(Instr_valid) ,.icode(icode),.ifun(ifun),.Byte0(Byte[79:72]),.imem_err(imem_err));
        align Al(.rA(rA),.rB(rB),.valC(valC),.Byte19(Byte[71:0]),.need_regids(need_regids));
        pcIncrement PCI (.valP(valP),.need_regids(need_regids),.need_valC(need_valC),.PC(PC));
        
        //INSERT stat combination
        
        //******************************************************************************************************************************************************//
        //DECODE STAGE
        pipe_reg D (
        .stat(f_stat),
        .icode(f_icode),
        .ifun(f_ifun),
        .rA(f_rA),
        .rB(f_rB),
        .valC(f_valC),
        .valP(f_valP),

        .o_stat(E_stat),
        .o_icode(E_icode),
        .o_ifun(D_ifun),
        .o_rA(D_rA),
        .o_rB(D_rB),
        .o_valC(D_valC),
        .o_valP(D_valP)
            );
        
        //Register File
        RegFile RF (.valA(valA),.valB(valB),.valM(valM),.valE(valE),.icode(icode),.clk(clk),.cnd(cnd),.rA(rA),.rB(rB));
        //******************************************************************************************************************************************************//
        //Execute
        pipe_reg E (
        .stat(D_stat),
        .icode(D_icode),
        .ifun(D_ifun),
        .valC(D_valC),
        .valA(d_valA),
        .valB(d_valB),
        .bubble(E_bubble),
        .stall(E_stall),
        .dstE(d_dstE),
        .dstM(d_dstM),
        .srcA(d_srcA),
        .srcB(d_srcB),
        .stat(D_stat),

        .o_stat(E_stat),
        .o_icode(E_icode),
        .o_ifun(E_ifun),
        .o_valC(E_valC),
        .o_valA(E_valA),
        .o_valB(E_valB),
        
        .o_dstE(E_dstE),
        .o_dstM(E_dstM),
        .o_srcA(E_srcA),
        .o_srcB(E_srcB)
        
        );

        ALU_fun #(.N(64)) ALU(.valE(valE),.cnd(cnd),.icode(icode),.ifun(ifun),.valA(valA),.valB(valB),.valC(valC),.clk(clk));
        //******************************************************************************************************************************************************//
        //MEMORY STAGE
        pipe_reg M (
        .stat(E_stat),
        .icode(E_icode),
        .cnd(e_Cnd),
        .valE(valE),
        .valA(d_valB),
        .bubble(M_bubble),
        .stall(M_bubble),
        .dstE(d_dstE),
        .dstM(d_dstM),
        .srcA(d_srcA),
        .srcB(d_srcB),
        .stat(D_stat),

        .o_stat(E_stat),
        .o_icode(E_icode),
        .o_ifun(E_ifun),
        .o_valC(E_valC),
        .o_valA(E_valA),
        .o_valB(E_valB),
        
        .o_dstE(E_dstE),
        .o_dstM(E_dstM),
        .o_srcA(E_srcA),
        .o_srcB(E_srcB)
        
        );
        //DataMemory
        DataWrap Dm (.valM(valM),.stat(stat),.valE(valE),.valA(valA),.valP(valP),.icode(icode),.Instr_valid(Instr_valid),.imem_error(imem_err),.clk(clk),.rst(1'b0));

        assign PCt=PC;
        
// always @(stat==0)
//     begin
//     end

endmodule