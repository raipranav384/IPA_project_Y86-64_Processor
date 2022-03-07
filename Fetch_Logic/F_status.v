module f_status (
    output reg [1:0]f_stat,
    input [3:0]icode,
    input imem_error,Instr_valid
);
    always  @*
    begin
        if(icode==0)
            f_stat<=2'd1;
        else if(imem_error==1)
            f_stat<=2'd2;
        else if(!Instr_valid)
            f_stat<=2'd3;
        else
            f_stat<=2'd0;
    end
endmodule