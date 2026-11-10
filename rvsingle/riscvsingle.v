module riscvsingle(input               clk, reset,
                    output   [31:0]   PC,
                    input     logic   [31:0]   Instr,
                    output  logic              MemWrite,
                    output  logic  [31:0]  ALUResult, WriteData,
                    input    logic  [31:0]  ReadData);
    
    wire           ALUSrc, RegWrite, Jump, Zero;
    wire [1:0] ResultSrc, ImmSrc;
    wire [2:0] ALUControl;

    controller c(Instr[6:0], Instr[14:12], Instr[30], ResultSrc, MemWrite, ALUSrc, RegWrite, Jump, Branch, ImmSrc, ALUControl);
    datapath dp(clk, reset, ResultSrc, PCSrc, ALUSrc, RegWrite, ImmSrc, ALUControl, Zero, PC, Instr, ALUResult, WriteData, ReadData);
endmodule