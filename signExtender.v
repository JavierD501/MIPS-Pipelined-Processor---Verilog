`timescale 1ns / 1ps

module signExtender(
	input [15:0] A,
	input [31:0] Out
	);
    
	assign Out = {{16{A[15]}}, A};
    
endmodule





