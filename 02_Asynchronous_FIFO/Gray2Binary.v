`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Purpose: practice verilog coding
// Engineer: Allen Li
// 
// Create Date: 12/30/2020 01:17:54 AM
// Design Name: binary nuymber to gray code converter
// Module Name: Binary2Gray
// Project Name: 
// Target Devices: 
// Tool Versions: vivado 2019.1
// Description:  
    // this module is used to covert gray code into binary counter.
// Dependencies: 
// 
// Revision: 
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module Gray2Binary(
    output [4:0] BIN_o,
    input [4:0] GRAY_i
);
wire [4:0] g;
wire [4:0] b;
assign g = GRAY_i;
assign BIN_o = b;

assign b[4] = g[4];
assign b[3] = g[3]^g[4];
assign b[2] = g[2]^g[3]^g[4];
assign b[1] = g[1]^g[2]^g[3]^g[4];
assign b[0] = g[0]^g[1]^g[2]^g[3]^g[4];
    
endmodule
