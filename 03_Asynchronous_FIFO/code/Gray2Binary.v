`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Allen Li
// 
// Create Date: 12/30/2020 01:17:54 AM
// Design Name: binary nuymber to gray code converter
// Module Name: Binary2Gray
// Project Name: Asynchronous FIFO
// Target Devices: 
// Tool Versions: Synopsys VCS 2020.3
// Description:  
    // this module is used to covert gray code into binary counter.
// Dependencies: 
// 
// Revision: 
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module Gray2Binary #(
    parameter WIDTH=5
) (
    output [WIDTH-1:0] BIN_o,
    input [WIDTH-1:0] GRAY_i
);
integer i;
wire [WIDTH-1:0] g;
reg [WIDTH-1:0] b;
assign g = GRAY_i;
assign BIN_o = b;

always @(*) begin
    b[WIDTH-1] <= g[WIDTH-1];
    for(i=0;i<WIDTH-1;i=i+1)begin
        b[i] <= g[i]^b[i+1];
    end
end
//assign b[4] = g[4];
//assign b[3] = g[3]^g[4];
//assign b[2] = g[2]^g[3]^g[4];
//assign b[1] = g[1]^g[2]^g[3]^g[4];
//assign b[0] = g[0]^g[1]^g[2]^g[3]^g[4];
    
endmodule
