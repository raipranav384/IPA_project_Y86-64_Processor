`include "Fetch_Logic/inst_mem.v"
`include "Fetch_Logic/Split1.v"
`include "Fetch_Logic/Align.v"
`include "Fetch_Logic/predict_pc.v"
`include "Fetch_Logic/select_pc.v"
`include "Fetch_Logic/pc_increment.v"
`include "Fetch_Logic/F_status.v"
`include "ALU_Logic/ALU_func.v"
`include "RegisterFile/registerFile2.v"
`include "RegisterFile/dst_srcLogic.v"
`include "Data_mem/Data_memWrap.v"
`include "Data_mem/M_status.v"
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


// Required Wires
//for fetch
    wire F_bubble;
    wire [79:0]f_Byte;
    wire [1:0]f_stat;
    wire [3:0]f_icode;
    wire [3:0]f_ifun;
    wire [3:0]f_rA;
    wire [3:0]f_rB;
    wire [63:0]f_valC;
    wire [63:0]f_valP;
    wire [63:0]f_predPC;
    wire [63:0]f_pc;

    wire [63:0]F_predPC;
    
    //for Decode
    wire D_stall,D_bubble;
    wire [1:0]D_stat;
    wire [3:0]D_icode;
    wire [3:0]D_ifun;
    wire [3:0]D_rA;
    wire [3:0]D_rB;
    wire [63:0]D_valC;
    wire [63:0]D_valP;
    wire [63:0]d_valA;
    wire [63:0]d_valB;
    wire [63:0]d_rvalA;
    wire [63:0]d_rvalB;
    wire [3:0]d_dstE;
    wire [3:0]d_dstM;
    wire [3:0]d_srcA;
    wire [3:0]d_srcB;

    //for execute
    wire E_stall,E_bubble;
    wire [1:0]E_stat;
    wire [3:0]E_icode;
    wire [3:0]E_ifun;
    wire [63:0]E_valC;
    wire [63:0]E_valA;
    wire [63:0]E_valB;
    wire [3:0]E_dstE;
    wire [3:0]E_dstM;
    wire [3:0]E_srcA;
    wire [3:0]E_srcB;

    wire [3:0]e_dstE;
    wire e_Cnd;
    wire [63:0]e_valE;

    //for memory
    wire M_stall,M_bubble;
    wire [1:0]M_stat;
    wire [3:0]M_icode;
    wire [3:0]M_ifun;
    wire M_Cnd;
    wire [63:0]M_valE;
    wire [63:0]M_valA;
    wire [3:0]M_dstE;
    wire [3:0]M_dstM;
    
    wire [1:0]m_stat;
    wire [1:0]m_rstat;
    wire [63:0]m_valM;
    
    //for Write back
    wire W_stall,W_bubble;
    wire [1:0]W_stat;
    wire [3:0]W_icode;
    wire W_cnd;
    wire [63:0]W_valE;
    wire [63:0]W_valM;
    wire [3:0]W_dstE;
    wire [3:0]W_dstM;
