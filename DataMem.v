`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
/// data memory
//////////////////////////////////////////////////////////////////////////////////

module DataMem(MemRead, MemWrite, addr, write_data, read_data);

// Define I/O ports
input MemRead;
input MemWrite; 
input [4:0] addr;
input [31:0] write_data;
output reg [31:0] read_data;

// Define the input and output signals
reg [31:0] DataMemory [127:0];

// Describe DataMem behavior 
always @(*)     
    begin
         if(MemRead==1'b1) //Read
            read_data = DataMemory[addr];
         if(MemRead==1'b1) //Write
            DataMemory[addr] = write_data;
    end  

endmodule // data_mem
     
