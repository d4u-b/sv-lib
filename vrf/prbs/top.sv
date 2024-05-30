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
  parameter DATW = 64;
  parameter STA0 = 9;
  
  logic [STA0-1:0] iprbs_cur;
  logic [STA0-1:0] oprbs_nxt;
  logic [DATW-1:0] oprbs_dat;
  
  always_ff @(posedge clk or negedge rstn) begin
    if(~rstn) iprbs_cur <= '1;
    else iprbs_cur <= oprbs_nxt;
  end

  prbs_itu_o150 u_prbs
    (
     .iprbs_cur,
     .oprbs_nxt,
     .oprbs_dat     
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
