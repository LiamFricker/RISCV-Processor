`timescale 1 ns / 1 ps

// Module definition
module ALUController (
    ALUOp, Funct7, Funct3, Operation
    );

    // Define the input and output signals
    input [1:0] ALUOp;
    input [6:0] Funct7;
    input [2:0] Funct3;
    output [3:0] Operation;

    // Define the ALUController modules behavior
    assign Operation[0] = 
    ((Funct3 == 3'b110) || ((Funct3 == 3'b010) && (ALUOp[0] == 1'b0)))
    ? 1'b1 : 1'b0; 
    assign Operation[1] = ((Funct3 == 3'b000) || (Funct3 == 3'b010)) 
    ? 1'b1 : 1'b0; 
    assign Operation[2] = 
    ((Funct3 == 3'b100) || ((Funct3 == 3'b010) && (ALUOp[0] == 1'b0))
    || ((Funct3 == 3'b000) && (Funct7[5] == 1'b1))) ? 1'b1 : 1'b0; 
    assign Operation[3] = (Funct3 == 3'b100) ? 1'b1 : 1'b0; 

endmodule // ALUController

