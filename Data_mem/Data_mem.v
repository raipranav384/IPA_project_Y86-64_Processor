module DataWrap (
    output [63:0]valM,
    output [3:0]stat,
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
            4: rEn<=0;
                wEn<=1;
                inData<=valA;
                inAdd<=valE;
            11: rEn<=1; wEn<=0;
                inData<=0;
                inAdd<=valA;
            8: rEn<=0;
                wEn<=1;
                inData<=valP;
                inAdd<=valE;
            9: rEn<=1; wEn<=0;
                inData<=0;
                inAdd<=valA;
            default: rEn<=0;wEn<=0;
        endcase
        stat<=3'd0;
        if(icode==0)
            stat<=3'd1;
        if(dmem_err||imem_error)
            stat<=3'd2;
        if(!instr_valid)
            stat<=3'd3;
    end
    DataMem #(.N(64)) (.outData(valM),.dmem_err(dmem_err),.inData(inData),.inAdd(inAdd),.rEn(rEn),.wEn(wEn),.clk(clk));
    

endmodule