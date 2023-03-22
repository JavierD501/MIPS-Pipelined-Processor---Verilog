`timescale 1ns / 1ps


module regIDtoEx(
    input CLK,
    input RST,
    input RegWriteD,
    input MemToRegD,
    input MemWriteD,
    input BranchD,
    input [2:0] ALUControlD,
    input ALUSrcD,
    input RegDSTD,
    input [31:0] RD1D,
    input [31:0] RD2D,
    input [4:0] RTD,
    input [4:0] RDD,
    input [31:0] SignImmD,
    input [31:0] PCPlus4D,
    output RegWriteE,
    output MemToRegE,
    output MemWriteE,
    output BranchE,
    output [2:0] ALUControlE,
    output ALUSrcE,
    output RegDstE,
    output [31:0] RD1E,
    output [31:0] RD2E,
    output [4:0] RTE,
    output [4:0] RDE,
    output [31:0] SignImmE,
    output [31:0] PCPlus4E
    );
    
    reg RegWriteE, MemToRegE, MemWriteE, BranchE,ALUSrcE, RegDstE;
    reg[2:0] ALUControlE;
    reg[4:0] RTE, RDE;
    reg[31:0] RD1E, RD2E, SignImmE, PCPlus4E;
    
    always @(posedge CLK or posedge RST)
    begin
    if(RST)
    begin
    RegWriteE = 1'b0;
    MemToRegE = 1'b0;
    MemWriteE = 1'b0;
    BranchE  = 1'b0;
    ALUSrcE  = 1'b0;
    RegDstE = 1'b0;
    ALUControlE  = 3'b000;
    RTE = 5'b00000;
    RDE= 5'b00000;
    RD1E = 32'h00000000;
    RD2E = 32'h00000000;
    SignImmE = 32'h00000000;
    PCPlus4E = 32'h00000000;
    end
    else
    begin
    RegWriteE = RegWriteD;
    MemToRegE = MemToRegD;
    MemWriteE = MemWriteD;
    BranchE  = BranchD;
    ALUSrcE  = ALUSrcD;
    RegDstE = RegDSTD;
    ALUControlE  = ALUControlD;
    RTE = RTD;
    RDE= RDD;
    RD1E = RD1D;
    RD2E = RD2D;
    SignImmE = SignImmD;
    PCPlus4E = PCPlus4D;
    end
    end
endmodule





