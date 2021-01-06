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

module Async_FIFO #(
    parameter DATA_WIDTH = 32
)(
    // write clock domain
    input wclk,
    input wrst_n,
    input [DATA_WIDTH-1:0] wdata,
    input winc,
    output wfull,
    output already_wfull,
    
    // read clock domain
    input rclk,
    input rrst_n,
    input rinc,
    output rempty,
    output already_rempty,
    output [DATA_WIDTH-1:0] rdata 
    );

    // use one more addr bit for wfull, rempty compare
    reg [4:0] wptr;
    reg [4:0] wq2_rptr;
    reg [4:0] reg_gray_wptr;
    reg [4:0] sync_r2w;
    reg [4:0] sync_w2r;
    reg [4:0] rptr;
    reg [4:0] rq2_wptr;
    reg [4:0] reg_gray_rptr;
    
    wire [4:0] gray_wptr;
    wire [4:0] gray_rptr;
    wire [4:0] bin_wptr;
    wire [4:0] bin_rptr;
    
    wire [4:0] wptr_next;
    wire [4:0] rptr_next;
    wire writable;
    wire readable;
    
    assign wptr_next = wptr+1;
    assign rptr_next = rptr+1;
    
    assign wfull = ({~wptr[4],wptr[3:0]}==bin_rptr)? 1 : 0;
    assign rempty = (bin_wptr == rptr)? 1 : 0;
    
    assign already_wfull = ({~wptr_next[4],wptr_next[3:0]}==bin_rptr)? 1 : 0;
    assign already_rempty = (bin_wptr == rptr_next)? 1 : 0;
    
    assign writable = winc & (~wfull);
    assign readable = rinc & (~rempty);

    Binary2Gray inst_b2g_wptr(.BIN_i(wptr),.GRAY_o(gray_wptr));
    Binary2Gray inst_b2g_rptr(.BIN_i(rptr),.GRAY_o(gray_rptr));
    Gray2Binary inst_g2b_rptr(.GRAY_i(wq2_rptr),.BIN_o(bin_rptr));
    Gray2Binary inst_g2b_wptr(.GRAY_i(rq2_wptr),.BIN_o(bin_wptr));

    FIFO_MEM #(.DATA_WIDTH(DATA_WIDTH)) inst_fifo_mem(
        //wport
        .waddr(wptr[3:0]),
        .wclk(wclk),
        .wdata(wdata),
        .wclken(writable),
        //rport
        .raddr(rptr[3:0]),
        .rdata(rdata),
        .rclk(rclk),
        .rrst_n(rrst_n)
    );
    always @(posedge rclk or negedge rrst_n) begin
        if (!wrst_n) begin
            reg_gray_rptr <= 0;
        end else begin
            reg_gray_rptr <= gray_rptr;
        end
    end
    always @(posedge wclk or negedge wrst_n) begin
        if (!wrst_n) begin
            reg_gray_wptr <= 0;
        end else begin
            reg_gray_wptr <= gray_wptr;
        end
    end
    
    always @(posedge wclk or negedge wrst_n) begin
        if (!wrst_n) begin
            sync_r2w <= 0;
            wq2_rptr <= 0;
        end else begin
            sync_r2w <= reg_gray_rptr;
            wq2_rptr <= sync_r2w;
        end
    end

    always @(posedge rclk or negedge rrst_n) begin
        if (!wrst_n) begin
            sync_w2r <= 0;
            rq2_wptr <= 0;
        end else begin
            sync_w2r <= reg_gray_wptr;
            rq2_wptr <= sync_w2r;
        end
    end  

    always @(posedge wclk or negedge wrst_n) begin
        if (!wrst_n) begin
            wptr <= 0;
        end else begin
            wptr <= ( writable )? wptr+1 : wptr;
        end
    end

    always @(posedge rclk or negedge rrst_n) begin
        if (!rrst_n) begin
            rptr <= 0;
        end else begin
            rptr <= ( readable )? rptr+1 : rptr;
        end
    end
    
endmodule