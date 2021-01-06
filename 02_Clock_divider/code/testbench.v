module testbench();
  reg clk;
  reg rst_n;
  wire clk_out;

  clk_div #(.N(5)) inst(.clk(clk),.clk_out(clk_out),.rst_n(rst_n));
  
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    rst_n = 1;
    #5 rst_n = 0;
    #10 rst_n = 1;
    #200 $finish;
  end

  initial begin
    $dumpfile("clk_div.vcd");
    $dumpvars;
  end
  
endmodule