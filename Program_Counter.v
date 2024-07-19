`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/23/2024 03:20:49 PM
// Design Name: 
// Module Name: Program_Counter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Program_Counter(
    input clk, rst,
    input [31:0] PC_Next,
    output reg [31:0] PC
);

always @(posedge clk or posedge rst) begin
    if (rst) 
        PC <= 32'b0;     
    else
        PC <= PC_Next;  
end

endmodule
