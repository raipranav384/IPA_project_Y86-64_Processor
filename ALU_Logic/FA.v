
module FA (
    output sum,
    output cout,
    input a,
    input b,
    input c
);

wire t1,t2,t3;
xor G1(t1,a,b);
and G2(t2,a,b);
xor G3(sum,t1,c);
and G4(t3,t1,c);
or G5(cout,t3,t2);

endmodule