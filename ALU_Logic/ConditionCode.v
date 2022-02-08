`include "flipflop.v"

module CC #(
   parameter N=3
) (
    output [N-1:0]out,
    input [N-1:0]in,
    input clk,
    input reset,
    input async_reset,
    input set
);

    genvar i;
    generate
        for(i=0;i<N;i=i+1)
        begin
            ff T(.out(out[i]),.in(in[i]),.clk(clk),.reset(reset),.async_reset(async_reset),.en(set));
        end
    endgenerate    
endmodule