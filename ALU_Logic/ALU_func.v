`include "AND.v"
`include "XOR.v"
`include "FA.v"
`include "ADDSUB.v"
`include "ALU.v"
`include "Condition.v"
`include "ConditionCode.v"

module ALU_fun #(
    parameter N=64
) (
    output [N-1:0]valE,
    output cnd,
    input [3:0]icode,
    input [3:0]ifun,
    input [N-1:0]valA,
    input [N-1:0]valB,
    input [N-1:0]valC,
    input clk
);

    wire [2:0]CF1;
    reg [63:0]a;
    reg [63:0]b;
    wire [2:0]CF;
    reg [1:0]c;
    reg set;

    // generate
    //     case(icode)
        
    //     6:  begin
    //             ALU #(.N(N)) A1(.OUT(valE),.CF(CF1),.a(valB),.b(valA),.c(icode[1:0]));
    //             set=1;
    //         end
    //     4:  ALU #(.N(N)) A2(.OUT(valE),.CF(CF1),.a(valB),.b(valC),.c(2'b00));
        
    //     2:  ALU #(.N(N)) A3(.OUT(valE),.CF(CF1),.a(64'd0),.b(valA),.c(2'b00));

    //     8: ALU #(.N(N)) A4(.OUT(valE),.CF(CF1),.a(valB),.b(64'd8),.c(2'b01));

    //     11: ALU #(.N(N)) A5(.OUT(valE),.CF(CF1),.a(valB),.b(64'd8),.c(2'b00));

    //     default:begin
    //                 assign valE=0;
    //             end
    //     endcase
    // endgenerate
    always @*
    begin
        set=0;
        case(icode)
        6:  begin   //opq
                a<=valB;
                b<=valA;
                c<=ifun[1:0];
                set<=1;
            end
        3:  begin   //irmovq
                a<=valC;
                b<=64'd0;
                c<=2'b00;
                
            end
        4:  begin   //rmmovq
                a<=valC;
                b<=valA;
                c<=2'b00;
                
            end
        5:  begin   //mrmovq
                a<=valB;
                b<=valC;
                c<=2'b00;
                
            end
        2:  begin   //cmov
                a<=64'd0;
                b<=valA;
                c<=2'b00;
                
            end
        8:  begin   //call
                a<=valB;
                b<=64'd8;
                c<=2'b01;
                
            end
        11:  begin  //popq
                a<=valB;
                b<=64'd8;
                c<=2'b00;
            end
        10:  begin  //pushq
                a<=valB;
                b<=64'd8;
                c<=2'b01;
                
            end
        default:  begin
                a<=0;
                b<=0;
                c<=0;
                
            end
        endcase
    end
    ALU #(.N(N)) A(.OUT(valE),.CF(CF1),.a(a),.b(b),.c(c));
    regNbit T1(.out(CF),.in(CF1),.clk(clk),.reset(1'b0),.async_reset(1'b0),.set(set));
    cond T2(.cnd(cnd),.CF(CF),.ifun(ifun));
    
endmodule
    
