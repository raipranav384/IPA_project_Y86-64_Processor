module dst_src (
    output reg [3:0]dstE,dstM,srcA,srcB,
    input [3:0]icode,
    input [3:0]rA,rB,
    input cnd
);
    always @(*) //Combinational part
begin
    case(icode)
    6:begin  //opq
    srcA<=rA;
    srcB<=rB;
    dstE<=rB;
    dstM<=4'd15;
    end
    2:begin //cmovXX
    srcA<=rA;
    srcB<=rB;
    dstM<=4'd15;
    if(cnd)
    begin
        dstE<=rB;
    end
    else
        dstE<=4'd15;
    end
    3:begin //irmovq
        srcA<=rA;
        srcB<=rB;
        dstE<=rB;
        dstM<=4'd15;
    end
    4:begin //rmmovq
        srcA<=rA;
        srcB<=rB;
        dstE<=4'd15;
        dstM<=4'd15;
    end
    5:begin //mrmovq
        srcA<=rA;
        srcB<=rB;
        dstM<=rA;
        dstE<=4'd15;
    end
    8:begin //call
        srcB<=4'd4;
        srcA<=rA;
        dstE<=4'd4;
        
    end
    9:begin //ret
        srcA<=4'd4;
        srcB<=4'd4;
        dstE<=4'd4;
        dstM<=4'd15;
    end
    10:begin //pushq
    srcA<=rA;
    srcB<=4'd4;
    dstE<=4'd4;
    dstM<=4'd15;
    end
    11:begin //popq
    srcA<=4'd4;
    srcB<=4'd4;
    if(rA==4)
    begin
        dstM<=4'd4;
        dstE<=4'd15;
    end
    else
    begin
        dstE<=4'd4;
        dstM<=rA;
    end
    end
    default:begin
    // valA=0;
    // valB=0;
    srcA<=rA;
    srcB<=rB;
    dstM<=4'd15;
    dstE<=4'd15;
    end
    endcase
end  
endmodule