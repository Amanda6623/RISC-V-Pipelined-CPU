module top(input clk, reset,
            output [31:0] WriteData, DataAdr,
            output MemWrite);

    wire [31:0] PC, Instr, ReadData;
    
    // instantiate processor and memories
    rvpipeline rvpipe(clk, reset, Instr, ReadData, PC, MemWrite, DataAdr, WriteData);

    imem imem(clk, PC, 32'b0, Instr);
    dmem dmem(clk, MemWrite, DataAdr, WriteData, ReadData);
endmodule
