`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Purpose: practice verilog coding
// Engineer: Allen Li
// 
// Create Date: 12/30/2020 01:17:54 AM
// Design Name: Async_FIFO
// Module Name: Async_FIFO
// Project Name: 
// Target Devices: 
// Tool Versions: vivado 2019.1
// Description:  
    // Async_FIFO
// Dependencies: 
// 
// Revision: 
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module FIFO_MEM #(
    parameter DATA_WIDTH = 32
)(
    // write port
    input wclk,
    input wclken,
    input [3:0] waddr,
    input [DATA_WIDTH-1:0] wdata,
    //read port
    input rclk,
    input rrst_n,
    input [3:0] raddr,
    output [DATA_WIDTH-1:0] rdata
); 
    reg [DATA_WIDTH-1:0] MEM [15:0];

    always @(posedge wclk) begin
        if (wclken) begin
            MEM[waddr] <= wdata;
        end
    end
//    always @(posedge rclk or negedge rrst_n) begin
//        if (!rrst_n) begin
//            rdata <= 0;
//        end else begin
             
   assign   rdata = MEM[raddr];

endmodule