`timescale 1ns / 1ps

module controlUnit(
    input [5:0] opcode,
    input [5:0] funct,
    output regWriteD,
    output memToRegD,
    output memWriteD,
    output branchD,
    output [2:0] ALUControlD,
    output ALUSrcD,
    output regDstD
    );
    reg [2:0] ALUControlD;
    reg regWriteD, memToRegD, memWriteD, branchD, ALUSrcD,regDstD;
    
    always @(*)
    begin
    case(opcode)
    6'b00000: begin //various instructions, look at funct
    	case(funct)
    	6'b100000: begin //0 opcode/ 20hex funct
            	regWriteD = 1'b1;
            	memToRegD = 1'b0;
            	memWriteD = 1'b0;
            	branchD  = 1'b0;
            	ALUControlD = 3'b010;
            	ALUSrcD = 1'b0;
            	regDstD  = 1'b1;
        	end
     	6'b100010: begin //subtract 22hex function
            	regWriteD = 1'b1;
            	memToRegD = 1'b0;
            	memWriteD = 1'b0;
            	branchD  = 1'b0;
            	ALUControlD = 3'b000;
            	ALUSrcD = 1'b0;
            	regDstD  = 1'b1;
        	end
      	6'b100100: begin //AND 24hex function
            	regWriteD = 1'b1;
            	memToRegD = 1'b0;
            	memWriteD = 1'b0;
            	branchD  = 1'b0;
            	ALUControlD = 3'b000;
            	ALUSrcD = 1'b0;
            	regDstD  = 1'b1;
        	end
     	6'b100101: begin //or 25hex function
            	regWriteD = 1'b1;
            	memToRegD = 1'b0;
            	memWriteD = 1'b0;
            	branchD  = 1'b0;
            	ALUControlD = 3'b001;
            	ALUSrcD = 1'b0;
            	regDstD  = 1'b1;
        	end
      	6'b101010: begin //slt 2ahex function
            	regWriteD = 1'b1;
            	memToRegD = 1'b0;
            	memWriteD = 1'b0;
            	branchD  = 1'b0;
            	ALUControlD = 3'b111;
            	ALUSrcD = 1'b0;
            	regDstD  = 1'b1;
        	end
        	default: begin
            	regWriteD = 1'b1;
            	memToRegD = 1'b0;
            	memWriteD = 1'b0;
            	branchD  = 1'b0;
            	ALUControlD = 3'b010;
            	ALUSrcD = 1'b0;
            	regDstD  = 1'b1;
        	end
        	endcase
    	end
    
    6'b001000: begin //addi 8hex
    	regWriteD = 1'b1;
    	memToRegD = 1'b0;
    	memWriteD = 1'b0;
    	branchD  = 1'b0;
    	ALUControlD = 3'b010;
    	ALUSrcD = 1'b1;
    	regDstD  = 1'b0;
    end
    
    6'b100011: begin //lw 23hex
    	regWriteD = 1'b1;
    	memToRegD = 1'b1;
    	memWriteD = 1'b0;
    	branchD  = 1'b0;
    	ALUControlD = 3'b010;
    	ALUSrcD = 1'b1;
    	regDstD  = 1'b0;
    end
    
    6'b101011: begin //sw 2bhex
    	regWriteD = 1'b0;
    	memToRegD = 1'b0;
    	memWriteD = 1'b1;
    	branchD  = 1'b0;
    	ALUControlD = 3'b010;
    	ALUSrcD = 1'b1;
    	regDstD  = 1'b0;
    end
    
    6'b000100: begin //BEQ 4hex
    	regWriteD = 1'b0;
    	memToRegD = 1'b0;
    	memWriteD = 1'b0;
    	branchD  = 1'b1;
    	ALUControlD = 3'b110;
    	ALUSrcD = 1'b0;
    	regDstD  = 1'b0;
    end
    
	default: begin
    	regWriteD = 1'b0;
    	memToRegD = 1'b0;
    	memWriteD = 1'b0;
    	branchD  = 1'b0;
    	ALUControlD = 3'b000;
    	ALUSrcD = 1'b0;
    	regDstD  = 1'b0;
    	end
    
    endcase
    end
endmodule





