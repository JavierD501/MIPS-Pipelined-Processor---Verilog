`timescale 1ns / 1ps

module shifter(
	input [31:0] A,
	input [31:0] Out
	);
    
	assign Out = {A[29:0], 2'b00};
    
endmodule





