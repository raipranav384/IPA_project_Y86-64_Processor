`include "flipflip.v"

module CC #(
   parameter  N=3; 
) (
    output reg [N-1]out;
    input [N-1,0]in;
    input clk,
    input reset,
    input async_reset,
    input set
);

    genvar i;
    generate
        for(i=0;i<=N;i++)
        begin
            ff(.out(out[i]),.in(in[i]),.clk(clk),.reset(reset),.async_reset(async_reset),.en(set));
        end
    endgenerate    
endmodule