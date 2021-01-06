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
    // this module is used to covert binary counter into gray code.
// Dependencies: 
// 
// Revision: 
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module Binary2Gray(
    input [4:0] BIN_i,
    output [4:0] GRAY_o
);
wire [4:0] g;
wire [4:0] b;
assign b = BIN_i;
assign GRAY_o = g;

assign g[4] = b[4];
assign g[3] = b[3]^b[4];
assign g[2] = b[2]^b[3];
assign g[1] = b[1]^b[2];
assign g[0] = b[0]^b[1];
    
endmodule
