module tb_aluflags;
    parameter n = 32;
    reg [(n-1):0] A, B;
    reg [1:0] alucontrol;
    wire [(n-1):0] result;
    wire [3:0] flags;

    aluflags uut (
        .A(A), 
        .B(B), 
        .alucontrol(alucontrol), 
        .result(result), 
        .flags(flags)
    );

    initial begin
        $dumpfile("aluflags.vcd");
        $dumpvars(0, uut);
        $monitor("time=%0t A=%0h B=%0h alucontrol=%0b result=%0h flags=%0b", $time, A, B, alucontrol, result, flags);
    end

    initial begin
        A = 'h00000000; B = 'h00000000; alucontrol = 2'b00;
        
        #10 A = 'h90000101; B = 'hA0001110;
        #10 alucontrol = 2'b01;
        #10 alucontrol = 2'b10;
        #10 alucontrol = 2'b11;

        #10 B = 'h80001200; alucontrol = 2'b01;
        #10;

        $finish;
    end
endmodule

