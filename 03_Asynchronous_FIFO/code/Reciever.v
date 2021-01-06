`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Allen Li
// 
// Create Date: 12/29/2020 11:15:05 PM
// Design Name: Reciever
// Module Name: Reciever
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


module Reciever #(parameter DATA_WIDTH=32) (
    input clk,
    input rst_n,
    input rempty_i,
    input already_rempty_i,
    output reg rinc_o,
    input [DATA_WIDTH-1:0] rdata_i
    );

    reg [DATA_WIDTH-1:0] counter;

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
// check whether rdata equal to counter 
always@(posedge clk) begin
    if(rinc_o) begin
        if(counter != rdata_i) begin
            $error("counter=%d, rdata=%d",counter,rdata_i);
            #30 $finish;
        end
        if(32'd100 == counter) begin
            $display("===================================");
            $display("PASS at count %d !",counter);
            $display("===================================");
            $finish;
        end
   end
end
endmodule