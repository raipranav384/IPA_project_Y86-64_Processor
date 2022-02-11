module PC_update (
    output reg [63:0]PC,
    input [3:0]icode,
    input cnd,
    input [63:0] valC,valM,valP,
    input clk
);

always @(posedge clk)
begin
    case(icode)
    1: PC<=valP;

    2: PC<=valP;    //cmov

    3: PC<=valP;    //irmovq

    4: PC<=valP;    //rmmovq

    5: PC<=valP;    //mrmovq

    6: PC<=valP;    //OPq

    7: PC<=cnd?valC:valP;   //jump

    8: PC<=valC;    //call

    9: PC<=valM;    //ret

    10: PC<=valP;   //pushq

    11: PC<=valP;   //popq

    default: PC<=0;

    endcase
end
    
endmodule