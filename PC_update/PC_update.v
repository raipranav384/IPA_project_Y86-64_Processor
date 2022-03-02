module PC_update (
    output reg [63:0]PC,
    input [3:0]icode,
    input cnd,
    input [1:0] stat,
    input [63:0] valC,valM,valP,
    input clk
);
initial begin
    PC<=0;
end

always @(posedge clk)
begin
    case(icode)

    // 1: PC<=valP;

    // 2: PC<=valP;    //cmov

    // 3: PC<=valP;    //irmovq

    // 4: PC<=valP;    //rmmovq

    // 5: PC<=valP;    //mrmovq

    // 6: PC<=valP;    //OPq

    7:  //PC<=cnd?valC:valP;  //jump
        begin
        if(stat==2'b0)
            PC<=cnd?valC:valP;
        else
            PC<=PC;
        end


    8: //PC<=valC;    //call
        begin
           if(stat==2'b0)
            PC<=valC;
        else
            PC<=PC;
        end 

    9: //PC<=valM;    //ret
        begin
            if(stat==2'b0)
            PC<=valM;
        else
            PC<=PC;
        end

    // 10: PC<=valP;   //pushq

    // 11: PC<=valP;   //popq

    default:begin   //nop cmov irmovq mrmovq OPq popq pushq
        if(stat==2'b0)
            PC<=valP;
        else
            PC<=PC;
        end
    endcase


end
    
endmodule