module clk_div #( parameter N = 3)(
    input clk,
    input rst_n,
    output clk_out
);

localparam HALF = N >> 1;
localparam WIDTH = $clog2(N);

reg [WIDTH-1:0] cnt;
reg clk_p,clk_n;

// MOD-N counter
always@(posedge clk or negedge rst_n) begin
    if(!rst_n)
      cnt <= 0;
    else if( (N-1) == cnt )
      cnt <= 1'b0;
    else
      cnt <= cnt+1;
end

// Convert counter to clock
always@(posedge clk or negedge rst_n) begin
    if(!rst_n)
      clk_p <= 1'b0;
    else if( cnt < HALF )
      clk_p <= 1'b1;
    else
      clk_p <= 1'b0;
end

// sample negedge clock
always@(negedge clk or negedge rst_n) begin
    if(!rst_n)
      clk_n <= 1'b0;
    else
      clk_n <= clk_p;
end

assign clk_out = ( 1 == N )? clk : ( 0 == N[0] )? clk_p : clk_n | clk_p;

endmodule