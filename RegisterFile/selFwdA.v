module fwd_selA(
    output reg [63:0]d_valA,
    input [3:0]D_icode,
    input [63:0]D_valP,
    input [63:0]d_rvalA,
    input [3:0]d_srcA,
    input [63:0]W_valE,
    input [3:0]W_dstE,
    input [63:0]W_valM,
    input [3:0]W_dstM,
    input [63:0]m_valM,
    input [3:0]M_dstM,
    input [63:0]M_valE,
    input [3:0]M_dstE,
    input [63:0]e_valE,
    input [3:0]e_dstE
);

    always @*
    begin
        
        if((D_icode==4'd7)||(D_icode==4'd8))
        begin
            d_valA<=D_valP;
        end
        else if(d_srcA == e_dstE)
        begin
            d_valA<=e_valE;
        end 
        else if(d_srcA == M_dstM)
        begin
            d_valA<=m_valM;
        end
        else if(d_srcA == M_dstE)
        begin
            d_valA<=M_valE;
        end
        else if(d_srcA == W_dstM)
        begin
            d_valA<=W_valM;
        end        
        else if(d_srcA == W_dstE)
        begin
            d_valA<=W_valE;
        end  
        else
        begin
            d_valA<=d_rvalA;
        end    
    end
endmodule  