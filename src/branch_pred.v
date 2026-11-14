// module branch_pred(clk, PC, PCE, PCSrcE, PCSrc_predE, PCTargetE, PCPlus4F, PCSrc_predF, PCTargetF);
//     input clk, PCSrcE, PCSrc_predE;
//     input [31:0] PC, PCE, PCTargetE, PCPlus4F;
//     output PCSrc_predF;
//     output [31:0] PCTargetF;

//     reg [31:0] PClib [31:0];
//     reg [31:0] PCTarget [31:0];
//     reg [1:0] branch_state [31:0];

//     // State 00 = branch strongly not taken
//     // State 01 = branch weakly not taken
//     // State 10 = branch weakly taken
//     // State 11 = branch strongly taken


//     initial 


//     integer i;
//     integer a;
//     initial a = 0;

//     // BTB
//     always @(*) begin
//         case(PC)
//             PClib[0]: i = 0;
//             PClib[1]: i = 1;
//             ... continued
//             default: i = 32;    // when PC does not have an entry
//         endcase
//     end

//     // Branch state update
//     always @(*) begin
//         case()
//     end

//     // Update BHT and BTB tables
//     always @(posedge clk) begin
//         if(PCSrcE) begin
//             PClib[a] <= PCE;
//             PCTarget[a] <= PCTargetE;
//             branch_state[a] <= 2'b01;
//         end
//     end


//     always @(*) begin
//         branch_predict = 
//         PCSrc_predF =
//     end

// endmodule