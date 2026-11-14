module top(input clk, reset,
            output [31:0] WriteData, DataAdr,
            output MemWrite);

    wire [31:0] PC, Instr, InstrD, ReadData, RD1, RD2, Result;
    wire RegWrite;
    wire [4:0] Rd;

    // instantiate processor and memories
    rvpipeline rvpipe(clk, reset, Instr, ReadData, RD1, RD2, InstrD, PC, MemWrite, DataAdr, WriteData, Result, RegWrite, Rd);

    regfile rf(clk, RegWrite, InstrD[19:15], InstrD[24:20], Rd, Result, RD1, RD2);
    imem imem(clk, 1'b0, PC, 32'b0, Instr);
    dmem dmem(clk, MemWrite, DataAdr, WriteData, ReadData);
endmodule
