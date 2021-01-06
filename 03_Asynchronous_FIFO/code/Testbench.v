`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Allen Li
// 
// Create Date: 12/29/2020 11:15:05 PM
// Design Name: Testbench
// Module Name: Testbench
// Project Name:  Asynchronous FIFO
// Target Devices: 
// Tool Versions: Synopsys VCS 2020.3
// Description: 
// 
// Dependencies: 
// 
// Revision:/ Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
`include "Reciever.v"
`include "Producer.v"

module Testbench();
    
    reg wclk;
    reg rclk;
    reg rst_n;
    
    localparam HALF_PERIOD_W = 3;
    localparam HALF_PERIOD_R = 5;
    localparam DATA_WIDTH = 8;

    wire [DATA_WIDTH-1:0] wdata;
    wire [DATA_WIDTH-1:0] rdata;
    wire winc;
    wire rinc;
    wire wfull;
    wire rempty;
    wire already_wfull;
    wire already_rempty;
    
    Producer #(.DATA_WIDTH(DATA_WIDTH))  inst_produ(.clk(wclk), .rst_n(rst_n), .winc_o(winc),.wdata_o(wdata),.wfull_i(wfull),.already_wfull_i(already_wfull));
    Reciever #(.DATA_WIDTH(DATA_WIDTH)) inst_recie(.clk(rclk), .rst_n(rst_n), .rinc_o(rinc),.rdata_i(rdata),.rempty_i(rempty),.already_rempty_i(already_rempty));
    Async_FIFO #(.DATA_WIDTH(DATA_WIDTH)) inst_afifo(.wclk(wclk),.wrst_n(rst_n),.wdata(wdata),.winc(winc),.wfull(wfull),.rclk(rclk),.rrst_n(rst_n),.rinc(rinc),.rempty(rempty),.rdata(rdata),.already_wfull(already_wfull),.already_rempty(already_rempty));
    
    initial begin
        wclk = 0;
        forever #HALF_PERIOD_W wclk = ~ wclk;
    end

    initial begin
        rclk = 0;
        forever #HALF_PERIOD_R rclk = ~ rclk;
    end

    initial begin 
        $dumpfile("afifo.vcd");
        $dumpvars;
        rst_n = 1;
        #20 rst_n = 0;
        #20 rst_n = 1;
    end

endmodule
