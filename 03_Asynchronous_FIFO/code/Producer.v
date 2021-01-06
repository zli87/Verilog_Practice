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


module Producer (
    input clk,
    input rst_n,
    input wfull_i,
    input already_wfull_i,
    output reg winc_o,
    output [31:0] wdata_o
    );
//    wire [31:0] rand;
    reg [31:0] counter;
always@(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        counter <=0;
    end else begin 
        counter <= ( ~(wfull_i | already_wfull_i) )? counter + 1 : counter;
   end
end    
assign wdata_o = counter;

always@(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        winc_o <=0;
    end else begin 
        winc_o <= ( ~(wfull_i | already_wfull_i) )? 1 : 0;
   end
end
//wire [3:0] cnt_in;
//wire [3:0] gray;
//wire [3:0] cnt_out;
//assign cnt_in = counter[3:0];


endmodule
