////   Data Path /////
module data_path #(
    parameter PC_W = 8,       // Program Counter
    parameter INS_W = 32,     // Instruction Width
    parameter RF_ADDRESS = 5, // Register File Address
    parameter DATA_W = 32,    // Data WriteData
    parameter DM_ADDRESS = 9, // Data Memory Address
    parameter ALU_CC_W = 4    // ALU Control Code Width
 )(
    input                  clk ,    // CLK in datapath figure
    input                  reset,   // Reset in datapath figure      
    input                  reg_write,   // RegWrite in datapath figure
    input                  mem2reg,     // MemtoReg in datapath figure
    input                  alu_src,     // ALUSrc in datapath figure 
    input                  mem_write,   // MemWrite in datapath figure  
    input                  mem_read,    // MemRead in datapath figure          
    input  [ALU_CC_W-1:0]  alu_cc,      // ALUCC in datapath figure
    output          [6:0]  opcode,      // opcode in dataptah figure
    output          [6:0]  funct7,      // Funct7 in datapath figure
    output          [2:0]  funct3,      // Funct3 in datapath figure
    output   [DATA_W-1:0]  alu_result   // Datapath_Result in datapath figure
 );

wire [7:0] PC;// = 8'b00000000;
wire [7:0] PCPlus4;// = 8'b00000100;
wire [31:0] Instruction;// = 0;

wire [4:0] rd_addr1_wire;// = 0;
wire [4:0] rd_addr2_wire;// = 0;
wire [4:0] wrt_addr_wire;// = 0;

wire [31:0] WriteBack_Data;// = 0;

wire [31:0] Reg1;// = 0;
wire [31:0] Reg2;// = 0;

wire [31:0] ExtImm;// = 0;

wire [31:0] SrcB;// = 0;

wire Carry_out;// = 0;
wire overflow;// = 0;
wire zero;// = 0;
wire [31:0] ALU_Result;// = 0;

wire DataMem_read;// = 0;

// Write your code here

//FlipFlop
FlipFlop ff(.clk(clk), .reset(reset), .d(PCPlus4), .q(PC));

//Adder
assign PCPlus4 = PC + 4;

//Instr_mem
InstMem im(.addr(PC), .instruction(Instruction));

//Misc Wiring
assign rd_addr1_wire = Instruction[19:15];
assign rd_addr2_wire = Instruction[24:20];
assign wrt_addr_wire = Instruction[11:7];
assign opcode = Instruction[6:0];
assign funct3 = Instruction[14:12];
assign funct7 = Instruction[31:25];

//RegFile
RegFile rf(.clk(clk), .reset(reset), .rg_wrt_en(reg_write), .rg_wrt_addr(wrt_addr_wire), 
  .rg_rd_addr1(rd_addr1_wire), .rg_rd_addr2(rd_addr2_wire), 
  .rg_wrt_data(WriteBack_Data), .rg_rd_data1(Reg1), .rg_rd_data2(Reg2));
  
//ImmGen
ImmGen ig(.InstCode(Instruction), .ImmOut(ExtImm));

//First Mux21
MUX21 m1(.D1(Reg2), .D2(ExtImm), .S(alu_src), .Y(SrcB));

//ALU
alu_32 a(.A_in(Reg1), .B_in(SrcB), .ALU_Sel(alu_cc), .ALU_Out(ALU_Result), 
.Carry_Out(Carry_out), .Zero(zero), .Overflow(overflow));
assign alu_result = ALU_Result;

//DataMem
DataMem dm(.MemRead(mem_read), .MemWrite(mem_write), .addr(ALU_Result[8:0]), 
.write_data(Reg2), .read_data(DataMem_read));

//Second Mux21
MUX21 m2(.D1(ALU_Result), .D2(DataMem_read), .S(mem2reg), .Y(WriteBack_Data));

endmodule // Datapath
