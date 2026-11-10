module flopenr #(parameter WIDTH = 8)
                (input clk, reset, en,
                input [(WIDTH-1) : 0] d,
                output reg [(WIDTH-1) : 0] q);

    always @(posedge clk, posedge reset) begin
        if (reset)     q <= 0;
        else if (en) q <= d;
    end
endmodule



module flopr #(parameter WIDTH = 8)
                (input clk, reset,
                input [(WIDTH-1):0] d,
                output reg [(WIDTH-1):0] q);

    always @(posedge clk, posedge reset)
        if (reset) q <= 0;
        else           q <= d;
endmodule


// Fetch-Decode Register
module regFD(clk, reset, en, InstrF, PCF, PCPlus4F, InstrD, PCD, PCPlus4D);
    input clk, reset, en;
    input [31:0] InstrF, PCF, PCPlus4F;
    output reg [31:0] InstrD, PCD, PCPlus4D;

    always @(posedge clk) begin
        if (reset)  {InstrD, PCD, PCPlus4D} <= 0;
        else if (en) {InstrD, PCD, PCPlus4D} <= {InstrF, PCF, PCPlus4F};
    end
endmodule


// Decode-Execute Register
module regDE(clk, reset, RegWriteD, ResultSrcD, MemWriteD, JumpD, BranchD, ALUControlD, ALUSrcD, RD1, RD2, PCD, Rs1D, Rs2D, RdD, ImmExtD, PCPlus4D, RegWriteE, ResultSrcE, MemWriteE, JumpE, BranchE, ALUControlE, ALUSrcE, RD1E, RD2E, PCE, Rs1E, Rs2E, RdE, ImmExtE, PCPlus4E);
    input clk, reset;
    input RegWriteD, MemWriteD, JumpD, BranchD, ALUSrcD;
    input [1:0] ResultSrcD;
    input [2:0] ALUControlD;
    input [31:0] RD1, RD2, PCD, ImmExtD, PCPlus4D;
    input [4:0] Rs1D, Rs2D, RdD;
    output reg RegWriteE, MemWriteE, JumpE, BranchE, ALUSrcE;
    output reg [1:0] ResultSrcE;
    output reg [2:0] ALUControlE;
    output reg [31:0] RD1E, RD2E, PCE,  ImmExtE, PCPlus4E;
    output reg [4:0] Rs1E, Rs2E, RdE;

    always @(posedge clk) begin
        if (reset)  {RegWriteE, ResultSrcE, MemWriteE, JumpE, BranchE, ALUControlE, ALUSrcE, RD1E, RD2E, PCE, Rs1E, Rs2E, RdE, ImmExtE, PCPlus4E} <= 0;
        else begin
            RegWriteE <= RegWriteD;
            ResultSrcE <= ResultSrcD;
            MemWriteE <= MemWriteD;
            JumpE <= JumpD;
            BranchE <= BranchD;
            ALUControlE <= ALUControlD;
            ALUSrcE <= ALUSrcD;
            RD1E <= RD1;
            RD2E <= RD2;
            PCE <= PCD;
            Rs1E <= Rs1D;
            Rs2E <= Rs2D;
            RdE <= RdD;
            ImmExtE <= ImmExtD;
            PCPlus4E <= PCPlus4D;
        end
    end
endmodule


module regem(clk, RegWriteE, ResultSrcE, MemWriteE, ALUResult, WriteDataE, RdE, PCPlus4E, RegWriteM, ResultSrcM, MemWriteM, ALUResultM, WriteDataM, RdM, PCPlus4M);
    input clk;
    input RegWriteE, MemWriteE;
    input [1:0] ResultSrcE;
    input [4:0] RdE;
    input [31:0] ALUResult, WriteDataE, PCPlus4E;
    output reg RegWriteM, MemWriteM;
    output reg [1:0] ResultSrcM;
    output reg [4:0] RdM;
    output reg [31:0] ALUResultM, WriteDataM, PCPlus4M;

    always @(posedge clk) begin
        RegWriteM <= RegWriteE;
        ResultSrcM <= ResultSrcE;
        MemWriteM <= MemWriteE;
        ALUResultM <= ALUResult;
        WriteDataM <= WriteDataE;
        RdM <= RdE;
        PCPlus4M <= PCPlus4E; 
    end
        
endmodule



module regmw(clk, RegWriteM, ResultSrcM, ALUResultM, ReadData, RdM, PCPlus4M, RegWriteW, ResultSrcW, ALUResultW, ReadDataW, RdW, PCPlus4W);
    input clk, RegWriteM;
    input [1:0] ResultSrcM;
    input [4:0] RdM;
    input [31:0] ALUResultM, ReadData, PCPlus4M;
    output reg RegWriteW;
    output reg [1:0] ResultSrcW;
    output reg [4:0] RdW;
    output reg [31:0] ALUResultW, ReadDataW, PCPlus4W;

    always @(posedge clk) begin
        RegWriteW <= RegWriteM;
        ResultSrcW <= ResultSrcM;
        ALUResultW <= ALUResultM;
        ReadDataW <= ReadData;
        RdW <= RdM;
        PCPlus4W <= PCPlus4M; 
    end
        
endmodule