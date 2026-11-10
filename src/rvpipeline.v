module rvpipeline(clk, reset, InstrF, ReadData, PCF, MemWriteM, ALUResultM, WriteDataM);
    input clk, reset;
    input [31:0] InstrF, ReadData;
    output [31:0] PCF, ALUResultM, WriteDataM;
    output MemWriteM;

    // Fetch signals
    wire StallF;
    wire [31:0] PCPlus4F;       

    // Decode signals
    wire FlushD, StallD, RegWriteD, MemWriteD, JumpD, BranchD, ALUSrcD;
    wire [1:0] ResultSrcD;
    wire [2:0] ALUControlD;
    wire [4:0] Rs1D, Rs2D, RdD;
    wire [31:0] PCD, InstrD, RD1, RD2, ImmExtD, PCPlus4D;     

    // Execute Signals
    wire PCSrcE, RegWriteE, MemWriteE, JumpE, BranchE, ALUSrcE;
    wire [1:0] ResultSrcE, ForwardAE, ForwardBE;
    wire [2:0] ALUControlE;
    wire [4:0] Rs1E, Rs2E, RdE;
    wire [31:0] RD1E, RD2E, PCE, ImmExtE, PCPlus4E, WriteDataE, PCTargetE, ALUResult;

    // Memory Signals
    wire RegWriteM, MemWriteM;
    wire [1:0] ResultSrcM;
    wire [4:0] RdM;
    wire [31:0] WriteDataM, PCPlus4M;

    // WriteBack Signals
    wire RegWriteW;
    wire [1:0] ResultSrcW;
    wire [4:0] RdW;
    wire [31:0] ResultW, ALUResultW, ReadDataW, PCPlus4W; 


    // Fetch
    fetch fe(clk, reset, PCSrcE, PCTargetE, StallF, PCF, PCPlus4F);
    regFD fereg(clk, FlushD, ~StallD, InstrF, PCF, PCPlus4F, InstrD, PCD, PCPlus4D);

    // Decode
    decode de(clk, InstrD, ResultW, RdW, RegWriteW, RegWriteD, ResultSrcD, MemWriteD, JumpD, BranchD, ALUControlD, ALUSrcD, RD1, RD2, Rs1D, Rs2D, RdD, ImmExtD);
    regDE dereg(clk, FlushE, RegWriteD, ResultSrcD, MemWriteD, JumpD, BranchD, ALUControlD, ALUSrcD, RD1, RD2, PCD, Rs1D, Rs2D, RdD, ImmExtD, PCPlus4D, RegWriteE, ResultSrcE, MemWriteE, JumpE, BranchE, ALUControlE, ALUSrcE, RD1E, RD2E, PCE, Rs1E, Rs2E, RdE, ImmExtE, PCPlus4E);

    // Execute
    execute ex(clk, RD1E, RD2E, PCE, ImmExtE, ForwardAE, ForwardBE, ResultW, ALUResultM, JumpE, BranchE, ALUControlE, ALUSrcE, PCSrcE, ALUResult, WriteDataE, PCTargetE);
    regem exreg(clk, RegWriteE, ResultSrcE, MemWriteE, ALUResult, WriteDataE, RdE, PCPlus4E, RegWriteM, ResultSrcM, MemWriteM, ALUResultM, WriteDataM, RdM, PCPlus4M);

    // Memory
    regmw memreg(clk, RegWriteM, ResultSrcM, ALUResultM, ReadData, RdM, PCPlus4M, RegWriteW, ResultSrcW, ALUResultW, ReadDataW, RdW, PCPlus4W);

    // WriteBack
    writeback wr(ResultSrcW, ALUResultW, ReadDataW, PCPlus4W, ResultW);

    // Hazard
    hazard haz(RegWriteW, RdW, RegWriteM, RdM, ResultSrcE[0], PCSrcE, Rs1E, Rs2E, RdE, Rs1D, Rs2D, StallF, StallD, FlushD, FlushE, ForwardAE, ForwardBE);

endmodule