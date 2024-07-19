`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/27/2024 02:07:42 AM
// Design Name: 
// Module Name: Division
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


module Division(
    input [31:0] A,B,
    output reg [31:0] Div, Rem
    );

   reg signed [31:0] SignedA, SignedB, UnsignedA, UnsignedB;
   integer i;

   always @(A or B) begin
      SignedA = A;
      SignedB = B;
      UnsignedA = A[31] ? -SignedA : SignedA;
      UnsignedB = B[31] ? -SignedB : SignedB;

      if (UnsignedB == 0) begin
         Div = 32'hX;
         Rem = 32'hX;
      end else begin
         Div = 32'h0;
         Rem = 32'h0;

         for (i = 31; i >= 0; i = i - 1) begin
            Rem = {Rem[30:0], UnsignedA[i]};
            if (Rem >= UnsignedB) begin
               Rem = Rem - UnsignedB;
               Div[i] = 1'b1;
            end
         end

         if (A[31] ^ B[31]) begin
            Div = -Div;
            Rem = -Rem;
         end
      end
   end
endmodule
