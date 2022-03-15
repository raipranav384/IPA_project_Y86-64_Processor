`include "Data_memWrap.v"
`default_nettype none

module tb_Data_memWrap;
wire [63:0]valM,inData,inAdd;
wire [1:0]stat;
wire dmem_err;

reg clk;
reg rst;
reg [63:0]valE;
reg [63:0]valA;
reg [63:0]valP;
reg [3:0]icode;
reg instr_valid,imem_error;
reg [7:0]memory[65535:0];

reg cond;

DataWrap uut
(
    .valM(valM),
    .stat(stat),
    // .dmem_err(dmem_err),
    // .inAdd(inAdd),
    // .inData(inData),
    .valE(valE),
    .valA(valA),
    .valP(valP),
    .icode(icode),
    .Instr_valid(instr_valid),
    .imem_error(imem_error),
    .clk(clk),.rst(rst)
);

localparam CLK_PERIOD = 30;
always #(CLK_PERIOD/2) clk=~clk;

// always #(CLK_PERIOD/2) $display($time," clk=%b, icode=%d, valM=%d , stat=%b, valE=%d, dmem=%b, inADD=%d , inData=%d",clk,icode,valM,stat,valE,dmem_err,cond,inData);

initial begin
    $dumpfile("tb_Data_memWrap.vcd");
    $dumpvars(0, tb_Data_memWrap);
    $monitor($time," clk=%b, icode=%d, valM=%d , stat=%b, valE=%d",clk,icode,valM,stat,valE);//,dmem_err,cond,inData);
end

initial begin
    clk<=0;
    #1 rst<=0;
    icode<=4;
    valE<=58;
    valA<=64'd12;
    valP<=64'd10;
    imem_error<=0;instr_valid<=1;

    // cond<=(inAdd+7>=16383);
    #20;
    icode<=5;
    valE<=64'd58;
    valP<=64'd11;
    imem_error<=0;instr_valid<=1;
    #40;
    icode<=4;
    valE<=64'd58;
    valP<=64'd11;
    imem_error<=0;instr_valid<=1;

    #40;
    icode<=9;
    valE<=64'd58;
    valA<=64'd58;
    valP<=64'd11;
    imem_error<=0;instr_valid<=1;

    #40;

    $finish(2);
end

endmodule

`default_nettype wire
