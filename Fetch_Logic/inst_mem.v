module instruction_memory(
    output reg [71:0]byte19,
    output reg [7:0]byte0,
    output reg imem_err,
    input clk, wEn,
    input [63:0]PC
    // input [7:0]val0, [7:0]val1, [7:0]val2, [7:0]val3, [7:0]val4,
    // input [7:0]val5, [7:0]val6, [7:0]val7, [7:0]val8, [7:0]val9
);

reg [7:0]memory[1024:0];
initial begin
// First instruction
memory[0][7:4]<=4'd3;
memory[0][3:0]<=4'd0;
memory[1][7:4]<=4'd15;
memory[1][3:0]<=4'd11;
memory[2][7:4]<=4'd0;
memory[2][3:0]<=4'd5;
memory[3][7:4]<=4'd0;
memory[3][3:0]<=4'd0;
memory[4][7:4]<=4'd0;
memory[4][3:0]<=4'd0;
memory[5][7:4]<=4'd0;
memory[5][3:0]<=4'd0;
memory[6][7:4]<=4'd0;
memory[6][3:0]<=4'd0;
memory[7][7:4]<=4'd0;
memory[7][3:0]<=4'd0;
memory[8][7:4]<=4'd0;
memory[8][3:0]<=4'd0;
memory[9][7:4]<=4'd0;
memory[9][3:0]<=4'd0;

// Second instruction
memory[10+0][7:4]<=4'd3;
memory[10+0][3:0]<=4'd0;
memory[10+1][7:4]<=4'd15;
memory[10+1][3:0]<=4'd10;
memory[10+2][7:4]<=4'd0;
memory[10+2][3:0]<=4'd10;
memory[10+3][7:4]<=4'd0;
memory[10+3][3:0]<=4'd0;
memory[10+4][7:4]<=4'd0;
memory[10+4][3:0]<=4'd0;
memory[10+5][7:4]<=4'd0;
memory[10+5][3:0]<=4'd0;
memory[10+6][7:4]<=4'd0;
memory[10+6][3:0]<=4'd0;
memory[10+7][7:4]<=4'd0;
memory[10+7][3:0]<=4'd0;
memory[10+8][7:4]<=4'd0;
memory[10+8][3:0]<=4'd0;
memory[10+9][7:4]<=4'd0;
memory[10+9][3:0]<=4'd0;

//3rd instruction

memory[20+0][7:4]<=4'd6;
memory[20+0][3:0]<=4'd0;
memory[20+1][7:4]<=4'd11;
memory[20+1][3:0]<=4'd10;


//4th instruction
memory[22+0][7:4]<=4'd4;
memory[22+0][3:0]<=4'd0;
memory[22+1][7:4]<=4'd10;
memory[22+1][3:0]<=4'd6;
memory[22+2][7:4]<=4'd0;
memory[22+2][3:0]<=4'd0;
memory[22+3][7:4]<=4'd0;
memory[22+3][3:0]<=4'd0;
memory[22+4][7:4]<=4'd0;
memory[22+4][3:0]<=4'd0;
memory[22+5][7:4]<=4'd0;
memory[22+5][3:0]<=4'd0;
memory[22+6][7:4]<=4'd0;
memory[22+6][3:0]<=4'd0;
memory[22+7][7:4]<=4'd0;
memory[22+7][3:0]<=4'd0;
memory[22+8][7:4]<=4'd0;
memory[22+8][3:0]<=4'd0;
memory[22+9][7:4]<=4'd0;
memory[22+9][3:0]<=4'd0;

//5th instruction
memory[32+0][7:4]<=4'd0;
memory[32+0][3:0]<=4'd0;
end



always @(posedge clk)
begin
    imem_err<=(PC+9>=1025);
end
always @(*)
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
    

      if(~imem_err)
        begin
            byte0[7:0]<=memory[PC+0];
            byte19[7:0]<=memory[PC+9];
            byte19[15:8]<=memory[PC+8];
            byte19[23:16]<=memory[PC+7];
            byte19[31:24]<=memory[PC+6];
            byte19[39:32]<=memory[PC+5];
            byte19[47:40]<=memory[PC+4];
            byte19[55:48]<=memory[PC+3];
            byte19[63:56]<=memory[PC+2];
            byte19[71:64]<=memory[PC+1];
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