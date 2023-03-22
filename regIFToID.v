`timescale 1ns / 1ps

module regIfToID(
	CLK,
	RST,
	instrIN,
	instrOUT,
	PCPlus4F,
	PCPlus4D
	);
    
	input CLK, RST;
	input wire [31:0] instrIN; //in
	output reg [31:0] instrOUT; //out
	input wire [31:0] PCPlus4F; //in
	output reg [31:0] PCPlus4D; //out
    
    
	always @(posedge CLK or posedge RST)
	begin
    	if(RST)
        	begin
        	PCPlus4D <= 32'h00000000;
        	instrOUT <= 32'h00000000;
        	end
    	else
        	PCPlus4D <= PCPlus4F;
        	instrOUT <= instrIN;
	end
    
endmodule






