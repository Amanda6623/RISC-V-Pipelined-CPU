module fetch(clk, reset, PCSrc, PCTarget, Stall, PC, PCPlus4);
    input clk, reset, PCSrc, Stall;
    input [31:0] PCTarget;
    output [31:0] PC, PCPlus4;

    wire [31:0]  PCNext;

    flopenr #(32) pcreg(clk, reset, ~Stall, PCNext, PC);
    adder pcadd4(PC, 32'd4, PCPlus4);
    mux2 #(32) pcmux(PCPlus4, PCTarget, PCSrc, PCNext);
endmodule