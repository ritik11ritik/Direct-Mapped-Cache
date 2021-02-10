// Code your testbench here
// or browse Examples
`timescale 1ns/1ps
module tb;
  reg clk;
  reg[7:0] addr;
  reg rst;
  wire[7:0] out;

  cache cache1(.addr(addr),
               .clk(clk),
               .out(out),
               .rst(rst)
              );

  initial
    begin
      clk = 1'b1;
      rst = 1'b1;
      #50
      
      rst = 1'b0;
      addr = 8'h02;
      #20
      
      addr = 8'h03;
      #20
      
      addr = 8'h04;
      #20
      
      addr = 8'h03;
      #60
      
      $finish;
    end
  
  always #5 clk = ~clk;
  
  
  
endmodule
