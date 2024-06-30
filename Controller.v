`timescale 1 ns / 1 ps

// Module definition
module Controller (
    Opcode,
    ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite,
    ALUOp
    );
    
    // Define the input and output signals
    input [6:0] Opcode;
    output ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite;
    output [1:0] ALUOp;

    // Define the Controller modules behavior
    assign MemtoReg = (Opcode == 7'b0000011) ? 1'b1 : 1'b0; 
    assign MemWrite = (Opcode == 7'b0100011) ? 1'b1 : 1'b0; 
    assign MemRead = (Opcode == 7'b0000011) ? 1'b1 : 1'b0; 
    assign ALUSrc = ((Opcode == 7'b0000011) || (Opcode == 7'b0100011) || 
        (Opcode == 7'b0010011)) ? 1'b1 : 1'b0; 
    assign RegWrite = (Opcode == 7'b0100011) ? 1'b0 : 1'b1;
    assign ALUOp = ((Opcode == 7'b0000011) || (Opcode == 7'b0100011)) ? 2'b01 :  
        (Opcode == 7'b0010011) ? 2'b00 : (Opcode == 7'b0110011) ? 2'b10 : 2'b11;     

endmodule // Controller