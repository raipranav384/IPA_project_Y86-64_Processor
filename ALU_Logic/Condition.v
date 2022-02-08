module cond (
    output reg cnd,
    input [2:0]CF, //CF[0]=OF;CF[1]=ZF;CF[2]=SF
    input [3:0]ifun
);
    
    //not equal
    not(zfbar,CF[1]);
    //greater than and greater than or equal to
    nor(ge,CF[2],CF[0]);
    and(g,ge,zfbar);

    //less than and less than or euqal to
    or(l,CF[2],CF[0]);
    or(le,l,CF[1]);

    always @*
    // generate
    begin
        case (ifun)
            4'b0000: cnd<=0;//put IDC
            4'b0001: cnd<=le;
            4'b0010: cnd<=l;
            4'b0011: cnd<=CF[1];
            4'b0100: cnd<=zfbar;
            4'b0101: cnd<=ge;
            4'b0110: cnd<=g;
            default: cnd<=0; //put IDC
        endcase
    end
    // endgenerate
    

endmodule