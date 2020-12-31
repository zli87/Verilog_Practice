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
    
    reg clk;
    reg rst_n;
    wire [3:0] A;
    wire [3:0] B;
    wire [7:0] D;
    reg [7:0] D_tb;
    integer i;
    
    localparam HALF_PERIOD = 5;
    always #HALF_PERIOD clk = ~ clk;
    
    Random #(.SEED(32'h8456CAD7) ) inst_random0( .clk(clk), .rst_n(rst_n), .lsfr_o(A) );
    Random #(.SEED(32'h897EA5F3) ) inst_random1( .clk(clk), .rst_n(rst_n), .lsfr_o(B) );
    Multiplier wrapper( .clk(clk), .rst_n(rst_n), .A_i(A), .B_i(B), .D_o(D) );
    
 initial begin 
     clk = 0;
     D_tb = 0;
     rst_n = 0;
     #(20*HALF_PERIOD)
     rst_n = 1;
     
     for(i=0;i<10;i=i+1)begin
        D_tb = A*B;
        @(posedge clk);
        if(D_tb != D)begin
            $error("A=%h, B=%h, D_tb=%h, D=%h",A,B,D_tb,D);
            repeat(10) @(posedge clk);
            $finish;
        end else begin
//            $display("pass: %d",i);
        end
      end
      $info("******** PASS ********");
      $finish;
 end
 // $info, $warning, and $error.
endmodule
