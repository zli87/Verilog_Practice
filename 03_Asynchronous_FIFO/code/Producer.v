`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Allen Li
// 
// Create Date: 12/29/2020 11:15:05 PM
// Design Name: Producer
// Module Name: Producer
// Project Name: Asynchronous FIFO
// Target Devices: 
// Tool Versions: Synopsys VCS 2020.3
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Producer #(parameter DATA_WIDTH=32) (
    input clk,
    input rst_n,
    input wfull_i,
    input already_wfull_i,
    output reg winc_o,
    output [DATA_WIDTH-1:0] wdata_o
    );

    reg [DATA_WIDTH-1:0] counter;

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

endmodule
