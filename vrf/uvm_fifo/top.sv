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

`include "uvm_pkg.sv"
import uvm_pkg::*;
import fifo_para_pkg::*;
import fifo_pkg::*;


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

  sfifo_dut_if sfifo_vif(clk,rstn);

`include "svlib_macro.sv"
  `sfifo_inst(test,FF_D,FF_W,0,clk,rstn)

  assign test.fifo_we  = sfifo_vif.fifo_we;
  assign test.fifo_wd  = sfifo_vif.fifo_wd;
  assign test.fifo_re  = sfifo_vif.fifo_re;
  assign test.fifo_fsh = sfifo_vif.fifo_fsh;

  assign sfifo_vif.fifo_full = test.fifo_full;
  assign sfifo_vif.fifo_ovf  = test.fifo_ovf;
  assign sfifo_vif.fifo_udf  = test.fifo_udf;
  assign sfifo_vif.fifo_rd   = test.fifo_rd;
  assign sfifo_vif.fifo_empt = test.fifo_empt;
  assign sfifo_vif.fifo_len  = test.fifo_len;

  //---------------------------------------
  //SIM
  //---------------------------------------

  // Connecting interface to UVM
  initial begin
    uvm_config_db#(virtual sfifo_dut_if)::set(uvm_root::get(),"*","vif",sfifo_vif);
  end

  // Testbench
  initial begin
    //run_test("fifo_test");
    run_test();
  end

  //---------------------------------------
  //Dump VCD
  //---------------------------------------

   initial begin
      $dumpfile("top.vcd");
      $dumpvars();
   end

endmodule // top
