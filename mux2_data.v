`timescale 1ns / 1ps

module mux2_data(
	input [31:0] D0,
	input [31:0] D1,
	input Sel,
	output [31:0] Out
	);
	//Left = 1, right = 0
	assign Out=(Sel)?D1:D0;

    
endmodule





