//General
`define ZERO_DWORD 32'h00000000
`define RST_ENABLE 1'b1         //Reset enabled
`define RST_DISABLE 1'b0        //Reset disabled
`define CHIP_ENABLE 1'b1
`define CHIP_DISABLE 1'b0
`define WRITE_ENABLE 1'b1
`define WRITE_DISABLE 1'b0
`define READ_ENABLE 1'b1
`define READ_DISABLE 1'b0
`define ALU_OP_BUS 7:0          //ALU operation bus
`define ALU_SEL_BUS 2:0         //ALU sel bus
`define INST_VALID 1'b0
`define INST_INVALID 1'b1


`define INST_ADDR_BUS 31:0      //Instruction ROM address bus
`define INST_BUS 31:0           //Instruction ROM data bus
`define INST_MEM_NUM 131071     //ROM size: 128KB
`define INST_MEM_NUM_LOG2 17    //Actual instruction address width
//GPRs define
`define REG_ADDR_BUS 4:0    //32 GPRs need 5 bits address bus
`define REG_BUS 31:0        //GPRs data bus
`define REG_WIDTH 32        //GPRs size: 32 bits
`define REG_NUM 32          //Number of GPRs
`define REG_NUM_LOG2 5      //Actual register address width
`define NOP_REG_ADDR 5'b00000

//Instruction
`define EXE_ORI 6'b001101
`define EXE_NOP 6'b000000

//ALUop
`define EXE_OR_OP 8'b00100101
`define EXE_NOP_OP 8'b00000000

//ALUsel
`define EXE_RES_LOGIC 3'b001
`define EXE_RES_NOP 3'b000
