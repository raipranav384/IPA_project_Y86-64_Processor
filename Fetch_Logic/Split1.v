module split(
    output reg need_regids,
    output reg need_valC,
    output reg Instr_valid,
    output reg [3:0]icode,
    output reg [3:0]ifun,
    input [7:0]Byte0,
    input imem_err
);

    // assign icode=Byte0[7:4];
    // assign ifun=Byte0[3:0];
    //need registers

    // or(t1,icode[2],icode[1]);
    // nand(t2,icode[2],icode[1],icode[0]);
    // and(need_regids,t1,t2);
    
    // //need Valc
    // not(ic0,icode[0]);
    // not(ic1,icode[1]);
    // not(ic2,icode[2]);
    // not(ic3,icode[3]);

    // and(t3,ic3,icode[1],icode[0]);
    // // and(t4,ic1,ic0,icode[2]);
    // and(t5,ic1,ic0,icode[3]);
    // and(t4,icode[2],ic1);
    // or(need_valC,t3,t4,t5);

    // //Is Instruction valid
    // and(Instr_valid,icode[3],icode[2]);
    
    always @*
    begin
         icode<=~imem_err?Byte0[7:4]:4'b0;
         ifun<=Byte0[3:0];
        if((icode==2||icode==3||icode==4||icode==5|| icode==6 )||(icode==10|| icode==11))
        
             need_regids<=1'b1;
        
        else
            need_regids<=1'b0;
        if((icode==3 || icode==4 )||(icode==7 || icode==8))
        
             need_valC<=1'b1;
        
        else
             need_valC<=1'b0;
        if(icode>11)
            Instr_valid<=1'b0;
        else
            Instr_valid<=1'b1;
    end
    
endmodule