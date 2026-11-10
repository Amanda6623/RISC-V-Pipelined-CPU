module execute(clk, RD1, RD2, PC, ImmExt, ForwardAE, ForwardBE, Result, ALUResultM, Jump, Branch, ALUControl, ALUSrc, PCSrc, ALUResult, WriteData, PCTarget);
    input clk;
    input [31:0] RD1, RD2, PC, ImmExt, Result, ALUResultM;
    input [1:0] ForwardAE, ForwardBE;
    input Jump, Branch;
    input [2:0] ALUControl;
    input ALUSrc;
    output reg PCSrc;
    output [31:0] ALUResult, WriteData, PCTarget;

    wire [31:0] SrcA, SrcB;

    mux3 #(32) srcamux(RD1, Result, ALUResultM, ForwardAE, SrcA);
    mux3 #(32) srcbmux1(RD2, Result, ALUResultM, ForwardBE, WriteData);
    mux2 #(32) srcbmux2(WriteData, ImmExt, ALUSrc, SrcB);
    alu alu(SrcA, SrcB, ALUControl, ALUResult, Zero);
    adder pctarg(PC, ImmExt, PCTarget);

    initial PCSrc = 0;
    always @(*) PCSrc = (Zero & Branch) | Jump; 
endmodule