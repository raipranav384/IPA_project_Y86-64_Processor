module instruction_memory(
    output reg [71:0]byte19,
    output reg [7:0]byte0,
    output reg imem_err,
    input clk, wEn,
    input [63:0]PC
    // input [7:0]val0, [7:0]val1, [7:0]val2, [7:0]val3, [7:0]val4,
    // input [7:0]val5, [7:0]val6, [7:0]val7, [7:0]val8, [7:0]val9
);

reg [7:0]inst_memory[1024:0];
initial begin
// // First instruction
// inst_memory[0][7:4]<=4'd3;
// inst_memory[0][3:0]<=4'd0;
// inst_memory[1][7:4]<=4'd15;
// inst_memory[1][3:0]<=4'd11;
// inst_memory[2][7:4]<=4'd0;
// inst_memory[2][3:0]<=4'd5;
// inst_memory[3][7:4]<=4'd0;
// inst_memory[3][3:0]<=4'd0;
// inst_memory[4][7:4]<=4'd0;
// inst_memory[4][3:0]<=4'd0;
// inst_memory[5][7:4]<=4'd0;
// inst_memory[5][3:0]<=4'd0;
// inst_memory[6][7:4]<=4'd0;
// inst_memory[6][3:0]<=4'd0;
// inst_memory[7][7:4]<=4'd0;
// inst_memory[7][3:0]<=4'd0;
// inst_memory[8][7:4]<=4'd0;
// inst_memory[8][3:0]<=4'd0;
// inst_memory[9][7:4]<=4'd0;
// inst_memory[9][3:0]<=4'd0;

// // Second instruction
// inst_memory[10+0][7:4]<=4'd3;
// inst_memory[10+0][3:0]<=4'd0;
// inst_memory[10+1][7:4]<=4'd15;
// inst_memory[10+1][3:0]<=4'd10;
// inst_memory[10+2][7:4]<=4'd0;
// inst_memory[10+2][3:0]<=4'd10;
// inst_memory[10+3][7:4]<=4'd0;
// inst_memory[10+3][3:0]<=4'd0;
// inst_memory[10+4][7:4]<=4'd0;
// inst_memory[10+4][3:0]<=4'd0;
// inst_memory[10+5][7:4]<=4'd0;
// inst_memory[10+5][3:0]<=4'd0;
// inst_memory[10+6][7:4]<=4'd0;
// inst_memory[10+6][3:0]<=4'd0;
// inst_memory[10+7][7:4]<=4'd0;
// inst_memory[10+7][3:0]<=4'd0;
// inst_memory[10+8][7:4]<=4'd0;
// inst_memory[10+8][3:0]<=4'd0;
// inst_memory[10+9][7:4]<=4'd0;
// inst_memory[10+9][3:0]<=4'd0;

// //3rd instruction

// inst_memory[20+0][7:4]<=4'd6;
// inst_memory[20+0][3:0]<=4'd0;
// inst_memory[20+1][7:4]<=4'd11;
// inst_memory[20+1][3:0]<=4'd10;

// //3.5
// inst_memory[22+0][7:4]<=4'd3;
// inst_memory[22+0][3:0]<=4'd0;
// inst_memory[22+1][7:4]<=4'd15;
// inst_memory[22+1][3:0]<=4'd6;
// // inst_memory[22+2][7:4]<=4'd0;
// inst_memory[22+2][7:0]<=8'b11110111;
// // inst_memory[22+3][7:4]<=4'd0;
// inst_memory[22+3][7:0]<=8'b11111111;
// inst_memory[22+4][7:4]<=4'd0;
// inst_memory[22+4][3:0]<=4'd0;
// inst_memory[22+5][7:4]<=4'd0;
// inst_memory[22+5][3:0]<=4'd0;
// inst_memory[22+6][7:4]<=4'd0;
// inst_memory[22+6][3:0]<=4'd0;
// inst_memory[22+7][7:4]<=4'd0;
// inst_memory[22+7][3:0]<=4'd0;
// inst_memory[22+8][7:4]<=4'd0;
// inst_memory[22+8][3:0]<=4'd0;
// inst_memory[22+9][7:4]<=4'd0;
// inst_memory[22+9][3:0]<=4'd0;

// //4th instruction
// inst_memory[32+0][7:4]<=4'd4;
// inst_memory[32+0][3:0]<=4'd0;
// inst_memory[32+1][7:4]<=4'd10;
// inst_memory[32+1][3:0]<=4'd6;
// inst_memory[32+2][7:4]<=4'd0;
// inst_memory[32+2][3:0]<=4'd0;
// inst_memory[32+3][7:4]<=4'd0;
// inst_memory[32+3][3:0]<=4'd0;
// inst_memory[32+4][7:4]<=4'd0;
// inst_memory[32+4][3:0]<=4'd0;
// inst_memory[32+5][7:4]<=4'd0;
// inst_memory[32+5][3:0]<=4'd0;
// inst_memory[32+6][7:4]<=4'd0;
// inst_memory[32+6][3:0]<=4'd0;
// inst_memory[32+7][7:4]<=4'd0;
// inst_memory[32+7][3:0]<=4'd0;
// inst_memory[32+8][7:4]<=4'd0;
// inst_memory[32+8][3:0]<=4'd0;
// inst_memory[32+9][7:4]<=4'd0;
// inst_memory[32+9][3:0]<=4'd0;

// //5th instruction
// inst_memory[42+0][7:4]<=4'd0;
// inst_memory[42+0][3:0]<=4'd0;
// end

