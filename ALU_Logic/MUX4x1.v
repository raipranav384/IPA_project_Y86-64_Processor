module MUX4x1 (
    output M,
    input x0,
    input x1,
    input x2,
    input x3,
    input [1:0]s
);

    wire sbar0,sbar1,out0,out1,out2,out3;
    not (sbar0,s[0]);
    not (sbar1,s[1]);

    and (out0,sbar0,sbar1,x0);
    and (out1,s[0],sbar1,x1);
    and (out2,sbar0,s[1],x2);
    and (out3,s[0],s[1],x3);

    or G7(M,out0,out1,out2,out3);

endmodule