`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:37:18 04/20/2024 
// Design Name: 
// Module Name:   Instruction_Fetch_CC
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
module Instruction_Fetch_CC(  
    input clk, rst, PCSrcE,
    input [31:0] PCTargetE,
    output [31:0] InstrD, PCD
); 
    wire [31:0] PC_F, PCF, PCPlus4F, InstrF;
    reg [31:0] InstrF_r, PCF_r; 

    Mux2 MUX_F(
        .a(PCPlus4F), 
        .b(PCTargetE), 
        .s(PCSrcE), 
        .c(PC_F)
    );

    Program_Counter PC(
        .clk(clk), 
        .rst(rst),
        .PC_Next(PC_F), 
        .PC(PCF)
    );

    Instruction_Memory INSTR_MEM(
        .rst(rst), 
        .A(PCF), 
        .RD(InstrF)
    );

    Adder PC_ADDER(
        .a(PCF), 
        .b(32'd4), 
        .c(PCPlus4F)
    );

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            InstrF_r <= 32'd0;
            PCF_r <= 32'd0;
        end 
        else begin 
            InstrF_r <= InstrF;
            PCF_r <= PCF;
        end
    end 
 
    assign InstrD = InstrF_r;
    assign PCD = PCF_r;
endmodule