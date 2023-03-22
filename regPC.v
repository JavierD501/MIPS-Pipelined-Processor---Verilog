`timescale 1ns / 1ps

module regPC(
    input CLK,
    input RST,
    input [31:0] D,
    output [31:0] Q
    );
    
    reg[31:0] Q;
    always @(posedge CLK or posedge RST)
    if(RST)
    Q <= 32'h00000000;
    else
    Q <= D;
    
endmodule





