`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Allen Li
// 
// Create Date: 12/29/2020 11:15:05 PM
// Design Name: 
// Module Name: Multiplexer
// Project Name: Multiplier, and Random generator
// Target Devices: 
// Tool Versions: vivado 2019.1
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Multiplier (
    input clk,
    input rst_n,
    input [3:0] A_i,
    input [3:0] B_i,
    output reg[7:0] D_o
    );

always@(posedge clk) begin
    if (!rst_n) begin
        D_o <=0;
    end else begin 
        D_o <= A_i * B_i;
    end
end

endmodule
