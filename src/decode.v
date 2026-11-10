module decode(clk, Instr, Result, RdW, RegWriteW, RegWriteD, ResultSrc, MemWrite, Jump, Branch, ALUControl, ALUSrc, RD1, RD2, Rs1, Rs2, RdD, ImmExt);
    input clk, RegWriteW;
    input [31:0] Instr, Result;
    input [4:0] RdW;
    output RegWriteD, MemWrite, Jump, Branch, ALUSrc;
    output [1:0] ResultSrc;
    output [2:0] ALUControl;
    output [31:0] RD1, RD2, ImmExt;
    output [4:0] Rs1, Rs2, RdD;

    wire [1:0] ImmSrc;

    regfile rf(clk, RegWriteW, Instr[19:15], Instr[24:20], RdW, Result, RD1, RD2);
    extend ext(Instr[31:7], ImmSrc, ImmExt);

    controller c(Instr[6:0], Instr[14:12], Instr[30], ResultSrc, MemWrite, ALUSrc, RegWriteD, Jump, Branch, ImmSrc, ALUControl);

    assign Rs1 = Instr[19:15];
    assign Rs2 = Instr[24:20];
    assign RdD = Instr[11:7];
endmodule