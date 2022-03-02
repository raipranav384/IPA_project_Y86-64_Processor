module pipe_Logic (
    output reg W_stall,M_bubble,E_bubble,D_bubble,D_stall,F_stall,set_cc
    input [3:0]D_icode,M_icode,E_icode,d_srcB,d_srcA,E_dstM,
    input W_stat,m_stat,e_cnd
);
    always @ *
    begin
        if(((E_icode==5)||(E_icode==11)&&(E_dstM==d_srcA||E_dstM==d_srcB))||(D_icode==9||E_icode==9||M_icode==9))
            F_stall<=1;
        else
            F_stall<=0;
        if(((E_icode==5)||(E_icode==11)&&(E_dstM==d_srcA||E_dstM==d_srcB)))
            D_stall<=1;
        else
            D_stall<=0;
        if((E_icode==7)&&~e_cnd)||(D_icode==9||E_icode==9||M_icode==9))
            D_bubble<=1;
        else
            D_bubble<=0;
        if(((E_icode==7)&&~e_cnd)||((E_icode==5)||(E_icode==11)&&(E_dstM==d_srcA||E_dstM==d_srcB)))
    end
endmodule