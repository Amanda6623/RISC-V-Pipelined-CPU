module hazard(RegWriteW, RdW, RegWriteM, RdM, ResultSrcE0, PCSrcE, Rs1E, Rs2E, RdE, Rs1D, Rs2D, StallF, StallD, FlushD, FlushE, ForwardAE, ForwardBE);
    input RegWriteW, RegWriteM, ResultSrcE0, PCSrcE;
    input [4:0] RdW, RdM, Rs1E, Rs2E, RdE, Rs1D, Rs2D;
    output reg StallF, StallD, FlushD, FlushE;
    output reg [1:0] ForwardAE, ForwardBE;

    reg lwStall;

    initial begin
        StallF = 0;
        StallD = 0;
    end

    // Forwarding
    always @(*) begin
        if (((Rs1E == RdM) & RegWriteM) & (Rs1E != 0)) ForwardAE = 2'b10;
        else if (((Rs1E == RdW) & RegWriteW) & (Rs1E != 0)) ForwardAE = 2'b01;
        else  ForwardAE = 2'b00;

        if (((Rs2E == RdM) & RegWriteM) & (Rs2E != 0)) ForwardBE = 2'b10;
        else if (((Rs2E == RdW) & RegWriteW) & (Rs2E != 0)) ForwardBE = 2'b01;
        else  ForwardBE = 2'b00;
    end

    // lw stalling
    always @(*) begin
        lwStall = ResultSrcE0 & ((Rs1D == RdE) | (Rs2D == RdE));
        {StallF, StallD} = {2{lwStall}};
    end

    // Branch misprediction
    assign FlushD = PCSrcE;
    assign FlushE = lwStall | PCSrcE;


endmodule