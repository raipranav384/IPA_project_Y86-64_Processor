module align (
    output reg [3:0]rA,
    output reg [3:0]rB,
    output reg [63:0]valC, 
    // input [7:0]Byte19[9:0],
    // input [7:0]Byte191,
    // input [7:0]Byte192,
    // input [7:0]Byte193,
    // input [7:0]Byte194,
    // input [7:0]Byte195,
    // input [7:0]Byte196,
    // input [7:0]Byte197,
    // input [7:0]Byte198,
    // input [7:0]Byte199,
    input [71:0] Byte19,
    input need_regids

);
    integer j;
    always @*
    begin

        if(need_regids==1)
        begin
        
            // rA<=Byte199[7:4];
            // rB<=Byte199[3:0];

            rA<=Byte19[71:68];
            rB<=Byte19[67:64];

            //remove this if sv allowed
            // valC[7:0]<=Byte198;
            // valC[15:8]<=Byte197;
            // valC[23:16]<=Byte196;
            // valC[31:24]<=Byte195;
            // valC[39:32]<=Byte194;
            // valC[47:40]<=Byte193;
            // valC[55:48]<=Byte192;
            // valC[63:56]<=Byte191;
            //upto here

            valC[7:0]<=Byte19[63:56];
            valC[15:8]<=Byte19[55:48];
            valC[23:16]<=Byte19[47:40];
            valC[31:24]<=Byte19[39:32];
            valC[39:32]<=Byte19[31:24];
            valC[47:40]<=Byte19[23:16];
            valC[55:48]<=Byte19[15:8];
            valC[63:56]<=Byte19[7:0];

            
        //     for( j=0;j<=7;j=j+1) begin
        //         valC[j] <= Byte19[j+1];
        //     end

        end
        else
        begin
            //Remove this if sv allowed
            // valC[7:0]<=Byte199;
            // valC[15:8]<=Byte198;
            // valC[23:16]<=Byte197;
            // valC[31:24]<=Byte196;
            // valC[39:32]<=Byte195;
            // valC[47:40]<=Byte194;
            // valC[55:48]<=Byte193;
            // valC[63:56]<=Byte192;
            //Upto here
        //     for( j=0;j<=7;j=j+1) begin
        //         valC[j] <= Byte19[j];
        
            valC[7:0]<=Byte19[71:64];
            valC[15:8]<=Byte19[63:56];
            valC[23:16]<=Byte19[55:48];
            valC[31:24]<=Byte19[47:40];
            valC[39:32]<=Byte19[39:32];
            valC[47:40]<=Byte19[31:24];
            valC[55:48]<=Byte19[23:16];
            valC[63:56]<=Byte19[15:8];
        
        end

    end
endmodule