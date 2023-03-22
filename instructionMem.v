`timescale 1ns / 1ps

module instructionMem(
	input [31:0] instructionIn,
	output[31:0] instructionOut
	);
    
	reg [31:0] instructionOut;
    
	always@(*)
	begin
	case(instructionIn)     //R-Type op   rs    rt    rd    shamt     funct  Resepectively(6, 5, 5, 5, 5 ,6) BITS
                  		 //I-Type op    rs 	rt 	immediate

	32'h0 :instructionOut <=32'b001000_00000_00011_00000_00000_000000;// addi r3, r0, 0
        	32'h4 :instructionOut <=32'b001000_00000_00001_00000_00000_000001;// addi r1, r0, 1
32'h8 :instructionOut <=32'b001000_00000_00010_00000_00000_000101;// addi r2, r0, 5
        	32'hc :instructionOut <=32'b000000_00001_00010_00001_00000_100000;// add  r1, r1, r2
        	32'h10:instructionOut <=32'b001000_00010_00010_11111_11111_111111;// addi r2, r2, -1
        	32'h14:instructionOut <=32'b000100_00010_00011_00000_00000_000010;// beq r2, r3, (+2) 
        	32'h18:instructionOut <=32'b000100_00000_00000_11111_11111_111100;// beq r0, r0, (-4) 
        	32'h1c:instructionOut <=32'b100011_00001_01010_00000_00000_010100;// lw $10, 20($1)
	32'h20:instructionOut<=32'b000000_00001_00011_01011_00000_100010;// sub $11, $1, $3
        32'h24:instructionOut<=32'b000000_00011_00100_01100_00000_100000;// add $12, $3, $4
        32'h28:instructionOut<=32'b001000_00000_00010_00000_00000_100101;// addi r2, r0, 37
        32'h2c:instructionOut<=32'b000000_00101_00010_00110_00000_100000;// add $6, $5, $2
        32'h30:instructionOut<=32'b101011_00001_00010_00000_00000_010100;// sw $2, 20($1)
        32'h34:instructionOut<=32'b100011_00001_00110_00000_00000_010100;// lw $6, 20($1)
        32'h38:instructionOut<=32'b000000_00110_00011_01100_00000_100000;// add $12, $6, $3
        32'h3c:instructionOut<=32'b000000_00110_00001_01011_00000_100010;// sub $11, $6, $1
        32'h40:instructionOut<=32'b000000_01100_00110_01001_00000_100010;// sub $9, $12, $6
        default:instructionOut<=32'h0;
    endcase
end

endmodule







////
//	32'h0 : instructionOut <= 32'b001000_01000_01001_0000000000000001; //Following instruction formats: This is Immediate type opcode = 8hex.registers used $t1,$t0, #1 = t1 = t0 + 1
//	32'h4 : instructionOut <= 32'b000000_01110_11001_01111_00000_100010; //sub $t7, $t6, $t9: t7 = t6 - t9
//	32'h8 : instructionOut <= 32'b000000_01100_01110_01101_00000_100100; //and $t5, $t4, $t6: t5 = t4 & t6
//	32'hc : instructionOut <= 32'b000000_01010_01110_01011_00000_100101; //or $t3, $t2, $t6: t3 = t2 | t6
//	32'h10 : instructionOut <= 32'b000000_01110_11001_01100_00000_101010; //slt $t4, $t6, $t9
//	32'h14 : instructionOut <= 32'b100011_11000_11001_0000000000000010; //lw $t9, 2($t8)
//	32'h18 : instructionOut <= 32'b101011_01001_01000_0000000000000010; //sw $t0, 2($t1)
//	32'h1c : instructionOut <= 32'b000100_01010_01011_0000000000000110; //beq $t2, $t3, 6
//	//incremeted by 4 as pc increments by 4.
//                     			  //op	rs	rt	rd	shant function
//	32'h4 : instructionOut <= 32'b000000_01001_00000_01010_00000_100000;// This is R type. opcode = 0. Function = 20hex. registers : $t2,
//	default : instructionOut <= 32'h0;
//	endcase
//	end
//endmodule

////










