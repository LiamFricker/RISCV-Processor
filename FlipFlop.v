`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: FlipFlop
//////////////////////////////////////////////////////////////////////////////////

// Module definition
module FlipFlop(
   input  clk , reset,
   input  [7:0] d,
   output [7:0] q
   );
 
reg [7:0] temp_q;   
// Write your code

always @(posedge clk) 
    begin
         if(reset==1'b1)
            temp_q <= 1'b0;
         else
            temp_q <= d;   
    end  

assign q = temp_q;

endmodule // FlipFlop



