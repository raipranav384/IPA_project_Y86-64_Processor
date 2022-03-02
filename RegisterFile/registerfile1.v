module RegFile (

    output reg [63:0]valA,
    output reg [63:0]valB,
    input [63:0]valM,
    input [63:0]valE,
    input [3:0]icode,
    output reg [3:0]srcA,srcB,dstE,dstM,
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
    case(icode)
    6:begin  //opq
    srcA<=rA;
    srcB<=rB;
    dstE<=rB;
    dstM<=4'd15;
    // valA<=register[rA];
    // valB<=register[rB];
    // register[rB]<=valE;
    end
    2:begin //cmovXX
    // valA<=register[rA];
    srcA<=rA;
    srcB<=rB;
    dstM<=4'd15;
    if(cnd)
    begin
        dstE<=rB;
        // register[rB]<=valE;
    end
    else
        dstE<=4'd15;
    end
    3:begin //irmovq
        srcA<=rA;
        srcB<=rB;
        dstE<=rB;
        dstM<=4'd15;
        // register[rB]<=valE;
    end
    4:begin //rmmovq
        srcA<=rA;
        srcB<=rB;
        dstE<=4'd15;
        dstM<=4'd15;
    // valA<=register[rA];
    // valB<=register[rB];
    end
    5:begin //mrmovq
        srcA<=rA;
        srcB<=rB;
        dstM<=rA;
        dstE<=4'd15;
    // valB<=register[rB];
    // register[rA]<=valM;
    end
    8:begin //call
        srcB<=4'd4;
        srcA<=rA;
        dstE<=4'd4;
        
    // valB<=register[4];
    // register[4]<=valE;
    end
    9:begin //ret
        srcA<=4'd4;
        srcB<=4'd4;
        dstE<=4'd4;
        dstM<=4'd15;
    // valA<=register[4];
    // valB<=register[4];
    // register[4]<=valE;
    end
    10:begin //pushq
    srcA<=rA;
    srcB<=4'd4;
    dstE<=4'd4;
    dstM<=4'd15;
    // valA<=register[rA];
    // valB<=register[4];
    // register[4]<=valE;
    end
    11:begin //popq
    srcA<=4'd4;
    srcB<=4'd4;
    // valA<=register[4];
    // valB<=register[4];
    if(rA==4)
    begin
        dstM<=4'd4;
        dstE<=4'd15;
        // register[4]<=valM;
    end
    else
    begin
        dstE<=4'd4;
        dstM<=rA;
    // register[4]<=valE;
    // register[rA]<=valM;
    end
    end
    default:begin
    // valA=0;
    // valB=0;
    srcA<=rA;
    srcB<=rB;
    dstM<=4'd15;
    dstE<=4'd15;
    // valA<=register[rA];
    // valB<=register[rB];
    end
    endcase
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