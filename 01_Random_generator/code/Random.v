`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Allen Li
// 
// Create Date: 12/30/2020 03:55:33 AM
// Design Name:  pseudo-random number generation
// Module Name: Random
// Project Name: Multiplier, and Random generator
// Target Devices: 
// Tool Versions: vivado 2019.1
// Description: 
//  pseudo-random number generation with linear-feedback shift register (LFSR)
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Random #(    
   parameter SEED = 32'h80000000   
)(
    input clk,
    input rst_n,
    output reg [31:0] lsfr_o
);
    reg [31:0] X;
    wire X0_next;
    wire [31:0] X_next;
    
// Feedback polynomial : x^32 + x^22 +x^2+x^1+ 1
//total sequences (maximum) : 2^32 - 1 = 429,49,67,295
    assign X0_next = X[31]^X[21]^X[1]^X[0];
    assign X_next = {X[30:0],X0_next};
    always@(posedge clk or posedge rst_n)begin
        if(!rst_n)begin
            X[31] <= 1;
            X[30:0] <= SEED; // prevent random sequence start at small number
        end else begin
            X <= X_next;
        end
    end
    
    always@(posedge clk or posedge rst_n)begin
        if(!rst_n)begin
            lsfr_o <= 0;
        end else begin
            lsfr_o <= X;
        end
    end
endmodule
