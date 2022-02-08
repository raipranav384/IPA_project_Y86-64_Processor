module wrap(
    output need_regids,
    output need_valC,
    output Instr_valid,
    input [3:0]icode
);
    //need registers
    or(t1,icode[2],icode[1]);
    nand(t2,icode[2],icode[1],icode[0]);
    and(need_regids,t1,t2);
    
    //need Valc
    not(ic0,icode[0]);
    not(ic1,icode[1]);
    not(ic2,icode[2]);
    not(ic3,icode[3]);

    and(t3,ic3,icode[1],icode[0]);
    // and(t4,ic1,ic0,icode[2]);
    and(t5,ic1,ic0,icode[3]);
    and(t4,icode[2],ic1);
    or(need_valC,t3,t4,t5);

    //Is Instruction valid
    and(Instr_valid,icode[3],icode[2]);
    
    // always @*
    // begin
    //     if((icode>=2 && icode<=6 )||(icode>=10 && icode<=11))
        
    //         assign need_regids=1;
        
    //     else
    //         need_regids=0;
    //     if((icode==3 || icode<=4 )||(icode==7 || icode==8))
        
    //         assign need_valC=1;
        
    //     else
    //         assign need_valC=0;
    //     if(icode>11)
    //        assign Instr_valid=0;
    //     else
    //        assign Instr_valid=1;
    // end
    
endmodule