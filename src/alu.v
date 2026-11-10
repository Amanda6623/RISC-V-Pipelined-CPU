module alu #(parameter n = 32) (
    input [(n-1):0] A, B,
    input [2:0] alucontrol,
    output reg [(n-1):0] result,
    output Zero
    );
    wire cin, cout, V, C, N;
    wire [(n-1):0] B_new, sum;

    assign B_new = alucontrol[0] ? ~B : B;
    assign cin = alucontrol[0] ? 1 : 0;
    assign {cout, sum} = A + B_new + cin;

    always @(A, B, sum, alucontrol) begin
        case (alucontrol)
            3'b000: result = sum;
            3'b001: result = sum;
            3'b010: result = A & B;
            3'b011: result = A | B;
            3'b101: result = (A < B) ? {31'b0, 1'b1} : 32'b0;
            default: result = 32'b0;
        endcase
    end

    assign Zero = &(~result);
    assign N = result[(n-1)];
    assign C = ~alucontrol[1] & cout;
    assign V = (alucontrol[0] ^ A[(n-1)] ^ B[(n-1)]) & (A[(n-1)] ^ sum[(n-1)]) & (~alucontrol[1]);

    // assign flags = {N, Z, C, V};

endmodule

