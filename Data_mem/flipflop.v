module ff(
    output reg out,out_bar,
    input in,clk,reset,async_reset,en
);
    always @(posedge clk)
    begin
        if(reset==0)
            if(en==1)
            begin
                out<=in;
                out_bar<=~in;
            end
        else
        begin
            out<=0;
            out_bar<=1;
        end
    end

    always @(negedge async_reset)
    begin
        out<=0;
        out_bar<=1;
    end
    
endmodule