// First instruction
// First instruction
//irmovq 3 0 F 4 14  //irmovq 3 0 F rB V
inst_memory[0][7:4]<=4'd3;
inst_memory[0][3:0]<=4'd0;
inst_memory[1][7:4]<=4'd15;
inst_memory[1][3:0]<=4'd4;
inst_memory[2][7:4]<=4'd0;
inst_memory[2][3:0]<=4'd14;
inst_memory[3][7:4]<=4'd0;
inst_memory[3][3:0]<=4'd0;
inst_memory[4][7:4]<=4'd0;
inst_memory[4][3:0]<=4'd0;
inst_memory[5][7:4]<=4'd0;
inst_memory[5][3:0]<=4'd0;
inst_memory[6][7:4]<=4'd0;
inst_memory[6][3:0]<=4'd0;
inst_memory[7][7:4]<=4'd0;
inst_memory[7][3:0]<=4'd0;
inst_memory[8][7:4]<=4'd0;
inst_memory[8][3:0]<=4'd0;
inst_memory[9][7:4]<=4'd0;
inst_memory[9][3:0]<=4'd0;

//Second instruction
//irmovq 3 0 F 8 6  //irmovq 3 0 F rB V
inst_memory[10+0][7:4]<=4'd3;
inst_memory[10+0][3:0]<=4'd0;
inst_memory[10+1][7:4]<=4'd15;
inst_memory[10+1][3:0]<=4'd8;
inst_memory[10+2][7:4]<=4'd0;
inst_memory[10+2][3:0]<=4'd6;
inst_memory[10+3][7:4]<=4'd0;
inst_memory[10+3][3:0]<=4'd0;
inst_memory[10+4][7:4]<=4'd0;
inst_memory[10+4][3:0]<=4'd0;
inst_memory[10+5][7:4]<=4'd0;
inst_memory[10+5][3:0]<=4'd0;
inst_memory[10+6][7:4]<=4'd0;
inst_memory[10+6][3:0]<=4'd0;
inst_memory[10+7][7:4]<=4'd0;
inst_memory[10+7][3:0]<=4'd0;
inst_memory[10+8][7:4]<=4'd0;
inst_memory[10+8][3:0]<=4'd0;
inst_memory[10+9][7:4]<=4'd0;
inst_memory[10+9][3:0]<=4'd0;

//Third instruction
//opq 6 1 4 8
inst_memory[20+0][7:4]<=4'd6;
inst_memory[20+0][3:0]<=4'd1;
inst_memory[20+1][7:4]<=4'd4;
inst_memory[20+1][3:0]<=4'd8;

//Fourth instrucion
//cmovXX 2 5 4 8
inst_memory[22+0][7:4]<=4'd2;
inst_memory[22+0][3:0]<=4'd2;
inst_memory[22+1][7:4]<=4'd4;
inst_memory[22+1][3:0]<=4'd8;

//Fifth instruction
//opq 6 0 4 8
inst_memory[24+0][7:4]<=4'd6;
inst_memory[24+0][3:0]<=4'd0;
inst_memory[24+1][7:4]<=4'd4;
inst_memory[24+1][3:0]<=4'd8;

//Sixth instruction
//jmp 7 5 38
inst_memory[26+0][7:4]<=4'd7;
inst_memory[26+0][3:0]<=4'd5;
inst_memory[26+1][7:4]<=4'd2;
inst_memory[26+1][3:0]<=4'd6;
inst_memory[26+2][7:4]<=4'd0;
inst_memory[26+2][3:0]<=4'd0;
inst_memory[26+3][7:4]<=4'd0;
inst_memory[26+3][3:0]<=4'd0;
inst_memory[26+4][7:4]<=4'd0;
inst_memory[26+4][3:0]<=4'd0;
inst_memory[26+5][7:4]<=4'd0;
inst_memory[26+5][3:0]<=4'd0;
inst_memory[26+6][7:4]<=4'd0;
inst_memory[26+6][3:0]<=4'd0;
inst_memory[26+7][7:4]<=4'd0;
inst_memory[26+7][3:0]<=4'd0;
inst_memory[26+8][7:4]<=4'd0;
inst_memory[26+8][3:0]<=4'd0;

//Sixth instrcution
//opq 6 0 4 8
inst_memory[38+0][7:4]<=4'd6;
inst_memory[38+0][3:0]<=4'd0;
inst_memory[38+1][7:4]<=4'd4;
inst_memory[38+1][3:0]<=4'd8;

//Seventh instrcution
//halt 0 0
inst_memory[40+0][7:4]<=4'd0;
inst_memory[40+0][3:0]<=4'd0;
end



always @(*)
begin
    imem_err<=(PC+9>=1025);
end
always @(*)
begin
    //     if(wEn)
    // begin
    //     inst_memory[PC+0]<=val0;
    //     inst_memory[PC+1]<=val1;
    //     inst_memory[PC+2]<=val2;
    //     inst_memory[PC+3]<=val3;
    //     inst_memory[PC+4]<=val4;
    //     inst_memory[PC+5]<=val5;
    //     inst_memory[PC+6]<=val6;
    //     inst_memory[PC+7]<=val7;
    //     inst_memory[PC+8]<=val8;
    //     inst_memory[PC+9]<=val9; 
    // end    
    

      if(~imem_err)
        begin
            byte0[7:0]<=inst_memory[PC+0];
            byte19[7:0]<=inst_memory[PC+9];
            byte19[15:8]<=inst_memory[PC+8];
            byte19[23:16]<=inst_memory[PC+7];
            byte19[31:24]<=inst_memory[PC+6];
            byte19[39:32]<=inst_memory[PC+5];
            byte19[47:40]<=inst_memory[PC+4];
            byte19[55:48]<=inst_memory[PC+3];
            byte19[63:56]<=inst_memory[PC+2];
            byte19[71:64]<=inst_memory[PC+1];
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