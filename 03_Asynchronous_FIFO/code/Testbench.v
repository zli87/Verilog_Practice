`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Allen Li
// 
// Create Date: 12/29/2020 11:15:05 PM
// Design Name: 
// Module Name: Testbench
// Project Name:  Multiplier, and Random generator
// Target Devices: 
// Tool Versions: vivado 2019.1
// Description: 
// 
// Dependencies: 
// 
// Revision:/ Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Testbench();
    
    reg clka;
    reg clkb;
    reg rst_n;
//    integer i;
    
    localparam HALF_PERIOD_A = 3;
    always #HALF_PERIOD_A clka = ~ clka;
    localparam HALF_PERIOD_B = 5;
    always #HALF_PERIOD_B clkb = ~ clkb;

    wire [31:0] wdata;
    wire [31:0] rdata;
    wire winc;
    wire rinc;
    wire wfull;
    wire rempty;
    wire already_wfull;
    wire already_rempty;
    
    Producer inst_produ(.clk(clka), .rst_n(rst_n), .winc_o(winc),.wdata_o(wdata),.wfull_i(wfull),.already_wfull_i(already_wfull));
    Reciever inst_recie(.clk(clkb), .rst_n(rst_n), .rinc_o(rinc),.rdata_i(rdata),.rempty_i(rempty),.already_rempty_i(already_rempty));
    Async_FIFO inst_afifo(.wclk(clka),.wrst_n(rst_n),.wdata(wdata),.winc(winc),.wfull(wfull),.rclk(clkb),.rrst_n(rst_n),.rinc(rinc),.rempty(rempty),.rdata(rdata),.already_wfull(already_wfull),.already_rempty(already_rempty));
    
    initial begin 
        reg_reset();
    end
    // $info, $warning, and $error.

    task reg_reset(); begin
        rst_n = 1;
        clka = 0;
        clkb = 0;

        #20 rst_n = 0;
        #20 rst_n = 1;
        repeat(10) @(posedge clka);
    end
    endtask

endmodule
