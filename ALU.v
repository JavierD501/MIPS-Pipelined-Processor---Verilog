`timescale 1ns / 1ps

module ALU(
	input [31:0] A,
	input [31:0] B,
	input [2:0] Control,
	output zeroFlag,
	output [31:0] ALUOut
	);
    
	wire [31:0] A, B;
	wire [2:0] Control;
    
	reg [31:0] ALUOut;
    
	always @(A, B, Control)
	begin
    	case(Control)
    	0://AND op
        	ALUOut <= A & B;
    	1://OR op
        	ALUOut <= A | B;
    	2://ADD op
        	ALUOut <= A + B;
    	6://SUB op
        	ALUOut <= A - B;
    	7://SLT op
        	ALUOut <= (A < B) ? 1 : 0;

     	default:
        	ALUOut <= 32'h00000000;

    	endcase
   	 
	end
	assign zeroFlag = (ALUOut == 32'h0);
    
endmodule





