module RegFile (

    output reg [63:0]valA,
    output reg [63:0]valB,
    input [63:0]valM,
    input [63:0]valE,
    input [3:0]srcA,srcB,dstE,dstM,
    input clk

);

// reg eEn,wEn;
reg [63:0]register[15:0];
// reg [3:0]srcA,srcB,dstE,dstM;
// initial begin
//     register[6]<=64'd65535; //change if PC points to LSB
// end
// always @*
// begin
//     case(icode)
//     8:valB<=register[4];
//     9:begin //ret
//     valA<=register[4];
//     valB<=register[4];
//     end
//     10:begin //pushq
//     valA<=register[rA];
//     valB<=register[4];
//     end
//     11:begin //popq
//     valA<=register[4];
//     valB<=register[4];
//     end
//     default:begin
//         valA<=register[rA];
//         valB<=register[rB];
//     end
//     endcase
// end

always @(*) //Combinational part
begin
    valA<=register[srcA];
    valB<=register[srcB];
end  

always @(posedge clk) begin
    if(dstE!=15)
        register[dstE]<=valE;
    if(dstM!=15)
        register[dstM]<=valM;
end
endmodule