`include "ConditionCode.v"

module DataMem #(
    parameter N=64
) (
    output [N-1:0]outData,
    output reg dmem_err,
    input [N-1:0] inData,
    input [N-1:0] inAdd,
    input rEn,wEn,clk//,reset
);
    
    reg [7:0]memory[65535:0];

    always @(posedge clk)
    begin
        for(integer i=inAdd;i<inAdd+64&&dmem;i=i+8)
        begin
            dmem_err<=(i>=65536)|(rEn&wEn);
            if(dmem_err!=0)
            begin
                if(rEn&~wEn)
                    outData[i-inAdd:i-inAdd+7]<=memory[i:i+7];
                if(~rEn&wEn)
                    memory[i:i+7]<=inData[i-inAdd:i-inAdd+7];
            end
            else
            begin
                    memory[i:i+7]<=8'b0;
            end
        begin
            
        end
    end

endmodule