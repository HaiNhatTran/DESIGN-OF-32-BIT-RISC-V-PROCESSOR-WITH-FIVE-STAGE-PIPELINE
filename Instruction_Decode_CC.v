`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:46:41 04/20/2024 
// Design Name: 
// Module Name:    Instruction_Decode_CC
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
module Instruction_Decode_CC(
    input clk, rst, RegWriteW,
    input [4:0] RDW, 
    input [31:0] PCD, InstrD, ResultW,
    output RegWriteE, ResultSrcE, MemWriteE, BranchE, ALUSrcE,
    output [3:0] ALUControlE,
    output [4:0] RDE, RS1E, RS2E,
    output [31:0] RD1E, RD2E, PCE, ImmExtE
    );
    
    wire RegWriteD, ALUSrcD, MemWriteD, ResultSrcD, BranchD;
    wire [1:0] ImmSrcD;
    wire [3:0] ALUControlD;
    wire [31:0] RD1D, RD2D, ImmExtD;
    
    reg RegWriteD_r, ALUSrcD_r, MemWriteD_r, ResultSrcD_r, BranchD_r;
    reg [3:0] ALUControlD_r;
    reg [4:0] RDD_r, RS1D_r, RS2D_r, RS1E_r, RS2E_r;
    reg [31:0] RD1D_r, RD2D_r, PCD_r, ImmExtD_r;
    
    Control_Unit CU(
         .Op(InstrD[6:0]), 
         .funct7(InstrD[31:25]), 
         .funct3(InstrD[14:12]), 
         .RegWrite(RegWriteD), 
         .ALUSrc(ALUSrcD), 
         .MemWrite(MemWriteD), 
         .ResultSrc(ResultSrcD), 
         .Branch(BranchD), 
         .ImmSrc(ImmSrcD), 
         .ALUControl(ALUControlD)
         );
    Register_File RegFile (
         .clk(clk), 
         .rst(rst), 
         .WE(RegWriteW), 
         .A1(InstrD[19:15]), 
         .A2(InstrD[24:20]), 
         .A3(RDW), 
         .WD(ResultW), 
         .RD1(RD1D), 
         .RD2(RD2D)
         );
    Extend EXT ( 
         .In(InstrD), 
         .ImmSrc(ImmSrcD), 
         .Imm_Ext(ImmExtD)
         );
         
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            RegWriteD_r <= 0;
            ResultSrcD_r <= 0;
            MemWriteD_r <= 0;
            BranchD_r <= 0;
            ALUControlD_r <= 0;
            ALUSrcD_r <= 0;
            RD1D_r <= 0;
            RD2D_r <= 0;
            PCD_r <= 0;
            RS1E_r <= 0;
            RS2E_r <= 0;
            RDD_r <= 0;
            ImmExtD_r <= 0;
        end else begin
            RegWriteD_r <= RegWriteD;
            ResultSrcD_r <= ResultSrcD;
            MemWriteD_r <= MemWriteD;
            BranchD_r <= BranchD;
            ALUControlD_r <= ALUControlD;
            ALUSrcD_r <= ALUSrcD;
            RD1D_r <= RD1D;
            RD2D_r <= RD2D;
            PCD_r <= PCD;
            RS1E_r <= InstrD[19:15];
            RS2E_r <= InstrD[24:20];
            RDD_r <= InstrD[11:7];
            ImmExtD_r <= ImmExtD;
        end
    end
    
    assign RegWriteE = RegWriteD_r;
    assign ResultSrcE = ResultSrcD_r;
    assign MemWriteE = MemWriteD_r;
    assign BranchE = BranchD_r;
    assign ALUControlE = ALUControlD_r;
    assign ALUSrcE = ALUSrcD_r;
    assign RD1E = RD1D_r;
    assign RD2E = RD2D_r;
    assign PCE = PCD_r;
    assign RS1E = RS1E_r;
    assign RS2E = RS2E_r;
    assign RDE = RDD_r;
    assign ImmExtE = ImmExtD_r;
endmodule
