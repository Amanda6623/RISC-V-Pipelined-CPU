module imem(
	input clk,
	input [31:0] a, wd,
	output [31:0] rd
);
	
	reg [31:0] RAM [0:63];

	initial begin
		$readmemh("riscvtest.txt", RAM);
	end


	assign rd = RAM[a[31:2]];

	always @(posedge clk) begin
		if (we)
			RAM[a[31:2]] <= wd;
	end
endmodule                
