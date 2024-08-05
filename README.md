# DESIGN-OF-32-BIT-RISC-V-PROCESSOR-WITH-FIVE-STAGE-PIPELINE

1. Instruction Fetch
1.1. Functions of the Instruction Fetch Stage
- Fetching Instructions: The IF stage retrieves instructions from the program memory based on the value of the Program Counter (PC).
- Updating the PC: After fetching the instruction, the PC is updated to point to the next instruction.
- Address Decoding: The IF stage decodes the address from the PC to determine the exact location of the instruction in memory.
- Sending Instructions to the Next Stage: The fetched instruction is sent to the Instruction Decode (ID) stage for further processing.

1.2. Block diagram
A detailed block diagram includes the following modules: the program input multiplexer, the adder, the program counter, the instruction memory, and the IF/ID register.
![image](https://github.com/user-attachments/assets/3ca6a9bd-e9df-4303-95af-ec9f37d260af)

1.3. Simulation Results
- Case 1: System Reset (0-20ns)
rst = 1: All outputs are set to 0.
- Case 2: PC Increment (20-80ns)
rst = 0, PCSrcE = 0: PC increments sequentially.
PCF values: 32’h00000004, 32’h00000008, 32’h0000000c.
Corresponding InstrF: 32’h00c00193, 32’hff718393, 32’h0023e233.
- Case 3: Address Jump (80-100ns)
rst = 0, PCSrcE = 1: PC jumps to target value.
PCTargetE: 32’h00000028.
Corresponding InstrF: 32’h23a233.
- Case 4: PC Increment after Jump (100-140ns)
rst = 0, PCSrcE = 0: PC increments sequentially post-jump.
PCF values: 32’h0000002c, 32’h00000030.
Corresponding InstrF: 32’h005203b3, 32’h402393b3.
![image](https://github.com/user-attachments/assets/3556d1ae-f3e7-4e5f-8ec3-a3dda994fbfe)

2. Instruction Decode

2.1. Functions of the Instruction Decode Stage
The ID stage is responsible for converting the instruction from binary code into a form that can be used by the following stages in the pipeline.
- Instruction Decoding: Analyzing the fetched instruction to determine its type and required operands.
- Decoding Operands and Registers: Identifying the registers and parameters specified in the instruction.
- Generating Control Signals: Producing control signals for other processor components based on the instruction type and operands.

2.2 Block diagram
A detailed block diagram includes the following modules: the control unit with the decoder.
![image](https://github.com/user-attachments/assets/f03ccca7-fa52-4f1e-b611-4d827a3780c6)

2.3. The control signal state table for each instruction type
![image](https://github.com/user-attachments/assets/a158d802-08f7-4709-b239-afef20881ef3)

2.4. The ALU control signal state table
![image](https://github.com/user-attachments/assets/20f0e795-f9cf-4b8e-8a0d-480ef3d8d926)

2.5. Simulation Results
- Case 1 (0-20ns): System Reset
rst = 1: All outputs are set to 0.

- Case 2 (20-100ns): Register File Write
rst = 0
20-60ns: RegWriteW = 0 (No write to register x3)
60-100ns: RegWriteW = 1 (Value written to x3)

- Case 3 (100-140ns): Load Instruction Control
Control Signals:
RegWriteE = 1, ResultSrcE = 1, MemWriteE = 0, BranchE = 0, ALUSrcE = 1
ALUControlE = 4’b0000 (Addition)

- Case 4 (140-180ns): Store Instruction Control
Control Signals:
RegWriteE = 0, ResultSrcE = 0, MemWriteE = 1, BranchE = 0, ALUSrcE = 1
ALUControlE = 4’b0000 (Addition)

- Case 5 (180-220ns): Branch Instruction Control
Control Signals:
RegWriteE = 0, ResultSrcE = 0, MemWriteE = 0, BranchE = 1, ALUSrcE = 0
ALUControlE = 4’b0001 (Subtraction)

- Case 6 (220-260ns): Immediate Type Instruction Control
Control Signals:
RegWriteE = 1, ResultSrcE = 0, MemWriteE = 0, BranchE = 0, ALUSrcE = 1
ALUControlE = 4’b0000 (Addition)

- Case 7 (260-300ns): R-type Instruction Control
Control Signals:
RegWriteE = 1, ResultSrcE = 0, MemWriteE = 0, BranchE = 0, ALUSrcE = 1
ALUControlE = 4’b0000 (Addition)

