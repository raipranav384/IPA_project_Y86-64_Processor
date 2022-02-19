module pcIncrement(
    output reg [63:0]valP,
    input need_regids,
    input need_valC,
    input [63:0]PC
);

always @*
begin
    if(need_regids&need_valC)
    begin
    valP<=PC+10;
    end
    else if(need_regids&~need_valC)
    begin
    valP<=PC+2;
    end
    else if(~need_regids&need_valC)
    begin
    valP<=PC+9;
    end
    else if (~need_regids&need_valC)
    begin
    valP<=PC+1;
    end
    else
    valP<=PC;   //Condition so that initially valP=PC instead of PC=1
   // valP = PC + 1 + need_regids + 8*need_valC;
end
endmodule