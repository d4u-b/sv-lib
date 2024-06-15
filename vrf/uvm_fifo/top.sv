//                              -*- Mode: Verilog -*-
// Filename        : top.sv
// Description     : Test TOP
// Author          : CaBao
// Created On      : Wed May 29 12:40:41 2024
// Last Modified By: CaBao
// Last Modified On: Wed May 29 12:40:41 2024
// Update Count    : 0
// Status          : Unknown, Use with caution!

module adder
  #(
    parameter ADD_B = 10
    )
  (
   input                  clk,
   input                  rstn,
   input [ADD_B-1:0]      i_a,
   input [ADD_B-1:0]      i_b,
   output logic [ADD_B:0] o_c
   );

  always_ff @(posedge clk or negedge rstn) begin
    if(~rstn) o_c <= '0;
    else o_c <= i_a + i_b;
  end

endmodule // cnt


module top;

`include "uvm_macros.svh"
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
  always #(CK_PER/2) clk = ~clk;

  //---------------------------------------
  //reset Generation
  //---------------------------------------
  initial begin
    #(RST_TIME) rstn =1;
  end

  //---------------------------------------
  //Instatiations
  //---------------------------------------

`ifdef FIFO_TEST
  sfifo_dut_if vif(clk,rstn);

 `include "svlib_macro.sv"
  `sfifo_inst(test,FF_D,FF_W,0,clk,rstn)

  assign test.fifo_we  = vif.fifo_we;
  assign test.fifo_wd  = vif.fifo_wd;
  assign test.fifo_re  = vif.fifo_re;
  assign test.fifo_fsh = vif.fifo_fsh;

  assign vif.fifo_full = test.fifo_full;
  assign vif.fifo_ovf  = test.fifo_ovf;
  assign vif.fifo_udf  = test.fifo_udf;
  assign vif.fifo_rd   = test.fifo_rd;
  assign vif.fifo_empt = test.fifo_empt;
  assign vif.fifo_len  = test.fifo_len;
`else // !`ifdef FIFO_TEST
`endif // !`ifdef FIFO_TEST

  sfifo_dut_if vif(clk,rstn);

  adder  u_dut
    (
     .clk(clk),
     .rstn(rstn),
     .i_a(vif.i_a),
     .i_b(vif.i_b),
     .o_c(vif.o_c)
     );

  //`endif // !`ifdef FIFO_TEST

  //---------------------------------------
  //SIM
  //---------------------------------------

  // Connecting interface to UVM
  initial begin
    uvm_config_db#(virtual sfifo_dut_if)::set(null,"*","vif",vif);
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
`ifdef VERILATOR
    $dumpfile("top.vcd");
    $dumpvars();
`else
    $wlfdumpvars(0, top);
`endif
  end

endmodule // top
