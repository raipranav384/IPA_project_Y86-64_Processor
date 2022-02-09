`include "Data_Memory.v"

module DataWrap (
    output [63:0]valM,
    output reg[3:0]stat,
    input [63:0]valE,
    input [63:0]valA,
    input [63:0]valP,
    input [3:0]icode,
    input instr_valid,imem_error,dmem_err,clk
);
    reg rEn,wEn;
     reg [63:0]inData,inAdd;
    always @*
    begin
        case(icode)
            4:begin
                 rEn<=0;
                wEn<=1;
                inData<=valA;
                inAdd<=valE;
            end
            11: begin
                rEn<=1; wEn<=0;
                inData<=0;
                inAdd<=valA;
            end
            8: begin
                rEn<=0;
                wEn<=1;
                inData<=valP;
                inAdd<=valE;
            end
            9: begin
                rEn<=1; wEn<=0;
                inData<=0;
                inAdd<=valA;
            end
            default: begin
                     rEn<=0;
                     wEn<=0;
            end
        endcase
        stat<=3'd0;
        if(icode==0)
            stat<=3'd1;
        if(dmem_err||imem_error)
            stat<=3'd2;
        if(!instr_valid)
            stat<=3'd3;
    end
    DataMem #(.N(64)) A(.outData(valM),.dmem_err(dmem_err),.inData(inData),.inAdd(inAdd),.rEn(rEn),.wEn(wEn),.clk(clk));
    

endmodule