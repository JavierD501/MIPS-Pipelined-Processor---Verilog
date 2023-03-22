`timescale 1ns / 1ps

module regMemtoWB(
    input CLK,
    input RST,
    input regWriteM,
    input MemToRegM,
    input[31:0] ALUOutM,
    input[31:0] ReadDataM,
    input [4:0] WriteRegM,
    output regWriteW,
    output MemToRegW,
    output[31:0] ALUOutW,
    output[31:0] ReadDataW,
    output[4:0] WriteRegW
    );
    
    reg regWriteW, MemToRegW;
    reg[4:0] WriteRegW;
    reg[31:0] ALUOutW, ReadDataW;
    
    always @(posedge CLK or posedge RST)
    begin
    if(RST)
    begin
    regWriteW = 1'b0;
    MemToRegW = 1'b0;
    WriteRegW = 5'b00000;
    ALUOutW = 32'h00000000;
    ReadDataW = 32'h00000000;
    end
    else
    begin
    regWriteW = regWriteM;
    MemToRegW = MemToRegM;
    WriteRegW = WriteRegM;
    ALUOutW = ALUOutM;
    ReadDataW = ReadDataM;
	end
    end
endmodule





