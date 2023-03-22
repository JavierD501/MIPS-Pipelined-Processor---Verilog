`timescale 1ns / 1ps

module CPUDatapath(
	input CLK,
	input RST
	);
    
	//IF Wires
	wire[31:0] PCF, PCPlus4F, PCPrime, PCRDOut;
    
	//ID Wires Input LHS --------------------------------------------------------------------------------------------

	wire[31:0] InstrD, PCPlus4D;
    
	//ID Wires Input RHS
	wire[31:0] RD1DOut, RD2DOut, signImmediateDOut;
    
	//ID Control Unit Wires
	wire regWriteD, memToRegD, memWriteD, branchD, ALUSrcD, regDstD;
	wire[2:0] ALUControlD;
    
	//Exe Wires Input LHS -------------------------------------------------------------------------------------------
	wire[31:0] SrcAE, SrcBE, writeDataE, signImmediateE, signImmediateShiftE, PCPlus4E;
	wire[4:0] RTE, RDE;
    
	//Exe Wires Input RHS
	wire[31:0] ALUOutE, PCPlusSignImmediateShiftE;
	wire[4:0] writeRegE;
	wire ZeroE;
    
	//Exe Control Unit Wires
	wire regWriteE, memToRegE, memWriteE, branchE, ALUSrcE,regDstE;
	wire[2:0] ALUControlE;
    
	//Mem Wire Inputs LHS -------------------------------------------------------------------------------------------
	wire ZeroM;
	wire[31:0] ALUOutM, writeDataM, PCBranchM;
	wire[4:0] writeRegM;
    
	//Mem Wire Inputs RHS
	wire PCSrcM;
	wire[31:0] readDataM;
    
	//Mem Control Unit Wires
	wire regWriteM, memToRegM, memWriteM, branchM;
    
	//WB Wire Inputs LHS ---------------------------------------------------------------------------------------------
	wire[31:0] ALUOutW, readDataW;
	wire[4:0] writeRegW;
    
	//WB Wire Inputs RHS
	wire[31:0] resultW;
    
	//WB Control Unit Wires
	wire regWriteW, memToRegW;
    
	//IF Connections --------------------------------------------------------------------------------------------------
	regPC PC1(.CLK(CLK), .RST(RST), .D(PCPrime), .Q(PCF));
	instructionMem IM1(.instructionIn(PCF), .instructionOut(PCRDOut));
	adder ADD1(.A(PCF), .B(32'd4), .D(PCPlus4F));
	mux2_data MUX1(.D1(PCBranchM), .D0(PCPlus4F), .Sel(regWriteW), .Out(PCPrime));
	regIfToID IntermediateReg1(.CLK(CLK), .RST(RST), .instrIN(PCRDOut), .instrOUT(InstrD), .PCPlus4F(PCPlus4F), .PCPlus4D(PCPlus4D));
    
	//ID Connections ---------------------------------------------------------------------------------------------------
	controlUnit CONTROL1(.opcode(InstrD[31:26]), .funct(InstrD[5:0]), .regWriteD(regWriteD), .memToRegD(memToRegD), .memWriteD(memWriteD), .branchD(branchD), .ALUControlD(ALUControlD), .ALUSrcD(ALUSrcD), .regDstD(regDstD));
	RegisterFile REGFILE1(.ReadRegister1(InstrD[25:21]), .ReadRegister2(InstrD[20:16]), .WriteRegister(writeRegW), .WriteData(resultW), .RegWrite(regWriteW), .Clk(CLK), .ReadData1(RD1DOut), .ReadData2(RD2DOut));
	signExtender EXTEND1(.A(InstrD[15:0]), .Out(signImmediateDOut));
	regIDtoEx IntermediateReg2(.CLK(CLK), .RST(RST), .RegWriteD(regWriteD), .MemToRegD(memToRegD), .MemWriteD(memWriteD), .BranchD(branchD), .ALUControlD(ALUControlD), .ALUSrcD(ALUSrcD), .RegDSTD(regDstD), .RD1D(RD1DOut), .RD2D(RD2DOut), .RTD(InstrD[20:16]), .RDD(InstrD[15:11]),
	.SignImmD(signImmediateDOut), .PCPlus4D(PCPlus4D), .RegWriteE(regWriteE), .MemToRegE(memToRegE), .MemWriteE(memWriteE), .BranchE(branchE), .ALUControlE(ALUControlE), .ALUSrcE(ALUSrcE), .RegDstE(regDstE), .RD1E(SrcAE), .RD2E(writeDataE), .RTE(RTE), .RDE(RDE), .SignImmE(signImmediateE), .PCPlus4E(PCPlus4E));
    
	//Exe Connections ---------------------------------------------------------------------------------------------------
	ALU ALU1(.A(SrcAE), .B(SrcBE), .Control(ALUControlE), .zeroFlag(ZeroE), .ALUOut(ALUOutE));
	mux2_data MUX2(.D1(signImmediateE), .D0(writeDataE), .Sel(ALUSrcE), .Out(SrcBE));
	mux2_data MUX3(.D1(RDE), .D0(RTE), .Sel(regDstE), .Out(writeRegE));
	shifter SHIFT1(.A(signImmediateE), .Out(signImmediateShiftE));
	adder ADD2(.A(signImmediateShiftE), .B(PCPlus4E), .D(PCPlusSignImmediateShiftE));
	regExtoMem IntermediateReg3(.CLK(CLK), .RST(RST), .regWriteE(regWriteE), .MemToRegE(memToRegE), .MemWriteE(memWriteE), .BranchE(branchE), .ZeroE(ZeroE), .ALUOutE(ALUOutE), .WriteDataE(writeDataE), .WriteRegE(writeRegE), .PCBranchE(PCPlusSignImmediateShiftE),
	.regWriteM(regWriteM), .MemToRegM(memToRegM), .MemWriteM(memWriteM), .BranchM(branchM), .ZeroM(ZeroM), .ALUOutM(ALUOutM), .WriteDataM(writeDataM), .WriteRegM(writeRegM), .PCBranchM(PCBranchM));
    
	//Mem Connections ----------------------------------------------------------------------------------------------------
	dataMem MEM1(.CLK(CLK), .RST(RST), .memLocation(ALUOutM), .writeData(writeDataM), .writeEn(memWriteM), .readData(readDataM));
	assign PCSrcM = branchM  & ZeroM;
	regMemtoWB IntermediateReg4(.CLK(CLK), .RST(RST), .regWriteM(regWriteM), .MemToRegM(memToRegM), .ALUOutM(ALUOutM), .ReadDataM(readDataM), .WriteRegM(writeRegM),
	.regWriteW(regWriteW), .MemToRegW(memToRegW), .ALUOutW(ALUOutW), .ReadDataW(readDataW), .WriteRegW(writeRegW));
    
	//WB Connections -----------------------------------------------------------------------------------------------------
	mux2_data MUX4(.D1(readDataW), .D0(ALUOutW), .Sel(memToRegW), .Out(resultW));
    
    
    
endmodule



