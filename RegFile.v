`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Design Name: 
// Module Name: RegFile
// 
//////////////////////////////////////////////////////////////////////////////////


module RegFile(
  input clk, reset, rg_wrt_en,
  input [4:0] rg_wrt_addr, 
  input [4:0] rg_rd_addr1,
  input [4:0] rg_rd_addr2, 
  input [31:0] rg_wrt_data,
  output wire [31:0] rg_rd_data1,
  output wire [31:0] rg_rd_data2
);

// Define the input and output signals
reg [31:0] temp_rd_data1;
reg [31:0] temp_rd_data2;
reg [31:0] register_file [31:0];
integer i = 0;

// Define the Register File module behavior
always @(posedge clk or posedge reset) 
    begin
         if(reset==1'b1) //Reset
            for(i = 0; i < 32; i = i + 1)
                begin
                    register_file[i] <= 32'h00000000;
                end
         else //Not Reset
            if(rg_wrt_en==1'b1) //Write
                    register_file[rg_wrt_addr] <= rg_wrt_data;
            else //Read
                begin
                   temp_rd_data1 = register_file[rg_rd_addr1];
                   temp_rd_data2 = register_file[rg_rd_addr2]; 
                end
    end  

assign rg_rd_data1 = register_file[rg_rd_addr1];
assign rg_rd_data2 = register_file[rg_rd_addr2];

endmodule // RegFile
