module tb_main_dec;
    reg [6:0] op;
    reg Zero;
    wire Branch, Jump, PCSrc, MemWrite, ALUSrc, RegWrite;
    wire [1:0] ResultSrc, ImmSrc, ALUOp;

    main_dec dut(.op(op), .Zero(Zero), .Branch(Branch), .Jump(Jump), .PCSrc(PCSrc), .MemWrite(MemWrite), .ALUSrc(ALUSrc), .RegWrite(RegWrite), .ResultSrc(ResultSrc), .ImmSrc(ImmSrc), .ALUOp(ALUOp));

    initial begin
        $dumpfile("tb_main_dec.vcd");
        $dumpvars(0, dut);
        $monitor
    end

    
endmodule