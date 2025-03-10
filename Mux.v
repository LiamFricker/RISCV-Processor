`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: MUX21
// 
//////////////////////////////////////////////////////////////////////////////////

module MUX21 (
        D1 , D2 , S , Y
);
 
input S;
input D1;
input D2;
output Y;

wire [32:0] D1;
wire [32:0] D2;
wire [32:0] Y;

// Define the modules 
assign Y = S ? D2 : D1; 

endmodule 

