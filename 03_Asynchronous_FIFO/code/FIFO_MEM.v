`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Allen Li
// 
// Create Date: 12/30/2020 01:17:54 AM
// Design Name: FIFO memory
// Module Name: FIFO_MEM
// Project Name: Asynchronous FIFO
// Target Devices: 
// Tool Versions: Synopsys VCS 2020.3
// Description:  
//      simple dual port sram in the Asynchronous FIFO. One is sychronized write port with wclk, another is asynchronous read port.
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
             
   assign   rdata = MEM[raddr];

endmodule