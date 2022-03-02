module Sel_PC (
    output reg [63:0]f_pc,
    input [63:0]F_predPC,
    input [63:0]W_valM,
    input [3:0]W_icode,
    input [63:0]M_valA,
    input M_Cnd,
    input [3:0]M_icode
);

 always @(*)
    begin
        if((M_icode == 4'd7)&&(!M_Cnd))
        begin
            f_pc<=M_valA;
        end
        else if (W_icode == 4'd9)
        begin
            f_pc<=W_valM;
        end
        else
        begin
            f_pc<=F_predPC;
        end            
    end
endmodule