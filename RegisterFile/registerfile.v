module RegFile (

    output reg [63:0]valA,
    output reg [63:0]valB,
    input [63:0]valM,
    input [63:0]valE,
    input [3:0]icode,
    input clk,
    input cnd,
    input [3:0]rA,
    input [3:0]rB
    // [63:0]register[15:0]
    // input [63:0]register1,
    // input [63:0]register2,
    // input [63:0]register3,
    // input [63:0]register4,
    // input [63:0]register5,
    // input [63:0]register6,
    // input [63:0]register7,
    // input [63:0]register8,
    // input [63:0]register9,
    // input [63:0]register10,
    // input [63:0]register11,
    // input [63:0]register12,
    // input [63:0]register13,
    // input [63:0]register14,
    // input [63:0]register15

);

// reg eEn,wEn;
// reg srcA,srcB,dstE,dstM;
reg [63:0]register[15:0];

always @*
begin
    case(icode)
    8:valB<=register[4];
    9:begin //ret
    valA<=register[4];
    valB<=register[4];
    end
    10:begin //pushq
    valA<=register[rA];
    valB<=register[4];
    end
    11:begin //popq
    valA<=register[4];
    valB<=register[4];
    end
    default:begin
        valA<=register[rA];
        valB<=register[rB];
    end
    endcase
end

always @(posedge clk)
begin
    case(icode)
    6:begin  //opq
    // valA<=register[rA];
    // valB<=register[rB];
    register[rB]<=valE;
    end
    2:begin //cmovXX
    // valA<=register[rA];
    if(cnd)
    begin
    register[rB]<=valE;
    end
    end
    3:begin //irmovq
    register[rB]<=valE;
    end
    // 4:begin //rmmovq
    // valA<=register[rA];
    // valB<=register[rB];
    // end
    5:begin //mrmovq
    // valB<=register[rB];
    register[rA]<=valM;
    end
    8:begin //call
    // valB<=register[4];
    register[4]<=valE;
    end
    9:begin //ret
    // valA<=register[4];
    // valB<=register[4];
    register[4]<=valE;
    end
    10:begin //pushq
    // valA<=register[rA];
    // valB<=register[4];
    register[4]<=valE;
    end
    11:begin //popq
    // valA<=register[4];
    // valB<=register[4];
    if(rA==4)
    begin
        register[4]<=valM;
    end
    else
    begin
    register[4]<=valE;
    register[rA]<=valM;
    end
    end
    default:begin
    // valA=0;
    // valB=0;
    valA<=register[rA];
    valB<=register[rB];
    end
    endcase
end  
endmodule