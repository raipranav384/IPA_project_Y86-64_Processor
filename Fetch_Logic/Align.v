module align (
    output reg [3:0]rA,
    output reg [3:0]rB,
    output reg [7:0]valC[7:0], 
    input [7:0]Byte19[8:0],
    input need_regids

);
    always @*
    begin
        if(need_regids==1)
        begin
        
            rA<=Byte19[0][7:4];
            rB<=Byte19[0][3:0];

            valC<=Byte19[8:1];
        end
        else
            valC<=Byte19[7:0];
    end
endmodule