module instruction_memory(
    output reg [71:0]byte19,
    output reg [7:0]byte0,
    output reg imem_err,
    input clk, wEn,
    input [63:0]PC
    // input [7:0]val0, [7:0]val1, [7:0]val2, [7:0]val3, [7:0]val4,
    // input [7:0]val5, [7:0]val6, [7:0]val7, [7:0]val8, [7:0]val9
);

reg [7:0]memory[65535:0];

always @(posedge clk)
begin
    //     if(wEn)
    // begin
    //     memory[PC+0]<=val0;
    //     memory[PC+1]<=val1;
    //     memory[PC+2]<=val2;
    //     memory[PC+3]<=val3;
    //     memory[PC+4]<=val4;
    //     memory[PC+5]<=val5;
    //     memory[PC+6]<=val6;
    //     memory[PC+7]<=val7;
    //     memory[PC+8]<=val8;
    //     memory[PC+9]<=val9; 
    // end    
    
    imem_err<=(PC+9>=65536);

      if(~imem_err)
        begin
            byte0[7:0]<=memory[PC+9];
            byte19[7:0]<=memory[PC+8];
            byte19[15:8]<=memory[PC+7];
            byte19[23:16]<=memory[PC+6];
            byte19[31:24]<=memory[PC+5];
            byte19[39:32]<=memory[PC+4];
            byte19[47:40]<=memory[PC+3];
            byte19[55:48]<=memory[PC+2];
            byte19[63:56]<=memory[PC+1];
            byte19[71:64]<=memory[PC+0];
        end
       else
        begin
            byte0[7:0]<=8'b0;
            byte19[7:0]<=8'b0;
            byte19[15:8]<=8'b0;
            byte19[23:16]<=8'b0;
            byte19[31:24]<=8'b0;
            byte19[39:32]<=8'b0;
            byte19[47:40]<=8'b0;
            byte19[55:48]<=8'b0;
            byte19[63:56]<=8'b0;
            byte19[71:64]<=8'b0;
        end 

end
endmodule        