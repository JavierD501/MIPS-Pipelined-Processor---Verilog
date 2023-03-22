`timescale 1ns / 1ps

module regExtoMem(
    input CLK,
    input RST,
    input regWriteE,
    input MemToRegE,
    input MemWriteE,
    input BranchE,
    input ZeroE, //Comes from ALU. Have to modify ALU to get this output
    input[31:0] ALUOutE,
    input [31:0] WriteDataE,
    input [4:0] WriteRegE,
    input [31:0] PCBranchE,
    output regWriteM,
    output MemToRegM,
    output MemWriteM,
    output BranchM,
    output ZeroM,
    output[31:0] ALUOutM,
    output[31:0] WriteDataM,
    output[4:0] WriteRegM,
    output[31:0] PCBranchM
    );
    
    reg regWriteM, MemToRegM, MemWriteM, BranchM,ZeroM;
    reg[4:0] WriteRegM;
    reg[31:0] ALUOutM, WriteDataM, PCBranchM;
    
always @(posedge CLK or posedge RST)
    begin
    if(RST)
    begin
    regWriteM = 1'b0;
    MemToRegM = 1'b0;
    MemWriteM = 1'b0;
    BranchM  = 1'b0;
    ZeroM = 1'b0;
    WriteRegM = 5'b00000;
    ALUOutM = 32'h00000000;
    WriteDataM = 32'h00000000;
    PCBranchM = 32'h00000000;
    end
    else
    begin
    regWriteM = regWriteE;
    MemToRegM = MemToRegE;
    MemWriteM = MemWriteE;
    BranchM  = BranchE;
    ZeroM = ZeroE;
    WriteRegM = WriteRegE;
    ALUOutM = ALUOutE;
    WriteDataM = WriteDataE;
    PCBranchM = PCBranchE;

    end
    end
endmodule





