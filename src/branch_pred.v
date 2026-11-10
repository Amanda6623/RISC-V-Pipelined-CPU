module branch_pred(clk, reset, taken, branch);
    input clk, reset, taken;
    output branch;

    wire [1:0] d;
    reg [1:0] q;

    // State 0 = branch strongly taken
    // State 1 = branch weakly taken
    // State 2 = branch weakly not taken
    // State 3 = branch strongly not taken

    always @(*) begin
        case(q)
            2'b00: d = taken ? 2'b00 : 2'b01;
            2'b01: d = taken ? 2'b00 : 2'b10;
            2'b10: d = taken ? 2'b01 : 2'b11;
            2'b11: d = taken ? 2'b10 : 2'b11;
        endcase
    end

    always @(posedge clk) begin
        if(reset) q <= 2'b10;
        else q <= d;
    end

    always @(*) begin
        case(q)
            2'b00: branch = 1;
            2'b01: branch = 1;
            2'b10: branch = 0;
            2'b11: branch = 0;
        endcase
    end

endmodule