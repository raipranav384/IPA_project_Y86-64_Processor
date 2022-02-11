`include "ALU_Logic/ALU_func.v"
`include "Data_mem/Data_memWrap.v"
`include "PC_update.v"
`include "Fetch_Logic/Align.v"
`include "Fetch_Logic/Split1.v"

`include "Fetch_Logic/pc_increment.v"
`include "Fetch_Logic/inst_mem.v"

`include "RegisterFile/registerfile.v"

module y86wrap (
    input clk
);

reg [7:0]in; //for loading to the instruction memory

wire [79:0]Byte;
wire [63:0]PC,valM,valE,valC,valP,valA,valB;

wire [3:0]icode,ifun,rA,rB;
wire [1:0]stat;
wire cnd,imem_err,Instr_valid,need_regids,need_valC;


// initial begin
    
//      stat<=2'b0;
//      PC<=64'd0;
//      imem_err<=0;
//      Instr_valid<=0;
//      need_regids<=0;
//      need_valC<=0;
// end

        instruction_memory IM(.byte19(Byte[71:0]),.byte0(Byte[79:72]),.imem_err(imem_err),.clk(clk),.wEn(1'b0),.PC(PC));
        split Sp(.need_regids(need_regids),.need_valC(need_valC),.Instr_valid(Instr_valid) ,.icode(icode),.ifun(ifun),.Byte0(Byte[79:72]),.imem_err(imem_err));
        align Al(.rA(rA),.rB(rB),.valC(valC),.Byte19(Byte[71:0]));
        pcIncrement PCI (.valP(valP),.need_regids(need_regids),.need_valC(need_valC),.PC(PC));

        RegFile RF (.valA(valA),.valB(valB),.valM(valM),.valE(valE),.icode(icode),.clk(clk),.cnd(cnd),.rA(rA),.rB(rB));
        
        ALU_fun #(.N(64)) ALU(.valE(valE),.cnd(cnd),.icode(icode),.ifun(ifun),.valA(valA),.valB(valB),.valC(valC),.clk(clk));

        DataWrap Dm (.valM(valM),.stat(stat),.valE(valE),.valA(valA),.valP(valP),.icode(icode),.Instr_valid(Instr_valid),.imem_error(imem_err),.clk(clk),.rst(1'b0));

        PC_update PCU(.PC(PC),.icode(icode),.cnd(cnd),.valC(valC),.valM(valM),.valP(valP),.clk(clk));
// always @(stat==0)
//     begin
//     end

endmodule