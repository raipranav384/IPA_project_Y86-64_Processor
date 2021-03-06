
module DataMem #(
    parameter N=64
) (
    output reg [N-1:0]outData,
    input dmem_err,
    // input  reg [7:0]memory[65535:0],
    input [N-1:0] inData,
    input [N-1:0] inAdd,
    input rEn,wEn,clk,reset
);
    
    // reg [7:0]memory[65535:0];
    reg [7:0]memory[16383:0]; //reduced memory size to improve compile time


    // integer i,j;
    // reg [7:0]displ;
    // always #(125)   begin
    //     displ<=memory[inAdd+7];
    //  $monitor($time,"memory[%d]=%d, valM=%d, rEn=%d, wEn=%d",inAdd,displ,outData,rEn,wEn);
    
    // end    
    //always @(rEn or inAdd)
    always @(*)//the reading must not be clock dependent
    begin
        if(~dmem_err)
        begin
            if(rEn&~wEn&~reset)
                begin
                    outData[7:0]<=memory[inAdd+7];  //Little Endian format
                    outData[15:8]<=memory[inAdd+6];
                    outData[23:16]<=memory[inAdd+5];
                    outData[31:24]<=memory[inAdd+4];
                    outData[39:32]<=memory[inAdd+3];
                    outData[47:40]<=memory[inAdd+2];
                    outData[55:48]<=memory[inAdd+1];
                    outData[63:56]<=memory[inAdd+0];

                end
            else
            begin
                    outData[7:0]<=8'b0;
                    outData[15:8]<=8'b0;
                    outData[23:16]<=8'b0;
                    outData[31:24]<=8'b0;
                    outData[39:32]<=8'b0;
                    outData[47:40]<=8'b0;
                    outData[55:48]<=8'b0;
                    outData[63:56]<=8'b0;
            end
        end
    end
    always @(posedge clk)
    begin
        // for( i=inAdd;i<inAdd+8 && dmem_err;i=i+1)
        // begin
            if(~dmem_err)
            begin
                // if(rEn&~wEn&~reset)
                // begin
                //     // outData[i-inAdd:i-inAdd+7]<=memory[i];
                //     // outData[j:j+7]<=memory[i];
                //     // outData[7:0]<=memory[inAdd+0];  //Little endian, but dec format PC points to highest add.
                //     // outData[15:8]<=memory[inAdd-1];
                //     // outData[23:16]<=memory[inAdd-2];
                //     // outData[31:24]<=memory[inAdd-3];
                //     // outData[39:32]<=memory[inAdd-4];
                //     // outData[47:40]<=memory[inAdd-5];
                //     // outData[55:48]<=memory[inAdd-6];
                //     // outData[63:56]<=memory[inAdd-7];
                //     outData[7:0]<=memory[inAdd+7];  //Little Endian format
                //     outData[15:8]<=memory[inAdd+6];
                //     outData[23:16]<=memory[inAdd+5];
                //     outData[31:24]<=memory[inAdd+4];
                //     outData[39:32]<=memory[inAdd+3];
                //     outData[47:40]<=memory[inAdd+2];
                //     outData[55:48]<=memory[inAdd+1];
                //     outData[63:56]<=memory[inAdd+0];

                // end
                if(~rEn&wEn&~reset)
                begin
                    // memory[i]<=inData[i-inAdd:i-inAdd+7];
                    // memory[i]<=inData[j:j+7];
                    // memory[inAdd+0]<=inData[7:0];
                    // memory[inAdd-1]<=inData[15:8];
                    // memory[inAdd-2]<=inData[23:16];
                    // memory[inAdd-3]<=inData[31:24];
                    // memory[inAdd-4]<=inData[39:32];
                    // memory[inAdd-5]<=inData[47:40];
                    // memory[inAdd-6]<=inData[55:48];
                    // memory[inAdd-7]<=inData[63:56];

                    memory[inAdd+7]<=inData[7:0];
                    memory[inAdd+6]<=inData[15:8];
                    memory[inAdd+5]<=inData[23:16];
                    memory[inAdd+4]<=inData[31:24];
                    memory[inAdd+3]<=inData[39:32];
                    memory[inAdd+2]<=inData[47:40];
                    memory[inAdd+1]<=inData[55:48];
                    memory[inAdd+0]<=inData[63:56];
                end
                if(reset)
                begin

                    memory[inAdd+0]<=8'b0;
                    memory[inAdd+1]<=8'b0;
                    memory[inAdd+2]<=8'b0;
                    memory[inAdd+3]<=8'b0;
                    memory[inAdd+4]<=8'b0;
                    memory[inAdd+5]<=8'b0;
                    memory[inAdd+6]<=8'b0;
                    memory[inAdd+7]<=8'b0;
                end
            end
            else
            begin
                    outData[7:0]<=8'b0;
                    outData[15:8]<=8'b0;
                    outData[23:16]<=8'b0;
                    outData[31:24]<=8'b0;
                    outData[39:32]<=8'b0;
                    outData[47:40]<=8'b0;
                    outData[55:48]<=8'b0;
                    outData[63:56]<=8'b0;
            end
        // end
    end

endmodule