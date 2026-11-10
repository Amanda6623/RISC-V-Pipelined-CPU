module writeback(ResultSrc, ALUResult, ReadData, PCplus4, Result);
    input [1:0] ResultSrc;
    input [31:0] ALUResult, ReadData, PCplus4;
    output [31:0] Result;

    mux3 #(32) resultmux(ALUResult, ReadData, PCplus4, ResultSrc, Result);

endmodule