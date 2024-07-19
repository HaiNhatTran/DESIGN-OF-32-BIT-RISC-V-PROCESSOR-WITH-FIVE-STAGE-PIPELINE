`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:00:56 04/21/2024 
// Design Name: 
// Module Name:    Memory_Acess_CC
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Memory_Acess_CC(
	input clk, rst,
	input RegWriteM, ResultSrcM, MemWriteM,
	input [4:0] RDM,
	input [31:0] ALUResultM, WriteDataM,
	
	output RegWriteW, ResultSrcW, 
	output [4:0] RDW,
	output [31:0] ALUResultW, ReadDataW
    );
	
	wire [31:0] ReadDataM;

	reg RegWriteM_r, ResultSrcM_r;
	reg [4:0] RDM_r;
	reg [31:0] ALUResultM_r, ReadDataM_r;
	
	Data_Memory DT_MEM (
		 .clk(clk), 
		 .rst(rst), 
		 .WE(MemWriteM), 
		 .A(ALUResultM), 
		 .WD(WriteDataM), 
		 .RD(ReadDataM)
		 );
	always @(posedge clk or posedge rst) begin
		if(rst) begin
			RegWriteM_r <= 0;
			ResultSrcM_r <= 0;
			ALUResultM_r <= 0;
			ReadDataM_r <= 0;
			RDM_r <= 0;
		end
		else begin
			RegWriteM_r <= RegWriteM;
			ResultSrcM_r <= ResultSrcM;
			ALUResultM_r <= ALUResultM;
			ReadDataM_r <= ReadDataM;
			RDM_r <= RDM;
		end
	end	
	assign RegWriteW = RegWriteM_r;
	assign ResultSrcW = ResultSrcM_r;
	assign ALUResultW = ALUResultM_r;
	assign ReadDataW = ReadDataM_r;
	assign RDW = RDM_r;
endmodule
