module fwd_selB(
    output reg [63:0]d_valB,
    input [63:0]d_rvalB,
    input [3:0]d_srcB,
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
        if(d_srcB == e_dstE)
        begin
            d_valB<=e_valE;
        end 
        else if(d_srcB == M_dstM)
        begin
            d_valB<=m_valM;
        end
        else if(d_srcB == M_dstE)
        begin
            d_valB<=M_valE;
        end
        else if(d_srcB == W_dstM)
        begin
            d_valB<=W_valM;
        end        
        else if(d_srcB == W_dstE)
        begin
            d_valB<=W_valE;
        end  
        else
        begin
            d_valB<=d_rvalB;
        end    
    end
endmodule  