`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Purpose: practice verilog coding
// Engineer: Allen Li
// 
// Create Date: 12/30/2020 01:17:54 AM
// Design Name: Multiplier
// Module Name: TOP
// Project Name: Multiplier, and Random generator
// Target Devices: 
// Tool Versions: vivado 2019.1
// Description:  
    // this TOP module aims to wrapp subsystem's input and output to FPGA board.
// Dependencies: 
// 
// Revision: 
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module TOP(
input wire clk,
input wire rst,
output wire [7:0] Dout
    );
    wire rst_n;
    assign rst_n = ~rst;
    
    wire [3:0] A;
    wire [3:0] B;
    wire [7:0] D;
    
    //pseudo-random number generation with LFSR
    Random #(.SEED(32'h8456CAD7) ) inst_random0( .clk(clk), .rst_n(rst_n), .lsfr_o(A) );
    Random #(.SEED(32'h897EA5F3) ) inst_random1( .clk(clk), .rst_n(rst_n), .lsfr_o(B) );
    
    Multiplier wrapper( .clk(clk), .rst_n(rst_n), .A_i(A), .B_i(B), .D_o(D) );
    
    // use LCD pin to provide output timing constrain, otherwise vivado will not synthesize design...
    assign Dout = D; 
endmodule
