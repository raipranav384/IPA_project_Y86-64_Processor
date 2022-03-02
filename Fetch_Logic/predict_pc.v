module predict_pc (
    output reg [63:0]predPC,
    input [3:0]icode,
    input [63:0]valC,
    input [63:0]valP
);
    
    always @*
    begin
        case(icode)
            4'b1000:predPC<=valC;
            4'b0111:predPC<=valC;
            default: predPC<=valP;
        endcase
    end
endmodule