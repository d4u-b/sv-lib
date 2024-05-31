//                              -*- Mode: Verilog -*-
// Filename        : top.sv
// Description     : Test TOP
// Author          : CaBao
// Created On      : Wed May 29 12:40:41 2024
// Last Modified By: CaBao
// Last Modified On: Wed May 29 12:40:41 2024
// Update Count    : 0
// Status          : Unknown, Use with caution!

module top;

  //---------------------------------------
  //clock and reset signal declaration
  //---------------------------------------
  bit clk;
  bit rstn;

  //---------------------------------------
  //clock generation
  //---------------------------------------
  always #5 clk = ~clk;

  //---------------------------------------
  //reset Generation
  //---------------------------------------
  initial begin
    #19 rstn =1;
  end

  //---------------------------------------
  //Instatiations
  //---------------------------------------

  
`include "svlib_macro.sv"
  `sfifo_inst(test,11,16,0,clk,rstn)
  logic [4:0] ckcnt;
  
  always_ff @(posedge clk or negedge rstn) begin
    if(~rstn) ckcnt <= '0;
    else ckcnt <= ckcnt + 1'b1;
  end
  
  assign test.fifo_we = (ckcnt > 0) & (ckcnt < 7);
  assign test.fifo_wd = 16'(ckcnt);
  assign test.fifo_re = (ckcnt > 5'd9) & (ckcnt < 5'd16);
  assign test.fifo_fsh = '0;
  
  //---------------------------------------
  //SIM
  //---------------------------------------

  initial begin
    #5000;
    $finish();
  end

  //---------------------------------------
  //Dump VCD
  //---------------------------------------

   initial begin
      $dumpfile("top.vcd");
      $dumpvars();
   end
  
endmodule // top
