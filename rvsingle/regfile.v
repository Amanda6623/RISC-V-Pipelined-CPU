module regfile(input clk, WE,
                input [4:0] A1, A2, A3,
                input [31:0] WD3,
                output [31:0] RD1, RD2);
    
    reg [31:0] Data [31:0];

    assign RD1 = Data[A1];
    assign RD2 = Data[A2];
    initial Data[0] = 32'b0;

    always @(posedge clk) begin
        if (WE & (A3 != 0)) Data[A3] <= WD3;
        
    end
endmodule