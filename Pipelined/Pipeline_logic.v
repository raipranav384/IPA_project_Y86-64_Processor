module pipe_Logic (
    output reg W_stall,M_bubble,E_bubble,D_bubble,D_stall,F_stall,set_cc,
    input [3:0]D_icode,M_icode,E_icode,d_srcB,d_srcA,E_dstM,
    input [1:0]W_stat,m_stat,
    input e_Cnd
);
    always @ *
    begin
        if(((E_icode==4'd5)||(E_icode==4'd11)&&(E_dstM==d_srcA||E_dstM==d_srcB))||(D_icode==4'd9||E_icode==4'd9||M_icode==4'd9))
            F_stall<=1'b1;
        else
            F_stall<=1'b0;
        if(((E_icode==4'd5)||(E_icode==4'd11)&&(E_dstM==d_srcA||E_dstM==d_srcB)))
            D_stall<=1'b1;
        else
            D_stall<=1'b0;
        // if(((E_icode==7)&&~e_cnd)||(D_icode==9||E_icode==9||M_icode==9))
        if(((E_icode==4'd7)&&~e_Cnd)||(D_icode==4'd9||E_icode==4'd9||M_icode==4'd9)&&!((E_icode==4'd5||E_icode==4'd11)&&(E_dstM==d_srcA||E_dstM==d_srcB)))
            D_bubble<=1'b1;
        else
            D_bubble<=1'b0;
        if(((E_icode==4'd7)&&~e_Cnd)||(((E_icode==4'd5)||(E_icode==4'd11))&&(E_dstM==d_srcA||E_dstM==d_srcB)))
            E_bubble<=1'b1;
        else
            E_bubble<=1'b1;
    end
endmodule