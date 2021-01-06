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


module Reciever (
    input clk,
    input rst_n,
    input rempty_i,
    input already_rempty_i,
    output reg rinc_o,
    input [31:0] rdata_i
    );
    reg [31:0] counter;

always@(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        rinc_o <=0;
    end else begin 
        rinc_o <= (~(rempty_i| already_rempty_i))? 1 : 0;
   end
end
// the same as the data sent from producer
always@(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        counter <= 1;
    end else begin 
        counter <= (rinc_o)? counter + 1 : counter;
   end
end
// checker
always@(posedge clk) begin
    if(rinc_o) begin
        if(counter != rdata_i) begin
            $error("counter=%d, rdata=%d",counter,rdata_i);
            #30 $finish;
        end
        if(32'd10000 == counter) begin
            $info("PASS at 10000 count!");
            $finish;
        end
   end
end
endmodule