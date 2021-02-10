`timescale 1ns/1ps
module ram(
  input[7:0] addr,
  input clk, rst,
  output[7:0] out
);
  
  reg[7:0] RAM[0:255];
  reg[7:0] DATA;
  assign out = RAM[addr];
  
  integer i;
  initial
    begin
      for(i=0;i<256;i=i+1)
        RAM[i] <= i;
    end
  
  always@(*)
    begin
      if (rst == 1'b1)
        DATA <= 8'h00;
    end
  
endmodule