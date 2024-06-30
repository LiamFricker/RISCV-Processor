`timescale 1ns / 1ps

module processor
(
    input clk , reset ,

    output [31:0] Result
);
    // Define the input and output signals
    wire [6:0] Op_code;
    wire ALU_Src;
    wire Mem_to_Reg;
    wire Reg_Write;
    wire Mem_Read;
    wire Mem_Write;
    wire [1:0] ALU_Op;
    
    wire [6:0] Funct_7;
    wire [2:0] Funct_3;
    wire [3:0] Operation;

    
    // Define the processor modules behavior
    Controller controll(.Opcode(Op_code) , .ALUSrc(ALU_Src), .MemtoReg(Mem_to_Reg), 
    .RegWrite(Reg_Write), .MemRead(Mem_Read), .MemWrite(Mem_Write), .ALUOp(ALU_Op));
    ALUController ALU_controll(.ALUOp(ALU_Op), .Funct7(Funct_7), .Funct3(Funct_3), 
        .Operation(Operation));
    data_path dp(.clk(clk), .reset(reset), .reg_write(Reg_Write), .mem2reg(Mem_to_Reg),
    .alu_src(ALU_Src), .mem_write(Mem_Write), .mem_read(Mem_Read), .alu_cc(Operation),
    .opcode(Op_code), .funct7(Funct_7), .funct3(Funct_3), .alu_result(Result));

endmodule // processor