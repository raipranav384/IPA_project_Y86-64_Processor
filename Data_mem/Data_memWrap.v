`include "Data_Memory.v"

module DataWrap (
    output [63:0]valM,
    output reg[1:0]stat,
    // input [7:0]memory[65535:0],
    // output reg dmem_err,
    // output reg [63:0]inData,inAdd,
    // output reg rEn,wEn,

    input [63:0]valE,
    input [63:0]valA,
    input [63:0]valP,
    input [3:0]icode,
    input Instr_valid,imem_error,clk,rst
);
    reg dmem_err;
    reg rEn,wEn;
    reg [63:0]inData,inAdd;
    // This is inpendent of clock, combinational logic part of data memory

    // initial begin
    //     stat<=1;
    // end
    always @ (*)
    begin
        case(icode)
            4:begin     //rmmovq
                rEn<=0;
                wEn<=1;
                inData<=valA;
                inAdd<=valE;
            end

            5:begin     //mrmovq
                rEn<=1;
                wEn<=0;
                inData<=64'd0;
                inAdd<=valE;
            end
            10: begin   //pushq
                rEn<=0; wEn<=1;
                inData<=valA;
                inAdd<=valE;
            end

            11: begin   //popq
                rEn<=1; wEn<=0;
                inData<=0;
                inAdd<=valA;
            end
            8: begin    //call
                rEn<=0;
                wEn<=1;
                inData<=valP;
                inAdd<=valE;
            end
            9: begin    //ret
                rEn<=1; wEn<=0;
                inData<=0;
                inAdd<=valA;
            end
            default: begin
                     rEn<=0;
                     wEn<=0;
            end
        endcase
        // dmem_err<=(inAdd+7>=65536)||(rEn&wEn);   //Add is the LSB
        // dmem_err<=(inAdd+7>=65536)||(rEn&wEn);        //Add points to MSB
        dmem_err<=(inAdd+7>=16384)||(rEn&wEn);        //Add points to MSB, reduced memory

        if(icode==0)
            stat<=2'd1;
        else if(dmem_err==1||imem_error==1)
            stat<=2'd2;
        else if(!Instr_valid)
            stat<=2'd3;
        else
            stat<=2'd0;
    end
    // DataMem #(.N(64)) A(.outData(valM),.dmem_err(dmem_err),.memory(memory),.inData(inData),.inAdd(inAdd),.rEn(rEn),.wEn(wEn),.clk(clk),.reset(1'b0));

    // This module only updates at positive edge
    DataMem #(.N(64)) A(.outData(valM),.dmem_err(dmem_err),.inData(inData),.inAdd(inAdd),.rEn(rEn),.wEn(wEn),.clk(clk),.reset(rst));
    

endmodule