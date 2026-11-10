module imem(input [31:0] a,
            output [31:0] rd);

   reg [31:0] RAM[0:63];
   integer i;
    
   initial begin
      for(i = 0; i < 64; i = i + 1) begin
         RAM[i] = 32'b0;
      end
      $readmemh("../src/riscvtest.txt", RAM, 0, 20);
   end
   assign rd = RAM[a[31:2]]; // word aligned
endmodule