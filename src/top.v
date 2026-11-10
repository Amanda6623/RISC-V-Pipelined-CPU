module top(input clk, reset,
            output [31:0] WriteData, DataAdr,
            output MemWrite);

    wire [31:0] PC, Instr, ReadData;
    
    // instantiate processor and memories
    rvpipeline rvpipe(clk, reset, Instr, ReadData, PC, MemWrite, DataAdr, WriteData);

    mem imem(clk, 1'b0, PC, 32'b0, Instr);
    dmem dmem(clk, MemWrite, DataAdr, WriteData, ReadData);
endmodule