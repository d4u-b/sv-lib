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
  bit clk_a;
  bit clk_b;
  bit rstn;

  //---------------------------------------
  //clock generation
  //---------------------------------------
  always #5 clk_a = ~clk_a;
  always #7 clk_b = ~clk_b;

  //---------------------------------------
  //reset Generation
  //---------------------------------------
  initial begin
    #16 rstn =1;
  end

  //---------------------------------------
  //Instatiations
  //---------------------------------------

  logic       src_lvl;
  logic       des_lvl;
  logic [3:0] ckcnt;
  
  always_ff @(posedge clk_a or negedge rstn) begin
    if(~rstn) ckcnt <= '0;
    else ckcnt <= ckcnt + 1;
  end

  assign src_lvl = ckcnt[3];
  
  cdcsync_l2l u_cdc
    (
     .des_clk (clk_b),
     .des_rstn(rstn),
     .src_lvl (src_lvl), //It should come from a flop
     .des_lvl (des_lvl)    
     );
  

  //---------------------------------------
  //SIM
  //---------------------------------------

  initial begin
    #500;
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
