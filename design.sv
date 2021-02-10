// Verilog Code for Direct Mapped Cache
`include "RAM.sv"
`timescale 1ns/1ps
module cache(
  input[7:0] addr,
  input clk, rst,
  output[7:0] out
);
  integer i;
  
  reg[7:0] data_mem[0:7];
  reg[2:0] index;
  reg[4:0] tag[0:7];
  reg valid_bit[0:7];
  
  reg[7:0] op, ram_out_reg;
  wire[7:0] ram_out;
  
  ram ram1(.addr(addr),
           .clk(clk),
           .out(ram_out),
           .rst(rst)
          );
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars(1, cache);
    end
  
  always @(*)
    begin
      index = addr[2:0];
      ram_out_reg = ram_out;
    end
  
  assign out = op;
  
  always @(*)
    begin
      if (rst == 1'b1)
        begin
          for(i=0;i<8;i=i+1)
            begin
              valid_bit[i] = 1'b0;
              tag[i] = 5'b00000;
            end
        end
    end
  
  always @(posedge clk)
    begin
      if(valid_bit[index] == 1'b1)
        begin
          if (tag[index] == addr[7:3])
            begin
              op = data_mem[index];
              $display($realtime);
              $display("HIT");
            end
          else
            begin
              op = ram_out_reg;
              data_mem[index] = ram_out_reg;
              tag[index] = addr[7:3];
              valid_bit[index] = 1'b1;
              $display($realtime);
              $display("MISS");
            end
        end
      
      else
      	begin
          op = ram_out_reg;
          data_mem[index] = ram_out_reg;
          tag[index] = addr[7:3];
          valid_bit[index] = 1'b1;
          $display($realtime);
          $display("MISS");
        end
    end
  
  
endmodule