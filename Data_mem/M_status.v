module M_status (
    output reg [1:0]m_stat,
    input [1:0]m_rstat,M_stat
);
always @*
begin
    if(m_rstat==2&&M_stat!=1)
        m_stat<=m_rstat;
    else
        m_stat<=M_stat;
end

endmodule