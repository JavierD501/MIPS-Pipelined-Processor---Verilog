`timescale 1ns / 1ps


module dataMem(
    input CLK,
    input RST,
    input [31:0] memLocation,
    input [31:0] writeData,
    input writeEn,
    output [31:0] readData
    );

    
	reg[31:0] memory [1023:0];//32 bit wide with 1024 depth
	genvar i;
	generate for(i= 0; i < 1024; i= i + 1)
	begin:gen_for
    	always@(posedge CLK or posedge RST)
    	begin
        	if(RST)begin
            	memory[i] <= 32'h00000000;
        	end
        	else if(writeEn & memLocation == i)
            	memory[i] <= writeData;
    	end
	end
	endgenerate
    
	assign readData = memory[memLocation];

endmodule






