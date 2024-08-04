
`timescale 1ns/1ps

module tb_Instruction_Fetch_CC;

    // Inputs
    reg clk;
    reg rst;
    reg PCSrcE;
    reg StallF;
    reg StallD;
    reg FlushD;
    reg [31:0] PCTargetE;

    // Outputs
    wire [31:0] InstrD;
    wire [31:0] PCD;

    // Instantiate the Unit Under Test (UUT)
    Instruction_Fetch_CC uut (
        .clk(clk), 
        .rst(rst), 
        .PCSrcE(PCSrcE), 
        .StallF(StallF), 
        .StallD(StallD), 
        .FlushD(FlushD), 
        .PCTargetE(PCTargetE), 
        .InstrD(InstrD), 
        .PCD(PCD)
    );

    // Clock generation
    always #10 clk = ~clk;

    initial begin   
// testcase1: Dat lai tin hieu
        clk = 1; 
        rst = 1;
        PCSrcE = 0;
        StallF = 1;
        StallD = 1;
        FlushD = 0;
        PCTargetE = 32'h0;
        #20;
// testcase2: tang dia chi pc thong thuong       
        rst = 0;
        #60;
    
        PCTargetE = 32'h3c;
        #20;
        
        PCSrcE = 1;
        #20;
        
        PCSrcE = 0;
        StallF = 1;
        #20;
        
        StallF = 0;
        FlushD = 1;
        #20;
        
        FlushD = 0;
        StallD = 1;
        FlushD = 1;
        #20;
        
        $stop;
    end
      
endmodule
/*

initial begin
		  //Test Case 1: Reset
        rst = 1;          
        PCSrcE = 0;       
        PCTargetE = 32'h00000000;           
		#20;

       // Test Case 2: Chu ky fetch 
        rst = 0;                        
        PCSrcE = 0;          
        PCTargetE = 32'h00000028;    
        #60;
            
        
        // Test Case 3: Thuc hien nhay (branch)
        PCSrcE = 1;      
        #40;
        // Test Case 4: Tiep tuc chu ky fetch sau khi nha
        PCSrcE = 0;       // Dat tin hieu chon dia chi nhay la 0
        #40;
        $stop;            // stop simulator
*/