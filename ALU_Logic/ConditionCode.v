`include "flipflop.v"

module regNbit #(
   parameter N=3
) (
    output reg [N-1:0]out,
    input [N-1:0]in,
    input clk,
    input reset,
    input async_reset,
    input set
);

    // genvar i;
    // generate
    //     for(i=0;i<N;i=i+1)
    //     begin
    //         ff T(.out(out[i]),.in(in[i]),.clk(clk),.reset(reset),.async_reset(async_reset),.en(set));
    //     end
    // endgenerate  

    always @(posedge clk)
    begin
        if(~reset)
        begin
            if(set)
                out<=in;
        end
        else
            out<=0;
    end
    always @(negedge async_reset)
        out<=0;

endmodule