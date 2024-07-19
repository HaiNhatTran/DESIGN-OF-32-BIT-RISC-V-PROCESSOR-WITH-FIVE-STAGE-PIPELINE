`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:36:47 04/20/2024 
// Design Name: 
// Module Name:    Execute_CC 
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
module Execute_CC (
    input clk, rst,
    input RegWriteE, ResultSrcE, MemWriteE, BranchE, ALUSrcE,
    input [1:0] ForwardAE, ForwardBE,
    input [3:0] ALUControlE,
    input [4:0] RDE,
    input [31:0] RD1E, RD2E, ImmExtE, PCE, ResultW,
    
    output RegWriteM, ResultSrcM, MemWriteM, PCSrcE,
    output [4:0] RDM,
    output [31:0] WriteDataM, PCTargetE, ALUResultM
    );

    // Internal wires
    wire ZeroE;
    wire [31:0] SrcAE, SrcBE, ALUResultE, SrcBE_out;

    // Pipeline registers
    reg RegWriteE_r, ResultSrcE_r, MemWriteE_r;
    reg [4:0] RDE_r;
    reg [31:0] WriteDataE_r, ALUResultE_r;

    // Forwarding multiplexers
    Mux3 MUX3_E1 (
        .a(RD1E), 
        .b(ResultW), 
        .c(ALUResultM), 
        .s(ForwardAE), 
        .d(SrcAE)
    );

    Mux3 MUX3_E2 (
        .a(RD2E), 
        .b(ResultW), 
        .c(ALUResultM), 
        .s(ForwardBE), 
        .d(SrcBE)
    ); 

    // ALU source multiplexer
    Mux2 MUX_E (
        .a(SrcBE), 
        .b(ImmExtE), 
        .s(ALUSrcE), 
        .c(SrcBE_out)
    );

    // ALU operation
    ALU ALU (
        .A(SrcAE), 
        .B(SrcBE_out), 
        .ALUControl(ALUControlE), 
        .Carry(), 
        .OverFlow(), 
        .Zero(ZeroE), 
        .Negative(), 
        .Result(ALUResultE)
    );

    // PC target calculation
    Adder ADDER_E (
        .a(PCE), 
        .b(ImmExtE), 
        .c(PCTargetE)
    );    

    // Register updates at clock edges or reset
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            RegWriteE_r <= 0;
            ResultSrcE_r <= 0;
            MemWriteE_r <= 0;
            ALUResultE_r <= 0;
            WriteDataE_r <= 0;
            RDE_r <= 0;
        end else begin
            RegWriteE_r <= RegWriteE;
            ResultSrcE_r <= ResultSrcE;
            MemWriteE_r <= MemWriteE;
            ALUResultE_r <= ALUResultE;
            WriteDataE_r <= SrcBE;
            RDE_r <= RDE;
        end
    end

    // Assign outputs to pipelined register values
    assign RegWriteM = RegWriteE_r;
    assign ResultSrcM = ResultSrcE_r;
    assign MemWriteM = MemWriteE_r;
    assign ALUResultM = ALUResultE_r;
    assign WriteDataM = WriteDataE_r;
    assign RDM = RDE_r;

    // Determine if the branch should be taken
    assign PCSrcE = BranchE & ZeroE;

endmodule