//

 //******************************************************************************************************************************************************//
        
        // always @(posedge clk)   PC<=PCt;
        // pipe_reg F (
        // .stat(f_stat),
        // .icode(f_icode),
        // .ifun(f_ifun),
        // .rA(f_rA),
        // .rB(f_rB),
        // .valC(f_valC),
        // .valP(f_valP),

        // .o_stat(E_stat),
        // .o_icode(E_icode),
        // .o_ifun(D_ifun),
        // .o_rA(D_rA),
        // .o_rB(D_rB),
        // .o_valC(D_valC),
        // .o_valP(D_valP)
        //     );
        //PC_update PCU(.PC(PC),.icode(icode),.cnd(cnd),.valC(valC),.valM(valM),.valP(valP),.stat(stat),.clk(clk));
        //FETCH STAGE
        pipe_Logic PLogic(
        .W_stall(W_stall),.M_bubble(M_bubble),.E_bubble(E_bubble),.D_bubble(D_bubble),.D_stall(D_stall),.F_stall(F_stall),.set_cc(set_cc),
        .D_icode(D_icode),.M_icode(M_icode),.E_icode(E_icode),.d_srcB(d_srcB),.d_srcA(d_srcA),.E_dstM(E_dstE),
        .W_stat(W_stat),.m_stat(m_stat),.e_Cnd(e_Cnd)
        );
        pipe_reg F(
            .o_pred_PC(F_predPC),
            .pred_PC(f_predPC)
        );
        //Fetch
        Sel_PC selP(.f_pc(f_pc),.F_predPC(F_predPC),.W_valM(W_valM),.W_icode(W_icode),.M_valA(M_valA),.M_Cnd(M_Cnd),.M_icode(M_icode));
        
        instruction_memory IM(.byte19(f_Byte[71:0]),.byte0(f_Byte[79:72]),.imem_err(f_imem_err),.clk(clk),.wEn(1'b0),.PC(f_pc));
        split Sp(.need_regids(f_need_regids),.need_valC(f_need_valC),.Instr_valid(f_Instr_valid) ,.icode(f_icode),.ifun(f_ifun),.Byte0(f_Byte[79:72]),.imem_err(f_imem_err));
        align Al(.rA(f_rA),.rB(f_rB),.valC(f_valC),.Byte19(f_Byte[71:0]),.need_regids(f_need_regids));
        pcIncrement PCI (.valP(f_valP),.need_regids(f_need_regids),.need_valC(f_need_valC),.PC(f_pc));
        predict_pc PCP(.predPC(f_predPC),.icode(f_icode),.valC(f_valC),.valP(f_valP));
        
        f_status F_stat(
        .f_stat(f_stat),.icode(f_icode),.imem_error(f_imem_err),.Instr_valid(f_Instr_valid)
        );
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

        .o_stat(D_stat),
        .o_icode(D_icode),
        .o_ifun(D_ifun),
        .o_rA(D_rA),
        .o_rB(D_rB),
        .o_valC(D_valC),
        .o_valP(D_valP)
            );
        
        //Register File
        // RegFile RF (.valA(d_rvalA),.valB(d_rvalB),.valM(W_valM),.valE(W_valE),.icode(icode),.clk(clk),.cnd(cnd),.rA(rA),.rB(rB),.srcA(d_srcA),.srcB(d_srcB),.dstE(d_dstE),.dstM(d_dstE));
        dst_src DST_SRC(
    .dstE(d_dstE),.dstM(d_dstM),.srcA(d_srcA),.srcB(d_srcB),
    .icode(D_icode),
    .rA(D_rA),.rB(D_rB),    
    .cnd(1'b1)      //cnd variable passed as one, so later we can acutally select to keep value of dstE, or disregard it, depending on cnd
);
        
        RegFile RF (.valA(d_rvalA),.valB(d_rvalB),.valM(W_valM),.valE(W_valE),.clk(clk),.srcA(d_srcA),.srcB(d_srcB),.dstE(d_dstE),.dstM(d_dstE));

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

        ALU_fun #(.N(64)) ALU(.valE(e_valE),.cnd(e_Cnd),.icode(E_icode),.ifun(E_ifun),.valA(E_valA),.valB(E_valB),.valC(E_valC),.clk(clk));
        assign e_dstE=e_Cnd?e_dstE:4'd15;   //Now the value is corrected;
    //******************************************************************************************************************************************************//
        //MEMORY STAGE
        pipe_reg M (
        .stat(E_stat),
        .icode(E_icode),
        .cnd(e_Cnd),
        .valE(e_valE),
        .valA(E_valA),
        .bubble(M_bubble),
        .stall(M_bubble),
        .dstE(e_dstE),
        .dstM(E_dstM),
        

        .o_stat(M_stat),
        .o_icode(M_icode),
        .o_cnd(M_Cnd),
        .o_valE(M_valE),
        .o_valA(M_valA),
        .o_dstE(M_dstE),
        .o_dstM(M_dstM)
        
        );
        //DataMemory
        DataWrap Dm (.valM(m_valM),.stat(m_rstat),.valE(valE),.valA(valA),.valP(valP),.icode(icode),.Instr_valid(1'b1),.imem_error(1'b0),.clk(clk),.rst(1'b0));
        //imem_error passed 1, to make stat 2 only because of dmem error
        //m_stat:
        assign m_stat=(m_rstat==2&&M_stat!=1)?m_rstat:M_stat;
        // M_status Mstat(.m_stat(m_stat),.m_rstat(m_rstat),.M_stat(M_stat));
    //******************************************************************************************************************************************************//
       //WRITE BACK STAGE
       pipe_reg W (
        .stat(m_stat),
        .icode(M_icode),
        .valE(M_valE),
        .valM(m_valM),
        .bubble(W_bubble),
        .stall(W_bubble),
        .dstE(M_dstE),
        .dstM(M_dstM),

        .o_stat(W_stat),
        .o_icode(W_icode),
        .o_valE(W_valE),
        .o_valM(W_valM),
        .o_dstE(W_dstE),
        .o_dstM(W_dstM)
        );
    //******************************************************************************************************************************************************//
        

        assign PCt=f_pc;
        
// always @(stat==0)
//     begin
//     end

endmodule